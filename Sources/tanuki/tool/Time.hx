package tanuki.tool;

import kha.Canvas;
import tanuki.Body;
import kha.Color;

import tanuki.Entity.Rectangle;

class Time extends Rectangle {
	public var timerWidth:Float;
	public var timer(get, null):Float;
	public var timerSpeed:Float = 3.0;
	public var timerMax:Float = 30;
	public var color:Color = Color.White;


	public function new(?x:Float, ?y:Float, ?width:Float, ?height:Float){
		super(x, y, width, height);
		timer = timerMax;
	}

	override public function update(){
		super.update();
		timer -= 0.6;
		if (timer >= timerMax){
			timer = timerMax;
		}
		if (timer <= 0){
			// timer = 0;
			reset();
		}
		// timerWidth -= 0.3;
		// if (timerWidth >= widthMax){
		// 	timerWidth = width;
		// }
		// if (timerWidth <= 0){
		// 	timerWidth = 0;
		// }
	}

	override public function render(canvas:Canvas){
		super.render(canvas);
		canvas.g2.color = color;
		canvas.g2.fillRect(position.x, position.y, timerWidth, height);
		// canvas.g2.drawRect(position.x - 2, position.y - 2, width + 4 - timerWidth, height + 4, 1);
	}

	public function reset(){
		timer = timerMax;
	}

	public function get_timer():Float {
		return timer;
	}

	// public function up(){
	// 	timerWidth += 10;
	// }

	// public function down(){
	// 	timerWidth -= 10;
	// }
}