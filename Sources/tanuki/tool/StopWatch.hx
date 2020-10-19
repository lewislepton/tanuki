package tanuki.tool;

class StopWatch {
  public var duration:Float = 0;
  public static var time:Float;
  public var run:Bool = false;
  var restart = 0.0;

  public function new(){}

  public function update(){
    if (run){
      duration += 1 / 60;
    } else {
      stop();
    }
  }

  public function stop(){
    time = duration;
  }

  public function reset(){
    duration = restart;
    time = restart;
  }
}