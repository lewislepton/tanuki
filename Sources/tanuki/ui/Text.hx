package tanuki.ui;

import kha.Canvas;
import kha.graphics2.Graphics;
using kha.graphics2.GraphicsExtension;
import kha.Color;
import kha.Assets;
import kha.Font;

import tanuki.Entity.Rectangle;

class Text extends Rectangle {
	public var font:Font;
	public var string:String;
	public var color:Color = Color.White;
	public var fontname:String;

	public var size:Int;

	public var alpha:Float = 1.0;

	public function new(font:Font, string:String, x:Float, y:Float, ?size:Int = 16){
		this.font = font;
		this.string = string;
		this.size = size;

		super(x, y, font.width(size, string), font.height(size));
	}

	override public function update(){
		super.update();
	}

	override public function render(canvas:Canvas){
		super.render(canvas);
		canvas.g2.color = Color.fromFloats(1.0, 1.0, 1.0, alpha);
		canvas.g2.font = font;
		canvas.g2.fontSize = size;
		canvas.g2.drawString(string, position.x, position.y);
	}
}