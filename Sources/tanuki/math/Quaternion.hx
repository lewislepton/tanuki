package tanuki.math;

/*
 * Copyright (c) 2017 Kenton Hamaluik
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at:
 *     http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
*/
import kha.math.Vector4;
import tanuki.tool.Util;
/**
  A quaternion
 */
abstract Quaternion(Vector4) from Vector4 to Vector4  {
    /**
      Accessor for the first element of the quaternion
     */
    public var x(get, set):Float;
    private inline function get_x():Float return this.x;
    private inline function set_x(v:Float):Float return this.x = v;

    /**
      Accessor for the second element of the quaternion
     */
    public var y(get, set):Float;
    private inline function get_y():Float return this.y;
    private inline function set_y(v:Float):Float return this.y = v;

    /**
      Accessor for the third element of the quaternion
     */
    public var z(get, set):Float;
    private inline function get_z():Float return this.z;
    private inline function set_z(v:Float):Float return this.z = v;

    /**
      Accessor for the fourth element of the quaternion
     */
    public var w(get, set):Float;
    private inline function get_w():Float return this.w;
    private inline function set_w(v:Float):Float return this.w = v;

    /**
      Read an element using an index
      @param key the index to use
      @return Float
     */
    @:arrayAccess
    public inline function get(key:Int):Float {
        return switch(key) {
            case 0: x;
            case 1: y;
            case 2: z;
            case 3: w;
            case _: throw 'Index ${key} out of bounds (0-3)!';
        };
    }

    /**
      Write to an element using an index
      @param key the index to use
      @param value the value to set
      @return Float
     */
    @:arrayAccess
    public inline function set(key:Int, value:Float):Float {
        return switch(key) {
            case 0: x = value;
            case 1: y = value;
            case 2: z = value;
            case 3: w = value;
            case _: throw 'Index ${key} out of bounds (0-3)!';
        };
    }

    public inline function new(x:Float = 0, y:Float = 0, z:Float = 0, w:Float = 1) {
        this = new Vector4();
        this.x = x;
        this.y = y;
        this.z = z;
        this.w = w;
    }

    /**
      Checks if `this == v` on an element-by-element basis
      @param v The quaternion to check against
      @return Bool
     */
    public inline function equals(b:Quaternion):Bool {
        return !(
               Math.abs(x - b.x) >= Util.EPSILON
            || Math.abs(y - b.y) >= Util.EPSILON
            || Math.abs(z - b.z) >= Util.EPSILON
            || Math.abs(w - b.w) >= Util.EPSILON
        );
    }

    /**
      Creates a string reprentation of `this`
      @return String
     */
    public inline function toString():String {
        return
            '{${this.x}, ${this.y}, ${this.z}, ${this.w}}';
    }

    /**
      Calculates the square of the magnitude of the quaternion, to save calculation time if the actual magnitude isn't needed
      @return Float
     */
    public inline function lengthSquared():Float {
        return x*x + y*y + z*z + w*w;
    }

    /**
      Calculates the magnitude of the quaternion
      @return Float
     */
    public inline function length():Float {
        return Math.sqrt(lengthSquared());
    }

    /**
      Normalizes `q` such that `q.length() == 1`, and stores the result in `dest`
      @param q 
      @param dest 
      @return Quaternion
     */
    public inline static function normalize(q:Quaternion, dest:Quaternion):Quaternion {
        var length:Float = q.length();
        var mult:Float = 0;
        if(length >= Util.EPSILON) {
            mult = 1 / length;
        }
        return Quaternion.multiplyScalar(q, mult, dest);
    }

    /**
      Calculates the dot product of two quaternions
      @param a 
      @param b 
      @return Float
     */
    public inline static function dot(a:Quaternion, b:Quaternion):Float {
        return
            a.x * b.x +
            a.y * b.y +
            a.z * b.z +
            a.w * b.w;
    }

    /**
      Fills `dest` with an identity quat
      @param dest 
      @return Quaternion
     */
    public inline static function identity(dest:Quaternion):Quaternion {
        dest.x = 0;
        dest.y = 0;
        dest.z = 0;
        dest.w = 1;
        return dest;
    }

    /**
      Copies one quaternion into another
      @param src The quaternion to copy from
      @param dest The quaternion to copy into
      @return Quaternion
     */
    public inline static function copy(src:Quaternion, dest:Quaternion):Quaternion {
        dest.x = src.x;
        dest.y = src.y;
        dest.z = src.z;
        dest.w = src.w;
        return dest;
    }

    /**
      Creates a quaternion from an axis and an angle (in radians).
      @param axis The axis to rotate about. Must be normalized first!
      @param angle The angle to rotate by, in radians
      @param dest Where to store the result
      @return Quaternion
     */
    public inline static function axisAngle(axis:Vector3D, angle:Float, dest:Quaternion):Quaternion {
        angle *= 0.5;
        var s:Float = Math.sin(angle);
        dest.x = s * axis.x;
        dest.y = s * axis.y;
        dest.z = s * axis.z;
        dest.w = Math.cos(angle);
        return dest;
    }

    /**
      Multiplies two quaternions together, both inputs are cached so either can be used as the destination
      @param a The left-hand side quaternion
      @param b The right-hand side quaternion
      @param dest Where to store the result
      @return Quaternion
     */
    public inline static function multiplyQuats(a:Quaternion, b:Quaternion, dest:Quaternion):Quaternion {
        var ax:Float = a.x, ay:Float = a.y, az:Float = a.z, aw:Float = a.w;
        var bx:Float = b.x, by:Float = b.y, bz:Float = b.z, bw:Float = b.w;

        dest.x = ax * bw + aw * bx + ay * bz - az * by;
        dest.y = ay * bw + aw * by + az * bx - ax * bz;
        dest.z = az * bw + aw * bz + ax * by - ay * bx;
        dest.w = aw * bw - ax * bx - ay * by - az * bz;

        return dest;
    }

    /**
      Shortcut for `multiplyQuats(a, b, new Quaternion())`
      @param a The left-hand side quaternion
      @param b The right-hand side quaternion
      @return Quaternion
     */
    @:op(A * B)
    inline static function multiplyQuatsOp(a:Quaternion, b:Quaternion):Quaternion {
        return multiplyQuats(a, b, new Quaternion());
    }

    /**
      Scales `a` by `s`, storing the result in `dest`
      @param a 
      @param s 
      @param dest 
      @return Quaternion
     */
    public inline static function multiplyScalar(a:Quaternion, s:Float, dest:Quaternion):Quaternion {
        dest.x = a.x * s;
        dest.y = a.y * s;
        dest.z = a.z * s;
        dest.w = a.w * s;
        return dest;
    }

    /**
      Shortcut for `multiplyScalar(a, s, new Quaternion())`
      @param a 
      @param s 
      @return Quaternion
     */
    @:op(A * B)
    inline static function multiplyScalarOp(a:Quaternion, s:Float):Quaternion {
        return multiplyScalar(a, s, new Quaternion());
    }

    /**
      Linearly interpolates between `a` and `b`. Note: you probably want `slerp`!
      @param a The value when `t == 0`
      @param b The value when `t == 1`
      @param t A value between `0` and `1`, not clamped by the function
      @param dest The vector to store the result in
      @return Quaternion
     */
    public inline static function lerp(a:Quaternion, b:Quaternion, t:Float, dest:Quaternion):Quaternion {
        dest.x = Util.lerp(t, a.x, b.x);
        dest.y = Util.lerp(t, a.y, b.y);
        dest.z = Util.lerp(t, a.z, b.z);
        dest.w = Util.lerp(t, a.w, b.w);
        return dest;
    }

    /**
      Spherical-linear interpolates between `a` and `b`
      @param a The value when `t == 0`
      @param b The value when `t == 1`
      @param t A value between `0` and `1`, not clamped by the function
      @param dest The vector to store the result in
      @return Quaternion
     */
    public inline static function slerp(a:Quaternion, b:Quaternion, t:Float, dest:Quaternion):Quaternion {
        var bx:Float = b.x, by:Float = b.y, bz:Float = b.z, bw:Float = b.w;

        // calculate cosine
        var cosTheta:Float = dot(a, b);

        // if cosTheta < 0, the interpolation will go the long way around
        // invert 
        if(cosTheta < 0) {
            cosTheta = -cosTheta;
            bx = -bx;
            by = -by;
            bz = -bz;
            bw = -bw;
        }

        // perform a linear interpolation when cosTheta is
        // close to 1 to avoid side effect of sin(angle)
        // becoming a zero denominator
        if(cosTheta > 1 - Util.EPSILON) {
            return lerp(a, b, t, dest);
        }
        else {
            var angle:Float = Math.acos(cosTheta);
            var sa:Float = 1 / Math.sin(angle);
            var i:Float = Math.sin((1 - t) * angle);
            var j:Float = Math.sin(t * angle);

            dest.x = (i * a.x + j * bx) * sa;
            dest.y = (i * a.y + j * by) * sa;
            dest.z = (i * a.z + j * bz) * sa;
            dest.w = (i * a.w + j * bw) * sa;
            return dest;
        }
    }

    /**
      Inverts the quaterion `q`, storing the result in `dest`
      @param q 
      @param dest 
      @return Quaternion
     */
    public inline static function invert(q:Quaternion, dest:Quaternion):Quaternion {
        var x:Float = q.x, y:Float = q.y, z:Float = q.z, w:Float = q.w;
        var d:Float = dot(q, q);
        var oneOverD:Float = if(d < Util.EPSILON) 0; else 1 / d;

        dest.x = -x * oneOverD;
        dest.y = -y * oneOverD;
        dest.z = -z * oneOverD;
        dest.w =  w * oneOverD;

        return dest;
    }

    /**
      Calculates the conjugate of `q`, storing the result in `dest`
      @param q 
      @param dest 
      @return Quaternion
     */
    public inline static function conjugate(q:Quaternion, dest:Quaternion):Quaternion {
        dest.x = -1 * q.x;
        dest.y = -1 * q.y;
        dest.z = -1 * q.z;
        dest.w =      q.w;
        return dest;
    }

    /**
      Constructs a quaternion from roll, pitch, and yaw (x, y, and z axes)
      @param x The angle to rotate around x
      @param y The angle to rotate around y
      @param z The angle to rotate around z
      @param dest Where to store the result
      @return Quaternion
     */
    public inline static function fromEuler(x:Float, y:Float, z:Float, dest:Quaternion):Quaternion {
        var c1:Float = Math.cos(x / 2), c2:Float = Math.cos(y / 2), c3:Float = Math.cos(z / 2);
        var s1:Float = Math.sin(x / 2), s2:Float = Math.sin(y / 2), s3:Float = Math.sin(z / 2);

        dest.x = s1 * c2 * c3 + c1 * s2 * s3;
        dest.y = c1 * s2 * c3 - s1 * c2 * s3;
        dest.z = c1 * c2 * s3 + s1 * s2 * c3;
        dest.w = c1 * c2 * c3 - s1 * s2 * s3;

        return dest;
    }

    /**
      Construct a Quaternion from an array of floats
      @param arr an array with 4 elements, corresponding to x, y, z, w
      @return Quaternion
     */
    @:from
    public inline static function fromFloatArray(arr:Array<Float>):Quaternion {
        return new Quaternion(arr[0], arr[1], arr[2], arr[3]);
    }

    /**
      Converts this into a 4-element array of floats
      @return Array<Float>
     */
    @:to
    public inline function toFloatArray():Array<Float> {
        return [x, y, z, w];
    }
}