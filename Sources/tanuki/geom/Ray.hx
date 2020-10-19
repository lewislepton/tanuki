package tanuki.geom;

class Ray {
	public var x:Float;
	public var y:Float;
	public var direction:Float;

	public function new(x:Float, y:Float, direction:Float){
		this.x = x;
		this.y = y;
		this.direction = direction;
	}

	public static function set(x0:Float, y0:Float, x1:Float, y1:Float){
		var dx = Math.abs(x1 - x0);
		var dy = Math.abs(y1 - y0);

		var sx = x0 < x1 ? 1 : -1;
		var sy = y0 < y1 ? 1 : -1;
		var err = dx - dy;

		while (true){
			if (x0 == x1 && y0 == y1){
				break;
			}

			var e2 = err * 2;
			if (e2 > -dx){
				err -= dy;
				x0 += sx;
			}
			if (e2 < dx){
				err += dx;
				y0 += sy;
			}
		}
	}
}