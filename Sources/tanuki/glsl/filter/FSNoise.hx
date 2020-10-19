package tanuki.glsl.filter;

import kha.graphics4.ConstantLocation;
import kha.Canvas;
import kha.Shaders;
import tanuki.glsl.Filter;
import tanuki.tool.Util;

class FSNoise extends Filter {
	public function new(width:Int, height:Int) {
		super(Shaders.fsnoise_frag, null, 0, width, height);
	}

	override public function begin(canvas:Canvas) {
		super.begin(canvas);
	}

	override public function end(canvas:Canvas) {
		super.end(canvas);
	}
}
