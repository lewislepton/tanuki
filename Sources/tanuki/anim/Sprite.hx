package tanuki.anim;

import kha.Canvas;
using kha.graphics2.GraphicsExtension;
import kha.Color;
import kha.Image;

import tanuki.anim.Animation;
import tanuki.Texture.TRectangle;
import tanuki.Texture.TCircle;
import tanuki.Entity.ECircle;
import tanuki.tool.Util;
import tanuki.math.Vector2B;

class SRectangle extends TRectangle {
	private var _animation:Animation;
	private var _width:Float;
	private var _height:Float;

	public var color:Color = Color.White;
	
	public function new(image:Image, x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0){
		super(image, x, y, width, height);
		this._width = width;
		this._height = height;
		_animation = Animation.create(0);
	}
	
	override function update():Void {
		super.update();
		_animation.next();
	}
	
	override public function render(canvas:Canvas):Void {
		canvas.g2.color = color;
		if (image != null && active){
			canvas.g2.pushTranslation(position.x, position.y);
			canvas.g2.rotate(Util.degToRad(_rotation), position.x + width / 2, position.y + width / 2);
			canvas.g2.drawScaledSubImage(image, Std.int(_animation.get() * _width) % image.width, Math.floor(_animation.get() * _width / image.width) * _height, _width, _height, (flip.x ? width:0), (flip.y ? height:0), flip.x ? -width:width, flip.y ? -height:height);
			canvas.g2.popTransformation();
		}

		#if debugging
		canvas.g2.color = Color.Red;
		canvas.g2.drawRect(position.x, position.y, width, height);
		#end
	}

	public function setAnimation(animation:Animation):Void {
		this._animation.take(animation);
	}
	
	public function setImage(image:Image):Void {
		this.image = image;
	}
}

class SCircle extends TCircle {
	private var _animation:Animation;

	private var _radius:Float;

	public var color:Color = Color.White;
	
	public function new(image:Image, x:Float = 0, y:Float = 0, radius:Float = 0){
		super(image, x, y, radius);
		this._radius = radius;
		_animation = Animation.create(0);
	}
	
	override function update():Void {
		super.update();
		_animation.next();
	}
	
	override public function render(canvas:Canvas):Void {
		canvas.g2.color = color;
		if (image != null && active){
			canvas.g2.pushTranslation(position.x - radius, position.y - _radius);
			canvas.g2.rotate(Util.degToRad(_rotation), position.x + width / 2, position.y + width / 2);
			canvas.g2.drawScaledSubImage(image, Std.int(_animation.get() * _radius) % image.width, Math.floor(_animation.get() * _radius / image.width) * _radius, _radius, _radius, (flip.x ? width:0), (flip.y ? height:0), flip.x ? -width:width, flip.y ? -height:height);
			canvas.g2.popTransformation();
		}

		#if debugging
		canvas.g2.color = Color.Red;
		canvas.g2.drawRect(position.x, position.y, width, height);
		#end
		// if (image != null && active){
		// 	canvas.g2.pushTranslation(position.x, position.y);
		// 	canvas.g2.rotate(Util.degToRad(_rotation), position.x, position.y);

		// 	canvas.g2.color = Color.White;
		// 	canvas.g2.drawScaledSubImage(image, Std.int(_animation.get() * _radius) % image.width, Math.floor(_animation.get() * _radius / image.width) * _radius, _radius, _radius, - radius / 2, - radius / 2, radius, radius);
		// 	canvas.g2.popTransformation();
		// }

		// #if debugging
		// canvas.g2.color = Color.Red;
		// canvas.g2.drawCircle(position.x, position.y, radius);
		// #end
	}

	public function setAnimation(animation:Animation):Void {
		this._animation.take(animation);
	}
	
	public function setImage(image:Image):Void {
		this.image = image;
	}
}