package tanuki;

import kha.Canvas;
import kha.math.FastMatrix3;
import tanuki.geom.Rect;
import tanuki.Body;

class Camera extends Body {
	public var deadzone:Rect;
	public var viewport:Rect;
	public var transformation:FastMatrix3;
	public var target:Body;
	public var followStyle:CameraFollowStyle;

	var x:Float;
	var y:Float;

	public function new():Void {
		super();

		x = 0;
		y = 0;

		deadzone = new Rect(0, 0, 128, 64);
		viewport = new Rect(0, 0, Tanuki.BUFFERWIDTH, Tanuki.BUFFERHEIGHT);
		transformation = FastMatrix3.identity();
		target = null;
		followStyle = null;
	}

	override public function update():Void {
		super.update();

		follow();
	}

	override public function render(canvas:Canvas):Void {
		super.render(canvas);

		canvas.g2.transformation = transformation;
		// canvas.g2.pushTransformation(FastMatrix3.translation(target.position.x, target.position.y));
		// canvas.g2.drawRect(0, 0, deadzone.width, deadzone.height);
		// canvas.g2.popTransformation();
	}

	override public function destroy():Void {
		super.destroy();

		viewport = null;
		transformation = null;
	}

	function follow():Void {
		if (target != null || followStyle != null){
			switch (followStyle) {
				case CameraFollowStyle.Lock:
					transformation = FastMatrix3.translation(-target.position.x + viewport.width / 2, -target.position.y + viewport.height / 2);
				case CameraFollowStyle.Trap:
					if (target.position.x + position.x > deadzone.width) {
						transformation = transformation.multmat(FastMatrix3.translation(-viewport.width / 2, null));
						// x += -viewport.width;
					}
					if (target.position.x + position.x < deadzone.x) {
						transformation = transformation.multmat(FastMatrix3.translation(viewport.width / 2, null));
						// x += viewport.width;
					}
					if (target.position.y + position.y > deadzone.height) {
						transformation = transformation.multmat(FastMatrix3.translation(null, -viewport.height / 2));
						// y += -viewport.height;
					}
					if (target.position.y + position.y < deadzone.y) {
						transformation = transformation.multmat(FastMatrix3.translation(null, viewport.height / 2));
						// y += viewport.height;
					}
					// if (target.position.x + x > viewport.width / 2){
					// 	transformation = FastMatrix3.translation(-target.position.x + viewport.width / 2, null);
					// }
				case CameraFollowStyle.TrapX:
					if (target.velocity.x >= 0.1){
						transformation = FastMatrix3.translation(-target.position.x + Tanuki.BUFFERWIDTH / 2 - deadzone.width, null);
					} else if (target.velocity.x < 0.1) {
						transformation = FastMatrix3.translation(-target.position.x + Tanuki.BUFFERWIDTH / 2 + deadzone.width, null);
						
						// transformation = FastMatrix3.translation(target.position.x + Tanuki.BUFFERWIDTH / 2 - deadzone.width, null);
					} else {
						transformation = FastMatrix3.translation(-target.position.x + Tanuki.BUFFERWIDTH / 2, null);
					}
					// if (target.position.x + position.x > Tanuki.BUFFERWIDTH / 2){
					// 	transformation = FastMatrix3.translation(-target.position.x + Tanuki.BUFFERWIDTH / 2, null);
					// }
				case CameraFollowStyle.TrapY:
					if (target.position.y + position.y > viewport.height / 2){
						transformation = FastMatrix3.translation(null, -target.position.y + viewport.height / 2);
					}
				case CameraFollowStyle.Screen:
					if (target.position.x + position.x > viewport.width) {
						transformation = transformation.multmat(FastMatrix3.translation(-viewport.width, 0));
						position.x += -viewport.width;
					}
					if (target.position.x + position.x < viewport.x) {
						transformation = transformation.multmat(FastMatrix3.translation(viewport.width, 0));
						position.x += viewport.width;
					}
					if (target.position.y + position.y > viewport.height) {
						transformation = transformation.multmat(FastMatrix3.translation(0, -viewport.height));
						position.y += -viewport.height;
					}
					if (target.position.y + position.y < viewport.y) {
						transformation = transformation.multmat(FastMatrix3.translation(0, viewport.height));
						position.y += viewport.height;
					}
				default: return;
			}
		}
	}
}
enum CameraFollowStyle {
	Lock;
	Screen;
	Trap;
	TrapX;
	TrapY;
}









// class Camera extends Body {
// 	public var deadzone:Rect;
// 	public var viewport:Rect;
// 	public var transformation:FastMatrix3;
// 	public var target:Body;
// 	public var followType:FollowType;
// 	var x : Float;
// 	var y : Float;
// 	public var halfWidth:Float;
// 	public var halfHeight:Float;
// 	public function new(x, y, width:Float, height:Float):Void {
// 		super();
// 		deadzone = new Rect(x, y, 64, 120);
// 		viewport = new Rect(x, y, width, height);
// 		transformation = FastMatrix3.identity();
// 		target = null;
// 		followType = null;
// 		this.width = width;
// 		this.height = height;
// 		halfWidth = Std.int(width / 2);
// 		halfHeight = Std.int(height / 2);
// 	}
// 	override public function update():Void {
// 		super.update();
// 		// if (target.position.x + position.x > Tanuki.BUFFERWIDTH / 2){
// 		// 	// position.x = target.position.x - Tanuki.BUFFERWIDTH / 2;
// 		// 	transformation = FastMatrix3.translation(-target.position.x + Tanuki.BUFFERWIDTH / 2, null);
// 		// }
// 		// if (target.position.x + position.x >= width){
// 		// 	// position.x = target.position.x - Tanuki.BUFFERWIDTH / 2;
// 		// 	target.position.x = width;
// 		// 	// transformation = FastMatrix3.translation(position.x + Tanuki.BUFFERWIDTH, null);
// 		// }
// 		// if (target.position.x + position.x > Tanuki.BUFFERWIDTH / 2){
// 		// 	transformation = FastMatrix3.translation(-target.position.x + Tanuki.BUFFERWIDTH / 2, null);
// 		// }
// 		// if (position.x >= 640){
// 		// 	position.x = 640;
// 		// }
// 		follow();
// 	}
// 	override public function render(canvas:Canvas):Void {
// 		super.render(canvas);
// 		canvas.g2.transformation = transformation;
// 	}
// 	override public function destroy() : Void {
// 		super.destroy();
// 		viewport = null;
// 		transformation = null;
// 	}
// 	function follow():Void {
// 		if (target != null || followType != null){
// 			switch (followType) {
// 				case FollowType.Lock:
// 					transformation = FastMatrix3.translation(-target.position.x + viewport.width / 2, -target.position.y + viewport.height / 2);
// 				case FollowType.Trap:
// 					if (target.position.x + position.x > deadzone.width) {
// 						transformation = transformation.multmat(FastMatrix3.translation(-viewport.width / 2, 0));
// 						// x += -viewport.width;
// 					}
// 					if (target.position.x + position.x < deadzone.x) {
// 						transformation = transformation.multmat(FastMatrix3.translation(viewport.width / 2, 0));
// 						// x += viewport.width;
// 					}
// 					if (target.position.y + position.y > deadzone.height) {
// 						transformation = transformation.multmat(FastMatrix3.translation(0, -viewport.height / 2));
// 						// y += -viewport.height;
// 					}
// 					if (target.position.y + position.y < deadzone.y) {
// 						transformation = transformation.multmat(FastMatrix3.translation(0, viewport.height / 2));
// 						// y += viewport.height;
// 					}
// 					// if (target.position.x + x > viewport.width / 2){
// 					// 	transformation = FastMatrix3.translation(-target.position.x + viewport.width / 2, null);
// 					// }
// 				case FollowType.TrapX:
// 					if (target.position.x + position.x > Tanuki.BUFFERWIDTH / 2){
// 						transformation = FastMatrix3.translation(-target.position.x + Tanuki.BUFFERWIDTH / 2, null);
// 					}
// 					if (target.position.x >= width - 128){
// 						target.position.x = width - 128;
// 					}
// 				case FollowType.TrapY:
// 					if (target.position.y + position.y > viewport.height / 2){
// 						transformation = FastMatrix3.translation(null, -target.position.y + viewport.height / 2);
// 					}
// 				case FollowType.Screen:
// 					if (target.position.x + position.x > viewport.width) {
// 						transformation = transformation.multmat(FastMatrix3.translation(-viewport.width, 0));
// 						position.x += -viewport.width;
// 					}
// 					if (target.position.x + position.x < viewport.x) {
// 						transformation = transformation.multmat(FastMatrix3.translation(viewport.width, 0));
// 						position.x += viewport.width;
// 					}
// 					if (target.position.y + position.y > viewport.height) {
// 						transformation = transformation.multmat(FastMatrix3.translation(0, -viewport.height));
// 						position.y += -viewport.height;
// 					}
// 					if (target.position.y + position.y < viewport.y) {
// 						transformation = transformation.multmat(FastMatrix3.translation(0, viewport.height));
// 						position.y += viewport.height;
// 					}
// 				default: return;
// 			}
// 		}
// 	}
// }
// enum FollowType {
// 	Lock;
// 	Screen;
// 	Trap;
// 	TrapX;
// 	TrapY;
// }
// class Camera extends Body {
// 	// public var x:Float;
// 	// public var y:Float;
// 	public var offsetX:Int;
// 	public var offsetY:Int;
// 	public var viewPortX(get, never):Float;
// 	public var viewPortY(get, never):Float;
// 	// public var width:Int;
// 	// public var height:Int;
// 	public var halfWidth:Int;
// 	public var halfHeight:Int;
// 	public var worldWidth:Int;
// 	public var worldHeight:Int;
// 	var deadzone:Rect;
// 	var shakeTime:Float = 0;
// 	var shakeMagnitude:Int = 0;
// 	var shakeX:Int = 0;
// 	var shakeY:Int = 0;
// 	var dzLeft:Int;
// 	var dzRight:Int;
// 	var dzTop:Int;
// 	var dzBottom:Int;
// 	public function new(width:Int, height:Int, worldWidth:Int, worldHeight:Int):Void {
// 		super();
// 		position.x = 0;
// 		position.y = 0;
// 		offsetX = 0;
// 		offsetY = 0;
// 		// setDeadZones(0, 0, 64, 128);
// 		this.width = width;
// 		this.height = height;
// 		this.worldWidth = worldWidth;
// 		this.worldHeight = worldHeight;
// 		halfWidth = Std.int(width / 2);
// 		halfHeight = Std.int(height / 2);
// 		dzLeft = 0;
// 		dzRight = 0;
// 		dzTop = 0;
// 		dzBottom = 0;
// 	}
// 	public function setSize(width:Int, height:Int):Void {
// 		this.width = width;
// 		this.height = height;
// 		halfWidth = Std.int(width / 2);
// 		halfHeight = Std.int(height / 2);
// 	}
// 	public function setOffset(offsetX:Int, offsetY:Int):Void {
// 		this.offsetX = offsetX;
// 		this.offsetY = offsetY;
// 	}
// 	public function setDeadZones(left:Int, right:Int, top:Int, bottom:Int):Void {
// 		dzLeft = left;
// 		dzRight = right;
// 		dzTop = top;
// 		dzBottom = bottom;
// 	}
// 	// public function follow(objectX:Float, objectY:Float):Void {
// 	public function follow(object:Body):Void {
// 		if (object.position.x > dzLeft && object.position.x < (worldWidth - dzRight)) {
// 			position.x = object.position.x - halfWidth;
// 		}
// 		if (object.position.y > dzTop && object.position.y < (worldHeight - dzBottom)) {
// 			position.y = object.position.y - halfHeight;
// 		}
// 		checkBoundaries();
// 		update();
// 		if (object.position.x > Tanuki.BUFFERWIDTH / 2){
// 			position.x = object.position.x - Tanuki.BUFFERWIDTH / 2;
// 		}
// 		if (object.position.y > Tanuki.BUFFERHEIGHT / 2){
// 			position.y = object.position.y - Tanuki.BUFFERHEIGHT / 2;
// 		}
// 	}
// 	public function centerOnPos(px:Float, py:Float):Void {
// 		position.x = px - halfWidth + offsetX;
// 		position.y = py - halfHeight + offsetY;
// 		checkBoundaries();
// 	}
// 	function checkBoundaries():Void {
// 		if (position.x < 0) {
// 			position.x = 0;
// 		} else if (position.x + width - offsetX > worldWidth) {
// 			position.x = worldWidth - width + offsetX;
// 		}
// 		if (position.y < 0) {
// 			position.y = 0;
// 		} else if (position.y + height - offsetY > worldHeight) {
// 			position.y = worldHeight - height + offsetY;
// 		}
// 	}
// 	public function moveBy(stepX:Float, stepY:Float):Void {
// 		if (stepX < 0) {
// 			if ((position.x + stepX) > 0) {
// 				position.x += stepX;
// 			} else {
// 				position.x = 0;
// 			}
// 		} else {
// 			if ((position.x + 1024 + stepX) < width) {
// 				position.x += stepX;
// 			} else {
// 				position.x = width - 1024;
// 			}
// 		}
// 		if (stepY < 0) {
// 			if ((position.y + stepY) > 0) {
// 				position.y += stepY;
// 			} else {
// 				position.y = 0;
// 			}
// 		} else {
// 			if ((position.y + 768 + stepY) < height) {
// 				position.y += stepY;
// 			} else {
// 				position.y = height - 768;
// 			}
// 		}
// 	}
// 	public function shake(magnitude:Int, duration:Float) {
// 		if (shakeTime < duration)
// 			shakeTime = duration;
// 		shakeMagnitude = magnitude;
// 	}
// 	/** Stop the screen from shaking immediately. */
// 	public function shakeStop() {
// 		shakeTime = 0;
// 	}
// 	override function update():Void {
// 		super.update();
// 		// update screen shake
// 		if (shakeTime > 0) {
// 			var sx:Int = Std.random(shakeMagnitude * 2 + 1) - shakeMagnitude;
// 			var sy:Int = Std.random(shakeMagnitude * 2 + 1) - shakeMagnitude;
// 			position.x += sx - shakeX;
// 			position.y += sy - shakeY;
// 			shakeX = sx;
// 			shakeY = sy;
// 			shakeTime -= 1 / 60;
// 			if (shakeTime < 0)
// 				shakeTime = 0;
// 		} else if (shakeX != 0 || shakeY != 0) {
// 			position.x -= shakeX;
// 			position.y -= shakeY;
// 			shakeX = shakeY = 0;
// 		}
// 	}
// 	public function begin(canvas:Canvas):Void {
// 		canvas.g2.pushTranslation(-position.x + offsetX, -position.y + offsetY);
// 		canvas.g2.scissor(Std.int(offsetX), Std.int(offsetY), Std.int(width), Std.int(height));
// 	}
// 	public inline function end(canvas:Canvas):Void {
// 		canvas.g2.disableScissor();
// 		canvas.g2.popTransformation();
// 	}
// 	inline function get_viewPortX():Float {
// 		return position.x + offsetX;
// 	}
// 	inline function get_viewPortY():Float {
// 		return position.y + offsetY;
// 	}
// }
