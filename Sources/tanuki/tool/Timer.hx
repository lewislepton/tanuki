package tanuki.tool;

import kha.Scheduler;

class Timer {
  public var current(get, null):Float;
	public var delta:Float;
	public var last:Float;
	public var fps(get, null):Int;
	private var times:Array<Float>;

	public function new(){
		times = []; 
		reset();
	}

	public function update(){
		current = Scheduler.time();
    delta = current - last;
    last = current;
    times.push(current);
		
		while (times[0] < current - 1){
			times.shift();
    }
		fps = times.length;
	}

  public function reset(){
		last = Scheduler.time();
		delta = 0;
	}

	public function resetTime(){
		Scheduler.resetTime();
	}

  public function get_current():Float {
    return current;
  }

  public function get_fps():Int {
    return fps;
  }
}