package tanuki.geom;

class Rect {
	var collision:Int;

	public var onGround:Bool;
	public var x:Float;
	public var y:Float;
	public var width:Float;
	public var height:Float;

	public function new(?x:Float = 0, ?y:Float = 0, ?width:Float = 0, ?height:Float = 0) {
		set(x, y, width, height);
	}

	public function overlap(entity:Rect) {
		return x <= entity.x && x >= entity.x && y <= entity.y && y >= entity.y;
	}

	public inline function set(X:Float = 0, Y:Float = 0, Width:Float = 0, Height:Float = 0):Rect {
		x = X;
		y = Y;
		width = Width;
		height = Height;
		return this;
	}

	public static inline function get(X:Float = 0, Y:Float = 0, Width:Float = 0, Height:Float = 0):Rect{
		var rect = new Rect(X, Y, Width, Height);
		return rect;
	}
}
