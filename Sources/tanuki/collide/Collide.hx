package tanuki.collide;

import tanuki.math.Vector3D;

using tanuki.math.Vector2D;
using tanuki.math.Vector3D;

import tanuki.collide.Shape;
import tanuki.group.Pool;

private class Edge {
	public var distance:Float;
	public var normal:Vector2D;
	public var index:Int;

	public function new(distance:Float, normal:Vector2D, index:Int) {
		this.distance = distance;
		this.normal = normal;
		this.index = index;
	}
}

private enum EvolveResult {
	NoIntersection;
	FoundIntersection;
	StillEvolving;
}

private enum PolygonWinding {
	Clockwise;
	CounterClockwise;
}

class Collide {
	private static var vertices:Array<Vector2D>;
	private static var direction:Vector2D;
	private static var _shapeA:Shape;
	private static var _shapeB:Shape;

	/**
		The maximum number of simplex evolution iterations before we accept the
		given simplex. For non-curvy shapes, this can be low. Curvy shapes potentially
		require higher numbers, but this can introduce significant slow-downs at
		the gain of not much accuracy.
	 */
	public static var maxIterations:Int = 20;

	/**
		Create a new Headbutt instance. Headbutt needs to be instantiated because
		internally it stores state. This may change in the future.
	 */
	private static function calculateSupport(direction:Vector2D):Vector2D {
		var oppositeDirection:Vector2D = direction.multiplyScalar(-1, new Vector2D());
		var newVertex:Vector2D = _shapeA.support(direction).copy(new Vector2D());
		newVertex.subtractVec(_shapeB.support(oppositeDirection), newVertex);
		return newVertex;
	}

	private static function addSupport(direction:Vector2D):Bool {
		var newVertex:Vector2D = calculateSupport(direction);
		vertices.push(newVertex);
		return Vector2D.dot(direction, newVertex) >= 0;
	}

	static function tripleProduct(a:Vector2D, b:Vector2D, c:Vector2D):Vector2D {
		var A:Vector3D = new Vector3D(a.x, a.y, 0);
		var B:Vector3D = new Vector3D(b.x, b.y, 0);
		var C:Vector3D = new Vector3D(c.x, c.y, 0);

		var first:Vector3D = Vector3D.cross(A, B, new Vector3D());
		var second:Vector3D = Vector3D.cross(first, C, new Vector3D());

		return new Vector2D(second.x, second.y);
	}

	private static function evolveSimplex():EvolveResult {
		switch (vertices.length) {
			case 0:
				{
					// direction = _shapeB.center - _shapeA.center;
					direction = new Vector2D(1, 0);
				}
			case 1:
				{
					// flip the direction
					direction *= -1;
				}
			case 2:
				{
					// line ab is the line formed by the first two vertices
					var ab:Vector2D = vertices[1] - vertices[0];
					// line a0 is the line from the first vertex to the origin
					var a0:Vector2D = vertices[0] * -1;

					// use the triple-cross-product to calculate a direction perpendicular
					// to line ab in the direction of the origin
					direction = tripleProduct(ab, a0, ab);
				}
			case 3:
				{
					// calculate if the simplex contains the origin
					var c0:Vector2D = vertices[2] * -1;
					var bc:Vector2D = vertices[1] - vertices[2];
					var ca:Vector2D = vertices[0] - vertices[2];

					var bcNorm:Vector2D = tripleProduct(ca, bc, bc);
					var caNorm:Vector2D = tripleProduct(bc, ca, ca);

					if (bcNorm.dot(c0) > 0) {
						// the origin is outside line bc
						// get rid of a and add a new support in the direction of bcNorm
						vertices.remove(vertices[0]);
						direction = bcNorm;
					} else if (caNorm.dot(c0) > 0) {
						// the origin is outside line ca
						// get rid of b and add a new support in the direction of caNorm
						vertices.remove(vertices[1]);
						direction = caNorm;
					} else {
						// the origin is inside both ab and ac,
						// so it must be inside the triangle!
						return EvolveResult.FoundIntersection;
					}
				}
			case _:
				throw 'Can\'t have simplex with ${vertices.length} verts!';
		}

		return addSupport(direction) ? EvolveResult.StillEvolving : EvolveResult.NoIntersection;
	}

	/**
		Given two convex shapes, test whether they overlap or not
		@param _shapeA
		@param _shapeB
		@return Bool
	 */
	public static function overlap(shapeA:Shape, shapeB:Shape):Bool {
		// reset everything
		vertices = new Array<Vector2D>();
		_shapeA = shapeA;
		_shapeB = shapeB;

		// do the actual test
		var result:EvolveResult = EvolveResult.StillEvolving;
		var iterations:Int = 0;
		while (iterations < maxIterations && result == EvolveResult.StillEvolving) {
			result = evolveSimplex();
			iterations++;
		}
		return result == EvolveResult.FoundIntersection;
	}

	private static function findClosestEdge(winding:PolygonWinding):Edge {
		var closestDistance:Float = Math.POSITIVE_INFINITY;
		var closestNormal:Vector2D = new Vector2D();
		var closestIndex:Int = 0;
		var line:Vector2D = new Vector2D();
		for (i in 0...vertices.length) {
			var j:Int = i + 1;
			if (j >= vertices.length)
				j = 0;

			vertices[j].copy(line);
			line.subtractVec(vertices[i], line);

			var norm:Vector2D = switch (winding) {
				case PolygonWinding.Clockwise:
					new Vector2D(line.y, -line.x);
				case PolygonWinding.CounterClockwise:
					new Vector2D(-line.y, line.x);
			}
			norm.normalize(norm);

			// calculate how far away the edge is from the origin
			var dist:Float = norm.dot(vertices[i]);
			if (dist < closestDistance) {
				closestDistance = dist;
				closestNormal = norm;
				closestIndex = j;
			}
		}

		return new Edge(closestDistance, closestNormal, closestIndex);
	}

	/**
		Given two shapes, test whether they overlap or not. If they don't, returns
		`null`. If they do, calculates the penetration vector and returns it.
		@param _shapeA
		@param _shapeB
		@return Null<Vector2D>
	 */
	public static function intersect(shapeA:Shape, shapeB:Shape):Null<Vector2D> {
		// first, calculate the base simplex
		if (!overlap(shapeA, shapeB)) {
			// if we're not intersecting, return null
			return null;
		}

		// calculate the winding of the existing simplex
		var e0:Float = (vertices[1].x - vertices[0].x) * (vertices[1].y + vertices[0].y);
		var e1:Float = (vertices[2].x - vertices[1].x) * (vertices[2].y + vertices[1].y);
		var e2:Float = (vertices[0].x - vertices[2].x) * (vertices[0].y + vertices[2].y);
		var winding:PolygonWinding = if (e0 + e1 + e2 >= 0) PolygonWinding.Clockwise; else PolygonWinding.CounterClockwise;

		var intersection:Vector2D = new Vector2D();
		for (i in 0...32) {
			var edge:Edge = findClosestEdge(winding);
			var support:Vector2D = calculateSupport(edge.normal);
			var distance:Float = support.dot(edge.normal);

			intersection = edge.normal.copy(intersection);
			intersection.multiplyScalar(distance, intersection);

			if (Math.abs(distance - edge.distance) <= 0.000001) {
				return intersection;
			} else {
				vertices.insert(edge.index, support);
			}
		}

		return intersection;
	}
}
