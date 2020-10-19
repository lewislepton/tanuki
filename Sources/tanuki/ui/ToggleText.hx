package tanuki.ui;

import kha.Font;
import kha.Canvas;
import kha.Color;

import tanuki.ui.Text;
import tanuki.Entity.Rectangle;

class ToggleText extends Rectangle {
	public var isOn:Bool;

	public var colorFrame:Color = Color.White;
	public var colorOn:Color = Color.Green;
	public var colorOff:Color = Color.Black;
	public var colorTextOff:Color = Color.White;
	public var colorTextOn:Color = Color.Red;

	public var string(default, set):String;
	public var font:Font;
	public var text:Text;

	public var offsetWidth = 16.0;
	public var offsetHeight = 16.0;

	public function new(font:Font, string:String, ?x:Float = 0, ?y:Float = 0, ?size:Int = 32){
		this.font = font;
		this.string = string;
		text = new Text(font, string, x, y, size);

		isOn = false;
		
		super(x, y, offsetWidth + text.font.width(size, string), offsetHeight + text.font.height(size));
	}

	override public function update(){
		super.update();
		text.position.x = position.x + offsetWidth / 2;
		text.position.y = position.y + offsetHeight / 2;
	}

	override public function render(canvas:Canvas){
		update();
		super.render(canvas);
		if (isOn){
			canvas.g2.color = colorOn;
			canvas.g2.fillRect(this.position.x, this.position.y, this.width, this.height);
			canvas.g2.color = colorFrame;
			canvas.g2.drawRect(this.position.x, this.position.y, this.width, this.height);
			text.color = colorTextOn;
		} else {
			canvas.g2.color = colorOff;
			canvas.g2.fillRect(this.position.x, this.position.y, this.width, this.height);
			canvas.g2.color = colorFrame;
			canvas.g2.drawRect(this.position.x, this.position.y, this.width, this.height);
			text.color = colorTextOff;
		}
		text.render(canvas);
	}

	public function onButtonDown(x:Int, y:Int) {
		if (x >= this.position.x && x <= this.position.x + this.width && y >= this.position.y && y <= this.position.y + this.height){
			isOn = !isOn;
		}
	}

	public function set_string(value:Dynamic):String {
		return string = Std.string(value);
	}
}