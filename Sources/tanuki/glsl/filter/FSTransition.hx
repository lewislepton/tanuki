package tanuki.glsl.filter;

import kha.graphics4.ConstantLocation;
import kha.Canvas;
import kha.Shaders;
import tanuki.glsl.Filter;
import tanuki.tool.Util;

class FSTransition extends Filter {
	public var red = 0.63;
	public var green = 0.63;
	public var blue = 0.63;
  public var alpha = 1.0;

	var _redID:ConstantLocation;
	var _greenID:ConstantLocation;
	var _blueID:ConstantLocation;
	var _alphaID:ConstantLocation;

	public function new(?width:Int, ?height:Int) {
		super(Shaders.fstransition_frag, null, 1, width, height);

		_redID = pipeline.getConstantLocation('u_red');
    _greenID = pipeline.getConstantLocation('u_green');
    _blueID = pipeline.getConstantLocation('u_blue');
    _alphaID = pipeline.getConstantLocation('u_alpha');
	}

	override public function begin(canvas:Canvas) {
		super.begin(canvas);
		canvas.g4.setFloat(_redID, red);
    canvas.g4.setFloat(_greenID, green);
    canvas.g4.setFloat(_blueID, blue);
    canvas.g4.setFloat(_alphaID, alpha);
		canvas.g2.drawImage(Filter._image, 0, 0);
	}

	override public function end(canvas:Canvas) {
		super.end(canvas);
	}
}
