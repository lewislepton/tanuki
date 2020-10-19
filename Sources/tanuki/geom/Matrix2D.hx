package tanuki.geom;

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
import kha.math.Matrix2;

import tanuki.tool.Util;
import tanuki.math.Vector2D;

/**
  A 4x4 matrix
 */

abstract Matrix2D(Matrix2) from Matrix2 to Matrix2  {
    public inline function new(
            _r0c0:Float = 0, _r0c1:Float = 0,
            _r1c0:Float = 0, _r1c1:Float = 0
        ) {
        this = new Matrix2(
            _r0c0, _r0c1,
            _r1c0, _r1c1
        );
    }

    /**
      Accessor for the element in row 0 and column 0
     */
    public var r0c0(get, set):Float;
    private inline function get_r0c0():Float return this._00;
    private inline function set_r0c0(v:Float):Float return this._00 = v;

    /**
      Accessor for the element in row 1 and column 0
     */
    public var r1c0(get, set):Float;
    private inline function get_r1c0():Float return this._01;
    private inline function set_r1c0(v:Float):Float return this._01 = v;

    /**
      Accessor for the element in row 0 and column 1
     */
    public var r0c1(get, set):Float;
    private inline function get_r0c1():Float return this._10;
    private inline function set_r0c1(v:Float):Float return this._10 = v;

    /**
      Accessor for the element in row 1 and column 1
     */
    public var r1c1(get, set):Float;
    private inline function get_r1c1():Float return this._11;
    private inline function set_r1c1(v:Float):Float return this._11 = v;

    /**
      Read an element using a column-major index
      @param key the index to use
      @return Float
     */
    @:arrayAccess
    public inline function get(key:Int):Float {
        return switch(key) {
            case  0: r0c0;
            case  1: r1c0;
            case  2: r0c1;
            case  3: r1c1;
            case _: throw 'Index ${key} out of bounds (0-3)!';
        };
    }

    /**
      Write to an element using a column-major index
      @param key the index to use
      @param value the value to set
      @return Float
     */
    @:arrayAccess
    public inline function set(key:Int, value:Float):Float {
        return switch(key) {
            case  0: r0c0 = value;
            case  1: r1c0 = value;
            case  2: r0c1 = value;
            case  3: r1c1 = value;
            case _: throw 'Index ${key} out of bounds (0-3)!';
        };
    }

    /**
      Tests if two matrices are equal on an element-by-element basis
      @param m the other matrix to check
      @return Bool
     */
    public inline function equals(b:Matrix2D):Bool {
        return !(
               Math.abs(r0c0 - b.r0c0) >= Util.EPSILON
            || Math.abs(r0c1 - b.r0c1) >= Util.EPSILON
            || Math.abs(r1c0 - b.r1c0) >= Util.EPSILON
            || Math.abs(r1c1 - b.r1c1) >= Util.EPSILON
        );
    }

    /**
      Gets a string representation of the matrix
      @return String
     */
    public inline function toString():String {
        return
            '[${r0c0}, ${r0c1}]\n' +
            '[${r1c0}, ${r1c1}]\n';
    }

    /**
      Fill `dest` with an identity matrix
      @param dest the matrix to fill out
      @return Matrix2D
     */
    public inline static function identity(dest:Matrix2D):Matrix2D {
        dest.r0c0 = 1;
        dest.r0c1 = 0;

        dest.r1c0 = 0;
        dest.r1c1 = 1;

        return dest;
    }

    /**
      Copies one matrix into another
      @param src The matrix to copy from
      @param dest The matrix to copy into
      @return Matrix2D
     */
    public inline static function copy(src:Matrix2D, dest:Matrix2D):Matrix2D {
        dest.r0c0 = src.r0c0;
        dest.r0c1 = src.r0c1;
        
        dest.r1c0 = src.r1c0;
        dest.r1c1 = src.r1c1;

        return dest;
    }

    /**
      Transposes a matrix
      @param src The matrix to transpose
      @param dest The destination matrix. Call with `src == dest` to modify `src` in place
      @return Matrix2D
     */
    public inline static function transpose(src:Matrix2D, dest:Matrix2D):Matrix2D {
        var src_r1c0 = src.r1c0;

        dest.r0c0 = src.r0c0;
        dest.r1c0 = src.r0c1;

        dest.r0c1 = src_r1c0;
        dest.r1c1 = src.r1c1;

        return dest;
    }

    /**
      Calculates the determinant of the matrix
      @param src The matrix to calculate the determinant of
      @return Float
     */
    public inline static function determinant(src:Matrix2D):Float {
        return src.r0c0 * src.r1c1 - src.r0c1 * src.r1c0;
    }

    /**
      Inverts the `src` matrix, storing the result in `dest`. If `src == dest`, modifies `src` in place.
      @param src The source matrix
      @param dest The matrix to store the result in
      @return Matrix2D
     */
    public inline static function invert(src:Matrix2D, dest:Matrix2D):Matrix2D {
        var det:Float = Matrix2D.determinant(src);
        if (Math.abs(det) < Util.EPSILON) {
            throw "determinant is too small";
        }

        var invdet:Float = 1.0 / det;

        var _s:Matrix2D = src;
        if(src == dest) _s = Matrix2D.copy(src, new Matrix2D());

        dest.r0c0 =  _s.r1c1 * invdet;
        dest.r0c1 = -_s.r0c1 * invdet;
        dest.r1c0 = -_s.r1c0 * invdet;
        dest.r1c1 =  _s.r0c0 * invdet;
        return dest;
    }

    /**
      Multiplies two matrices together, storing the result in `dest`. Caches `a` and `b` so `a == dest` and `b == dest` are valid.
      @param a The left-hand matrix
      @param b The right-hand matrix
      @param dest The matrix to store the result in
      @return Matrix2D
     */
    public inline static function multMat(a:Matrix2D, b:Matrix2D, dest:Matrix2D):Matrix2D {
        // cache what we need to do the calculations
        var _a:Matrix2D;
        var _b:Matrix2D;
        if(dest == a) {
            _a = Matrix2D.copy(a, new Matrix2D());
            _b = b;
        }
        else if(dest == b) {
            _a = a;
            _b = Matrix2D.copy(b, new Matrix2D());
        }
        else {
            _a = a;
            _b = b;
        }

        dest.r0c0 = _a.r0c0*_b.r0c0 + _a.r0c1*_b.r1c0;
        dest.r0c1 = _a.r0c0*_b.r0c1 + _a.r0c1*_b.r1c1;

        dest.r1c0 = _a.r1c0*_b.r0c0 + _a.r1c1*_b.r1c0;
        dest.r1c1 = _a.r1c0*_b.r0c1 + _a.r1c1*_b.r1c1;
        
        return dest;
    }

    /**
      Shortcut operator for `multMat(a, b, new Matrix2D())`
      @param a 
      @param b 
      @return Matrix2D
     */
    @:op(A * B)
    inline static function multMatOp(a:Matrix2D, b:Matrix2D):Matrix2D {
        return multMat(a, b, new Matrix2D());
    }

    /**
      Multiplies a vector `v` by a matrix `m`, storing the result in `dest`. Caches so `v == dest` is valid.
      @param m The transforming matrix
      @param v The vector to multiply with
      @param dest The resulting vector
      @return Vec4
     */
    public inline static function multVec(m:Matrix2D, v:Vector2D, dest:Vector2D):Vector2D {
        var x:Float = v.x, y:Float = v.y;
        dest.x = m.r0c0*x + m.r0c1*y;
        dest.y = m.r1c0*x + m.r1c1*y;
        return dest;
    }

    /**
      Shortcut for `multVec(m, v, new Vec4())`
      @param m 
      @param v 
      @return Vec4
     */
    @:op(A * B)
    inline static function multVecOp(m:Matrix2D, v:Vector2D):Vector2D {
        return multVec(m, v, new Vector2D());
    }

    /**
      Construct a Matrix2D from an array of floats in column-major order
      @param arr an array with 16 elements
      @return Matrix2D
     */
    @:from
    public inline static function fromFloatArray(arr:Array<Float>):Matrix2D {
        return new Matrix2D(
            arr[0], arr[2],
            arr[1], arr[3]
        );
    }

    /**
      Cast the matrix in an array of floats, in column-major order
      @return Array<Float>
     */
    @:to
    public inline function toFloatArray():Array<Float> {
        return [
            r0c0, r1c0,
            r0c1, r1c1
        ];
    }
}