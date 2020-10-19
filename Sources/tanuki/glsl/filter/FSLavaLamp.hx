package tanuki.glsl.filter;

import kha.graphics4.ConstantLocation;
import kha.Canvas;
import kha.Shaders;
import tanuki.glsl.Filter;
import tanuki.tool.Util;

class FSLavaLamp extends Filter {
	public function new(?width:Int = 0, ?height:Int = 0) {
		super(Shaders.fslavalamp_frag, null, 0, width, height);
	}

	override public function begin(canvas:Canvas) {
		super.begin(canvas);
		canvas.g2.drawImage(Filter._image, 0, 0);
	}

	override public function end(canvas:Canvas) {
		super.end(canvas);
	}
}