package tanuki.collide.shape;

using tanuki.math.Vector2D;
import tanuki.collide.Shape;
import tanuki.Body;

import tanuki.collide.Collide;

class Circle extends Body {
	public var radius:Float;

	public function new(radius:Float){
		super();
		this.radius = radius;
	}

	public function collide(entity:Body):Bool {
		var touch:Vector2D = Collide.intersect(entity, this);
		var intersect:Bool = false;
		if (touch != null){
			intersect = true;
			Vector2D.addVec(this.position, touch, this.position);
		} else {
			intersect = false;
		}
		return intersect;
	}

	public function overlap(entity:Body):Bool {
		var intersect:Bool = false;
		if (Collide.overlap(this, entity)){
			intersect = true;
		} else {
			intersect = false;
		}
		return intersect;
	}

	override public function support(direction:Vector2D):Vector2D {
		var c: Vector2D = position.copy(new Vector2D());
		var d: Vector2D = direction.normalize(new Vector2D());
		d.multiplyScalar(radius, d);
		c.addVec(d, c);
		return c;
	}
}