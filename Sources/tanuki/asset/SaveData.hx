package tanuki.asset;

import kha.Storage;
import kha.StorageFile;

class SaveData {
	private var data:Dynamic;
	private var saved:Bool = false;

	public function new(){}

	public function create(){
		data = getSave().readObject();
		trace(data);
	}

	public function set(id:String, val:Dynamic){
		Reflect.setField(data, id, val);
	}

	public function get(id:String):Dynamic {
		return Reflect.field(data, id);
	}

	public function save(){
		getSave().writeObject(data);
		saved = true;
	}

	public function erase(){
		data = {};
		getSave().writeObject(data);
	}

	public function isSaved():Bool {
		return saved;
	}

	public function getSave():StorageFile {
		return Storage.namedFile('save.kha');
	}
}


// import kha.Storage;
// import kha.StorageFile;

// typedef SettingsData = {
// 	?v:Int,
// 	?levelProgress:Int,
// 	?musicVolume:Int,
// 	?lang:String,
// 	?controlType:Int,
// 	?touchMode:Bool,
// }

// class Settings {
	
// 	static inline var v = 1;
	
// 	public static function read():SettingsData {
// 		var file = Storage.defaultFile();
// 		var data:SettingsData = file.readObject();
// 		data = checkData(data);
// 		//trace(data);
// 		return data;
// 	}
	
// 	public static function set(sets:SettingsData):Void {
// 		var data = read();
		
// 		var fields = Reflect.fields(sets);
// 		for (field in fields) {
// 			var value = Reflect.field(sets, field);
// 			Reflect.setField(data, field, value);
// 		}
		
// 		write(data);
// 	}
	
// 	public static function write(data:SettingsData):Void {
// 		var file = Storage.defaultFile();
// 		data.v = v;
// 		file.writeObject(data);
// 	}
	
// 	public static function reset():Void {
// 		var data = checkData(null);
// 		write(data);
// 	}
	
// 	static inline function checkData(data:SettingsData):SettingsData {
// 		if (data != null && data.v == v) return data;
// 		var data:SettingsData = {
// 			v: v,
// 			levelProgress: 1,
// 			controlType: 1
// 		};
// 		return data;
// 	}
	
// }
