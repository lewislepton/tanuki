package tanuki.collide.shape;

import tanuki.tool.Util;
using tanuki.math.Vector2D;
using tanuki.math.Vector3D;
using tanuki.geom.Matrix3D;

import tanuki.collide.Shape;
import tanuki.Body;

class Polygon extends Body {
	public var vertices:Array<Vector2D>;

	public var transform:Matrix3D;

	public function new(?vertices:Array<Vector2D>) {
		super();
		this.vertices = vertices;
		this.transform = Matrix3D.identity(new Matrix3D());
	}

	public function collide(entity:Body):Bool {
		var touch:Vector2D = Collide.intersect(entity, this);
		var intersect:Bool = false;
		if (touch != null) {
			intersect = true;
			Vector2D.addVec(this.position, touch, this.position);
		} else {
			intersect = false;
		}
		return intersect;
	}

	public function overlap(entity:Body):Bool {
		var intersect:Bool = false;
		if (Collide.overlap(this, entity)) {
			intersect = true;
		} else {
			intersect = false;
		}
		return intersect;
	}

	// public function setTransform(position:Vector2D, rotation:Float, scale:Vector2D):Void {
	// 	var c:Float = Math.cos(rotation);
	// 	var s:Float = Math.sin(rotation);

	// 	this.transform.r0c0 = scale.x * c;
	// 	this.transform.r0c1 = -s;
	// 	this.transform.r0c2 = position.x;

	// 	this.transform.r1c0 = scale.x * s;
	// 	this.transform.r1c1 = scale.y * c;
	// 	this.transform.r1c2 = position.y;

	// 	this.transform.r2c0 = 0;
	// 	this.transform.r2c1 = 0;
	// 	this.transform.r2c2 = 1;
	// }

	public function rotate(value:Float):Void {
		var pos = new Vector2D(this.position.x, this.position.y);
		var scale = new Vector2D(1, 1);

		var c:Float = Math.cos(Util.degToRad(value));
		var s:Float = Math.sin(Util.degToRad(value));

		this.transform.r0c0 = scale.x * c;
		this.transform.r0c1 = -s;
		this.transform.r0c2 = pos.x;

		this.transform.r1c0 = scale.x * s;
		this.transform.r1c1 = scale.y * c;
		this.transform.r1c2 = pos.y;

		this.transform.r2c0 = 0;
		this.transform.r2c1 = 0;
		this.transform.r2c2 = 1;
	}

	override public function support(direction:Vector2D):Vector2D {
		var furthestDistance:Float = Math.NEGATIVE_INFINITY;
		var furthestVertex:Vector2D = new Vector2D();

		var vi:Vector3D = new Vector3D(0, 0, 1);
		var vo:Vector3D = new Vector3D();
		var vd:Vector2D = new Vector2D();
		for (v in vertices) {
			vi.x = v.x;
			vi.y = v.y;
			vo = Matrix3D.multVec(this.transform, vi, vo);
			vd.x = vo.x / vo.z;
			vd.y = vo.y / vo.z;
			var distance:Float = Vector2D.dot(vd, direction);
			if (distance > furthestDistance) {
				furthestDistance = distance;
				furthestVertex.x = vd.x;
				furthestVertex.y = vd.y;
			}
		}

		return furthestVertex;
	}

	function get_centre():Vector2D {
		return new Vector2D(this.transform.r0c2, this.transform.r1c2);
	}
}