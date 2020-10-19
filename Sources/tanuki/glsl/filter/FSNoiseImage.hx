package tanuki.glsl.filter;

import kha.graphics4.ConstantLocation;
import kha.Canvas;
import kha.Shaders;
import tanuki.glsl.Filter;
import tanuki.tool.Util;

class FSNoiseImage extends Filter {
	public var amount(default, set):Float;

	var amountID:ConstantLocation;

	public function new(width:Int, height:Int) {
		super(Shaders.fsnoiseimage_frag, null, 1, width, height);

		amountID = pipeline.getConstantLocation('amount');
		amount = 0.5;
	}

	override public function begin(canvas:Canvas) {
		super.begin(canvas);
		canvas.g4.setFloat(amountID, amount);
		canvas.g2.drawImage(Filter._image, 0, 0);
	}

	override public function end(canvas:Canvas) {
		super.end(canvas);
	}

	function set_amount(value:Float):Float {
		amount = Util.clamp(value, 0, 1);

		return amount;
	}
}
