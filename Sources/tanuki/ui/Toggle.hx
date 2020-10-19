package tanuki.ui;

import kha.Canvas;
import kha.Color;

import tanuki.Body;
import tanuki.Entity.Rectangle;

class Toggle extends Rectangle {
	public var isOn:Bool;

	public var colorFrame:Color = Color.Pink;
	public var colorOn:Color = Color.Green;
	public var colorOff:Color = Color.Black;

	public function new(?x:Float = 0, ?y:Float = 0, ?width:Float = 32, ?height:Float = 32){
		super(x, y, width, height);
		isOn = false;
	}

	// public function update(){}

	override public function render(canvas:Canvas){
		if (isOn){
			canvas.g2.color = colorOn;
			canvas.g2.fillRect(this.position.x, this.position.y, this.width, this.height);
			canvas.g2.color = colorFrame;
			canvas.g2.drawRect(this.position.x, this.position.y, this.width, this.height);
		} else {
			canvas.g2.color = colorOff;
			canvas.g2.fillRect(this.position.x, this.position.y, this.width, this.height);
			canvas.g2.color = colorFrame;
			canvas.g2.drawRect(this.position.x, this.position.y, this.width, this.height);
		}
	}

	public function onButtonDown(x:Int, y:Int) {
		if (x >= this.position.x && x <= this.position.x + this.width && y >= this.position.y && y <= this.position.y + this.height){
			isOn = !isOn;
		}
	}
}