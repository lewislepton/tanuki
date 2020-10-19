package tanuki.group;

import tanuki.Body;
import kha.Canvas;

// typedef PoolGroup = Pool<Body>;

class Pool<O:Body> extends Body {
	public var entities:Array<O>;
	public var max:Int;

	public var countEntities(get, null):Int;

	private function get_countEntities():Int {
		return entities.length;
	}

	public function new(max:Int = 100){
		super();
		this.max = max;
		entities = new Array<O>();
	}

	override public function update(){
		super.update();
		var i:Int = 0;
		while (i < entities.length){
			var member = entities[i];
			if (member != null){
				if (member.active){
					member.update();
					if (!member.active){
						if (i < countEntities){
							countEntities = i;
						}
					}
				}
			}
			i++;
		}
	}

	override public function render(canvas:Canvas){
		super.render(canvas);
		for (member in entities){
			if (member != null && member.active){
				member.render(canvas);
			}
		}
	}

	private function first():Int {
		var i = countEntities;
		while (i < entities.length + countEntities){
			var h = i % entities.length;
			if (entities[h] == null || !entities[h].active){
				if (i < entities.length){
					countEntities++;
				}
			}
			i++;
		}
		return -1;
	}

	// public function add(object:O):O {
	// 	var full:Bool = entities.length >= max;
	// 	if (!full){
	// 		entities.push(object);
	// 		return object;
	// 	} else {
	// 		var index = first();
	// 		entities[index] = object;
	// 		return object;
	// 	}
	// }

	// public function remove(object:O){
	// 	entities.remove(object);
	// }

	public function add(object:O, pos:Int = -1):Void {
		if (entities.indexOf(object) != -1) return;
		
		if (pos == -1) entities.push(object);
		else entities.insert(pos, object);
	}

	public function remove(object:O):O {
		var index = entities.indexOf(object);
		// entities[index] = null;
		entities.splice(index, 1);
		// if (index < 0) return null;
    return object;
		// var index = entities.indexOf(object);
		
		// if (index == -1) return null;

		// entities[index].deactivate();
		// entities[index] = null;
		// entities.splice(index, 1);
		
		// return object;
	}

	// public function removeentities(object:O, splice:Bool = false):O {
	// 	var index = entities.indexOf(object);
		
	// 	if (index == -1) return null;
		
	// 	if (splice){
	// 		entities.remove(object);
	// 		entities.splice(index, 1);
	// 		// object.deactivate();
	// 	} else {
	// 		entities[index] = null;
	// 	}
		
	// 	// object.firstFrameExecuted = false;
		
	// 	return object;
	// }

	override public function destroy():Void {
		super.destroy();
		if (entities != null) {
			var i:Int = 0;
			var member = null;
			
			while (i < countEntities){
				member = entities[i++];
				if (member != null && member.active){
					member.destroy();
				}
			}
			entities = null;
		}
	}

	// private static function resolveGroup(ObjectOrGroup:Body):Pool<Body>
	// {
	// 	var group:Pool<Body> = null;
	// 	if (ObjectOrGroup != null)
	// 	{
	// 		if (ObjectOrGroup.n4Type == GROUP)
	// 		{
	// 			group = cast ObjectOrGroup;
	// 		}
	// 		// else if (ObjectOrGroup.n4Type == SPRITEGROUP)
	// 		// {
	// 		// 	var spriteGroup:NTypedSpriteGroup<Dynamic> = cast ObjectOrGroup;
	// 		// 	group = cast spriteGroup.group;
	// 		// }
	// 	}
	// 	return group;
	// }

	public function forEachActive(action:O -> Void){
		for (m in entities){
			if (m != null && m.active){
				action(m);
			}
		}
	}
}