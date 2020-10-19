package tanuki.asset;

import kha.Blob;
import kha.Image;
import haxe.io.Bytes;
import tanuki.tmx.TiledMap;

class Resources {

  public static function jsonData(string:String){
    return haxe.Json.parse(haxe.Resource.getString(string));
  }

  // public static function tiledMap(string:String){
  //   // return haxe.xml.Parser.parse(haxe.Resource.getString(string));
    
  //   // TiledMap.fromAssets(Assets.blobs.get(string + '_tmx').toString())
  //   return TiledMap.fromAssets(haxe.Resource.getString(string));
  // }
}