package tanuki.glsl.filter;

import tanuki.math.Vector2B;
import kha.graphics4.ConstantLocation;
import kha.Canvas;
import kha.Shaders;
import tanuki.glsl.Filter;
import tanuki.tool.Util;

// Scan Effect
// Lewis Lepton 2020
// https://lewislepton.com

class FSScan extends Filter {
  public var u_size = 120.0;
  public var sizeID:ConstantLocation;

  public var u_speed = 16.0;
  public var speedID:ConstantLocation;

  // public var u_flip:Vector2B = new Vector2B();
  // public var flipXID:ConstantLocation;
  // public var flipYID:ConstantLocation;
  public var u_rotate:Float;
  public var rotateID:ConstantLocation;

	public function new(?width:Int = 0, ?height:Int = 0) {
		super(Shaders.fsscan_frag, null, 0, width, height);

    sizeID = pipeline.getConstantLocation('u_size');
    // flipXID = pipeline.getConstantLocation('u_flipx');
    // flipYID = pipeline.getConstantLocation('u_flipy');
    rotateID = pipeline.getConstantLocation('u_rotate');
    speedID = pipeline.getConstantLocation('u_speed');
	}

	override public function begin(canvas:Canvas) {
		super.begin(canvas);
    canvas.g4.setFloat(sizeID, u_size);
    // canvas.g4.setBool(flipXID, u_flip.x);
    // canvas.g4.setBool(flipYID, u_flip.y);
    canvas.g4.setFloat(rotateID, u_rotate);
    // canvas.g4.setFloat(rotateID, Util.scale(u_rotate, 0, 359, 0, 1));
    canvas.g4.setFloat(speedID, u_speed);
	}

	override public function end(canvas:Canvas) {
		super.end(canvas);
	}
}