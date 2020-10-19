package tanuki.ui;

import kha.Font;
import kha.Canvas;
import tanuki.ui.Text;
import tanuki.Body;

class Score extends Body {
  public var score(get, null):Int = 0;
  var _txtScore:Text;

  public function new(font:Font, x:Float, y:Float, size:Int){
    super(x, y);
    _txtScore = new Text(font, '' + score, x, y, size);
  }

  override public function render(canvas:Canvas){
    super.render(canvas);
    _txtScore.string = '' + score;
    _txtScore.render(canvas);
  }

  public function up(value:Int){
    score += value;
  }

  public function down(value:Int){
    score -= value;
  }

  public function reset(){
    score = 0;
  }

  public function get_score():Int {
    return score;
  }
}