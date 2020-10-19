package tanuki.tile;

import tanuki.Body;

class Tile extends Body {
	public var index:Int;

	public function new(x:Float, y:Float, width:Float, height:Float, index:Int):Void {
		super(x, y);
		this.width = width;
		this.height = height;
		this.index = index;
	}
}