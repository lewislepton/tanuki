package tanuki.collide;

import tanuki.math.Vector2D;

/**
 Implement a shape to use the object in Headbutt calculations
**/
interface Shape {
    /**
     The center of the shape, in global coordinates
    **/
    public var center(get, never): Vector2D;

    /**
       Given a direction in global coordinates, return the vertex (in global coordinates)
       that is the furthest in that direction
       @param direction the direction to find the support vertex in
       @return Vec2
    */
    public function support(direction: Vector2D): Vector2D;
}