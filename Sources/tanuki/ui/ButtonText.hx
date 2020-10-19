package tanuki.ui;

import kha.Font;
import kha.Canvas;
import kha.Color;

import tanuki.ui.Text;
import tanuki.Entity.Rectangle;

class ButtonText extends Rectangle {
	public var offsetWidth = 16.0;
	public var offsetHeight = 8.0;

	public var text:Text;

	public var onClick:Void->Void;
	public var isClicked:Bool = false;

	public var colorFrame:Color = Color.fromBytes(0, 0, 0, 1);
	public var colorOn:Color = Color.White;
	public var colorOff:Color = Color.fromFloats(0, 0, 0, 1);
	public var colorTextOff:Color = Color.White;
	public var colorTextOn:Color = Color.Black;

	public var string:String;
	public var font:Font;
	public var size:Int;

	public function new(font:Font, string:String, ?x:Float = 0, ?y:Float = 0, ?size:Int = 32){
		this.font = font;
		this.string = string;
		this.size = size;
		text = new Text(font, string, x, y, size);

		super(x, y, offsetWidth + text.font.width(size, string), offsetHeight + text.font.height(size));
	}

	override public function update(){
		super.update();
		width = offsetWidth + text.font.width(size, string);
		height = offsetHeight + text.font.height(size);
		text.position.x = position.x + offsetWidth / 2;
		text.position.y = position.y + offsetHeight / 2;
	}

	override public function render(canvas:Canvas){
		update();
		super.render(canvas);
		if (isClicked){
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
		isClicked = false;
	}

	public function onButtonDown(x:Int, y:Int){
    if (x >= this.position.x && x <= this.position.x + this.width && y >= this.position.y && y <= this.position.y + this.height){
      if (this.onClick != null){
				onClick();
				isClicked = true;
			}
      return true;
    }
    return false;
  }
}