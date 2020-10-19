package tanuki;

import kha.Canvas;

import tanuki.group.Group;
import tanuki.math.Vector2D;
import tanuki.math.Vector2B;
import tanuki.geom.Point;

import tanuki.collide.Shape;

class Body implements Shape {
	public var id:Int;
	public var center(get, never):Vector2D;
	public var position: Vector2D;
	
	public var width:Float;
	public var height:Float;

	public var velocity:Vector2D = new Vector2D();
	public var speed = 2.5;
	public var acceleration = 0.3;
	public var friction = 3.6;

	public var rotation = 0.0;

	public var active(default, set) = true;

	public var lives = 3;

	public var invincible = false;
	public var invincibleTimerMax = 3.0;
	public var invincibleTimer:Float;
	public var invincibleTimerSpeed = 0.05;

	public var bounce = false;

	public var onGround = false;
	public var direction:Int;

	public var flip:Vector2B;

	// public var scale:Vector2D = new Vector2D(1.0, 1.0);

	public function new(){
		this.position = new Vector2D(0, 0);
		
		invincibleTimer = invincibleTimerMax;

		flip = new Vector2B();

		revive(position.x, position.y);
	}

	public function update(){
		if (!active) return;

		position.x += velocity.x * speed;
		position.y += velocity.y * speed;
		velocity.x *= (1 - Math.min(1 / 60 * friction, 1));
		velocity.y *= (1 - Math.min(1 / 60 * friction, 1));

		if (invincible == true){
			invincibleTimer -= invincibleTimerSpeed;
		}

		if (invincibleTimer <= 0.0){
			invincible = false;
			invincibleTimer = invincibleTimerMax;
		}
	}

	public function render(canvas:Canvas) if (!active) return;

	function set_active(value:Bool):Bool {
		return active = value;
	}

	function get_center():Vector2D {
		return position;
	}

	/**
	 * scale width of object. adds onto existing width
	 * @param value 
	 * @return Float
	 */
	public function scale(value:Float){
		this.width *= value;
		this.height *= value;
		// return this.scale.x = value;
	}
	/**
	 * scale width of object. adds onto existing width
	 * @param value 
	 * @return Float
	 */
	public function scaleWidth(value:Float):Float {
		return this.width *= value;
		// return this.scale.x = value;
	}

	/**
	 * scale height of object. adds onto existing height
	 * @param value 
	 * @return Float
	 */
	public function scaleHeight(value:Float):Float {
		return this.height *= value;
		// return this.scale.y = value;
	}
	/**
	 * resizes width of object
	 * @param value 
	 * @return Float
	 */
	public function resizeWidth(value:Float):Float {
		return this.width = value;
		// return this.scale.x = value;
	}

	/**
	 * resizes height of object
	 * @param value 
	 * @return Float
	 */
	public function resizeHeight(value:Float):Float {
		return this.height = value;
		// return this.scale.y = value;
	}

	/**
	 * revive object
	 */
	public function revive(?x:Float, ?y:Float){
		active = true;
	}

	public function getCenter() {
		return new Point(position.x + width / 2, position.y + height / 2);
	}

	/**
	 * kill object
	 */
	public function destroy(){
		active = false;
	}

	public function support(direction:Vector2D):Vector2D { return null; }
}