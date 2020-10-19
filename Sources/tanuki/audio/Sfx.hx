package tanuki.audio;

class Sfx {
  public static function play(string:String, ?volume:Float = 0.3){
    var snd = kha.audio1.Audio.play(Reflect.field(kha.Assets.sounds, string), false);
    snd.volume = volume;
  }

  public static function random(string:String, ?volume:Float = 0.6, ?amount:Int = 3){
    var choiceSnd:Int = Math.floor(Math.random() * amount + 1);
		for (i in 0 ... amount){
			if (choiceSnd == i){
				var snd = kha.audio1.Audio.play(Reflect.field(kha.Assets.sounds, string + i), false);
				snd.volume = volume;
			}
      trace(choiceSnd);
		}
  }
}