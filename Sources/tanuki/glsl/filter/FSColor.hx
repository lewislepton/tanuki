package tanuki.glsl.filter;

import kha.graphics4.ConstantLocation;
import kha.Canvas;
import kha.Image;
import kha.Shaders;

import tanuki.glsl.Filter;

class FSColor extends Filter {
  public var red:Float;
	public var green:Float;
	public var blue:Float;
  public var alpha:Float = 1.0;

	var _redID:ConstantLocation;
	var _greenID:ConstantLocation;
	var _blueID:ConstantLocation;
	var _alphaID:ConstantLocation;

  public function new(width:Int = 0, height:Int = 0){
    super(Shaders.fscolor_frag, null, 0, width, height);

    _redID = pipeline.getConstantLocation('u_red');
    _greenID = pipeline.getConstantLocation('u_green');
    _blueID = pipeline.getConstantLocation('u_blue');
    _alphaID = pipeline.getConstantLocation('u_alpha');
  }

  override public function begin(canvas:Canvas){
    super.begin(canvas);
    canvas.g4.setFloat(_redID, red);
    canvas.g4.setFloat(_greenID, green);
    canvas.g4.setFloat(_blueID, blue);
    canvas.g4.setFloat(_alphaID, alpha);
  }

  override public function end(canvas:Canvas){
    super.end(canvas);
  }
}