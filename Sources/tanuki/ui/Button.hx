package tanuki.ui;

import kha.Canvas;
import kha.Color;

import tanuki.Entity.Rectangle;

class Button extends Rectangle {
	public var onClick:Void->Void;
	public var isClicked:Bool;

	public var colorFrame:Color = Color.White;
	public var colorOn:Color = Color.Green;
	public var colorOff:Color = Color.Black;
	public var colorTextOff:Color = Color.White;
	public var colorTextOn:Color = Color.Red;

	public function new(?x:Float = 0, ?y:Float = 0, width:Float = 32, height:Float = 32){
		super(x, y, width, height);
		
		isClicked = false;
	}

	override public function update(){
		super.update();
	}

	override public function render(canvas:Canvas){
		super.render(canvas);
		if (isClicked){
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
    // isClicked = false;
	}

	public function onButtonDown(x:Int, y:Int){
    if (x >= this.position.x && x <= this.position.x + this.width && y >= this.position.y && y <= this.position.y + this.height){
			isClicked = true;
      if (this.onClick != null){
				onClick();
			}
      return true;
    }
    return false;
  }

	public function onButtonUp(x:Int, y:Int){
    if (x >= this.position.x && x <= this.position.x + this.width && y >= this.position.y && y <= this.position.y + this.height){
			isClicked = false;
      return true;
    }
    return false;
  }
}