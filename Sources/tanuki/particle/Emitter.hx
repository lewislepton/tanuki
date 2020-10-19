package tanuki.particle;

import kha.Canvas;
import kha.Color;
import kha.graphics2.Graphics;

import tanuki.Body;
import tanuki.tool.Util;

class Emitter extends Body {
	public var particles:Array<Particle>;

	public var amount:Int = 6;
	public var color:Color = Color.fromBytes(255, 255, 255);

	public var lifeSpan = 1.0;
	public var power = 3.0;

	public var size:Float;

	public function new(?amount:Int = 6, ?power:Float = 3.0, ?size:Float = 1){
		super();
		this.amount = amount;
		this.power = power;

		this.size = size;

		particles = new Array<Particle>();
	}

	override public function update(){
		super.update();
		var p = particles.length;
		while (p --> 0){
			lifeSpan = particles[p].lifespan;
			particles[p].update();
			if (particles[p].position.x <= 0 || particles[p].position.x >= Tanuki.backbuffer.width || particles[p].position.y <= 0 || particles[p].position.y >= Tanuki.backbuffer.height || lifeSpan <= 0){
				particles.splice(p, 1);
			}
		}
	}

	override public function render(canvas:Canvas){
		super.render(canvas);
		for (particle in particles){
			particle.color = color;
			particle.render(canvas);
		}
	}

	public function spawn(?x:Float = 0, ?y:Float = 0, ?size:Float = 1, ?amount:Int = 6, ?power:Float = 3, ?life:Bool = true, ?lifespan:Float = 1.0){
		for (i in 0 ... amount){
			var particle = new Particle(x, y, life, lifespan);
			particle.acceleration = -0.5;
			particle.size = size;
			this.amount = amount;
			particle.velocity.x = Util.randomRangeFloat(-power, power);
			particle.velocity.y = Util.randomRangeFloat(-power, power);
			particles.push(particle);
		}
	}
}