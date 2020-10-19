package tanuki.glsl.filter;

import kha.math.FastVector2;
import kha.graphics4.ConstantLocation;
import kha.Canvas;
import kha.Image;
import kha.Shaders;

import tanuki.glsl.Filter;

class FSGlitch extends Filter {
  public function new(width:Int, height:Int){
    super(Shaders.fsglitch_frag, null, 1, width, height);
  }

  override public function begin(canvas:Canvas){
    super.begin(canvas);
    canvas.g2.drawImage(Filter._image, 0, 0);
  }

  override public function end(canvas:Canvas){
    super.end(canvas);
  }
}