package tanuki.tween;

class Back {
	public static var DRIVE:Float = 1.70158;
	public static inline function easeIn(start:Float, delta:Float, t:Float):Float {
		return delta * t * t * ((DRIVE + 1) * t - DRIVE) + start;
	}
	public static inline function easeOut(start:Float, delta:Float, t:Float):Float {
		return delta * ((t -= 1) * t * ((DRIVE + 1) * t + DRIVE) + 1) + start;
	}
	public static inline function easeInOut(start:Float, delta:Float, t:Float):Float {
		var s = DRIVE * 1.525;
		if ((t*=2) < 1) return (delta * 0.5) * (t * t * (((s) + 1) * t - s)) + start;
		return (delta * 0.5) * ((t -= 2) * t * (((s) + 1) * t + s) + 2) + start;
	}	
}


class Bounce {
	public static inline function easeIn(start:Float, delta:Float, t:Float):Float {
		return delta - easeOut(0, delta, 1 - t) + start;
	}
	public static inline function easeOut(start:Float, delta:Float, t:Float):Float {
		if (t < (1/2.75)) {
			return delta * (7.5625 * t * t) + start;
		} else if (t < (2/2.75)) {
			return delta * (7.5625 * (t -= (1.5 / 2.75)) * t + .75) + start;
		} else if (t < (2.5/2.75)) {
			return delta * (7.5625 * (t -= (2.25 / 2.75)) * t + .9375) + start;
		} else {
			return delta * (7.5625 * (t -= (2.625 / 2.75)) * t + .984375) + start;
		}
	}
	public static inline function easeInOut(start:Float, delta:Float, t:Float):Float {
		if (t < 0.5) {
			return easeIn(0, delta, t*2) * .5 + start;
		} else {
			return easeOut(0, delta, t*2-1) * .5 + delta *.5 + start; 
		}
	}
}


class Cubic {
	static public inline function easeIn(start:Float, delta:Float, t:Float):Float {
		return delta * t * t * t + start;
	}
	static public inline function easeOut(start:Float, delta:Float, t:Float):Float {
		return delta * ((t -= 1) * t * t + 1) + start;
	}
	static public inline function easeInOut(start:Float, delta:Float, t:Float):Float {
		if ((t *= 2) < 1) {
			return delta * 0.5 * t * t * t + start;
		}else {
			return delta * 0.5 * ((t -= 2) * t * t + 2) + start;
		}
	}
}


class Elastic {
	static var a = 0.1;
	static var p = 0.4;
	public static inline function easeIn(start:Float, delta:Float, t:Float):Float {
		if (t == 0) {
			return start;
		}
		if (t == 1) {
			return start + delta;
		}
		var s:Float;
		if (a < Math.abs(delta)) {
			a = delta;
			s = p / 4;
		}
		else {
			s = p / (2 * Math.PI) * Math.asin(delta / a);
		}
		return -(a * Math.pow(2, 10 * (t -= 1)) * Math.sin((t - s) * (2 * Math.PI) / p)) + start;
	}
	public static inline function easeOut(start:Float, delta:Float, t:Float):Float {
		if (t == 0) {
			return start;
		}
		if (t == 1) {
			return start + delta;
		}
		var s:Float;
		if (a < Math.abs(delta)) {
			a = delta;
			s = p / 4;
		}
		else {
			s = p / (2 * Math.PI) * Math.asin(delta / a);
		}
		return a * Math.pow(2, -10 * t) * Math.sin((t - s) * (2 * Math.PI) / p) + delta + start;
		
	}
	public static inline function easeInOut(start:Float, delta:Float, t:Float):Float {
		if (t == 0) {
			return start;
		}
		t *= 2;
		if (t == 2) {
			return start + delta;
		}
		var s:Float;
		if (a < Math.abs(delta)) {
			a = delta;
			s = p / 4;
		}
		else {
			s = p / (2 * Math.PI) * Math.asin(delta / a);
		}
		if (t < 1) {
			return -0.5 * (a * Math.pow(2, 10 * (t -= 1)) * Math.sin((t - s) * (2 * Math.PI) / p)) + start;
		}
		return a * Math.pow(2, -10 * (t -= 1)) * Math.sin((t - s) * (2 * Math.PI) / p) * 0.5 + delta + start;
	}
}


class Expo {
	public static inline function easeIn(start:Float, delta:Float, t:Float):Float {
		return t == 0 ? start : delta * Math.pow(2, 10 * (t - 1)) + start;
	}
	public static inline function easeOut(start:Float, delta:Float, t:Float):Float {
		return t == 1 ? start + delta : delta * (1 - Math.pow(2, -10 * t)) + start;
	}
	public static inline function easeInOut(start:Float, delta:Float, t:Float):Float {
		if (t == 0) {
			return start;
		}
		if (t == 1) {
			return start + delta;
		}
		if ((t *= 2.0) < 1.0) {
			return delta / 2 * Math.pow(2, 10 * (t - 1)) + start;
		}
		return delta / 2 * (2 - Math.pow(2, -10 * --t)) + start;
	}	
}


class Linear {
	public static inline function none(start:Float, delta:Float, time:Float):Float {
		return start + delta * time;
	}
}


class Quad {
	public static inline function easeIn(start:Float, delta:Float, t:Float):Float {
		return delta * t * t + start;
	}
	public static inline function easeOut(start:Float, delta:Float, t:Float):Float {
		return -delta * t * (t - 2) + start;
	}
	public static inline function easeInOut(start:Float, delta:Float, t:Float):Float {
		t *= 2;
		if (t < 1) {
			return delta / 2 * t * t + start;
		}
		return -delta / 2 * ((t - 1) * (t - 3) - 1) + start;
	}
}


class Quart {
	public static inline function easeIn(start:Float, delta:Float, t:Float):Float {
		return delta * t * t * t * t + start;
	}
	public static inline function easeOut(start:Float, delta:Float, t:Float):Float {
		return -delta * ((t -= 1) * t * t * t - 1) + start;
	}
	public static inline function easeInOut(start:Float, delta:Float, t:Float):Float {
		t *= 2;
		if (t < 1) {
			return delta / 2 * t * t * t * t + start;
		}
		return -delta / 2 * ((t -= 2) * t * t * t - 2) + start;
	}
}


class Quint {
	public static inline function easeIn(start:Float, delta:Float, t:Float):Float {
		return delta * t * t * t * t * t + start;
	}
	public static inline function easeOut(start:Float, delta:Float, t:Float):Float {
		return delta * ((t -= 1) * t * t * t * t + 1) + start;
	}
	public static inline function easeInOut(start:Float, delta:Float, t:Float):Float {
		t *= 2;
		if (t < 1) {
			return delta / 2 * t * t * t * t * t + start;
		}
		return delta / 2 * ((t -= 2) * t * t * t * t + 2) + start;
	}	
}


class Sine {
	public static inline function easeIn(start:Float, delta:Float, t:Float):Float {
		return -delta * Math.cos(t * (Math.PI / 2)) + delta + start;
	}
	public static inline function easeOut(start:Float, delta:Float, t:Float):Float {
		return delta * Math.sin(t * (Math.PI / 2)) + start;
	}
	public static inline function easeInOut(start:Float, delta:Float, t:Float):Float {
		return (-delta * 0.5) * (Math.cos(Math.PI * t) - 1) + start;
	}
}