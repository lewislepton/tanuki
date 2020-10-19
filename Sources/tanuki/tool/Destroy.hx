package tanuki.tool;

import tanuki.tool.Pool;

class Destroy {
	public static function destroy<T:IDestroy>(object:Null<IDestroy>):T{
		if (object != null){
			object.destroy(); 
		}
		return null;
	}

	public static function destroyArray<T:IDestroy>(array:Array<T>):Array<T>{
		if (array != null){
			for (e in array){
				destroy(e);
			}
			array.splice(0, array.length);
		}
		return null;
	}
}

interface IDestroy {
	function destroy():Void;
}