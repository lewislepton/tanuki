package tanuki;

import kha.Canvas;
import kha.Color;
import kha.Image;

import tanuki.Entity.Circle in Ci;
import tanuki.Entity.Rectangle in Re;
import tanuki.tool.Util;
import tanuki.math.Vector2D;

class Texture extends Body {
	public var image:Image;
	private var _rotation:Float = 0;
	
	public function new(image:Image, x:Float, y:Float, ?width:Float, ?height:Float){
		this.image = image;
		super();
		this.position.x = x;
		this.position.y = y;
		// x, y, image.width, image.height
		if (width > 0){
			this.width = width;
		} else {
			this.width = image.width;
		}
		if (height > 0){
			this.height = height;
		} else {
			this.height = image.height;
		}
	}

	override function update(){
		super.update();
		if (rotation != 0.0){
			_rotation += rotation;
		}
	}

	override public function render(canvas:Canvas){
		// canvas.g2.pushTranslation(position.x, position.y);
		super.render(canvas);
		// canvas.g2.rotate(Util.degToRad(_rotation), position.x + width / 2, position.y + height / 2);
		canvas.g2.color = Color.White;
		canvas.g2.drawScaledImage(image, position.x, position.y, width, height);
		// canvas.g2.popTransformation();
	}
}

// class TRectangle extends Re {
// 	public var image:Image;
// 	private var _rotation:Float = 0;
	
// 	public function new(image:Image, x:Float, y:Float, ?width:Float, ?height:Float){
// 		this.image = image;
// 		super(x, y, image.width, image.height);
// 		if (width > 0){
// 			this.width = width;
// 		} else {
// 			this.width = image.width;
// 		}
// 		if (height > 0){
// 			this.height = height;
// 		} else {
// 			this.height = image.height;
// 		}
// 	}

// 	override function update(){
// 		super.update();
// 		if (rotation != 0.0){
// 			_rotation += rotation;
// 		}
// 	}

// 	override public function render(canvas:Canvas){
// 		canvas.g2.pushTranslation(position.x, position.y);
// 		super.render(canvas);
// 		canvas.g2.rotate(Util.degToRad(_rotation), position.x + width / 2, position.y + height / 2);
// 		canvas.g2.color = Color.White;
// 		canvas.g2.drawScaledImage(image, 0, 0, width, height);
// 		canvas.g2.popTransformation();
// 	}
// }

// class TCircle extends Ci {
// 	public var image:Image;
// 	private var _rotation:Float = 0;
	
// 	public function new(image:Image, x:Float, y:Float, ?radius:Float){
// 		this.image = image;
// 		this.radius = radius;
// 		super(x, y, image.width);
// 		if (radius > 0){
// 			this.radius = radius;
// 		} else {
// 			this.radius = image.width;
// 		}
// 	}

// 	override function update(){
// 		super.update();
// 		if (rotation != 0.0){
// 			_rotation += rotation;
// 		}
// 	}

// 	override public function render(canvas:Canvas){
// 		canvas.g2.pushTranslation(position.x, position.y);
// 		super.render(canvas);
// 		canvas.g2.rotate(Util.degToRad(_rotation), position.x, position.y);
// 		canvas.g2.color = Color.White;
// 		canvas.g2.drawScaledImage(image, 0, 0, radius, radius);
// 		canvas.g2.popTransformation();
// 	}
// }