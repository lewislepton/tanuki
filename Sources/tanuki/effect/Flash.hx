package tanuki.effect;

import kha.Canvas;
import kha.graphics2.Graphics;
import kha.Color;

import tanuki.Body;

class Flash extends Body {
	public var flashed:Bool;

	public function new(?x:Float = 0, ?y:Float = 0, ?width:Float = 32, ?height:Float = 32){
		super(x, y, width, height);
		flashed = false;
	}
	
	override public function render(canvas:Canvas){
		super.render(canvas);
		if(flashed){
			canvas.g2.color = Color.White;
			canvas.g2.fillRect(position.x, position.y, width, height);
		} else {
			canvas.g2.color = Color.fromFloats(1.0, 1.0, 1.0, 0.0);
			canvas.g2.fillRect(position.x, position.y, width, height);
		}
		flashed = false;
	}
}