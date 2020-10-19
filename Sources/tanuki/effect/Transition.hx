package tanuki.effect;

import tanuki.Entity.ERectangle;
import kha.Canvas;
using kha.graphics2.GraphicsExtension;
import kha.Color;
import kha.Assets;

class Transition extends ERectangle {
  public var red = 200;
	public var green = 200;
	public var blue = 200;
  public var alpha = 0;

  public function new(x:Float, y:Float, width:Float, height:Float){
    super(x, y, width, height);
  }

  override public function render(canvas:Canvas){
    super.render(canvas);
    canvas.g2.color = Color.fromBytes(red, green, blue, alpha);
    canvas.g2.fillRect(position.x, position.y, width, height);
  }
}