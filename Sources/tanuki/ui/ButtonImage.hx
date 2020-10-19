package tanuki.ui;

import kha.Canvas;
import kha.Color;
import kha.Assets;
import kha.Image;

import tanuki.Entity.Rectangle;

class ButtonImage extends Rectangle {
  public var image:Image;
	public var onClick:Void->Void;
	public var isClicked:Bool;

	public var colorFrame:Color = Color.White;
	public var colorOn:Color = Color.Green;
	public var colorOff:Color = Color.Black;
	public var colorTextOff:Color = Color.White;
	public var colorTextOn:Color = Color.Red;

	public function new(imagename:String, ?x:Float = 0, ?y:Float = 0, width:Float = 32, height:Float = 32){
    image = Reflect.field(Assets.images, imagename);

		super(x, y, image.width, image.height);

    this.width = width;
    this.height = height;

    width = image.width;
    height = image.height;

		isClicked = false;
	}

	override public function update(){
		super.update();
	}

	override public function render(canvas:Canvas){
		super.render(canvas);

		if (isClicked){
			canvas.g2.color = Color.Black;
		} else {
			canvas.g2.color = Color.White;
		}
    isClicked = false;

    // canvas.g2.drawImage(image, position.x, position.y);
    canvas.g2.drawScaledImage(image, position.x, position.y, width, height);
    // canvas.g2.drawScaledImage(image, position.x, position.y, scaleX, scaleY);
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