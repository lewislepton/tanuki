package tanuki.input;

import kha.System;
import kha.ScreenCanvas;
import kha.Scaler;
import tanuki.App;

class Mouse {
  static var position(get, null):kha.math.Vector2;
	static var wheelPosition:Float;
	static var buttons:Map<Int, Bool>;

  public static function setup(){
    position = new kha.math.Vector2();
		buttons = new Map();
		wheelPosition = 0;

    if(kha.input.Mouse.get() != null){
			kha.input.Mouse.get().notify(mouseDown, mouseUp, mouseMove, mouseWheelMove);
    }
  }

  private static function mouseDown(button : Int, x : Int, y : Int) {
    Tanuki.mouseX = Scaler.transformX(x, y, Tanuki.backbuffer, ScreenCanvas.the, System.screenRotation);
		Tanuki.mouseY = Scaler.transformY(x, y, Tanuki.backbuffer, ScreenCanvas.the, System.screenRotation);
		buttons.set(button, true);
	}

	private static function mouseUp(button : Int, x : Int, y : Int) {
    Tanuki.mouseX = Scaler.transformX(x, y, Tanuki.backbuffer, ScreenCanvas.the, System.screenRotation);
		Tanuki.mouseY = Scaler.transformY(x, y, Tanuki.backbuffer, ScreenCanvas.the, System.screenRotation);
		buttons.set(button, false);
	}

	private static function mouseMove(x : Int, y : Int, cx : Int, cy : Int) {
    Tanuki.mouseX = Scaler.transformX(x, y, Tanuki.backbuffer, ScreenCanvas.the, System.screenRotation);
		Tanuki.mouseY = Scaler.transformY(x, y, Tanuki.backbuffer, ScreenCanvas.the, System.screenRotation);
		position.x = x;
		position.y = y;
	}

	private static function mouseWheelMove(x:Float){
		wheelPosition = x;
	}

  public static function onMouseDown(buttonId:Int):Bool {
		return buttons.get(buttonId);
	}

	public static function get_position():kha.math.Vector2 {
		return position;
	}
	
	public static function onMouseWheelMovement():Float {
		return wheelPosition;
	}
}