package tanuki.input;

class Gamepad {
	static var gamepads:Array<Controller>;

	public static function setup(){
		gamepads = [];
		for(i in 0...4) {
			gamepads.push(new Controller(i));
			kha.input.Gamepad.get(i).notify(gamepads[i].onAxis, gamepads[i].onButton);
		}
		kha.input.Gamepad.notifyOnConnect(onGamepadConnect, onGamepadDisconnect);
	}

	public static inline function onGamepadAxis(controller:Int, key:String):Bool {
		return gamepads[controller].buttons[key];
	}

	public static inline function onGamepadAngleLeft(controller:Int):Float {
		return gamepads[controller].angleLeft;
	}

	public static inline function onGamepadAngleRight(controller:Int):Float {
		return gamepads[controller].angleRight;
	}

	public static inline function onGamepadButton(controller:Int, button:String):Bool {
		return gamepads[controller].buttons[button];
	}

	static function onGamepadConnect(id:Int){
		gamepads[id].active = true;
	}

	static function onGamepadDisconnect(id:Int){
		gamepads[id].active = false;
	}
}

class Controller {
	public var id:Int = -1;
	public var buttons:Map<String, Bool>;
	public var active:Bool = false;

	public var angleLeft:Float;
	public var angleRight:Float;
	var axisMapLeft:Map<Int, Float> = new Map();
	var axisMapRight:Map<Int, Float> = new Map();

	public function new(id:Int){
		this.id = id;
		this.buttons = new Map();
	}

	public function onAxis(axis:Int, value:Float) {
		axisMapLeft[axis] = value;
		var AXISLEFT_X:Int = 0;
		var AXISLEFT_Y:Int = 1;
		angleLeft = tanuki.tool.Util.vectorDegrees(axisMapLeft[AXISLEFT_X], axisMapLeft[AXISLEFT_Y]);

		axisMapRight[axis] = value;
		var AXISRIGHT_X:Int = 2;
		var AXISRIGHT_Y:Int = 3;
		angleRight = tanuki.tool.Util.vectorDegrees(axisMapRight[AXISRIGHT_X], axisMapRight[AXISRIGHT_Y]);

		if (axis == 0){
			if (value < -0.5){
				buttons.set(LEFT_ANALOG_LEFT, true);
			} else if (value > 0.5){
				buttons.set(LEFT_ANALOG_RIGHT, true);
			} else {
				buttons.set(LEFT_ANALOG_LEFT, false);
				buttons.set(LEFT_ANALOG_RIGHT, false);
			}
		}
		if (axis == 1){
			if (value < -0.5){
				buttons.set(LEFT_ANALOG_UP, true);
			} else if (value > 0.5){
				buttons.set(LEFT_ANALOG_DOWN, true);
			} else {
				buttons.set(LEFT_ANALOG_UP, false);
				buttons.set(LEFT_ANALOG_DOWN, false);
			}
		}
		
		if (axis == 2){
			if (value < -0.5){
				buttons.set(RIGHT_ANALOG_LEFT, true);
			} else if (value > 0.5){
				buttons.set(RIGHT_ANALOG_RIGHT, true);
			} else {
				buttons.set(RIGHT_ANALOG_LEFT, false);
				buttons.set(RIGHT_ANALOG_RIGHT, false);
			}
		}

		if (axis == 3){
			if (value > 0.5){
				buttons.set(RIGHT_ANALOG_UP, true);
			} else if (value < -0.5){
				buttons.set(RIGHT_ANALOG_DOWN, true);
			} else {
				buttons.set(RIGHT_ANALOG_UP, false);
				buttons.set(RIGHT_ANALOG_DOWN, false);
			}
		}
		
		if (axis == 4){
			if (value < -0.5){
				buttons.set(LEFT_TRIGGER, true);
			} else {
				buttons.set(LEFT_TRIGGER, false);
			}
		}
		
		if (axis == 5){
			if (value < -0.5){
				buttons.set(RIGHT_TRIGGER, true);
			} else {
				buttons.set(RIGHT_TRIGGER, false);
			}
		}
	}

	public function onButton(button : Int, value : Float) {
		if (button == 0){
			buttons.set(A, getState(value));
		}
		
		if (button == 1){
			buttons.set(Y, getState(value));
		}
		
		if (button == 2){
			buttons.set(X, getState(value));
		}
		
		if (button == 3){
			buttons.set(B, getState(value));
		} 

		if (button == 4){
			buttons.set(LEFT_BUMPER_01, getState(value));
		}
		
		if (button == 5){
			buttons.set(RIGHT_BUMPER_01, getState(value));
		}

		if (button == 6){
			buttons.set(LEFT_BUMPER_02, getState(value));
		}
		
		if (button == 7){
			buttons.set(RIGHT_BUMPER_02, getState(value));
		}
		
		if (button == 8){
			buttons.set(BACK, getState(value));
		}
		
		if (button == 9){
			buttons.set(START, getState(value));
		} 
		
		if (button == 10){
			buttons.set(LEFT_ANALOG_PRESS, getState(value));
		} 
		
		if (button == 11){
			buttons.set(RIGHT_ANALOG_PRESS, getState(value));
		} 
		
		if (button == 12){
			buttons.set(DPAD_UP, getState(value));
		} 
		
		if (button == 13){
			buttons.set(DPAD_DOWN, getState(value));
		}
		
		if (button == 14){
			buttons.set(DPAD_LEFT, getState(value));
		}
		
		if (button == 15){
			buttons.set(DPAD_RIGHT, getState(value));
		}
		
		if (button == 16){
			buttons.set(HOME, getState(value));
		}

		#if debugging
		trace('button : ' + button + ' : ' + value);
		#end
	}

	private function getState(val : Float) : Bool {
		if(val == 0) {
			return false;
		} else {
			return true;
		}
	}
}

@:enum abstract GamepadKey(String) to String {
	var LEFT_ANALOG_UP = 'LEFT_ANALOG_UP';
	var LEFT_ANALOG_DOWN = 'LEFT_ANALOG_DOWN';
	var LEFT_ANALOG_LEFT = 'LEFT_ANALOG_LEFT';
	var LEFT_ANALOG_RIGHT = 'LEFT_ANALOG_RIGHT';

	var RIGHT_ANALOG_UP = 'RIGHT_ANALOG_UP';
	var RIGHT_ANALOG_DOWN = 'RIGHT_ANALOG_DOWN';
	var RIGHT_ANALOG_LEFT = 'RIGHT_ANALOG_LEFT';
	var RIGHT_ANALOG_RIGHT = 'RIGHT_ANALOG_RIGHT';
	
	var LEFT_TRIGGER = 'LEFT_TRIGGER';
	var RIGHT_TRIGGER = 'RIGHT_TRIGGER';

	var X = 'X';
	var Y = 'Y';
	var A = 'A';
	var B = 'B';

	var LEFT_BUMPER_01 = 'LEFT_BUMPER_01';
	var RIGHT_BUMPER_01 = 'RIGHT_BUMPER_01';

	var LEFT_BUMPER_02 = 'LEFT_BUMPER_02';
	var RIGHT_BUMPER_02 = 'RIGHT_BUMPER_02';

	var LEFT_ANALOG_PRESS = 'LEFT_ANALOG_PRESS';
	var RIGHT_ANALOG_PRESS = 'RIGHT_ANALOG_PRESS';

	var START = 'START';
	var BACK = 'BACK';
	var HOME = 'HOME';

	var DPAD_UP = 'DPAD_UP';
	var DPAD_DOWN = 'DPAD_DOWN';
	var DPAD_LEFT = 'DPAD_LEFT';
	var DPAD_RIGHT = 'DPAD_RIGHT';
}