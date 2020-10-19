package tanuki.tile;

import kha.Image;

import tanuki.tile.Tile;
import tanuki.tile.Tileset;

class Tilemap {
	public static function fromMatrix(tileWidth:Int, tileHeight:Int, tileSheet:Image, tileData:Array<Array<Int>>):Tileset {
		var width = tileData[0].length;
		var height = tileData.length;
		var tileset = new Tileset(tileWidth, tileHeight, tileSheet);

		for (y in 0 ... height) {
			for (x in 0 ... width) {
				tileset.add(new Tile(x * tileWidth, y * tileHeight, tileWidth, tileHeight, tileData[y][x]));
			}
		}
		return tileset;
	}
}
