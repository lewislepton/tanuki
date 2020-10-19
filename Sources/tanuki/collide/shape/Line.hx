package tanuki.collide.shape;

using tanuki.math.Vector2D;

import tanuki.collide.Shape;

class Line extends Body {
	public var start:Vector2D;
	public var end:Vector2D;

	public function new(start:Vector2D, end:Vector2D) {
		super();
		this.start = start;
		this.end = end;
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

	override public function support(direction:Vector2D):Vector2D {
		if (Vector2D.dot(start, direction) > Vector2D.dot(end, direction)) {
			return start;
		} else {
			return end;
		}
	}

	function get_centre():Vector2D {
		return new Vector2D((start.x + end.x) / 2, (start.y + end.y) / 2);
	}
}