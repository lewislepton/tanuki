package tanuki.glsl.filter;

import kha.Canvas;
import kha.graphics4.ConstantLocation;
import kha.Shaders;
import tanuki.glsl.Filter;
import tanuki.tool.Util;

class FSSaturation extends Filter {
  public var hue(default, set):Float;
	public var saturation(default, set):Float;

	var hueID:ConstantLocation;
	var saturationID:ConstantLocation;
	public function new(hue:Float = 0, saturation:Float = 0, width:Int, height:Int) {
		super(Shaders.fssaturation_frag, null, 1, width, height);
    hueID = pipeline.getConstantLocation('hue');
		saturationID = pipeline.getConstantLocation('saturation');

		this.hue = hue;
		this.saturation = saturation;
	}

  override public function begin(canvas:Canvas) {
		super.begin(canvas);
		canvas.g4.setFloat(hueID, hue);
		canvas.g4.setFloat(saturationID, saturation);
		canvas.g2.drawImage(Filter._image, 0, 0);
	}

	override public function end(canvas:Canvas) {
		super.end(canvas);
	}

	function set_hue(value:Float):Float {
		hue = Util.clamp(value, -1, 1);
		return hue;
	}

	function set_saturation(value:Float):Float {
		saturation = Util.clamp(value, -1, 1);
		return saturation;
	}
}
