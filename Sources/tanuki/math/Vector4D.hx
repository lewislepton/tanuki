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
  A four-element vector
 */
abstract Vector4D(Vector4) from Vector4 to Vector4  {
    /**
      Accessor for the first element of the vector
     */
    public var x(get, set):Float;
    private inline function get_x():Float return this.x;
    private inline function set_x(v:Float):Float return this.x = v;

    /**
      Accessor for the second element of the vector
     */
    public var y(get, set):Float;
    private inline function get_y():Float return this.y;
    private inline function set_y(v:Float):Float return this.y = v;

    /**
      Accessor for the third element of the vector
     */
    public var z(get, set):Float;
    private inline function get_z():Float return this.z;
    private inline function set_z(v:Float):Float return this.z = v;

    /**
      Accessor for the fourth element of the vector
     */
    public var w(get, set):Float;
    private inline function get_w():Float return this.w;
    private inline function set_w(v:Float):Float return this.w = v;
    
    /**
      Accessor for the first element of the vector
     */
    public var r(get, set):Float;
    private inline function get_r():Float return this.x;
    private inline function set_r(v:Float):Float return this.x = v;

    /**
      Accessor for the second element of the vector
     */
    public var g(get, set):Float;
    private inline function get_g():Float return this.y;
    private inline function set_g(v:Float):Float return this.y = v;

    /**
      Accessor for the third element of the vector
     */
    public var b(get, set):Float;
    private inline function get_b():Float return this.z;
    private inline function set_b(v:Float):Float return this.z = v;

    /**
      Accessor for the fourth element of the vector
     */
    public var a(get, set):Float;
    private inline function get_a():Float return this.w;
    private inline function set_a(v:Float):Float return this.w = v;

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

    public inline function new(x:Float = 0, y:Float = 0, z:Float = 0, w:Float = 0) {
        this = new Vector4();
        this.x = x;
        this.y = y;
        this.z = z;
        this.w = w;
    }

    /**
      Checks if `this == v` on an element-by-element basis
      @param v - The vector to check against
      @return Bool
     */
    public inline function equals(b:Vector4D):Bool {
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
            '<${this.x}, ${this.y}, ${this.z}, ${this.w}>';
    }

    /**
      Calculates the square of the magnitude of the vector, to save calculation time if the actual magnitude isn't needed
      @return Float
     */
    public inline function lengthSquared():Float {
        return x*x + y*y + z*z + w*w;
    }

    /**
      Calculates the magnitude of the vector
      @return Float
     */
    public inline function length():Float {
        return Math.sqrt(lengthSquared());
    }

    /**
      Copies one vector into another
      @param src The vector to copy from
      @param dest The vector to copy into
      @return Vector4D
     */
    public inline static function copy(src:Vector4D, dest:Vector4D):Vector4D {
        dest.x = src.x;
        dest.y = src.y;
        dest.z = src.z;
        dest.w = src.w;
        return dest;
    }

    /**
      Utility for setting an entire vector at once
      @param dest The vector to set values into
      @param x 
      @param y 
      @param z 
      @param w 
      @return Vector4D
     */
    public inline static function setComponents(dest:Vector4D, x:Float = 0, y:Float = 0, z:Float = 0, w:Float = 0):Vector4D {
        dest.x = x;
        dest.y = y;
        dest.z = z;
        dest.w = w;
        return dest;
    }

    /**
      Adds two vectors on an element-by-element basis
      @param a 
      @param b 
      @param dest The vector to store the result in
      @return Vector4D
     */
    public inline static function addVec(a:Vector4D, b:Vector4D, dest:Vector4D):Vector4D {
        dest.x = a.x + b.x;
        dest.y = a.y + b.y;
        dest.z = a.z + b.z;
        dest.w = a.w + b.w;
        return dest;
    }

    /**
      Subtracts `b` from `a` on an element-by-element basis
      @param a 
      @param b 
      @param dest The vector to store the result in
      @return Vector4D
     */
    public inline static function subtractVec(a:Vector4D, b:Vector4D, dest:Vector4D):Vector4D {
        dest.x = a.x - b.x;
        dest.y = a.y - b.y;
        dest.z = a.z - b.z;
        dest.w = a.w - b.w;
        return dest;
    }

    /**
      Shortcut operator for `addVec(a, b, new Vector4D())`
      @param a 
      @param b 
      @return Vector4D
     */
    @:op(A + B)
    inline static function addVecOp(a:Vector4D, b:Vector4D):Vector4D {
        return addVec(a, b, new Vector4D());
    }

    /**
      Shortcut operator for `subtractVec(a, b, new Vector4D())`
      @param a 
      @param b 
      @return Vector4D
     */
    @:op(A - B)
    inline static function subtractVecOp(a:Vector4D, b:Vector4D):Vector4D {
        return subtractVec(a, b, new Vector4D());
    }

    /**
      Adds a scalar to a vector
      @param a The vector to add a scalar to
      @param s A scalar to add
      @param dest The vector to store the result in
      @return Vector4D
     */
    public inline static function addScalar(a:Vector4D, s:Float, dest:Vector4D):Vector4D {
        dest.x = a.x + s;
        dest.y = a.y + s;
        dest.z = a.z + s;
        dest.w = a.w + s;
        return dest;
    }

    /**
      Multiplies the elements of `a` by `s`, storing the result in `dest`
      @param a 
      @param s 
      @param dest 
      @return Vector4D
     */
    public inline static function multiplyScalar(a:Vector4D, s:Float, dest:Vector4D):Vector4D {
        dest.x = a.x * s;
        dest.y = a.y * s;
        dest.z = a.z * s;
        dest.w = a.w * s;
        return dest;
    }

    /**
      Shortcut operator for `addScalar(a, s, new Vector4D())`
      @param a 
      @param s 
      @return Vector4D
     */
    @:op(A + B)
    inline static function addScalarOp(a:Vector4D, s:Float):Vector4D {
        return addScalar(a, s, new Vector4D());
    }

    /**
      Shortcut operator for `addScalar(a, -s, new Vector4D())`
      @param a 
      @param s 
      @return Vector4D
     */
    @:op(A - B)
    inline static function subtractScalarOp(a:Vector4D, s:Float):Vector4D {
        return addScalar(a, -s, new Vector4D());
    }

    /**
      Shortcut operator for `multiplyScalar(a, s, new Vector4D())`
      @param a 
      @param s 
      @return Vector4D
     */
    @:op(A * B)
    inline static function multiplyScalarOp(a:Vector4D, s:Float):Vector4D {
        return multiplyScalar(a, s, new Vector4D());
    }

    /**
      Shortcut operator for `multiplyScalar(a, 1/s, new Vector4D())`
      @param a 
      @param s 
      @return Vector4D
     */
    @:op(A / B)
    inline static function divideScalarOp(a:Vector4D, s:Float):Vector4D {
        return multiplyScalar(a, 1/s, new Vector4D());
    }

    /**
      Calculates the square of the distance between two vectors
      @param a 
      @param b 
      @return Float
     */
    public inline static function distanceSquared(a:Vector4D, b:Vector4D):Float {
        return (a.x - b.x) * (a.x - b.x) +
            (a.y - b.y) * (a.y - b.y) +
            (a.z - b.z) * (a.z - b.z) +
            (a.w - b.w) * (a.w - b.w);
    }

    /**
      Calculates the distance (magnitude) between two vectors
      @param a 
      @param b 
      @return Float
     */
    public inline static function distance(a:Vector4D, b:Vector4D):Float {
        return Math.sqrt(distanceSquared(a, b));
    }

    /**
      Calculates the dot product of two vectors
      @param a 
      @param b 
      @return Float
     */
    public inline static function dot(a:Vector4D, b:Vector4D):Float {
        return a.x * b.x +
            a.y * b.y +
            a.z * b.z +
            a.w * b.w;
    }

    /**
      Normalizes `v` such that `v.length() == 1`, and stores the result in `dest`
      @param v 
      @param dest 
      @return Vector4D
     */
    public inline static function normalize(v:Vector4D, dest:Vector4D):Vector4D {
        var length:Float = v.length();
        var mult:Float = 0;
        if(length >= Util.EPSILON) {
            mult = 1 / length;
        }
        return Vector4D.multiplyScalar(v, mult, dest);
    }

    /**
      Linearly interpolates between `a` and `b`.
      @param a The value when `t == 0`
      @param b The value when `t == 1`
      @param t A value between `0` and `1`, not clamped by the function
      @param dest The vector to store the result in
      @return Vector4D
     */
    public inline static function lerp(a:Vector4D, b:Vector4D, t:Float, dest:Vector4D):Vector4D {
        dest.x = Util.lerp(t, a.x, b.x);
        dest.y = Util.lerp(t, a.y, b.y);
        dest.z = Util.lerp(t, a.z, b.z);
        dest.w = Util.lerp(t, a.w, b.w);
        return dest;
    }

    /**
      Construct a Vector4D from an array of floats
      @param arr an array with 4 elements, corresponding to x, y, z, w
      @return Vector4D
     */
    @:from
    public inline static function fromFloatArray(arr:Array<Float>):Vector4D {
        return new Vector4D(arr[0], arr[1], arr[2], arr[3]);
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