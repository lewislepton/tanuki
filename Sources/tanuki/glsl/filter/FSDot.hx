package tanuki.glsl.filter;

import kha.graphics4.ConstantLocation;
import kha.Canvas;
import kha.Image;
import kha.Shaders;

import tanuki.glsl.Filter;

class FSDot extends Filter {
  var _angleID:ConstantLocation;
	var _scaleID:ConstantLocation;
  public var angle:Float;
	public var scaled:Float;

  public function new(width:Int, height:Int){
    super(Shaders.fsdot_frag, null, 1, width, height);

    _angleID = pipeline.getConstantLocation('angle');
		_scaleID = pipeline.getConstantLocation('scale');

    angle = 5;
		scaled = 1; 
  }

  override public function begin(canvas:Canvas){
    super.begin(canvas);
    canvas.g4.setFloat(_angleID, angle);
		canvas.g4.setFloat(_scaleID, scaled);
    canvas.g2.drawImage(Filter._image, 0, 0);
  }

  override public function end(canvas:Canvas){
    super.end(canvas);
  }
}