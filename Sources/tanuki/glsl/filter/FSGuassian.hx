package tanuki.glsl.filter;

import kha.graphics4.ConstantLocation;
import kha.Canvas;
import kha.Image;
import kha.Shaders;

import tanuki.glsl.Filter;
import kha.math.FastVector2;
import kha.math.Vector2;

class FSGuassian extends Filter {
  var _directID:ConstantLocation;
  var _flipID:ConstantLocation;
  public var direct:FastVector2;
  public var flipped:Bool;

  public function new(?width:Int = 320, ?height:Int = 320, ?direct:FastVector2, ?flipped:Bool = false){
    super(Shaders.fsguassian_frag, null, 1, width, height);

    _directID = pipeline.getConstantLocation('direction');
    _flipID = pipeline.getConstantLocation('flip');

    this.flipped = flipped;
    this.direct = direct;
  }

  override public function begin(canvas:Canvas){
    super.begin(canvas);
    canvas.g4.setBool(_flipID, flipped);
    canvas.g4.setVector2(_directID, direct);
    canvas.g2.drawImage(Filter._image, 0, 0);
  }

  override public function end(canvas:Canvas){
    super.end(canvas);
  }
}