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

import kha.math.Vector2;

import tanuki.tool.Util;

/**
  A two-element vector
 */
abstract Vector2D(Vector2) from Vector2 to Vector2  {
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
      Accessor for the first element of the vector
     */
    public var i(get, set):Float;
    private inline function get_i():Float return this.x;
    private inline function set_i(v:Float):Float return this.x = v;

    /**
      Accessor for the second element of the vector
     */
    public var j(get, set):Float;
    private inline function get_j():Float return this.y;
    private inline function set_j(v:Float):Float return this.y = v;

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
            case _: throw 'Index ${key} out of bounds (0-1)!';
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
            case _: throw 'Index ${key} out of bounds (0-1)!';
        };
    }

    public inline function new(x:Float = 0, y:Float = 0) {
        this = new Vector2();
        this.x = x;
        this.y = y;
    }

    /**
      Checks if `this == v` on an element-by-element basis
      @param v - The vector to check against
      @return Bool
     */
    public inline function equals(b:Vector2D):Bool {
        return !(
               Math.abs(x - b.x) >= Util.EPSILON || Math.abs(y - b.y) >= Util.EPSILON);
    }

    /**
      Creates a string reprentation of `this`
      @return String
     */
    public inline function toString():String {
        return
            '<${x}, ${y}>';
    }

    /**
      Calculates the square of the magnitude of the vector, to save calculation time if the actual magnitude isn't needed
      @return Float
     */
    public inline function lengthSquared():Float {
        return x*x + y*y;
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
      @return Vector2D
     */
    public inline static function copy(src:Vector2D, dest:Vector2D):Vector2D {
        dest.x = src.x;
        dest.y = src.y;
        return dest;
    }

    /**
      Utility for setting an entire vector at once
      @param dest The vector to set values into
      @param x 
      @param y 
      @return Vector2D
     */
    public inline static function setComponents(dest:Vector2D, x:Float = 0, y:Float = 0):Vector2D {
        dest.x = x;
        dest.y = y;
        return dest;
    }

    /**
      Adds two vectors on an element-by-element basis
      @param a 
      @param b 
      @param dest The vector to store the result in
      @return Vector2D
     */
    public inline static function addVec(a:Vector2D, b:Vector2D, dest:Vector2D):Vector2D {
        dest.x = a.x + b.x;
        dest.y = a.y + b.y;
        return dest;
    }

    /**
      Subtracts `b` from `a` on an element-by-element basis
      @param a 
      @param b 
      @param dest The vector to store the result in
      @return Vector2D
     */
    public inline static function subtractVec(a:Vector2D, b:Vector2D, dest:Vector2D):Vector2D {
        dest.x = a.x - b.x;
        dest.y = a.y - b.y;
        return dest;
    }

    /**
      Shortcut operator for `addVec(a, b, new Vector2D())`
      @param a 
      @param b 
      @return Vector2D
     */
    @:op(A + B)
    inline static function addVecOp(a:Vector2D, b:Vector2D):Vector2D {
        return addVec(a, b, new Vector2D());
    }

    /**
      Shortcut operator for `subtractVec(a, b, new Vector2D())`
      @param a 
      @param b 
      @return Vector2D
     */
    @:op(A - B)
    inline static function subtractVecOp(a:Vector2D, b:Vector2D):Vector2D {
        return subtractVec(a, b, new Vector2D());
    }

    /**
      Adds a scalar to a vector
      @param a The vector to add a scalar to
      @param s A scalar to add
      @param dest The vector to store the result in
      @return Vector2D
     */
    public inline static function addScalar(a:Vector2D, s:Float, dest:Vector2D):Vector2D {
        dest.x = a.x + s;
        dest.y = a.y + s;
        return dest;
    }

    /**
      Multiplies the elements of `a` by `s`, storing the result in `dest`
      @param a 
      @param s 
      @param dest 
      @return Vector2D
     */
    public inline static function multiplyScalar(a:Vector2D, s:Float, dest:Vector2D):Vector2D {
        dest.x = a.x * s;
        dest.y = a.y * s;
        return dest;
    }

    /**
      Shortcut operator for `addScalar(a, s, new Vector2D())`
      @param a 
      @param s 
      @return Vector2D
     */
    @:op(A + B)
    inline static function addScalarOp(a:Vector2D, s:Float):Vector2D {
        return addScalar(a, s, new Vector2D());
    }

    /**
      Shortcut operator for `addScalar(a, -s, new Vector2D())`
      @param a 
      @param s 
      @return Vector2D
     */
    @:op(A - B)
    inline static function subtractScalarOp(a:Vector2D, s:Float):Vector2D {
        return addScalar(a, -s, new Vector2D());
    }

    /**
      Shortcut operator for `multiplyScalar(a, s, new Vector2D())`
      @param a 
      @param s 
      @return Vector2D
     */
    @:op(A * B)
    inline static function multiplyScalarOp(a:Vector2D, s:Float):Vector2D {
        return multiplyScalar(a, s, new Vector2D());
    }

    /**
      Shortcut operator for `multiplyScalar(a, 1/s, new Vector2D())`
      @param a 
      @param s 
      @return Vector2D
     */
    @:op(A / B)
    inline static function divideScalarOp(a:Vector2D, s:Float):Vector2D {
        return multiplyScalar(a, 1/s, new Vector2D());
    }

    /**
      Calculates the square of the distance between two vectors
      @param a 
      @param b 
      @return Float
     */
    public inline static function distanceSquared(a:Vector2D, b:Vector2D):Float {
        return (a.x - b.x) * (a.x - b.x) +
            (a.y - b.y) * (a.y - b.y);
    }

    /**
      Calculates the distance (magnitude) between two vectors
      @param a 
      @param b 
      @return Float
     */
    public inline static function distance(a:Vector2D, b:Vector2D):Float {
        return Math.sqrt(distanceSquared(a, b));
    }

    /**
      Calculates the dot product of two vectors
      @param a 
      @param b 
      @return Float
     */
    public inline static function dot(a:Vector2D, b:Vector2D):Float {
        return a.x * b.x +
            a.y * b.y;
    }

    /**
      Calculates the cross product of `a` and `b`
      @param a The left-hand side vector to cross
      @param b The right-hand side vector to cross
      @param dest Where to store the result
      @return Vector3D `dest`
     */
    public inline static function cross(a:Vector2D, b:Vector2D, dest:Vector3D):Vector3D {
        dest = new Vector3D(
            0,
            0,
            a.x * b.y - a.y * b.x);
        return dest;
    }

    /**
      Normalizes `v` such that `v.length() == 1`, and stores the result in `dest`
      @param v 
      @param dest 
      @return Vector2D
     */
    public inline static function normalize(v:Vector2D, dest:Vector2D):Vector2D {
        var length:Float = v.length();
        var mult:Float = 0;
        if(length >= Util.EPSILON) {
            mult = 1 / length;
        }
        return Vector2D.multiplyScalar(v, mult, dest);
    }

    /**
      Linearly interpolates between `a` and `b`.
      @param a The value when `t == 0`
      @param b The value when `t == 1`
      @param t A value between `0` and `1`, not clamped by the function
      @param dest The vector to store the result in
      @return Vector2D
     */
    public inline static function lerp(a:Vector2D, b:Vector2D, t:Float, dest:Vector2D):Vector2D {
        dest.x = Util.lerp(t, a.x, b.x);
        dest.y = Util.lerp(t, a.y, b.y);
        return dest;
    }

    /**
      Construct a Vector2D from an array of floats
      @param arr an array with 2 elements, corresponding to x, y
      @return Vector2D
     */
    @:from
    public inline static function fromFloatArray(arr:Array<Float>):Vector2D {
        return new Vector2D(arr[0], arr[1]);
    }

    /**
      Converts this into a 2-element array of floats
      @return Array<Float>
     */
    @:to
    public inline function toFloatArray():Array<Float> {
        return [x, y];
    }
}