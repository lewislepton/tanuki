package tanuki.collide.shape;

import tanuki.tool.Util;

using tanuki.math.Vector2D;
using tanuki.math.Vector3D;
using tanuki.geom.Matrix3D;

import tanuki.Body;
import tanuki.tool.Direction;

class Rectangle extends Body {
	public var vertices:Array<Vector2D>;

	public var transform:Matrix3D;

	public function new(width:Float, height:Float) {
		super();
		this.transform = Matrix3D.identity(new Matrix3D());
		// this.vertices = new Vector<Vector2D>(4);
		// this.vertices[0] = new Vector2D();
		// this.vertices[1] = new Vector2D();
		// this.vertices[2] = new Vector2D();
		// this.vertices[3] = new Vector2D();
		// resize(size);
		this.width = width;
		this.height = height;
		vertices = [
			new Vector2D(0, 0),
			new Vector2D(width, 0),
			new Vector2D(width, height),
			new Vector2D(0, height)
		];
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

	public function resize(size:Vector2D):Void {
		this.vertices[0].x = -0.5 * size.x;
		this.vertices[0].y = -0.5 * size.y;
		this.vertices[1].x = 0.5 * size.x;
		this.vertices[1].y = -0.5 * size.y;
		this.vertices[2].x = 0.5 * size.x;
		this.vertices[2].y = 0.5 * size.y;
		this.vertices[3].x = -0.5 * size.x;
		this.vertices[3].y = 0.5 * size.y;
	}

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

	function checkCollision() {
		if (direction == Direction.DOWN && velocity.y >= 0) {
			onGround = true;
			velocity.y = 0;
		} else if (direction == Direction.UP && velocity.y <= 0) {
			onGround = false;
			velocity.y = 0;
		} else if (direction == Direction.RIGHT && velocity.x >= 0) {
			onGround = false;
			velocity.x = 0;
		} else if (direction == Direction.LEFT && velocity.x <= 0) {
			onGround = false;
			velocity.x = 0;
		}
		if (direction != Direction.DOWN && velocity.y > 0) {
			onGround = false;
		}
	}

	override function get_center():Vector2D {
		return new Vector2D(this.transform.r0c2, this.transform.r1c2);
	}
}
