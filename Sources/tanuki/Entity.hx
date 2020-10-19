package tanuki;

import tanuki.collide.shape.Circle in Ci;
import tanuki.collide.shape.Rectangle in Re;
// import tanuki.collide.shape.Box;
import tanuki.collide.shape.Polygon in Po;
import tanuki.collide.shape.Line in Li;
import tanuki.math.Vector2D;

class Circle extends Ci {
	public function new(x:Float, y:Float, radius:Float) {
		super(radius);

		position.x = x;
		position.y = y;
	}

	override public function update() {
		super.update();
	}
}

class Rectangle extends Re {
	public function new(x:Float, y:Float, width:Float, height:Float) {
		super(width, height);

		position.x = x;
		position.y = y;
	}

	override public function update() {
		super.update();
		rotate(rotation);

		this.position.x = position.x + 0;
		this.position.y = position.y + 0;

		vertices[0].x = 0;
		vertices[0].y = 0;
		vertices[1].x = width;
		vertices[1].y = 0;
		vertices[2].x = width;
		vertices[2].y = height;
		vertices[3].x = 0;
		vertices[3].y = height;
	}
}

class Polygon extends Po {
	public var fill:Bool = false;
	public var thick:Float = 1.0;

	var vert:Array<Vector2D> = new Array<Vector2D>();

	public function new(x:Float, y:Float, ?vertices:Array<Vector2D>) {
		super(vertices);

		position.x = x;
		position.y = y;

		for (i in 0...vertices.length) {
			vert.push(new Vector2D(i, i));
		}
	}

	override public function update() {
		super.update();
		rotate(rotation);

		this.position.x = position.x + 0;
		this.position.y = position.y + 0;

		for (i in 0...vertices.length) {
			vert[i].x = vertices[i].x;
			vert[i].y = vertices[i].y;
		}
	}
}

class Line extends Li {
	public var fill:Bool = false;
	public var thick:Float = 1.0;
	public var x2:Float;
	public var y2:Float;

	public function new(x1:Float, y1:Float, x2:Float, y2:Float) {
		super(new Vector2D(x1, y1), new Vector2D(x2, y2));

		position.x = x1;
		position.y = y1;
		this.x2 = x2;
		this.y2 = y2;
	}

	override public function update() {
		super.update();
		this.position.x = position.x + 0;
		this.position.y = position.y + 0;
	}
}
