package tanuki.group;

import tanuki.Body;
import tanuki.group.Pool;

typedef Group = Pool<Body>

// class Group {
// 	public var components:Map<String, Body>;
// 	public var exist:Bool;

// 	public function new(){
// 		components = new Map<String, Body>();
//     exist = true;
// 	}

// 	public function update(){
// 		if (!exist) { return; }
//     for (each in components.keys()){
// 			components[each].update();
// 		}
// 	}

// 	public function render(canvas:Canvas){
//     if (!exist) { return; }
// 		for (each in components.keys()){
// 			components[each].render(canvas);
// 		}		
// 	}    

//   public function addComponent(object:Body):Bool{
//     if (!exist) { return false; }
//     if(!components.exists(object.name)){
//       object.group = this;
//       components[object.name] = object;
//       return true;
//     }

//     trace("Body already exists :" + object.name);
//     return false;
//   }

//   public function getComponent(object:String):Dynamic{
//     if (!exist) { return null; }
//     return components[object];
//   }

//   public function removeComponent(name:String){
//     if (!exist) { return; }
//     components.remove(name);
//   }
// }







// // class Group {
// // 	private var entities:Array<Body>;
// // 	public var max:Int;

// // 	public var countEntities(get, null):Int;

// // 	private function get_countEntities():Int {
// // 		return entities.length;
// // 	}

// // 	public function new(max:Int = 100){
// // 		this.max = max;
// // 		entities = new Array<Body>();
// // 	}

// // 	public function update(){
// // 		var i:Int = 0;
// // 		while (i < entities.length){
// // 			var member = entities[i];
// // 			if (member != null){
// // 				if (member.active){
// // 					member.update();
// // 					if (!member.active){
// // 						if (i < countEntities){
// // 							countEntities = i;
// // 						}
// // 					}
// // 				}
// // 			}
// // 			i++;
// // 		}
// // 	}

// // 	public function render(canvas:Canvas){
// // 		for (member in entities){
// // 			if (member != null && member.active){
// // 				member.render(canvas);
// // 			}
// // 		}
// // 	}

// // 	private function first():Int {
// // 		var i = countEntities;
// // 		while (i < entities.length + countEntities){
// // 			var h = i % entities.length;
// // 			if (entities[h] == null || !entities[h].active){
// // 				if (i < entities.length){
// // 					countEntities++;
// // 				}
// // 			}
// // 			i++;
// // 		}
// // 		return -1;
// // 	}

// // 	public function add(object:Body):Body {
// // 		var full:Bool = entities.length >= max;
// // 		if (!full){
// // 			entities.push(object);
// // 			return object;
// // 		} else {
// // 			var index = first();
// // 			entities[index] = object;
// // 			return object;
// // 		}
// // 	}

// // 	// public function remove(object:Body){
// // 	// 	entities.remove(object);
// // 	// }

// // 	// public function add(object:Body, pos:Int = -1):Void {
// // 	// 	if (entities.indexOf(object) != -1) return;
		
// // 	// 	if (pos == -1) entities.push(object);
// // 	// 	else entities.insert(pos, object);
// // 	// }

// // 	// public function remove(object:Body):Body {
// // 	// 	var index = entities.indexOf(object);
// // 	// 	// entities[index] = null;
// // 	// 	entities.splice(index, 1);
// // 	// 	// if (index == -1) return null;
// //   //   return object;
// // 	// 	// var index = entities.indexOf(object);
		
// // 	// 	// if (index == -1) return null;

// // 	// 	// entities[index].deactivate();
// // 	// 	// entities[index] = null;
// // 	// 	// entities.splice(index, 1);
		
// // 	// 	// return object;
// // 	// }

// // 	public function removeEntity(object:Body, splice:Bool = false):Body {
// //     entities.remove(object);
// // 		var index = entities.indexOf(object);
		
// // 		// if (index == -1) return null;
		
// // 		// if (splice){
// // 		// 	entities.remove(object);
// // 			// entities.splice(index, 1);
// // 		// 	// object.deactivate();
// // 		// } else {
// // 		// 	entities[index] = null;
// // 		// }
		
// // 		// object.firstFrameExecuted = false;
		
// // 		return object;
// // 	}

// // 	public function kill():Void {
// // 		// super.kill();
// // 		if (entities != null) {
// // 			var i:Int = 0;
// // 			var member = null;
			
// // 			while (i < countEntities){
// // 				member = entities[i++];
// // 				if (member != null && member.active){
// // 					member.kill();
// // 				}
// // 			}
// // 			entities = null;
// // 		}
// // 	}

// // 	// private static function resolveGroup(ObjectOrGroup:Entity):Pool<Entity>
// // 	// {
// // 	// 	var group:Pool<Entity> = null;
// // 	// 	if (ObjectOrGroup != null)
// // 	// 	{
// // 	// 		if (ObjectOrGroup.n4Type == GROUP)
// // 	// 		{
// // 	// 			group = cast ObjectOrGroup;
// // 	// 		}
// // 	// 		// else if (ObjectOrGroup.n4Type == SPRITEGROUP)
// // 	// 		// {
// // 	// 		// 	var spriteGroup:NTypedSpriteGroup<Dynamic> = cast ObjectOrGroup;
// // 	// 		// 	group = cast spriteGroup.group;
// // 	// 		// }
// // 	// 	}
// // 	// 	return group;
// // 	// }

// // 	public function forEachActive(action:Body -> Void){
// // 		for (m in entities){
// // 			if (m != null && m.active){
// // 				action(m);
// // 			}
// // 		}
// // 	}
// // }