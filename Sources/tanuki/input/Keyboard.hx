package tanuki.input;

class Keyboard {
	static var keysPressed:Map<kha.input.KeyCode, Bool>;
	static var keysHeld:Map<kha.input.KeyCode, Bool>;
	static var keysUp:Map<kha.input.KeyCode, Bool>;
	static var keysCount:Int = 0;
	static var keyPressed:Bool;	

	public static function setup(){
		kha.input.Keyboard.get(0).notify(keyDown, keyUp);

		keysPressed = new Map<kha.input.KeyCode, Bool>();
		keysHeld = new Map<kha.input.KeyCode, Bool>();
		keysUp = new Map<kha.input.KeyCode, Bool>();		

		keyPressed = false;
	}

  @:noCompletion
	public function update():Void {
		for (key in keysPressed.keys()){
			keysPressed.remove(key);
		}

		for (key in keysUp.keys()){
			keysUp.remove(key);
		}

		keyPressed = false;
	}

	public function reset():Void {
		for (key in keysPressed.keys()){
			keysPressed.remove(key);
		}

		for (key in keysHeld.keys()){
			keysHeld.remove(key);
		}

		for (key in keysUp.keys()){
			keysUp.remove(key);
		}
	}

	static function keyDown(keyCode:kha.input.KeyCode):Void {
		keysPressed.set(keyCode, true);
		keysHeld.set(keyCode, true);				            									        		

		keysCount++;
		keyPressed = true;
	}

	static function keyUp(keyCode:kha.input.KeyCode):Void {
		keysUp.set(keyCode, true);
		keysHeld.set(keyCode, false);																					

		keysCount--;
		keyPressed = false;
	}

	inline public static function onKeyDown(keyCode:kha.input.KeyCode):Bool {
		return keysPressed.exists(keyCode);
	}

	inline public static function onKeyHeld(keyCode:kha.input.KeyCode):Bool {
		return keysHeld.get(keyCode);
	}

	inline public static function onKeyUp(keyCode:kha.input.KeyCode):Bool {
		keyPressed = false;
		return keysUp.exists(keyCode);
	}

	inline public static function anyKeyHeld():Bool {
		return (keysCount > 0);
	}

	inline public static function anyKeyPressed():Bool {
		return keyPressed;
	}
}