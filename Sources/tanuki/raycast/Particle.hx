package tanuki.raycast;

import kha.System;
import kha.math.Vector2;

import tanuki.tool.Util;

class Particle{
	public var pos: Vector2;
	var rays:Array<Raycast>;
	public var sphere:Float = 45;

	public function new(){
		this.pos = new Vector2(System.windowWidth()/2, System.windowHeight()/2);
		this.rays = [];
		var a = 0.0;
		while (a < sphere){
			a += 0.3;
			this.rays.push(new Raycast(this.pos, Util.degToRad(a + 16)));
			// this.rays.push(new Raycast(this.pos, a * Math.PI / 180.0));
		}
	}

	public function update(x: Float, y: Float){
		this.pos.x = x;
		this.pos.y = y;
	}

	public function render(canvas:kha.Canvas, walls:Array<Boundary>){
		for (i in 0...this.rays.length){
			var ray = this.rays[i];
			var closest = null;
			var record = Math.POSITIVE_INFINITY;
			for (wall in walls){
				var pt = ray.castwall(wall);
				// trace(pt);
				if (pt != null){
					var d: Float = Math.sqrt(Math.pow((this.pos.x - pt.x), 2) + Math.pow((this.pos.y - pt.y), 2));
					if (d < record){
						record = d;
						closest = pt;
					}
				}
			}
			if (closest != null){
				canvas.g2.drawLine(this.pos.x, this.pos.y, closest.x, closest.y);
			}
		}
	}

	// public function renderRay(canvas:kha.Canvas){
	// 	for (ray in this.rays){
	// 		ray.render(canvas);
	// 	}
	// }
}