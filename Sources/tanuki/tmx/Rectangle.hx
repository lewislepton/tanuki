package tanuki.tmx;

class Rectangle extends Body {
	// public var x: Float;
	// public var y: Float;
	// public var width: Float;
	// public var height: Float;

	public function new(x: Float, y: Float, width: Float, height: Float) {
		super();
		this.position.x = x;
		this.position.y = y;
		this.width = width;
		this.height = height;
	}
	
	public function setPos(x: Int, y: Int): Void {
		this.position.x = x;
		this.position.y = y;
	}

	public function moveX(xdelta: Int): Void {
		position.x += xdelta;
	}

	public function moveY(ydelta: Int): Void {
		position.y += ydelta;
	}

	public function collision(r: Rectangle): Bool {
		var a: Bool;
		var b: Bool;
		if (position.x < r.position.x) a = r.position.x < position.x + width;
		else a = position.x < r.position.x + r.width;
		if (position.y < r.position.y) b = r.position.y < position.y + height;
		else b = position.y < r.position.y + r.height;
		return a && b;
	}
}
