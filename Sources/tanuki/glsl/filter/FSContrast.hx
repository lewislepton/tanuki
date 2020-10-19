package tanuki.glsl.filter;

import kha.Canvas;
import kha.graphics4.ConstantLocation;
import kha.Shaders;
import tanuki.glsl.Filter;
import tanuki.tool.Util;

class FSContrast extends Filter {
	public var brightness(default, set):Float;
	public var contrast(default, set):Float;

	var brightnessID:ConstantLocation;
	var contrastID:ConstantLocation;

	public function new(width:Int, height:Int) {
		super(Shaders.fscontrast_frag, null, 1, width, height);

    brightnessID = pipeline.getConstantLocation('brightness');
		contrastID = pipeline.getConstantLocation('contrast');

		this.brightness = brightness;
		this.contrast = contrast;
	}

  override function begin(canvas:Canvas) {
    super.begin(canvas);
    canvas.g4.setFloat(brightnessID, brightness);
		canvas.g4.setFloat(contrastID, contrast);
		canvas.g2.drawImage(Filter._image, 0, 0);
  }

  override function end(canvas:Canvas) {
    super.end(canvas);
  }

	function set_brightness(value:Float):Float {
		brightness = Util.clamp(value, -1, 1);
		return brightness;
	}

	function set_contrast(value:Float):Float {
		contrast = Util.clamp(value, -1, 1);
		return contrast;
	}
}
