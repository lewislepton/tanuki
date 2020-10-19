package tanuki;

import haxe.ds.ArraySort;
import kha.Canvas;
import kha.input.KeyCode;

import tanuki.Body;
import tanuki.collide.Collide;
import tanuki.math.Vector2D;
import tanuki.Camera;

class State {
	// public static var width:Int;
	// public static var height:Int;

	public var active:Bool = false;
	public var count(get, null):Int;

  private var _depth:Bool;
	private var _entities:Array<Body>;
	
	// public var camera:Camera;
	
	public function new(){
		// super();
		active = true;
		_entities = new Array<Body>();
		// camera = new Camera();
		// camera = new Camera(Tanuki.BUFFERWIDTH, Tanuki.BUFFERHEIGHT, Level.map.width, Level.map.height);
		// camera = new Camera(Tanuki.BUFFERWIDTH, Tanuki.BUFFERHEIGHT);
	}

	public function update(){
		// super.update();
		for (entity in _entities){
      if (entity.active){
        entity.update();
      }
    }
	}

	public function render(canvas:Canvas){
		// super.render(canvas);
		// camera.render(canvas);
		// camera.begin(canvas);
		if (_depth) depth(_entities);

    for (entity in _entities){
      if (entity.active){
        entity.render(canvas);
      }
		}
		// camera.end(canvas);
		// camera.end(canvas);
		// canvas.g2.drawRect(camera.deadzone.x, camera.deadzone.y, camera.deadzone.width, camera.deadzone.height);
		// canvas.g2.drawRect(camera.target.position.x, camera.position.y, camera.width, camera.height);
	}

	public function onKeyDown(keyCode:KeyCode){}

	public function onKeyUp(keyCode:KeyCode){}

	public function onMouseDown(button:Int, x:Int, y:Int){}

	public function onMouseUp(button:Int, x:Int, y:Int){}

	public function onMouseMove(x:Int, y:Int, cx:Int, cy:Int){}

	public function onTouchDown(id:Int, x:Int, y:Int){}
	
	public function onTouchUp(id:Int, x:Int, y:Int){}

	public function onTouchMove(id:Int, x:Int, y:Int){}

	public function onGamepadAxis(axis:Int, value:Float){}

	public function onGamepadButton(button:Int, value:Float){}

	/**
   * add object to scene
   * @param entity 
   */
	 public function add(entity:Body){
    entity.active = true;
    _entities.push(entity);
  }

  /**
   * remove object from scene
   * @param entity 
   */
  public function remove(entity:Body){
    entity.active = false;
    _entities.remove(entity);
    entity = null;
  }

  function depth(entities:Array<Body>){
    if (entities.length == 0) return;
    ArraySort.sort(entities, function(ent1:Body, ent2:Body){
      if (ent1.position.y + ent1.height < ent2.position.y + ent2.height){
        return -1;
      } else if (ent1.position.y == ent2.position.y){
        return 0;
      } else {
        return 1;
      }
    });
  }

  /**
   * sort depth
   * @param value 
   * @return Bool
   */
  public function sort(?value:Bool = false):Bool {
    return _depth = value;
  }

	public function get_count():Int {
    return _entities.length;
  }

  /**
   * clear objects from scene
   */
  public function clear(){
    _entities = new Array<Body>();
  }

	public static function set(state:State){
		Tanuki.state = state;
		if (!Tanuki.state.active) Tanuki.setup();
	}
	
	public function collide(entity01:Body, entity02:Body):Bool {
		var intersect:Bool = false;
		var touch:Vector2D = Collide.intersect(entity02, entity01);
		if (touch != null){
			intersect = true;
			Vector2D.addVec(entity01.position, touch, entity01.position);
		} else {
			intersect = false;
		}
		return intersect;
	}

	public function collideArray(entity01:Body, entity02:Array<Body>):Bool {
		var intersect:Bool = false;
		for (entity in entity02){
			var touch:Vector2D = Collide.intersect(entity, entity01);
			if (touch != null){
				intersect = true;
				Vector2D.addVec(entity01.position, touch, entity01.position);
			} else {
				intersect = false;
			}
		}
		return intersect;
	}
	
	public function overlap(entity01:Body, entity02:Body):Bool {
		var intersect:Bool = false;
		if (Collide.overlap(entity01, entity02)){
			intersect = true;
		} else {
			intersect = false;
		}
		return intersect;
	}

	public function overlapArray(entity01:Body, entity02:Array<Body>):Bool {
		var intersect:Bool = false;
		for (entity02 in entity02){
			if (Collide.overlap(entity01, entity02)){
				intersect = true;
			} else {
				intersect = false;
			}
		}
		return intersect;
	}
}