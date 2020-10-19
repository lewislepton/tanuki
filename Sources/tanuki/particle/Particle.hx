package tanuki.particle;

import kha.Canvas;
import kha.Color;
import tanuki.collide.Shape;

import tanuki.Entity.Rectangle;

class Particle extends Rectangle {
	public var life:Bool;
	public var lifespan:Float = 1.0;
	public var color:Color;
	public var size:Float;

	public function new(?x:Float, ?y:Float, ?size:Float = 1, ?life:Bool = false, ?lifespan:Float = 1.0){
		super(x, y, size, size);
		this.life = life;
		this.lifespan = lifespan;
		speed = 1.75;
	}

	override public function update(){
		super.update();
		lifespan -= 0.01;
		velocity.y -= acceleration;
	}

	override public function render(canvas:Canvas){
		super.render(canvas);
		canvas.g2.color = color;
		canvas.g2.drawRect(position.x, position.y, size, size);
	}
}