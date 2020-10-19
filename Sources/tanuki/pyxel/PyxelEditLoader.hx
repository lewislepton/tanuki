package tanuki.pyxel;

import kha.Canvas;
import kha.graphics2.Graphics;
using kha.graphics2.GraphicsExtension;
import kha.Color;
import kha.Assets;

import tanuki.Body;
import tanuki.pyxel.PyxelEdit;
import tanuki.pyxel.PyxelEdit.Layer;
import tanuki.tile.Tileset;

class PyxelEditLoader {
	var pyxelEdit:PyxelEdit;
	
	var tileArray:Array<Array<Int>>;
	var tileset:Tileset;
	var tilesetName:String;

	var layerName:String;
	// var tileWidth:Int;
	// var tileHeight:Int;
	var layerNumber:Int = 0;
	var layer:Layer;

	public var entity:Array<Body>;

	public function new(pyxelEditXMLString:String, tilesetName:String, layerName:String, layerNumber:Int){
		this.layerName = layerName;
		// this.tileWidth = tileWidth;
		// this.tileHeight = tileHeight;
		this.layerNumber = layerNumber;

		// this.tilesetName = pyxelEditXMLString.toString();

		pyxelEdit = new PyxelEdit(pyxelEditXMLString);
		layer = pyxelEdit.getDatasFromLayer(layerName);
		tileArray = pyxelEdit.getLayerArray(layer);
		
		// tileset = new Tileset(Reflect.field(Assets.images, tilesetName), tileWidth, tileHeight);
		// tileset = new Tileset(Reflect.field(Assets.images, tilesetName), PyxelEdit.TILE_WIDTH, PyxelEdit.TILE_HEIGHT);
		tileset = new Tileset(PyxelEdit.TILE_WIDTH, PyxelEdit.TILE_HEIGHT, Reflect.field(Assets.images, tilesetName));

		setupEntity();
	}

	public function render(canvas:Canvas){
		for (row in 0 ... tileArray.length){
			for (col in 0 ... tileArray[row].length){
				if (tileArray[row][col] == layerNumber){
					canvas.g2.color = Color.White;
					tileset.render(canvas);
				}
			}
		}
	}

	function setupEntity(){
		entity = new Array<Body>();
		for (row in 0 ... tileArray.length){
			for (col in 0 ... tileArray[row].length){
				if (tileArray[row][col] == layerNumber){
					var ent = new Body(row * tileset..width, col * tileset.height, tileset.width, tileset.height);
					entity.push(ent);
				}
			}
		}
	}
}