
public static class PhysEngMath {

  //Precision for float comparison, equal to 0.00005 meters
  public static final float precision = 0.00005f;

  public static float Clamp(float value, float min, float max) {
    if (min == max) {
      return min;
    } else if (min > max) {
      throw new IllegalArgumentException("min must be less than max");
    } else if (value < min) {
      return min;
    } else if (value > max) {
      return max;
    } else {
      return value;
    }
  }
  public static int Clamp(int value, int min, int max) {
    if (min == max) {
      return min;
    } else if (min > max) {
      throw new IllegalArgumentException("min must be less than max");
    } else if (value < min) {
      return min;
    } else if (value > max) {
      return max;
    } else {
      return value;
    }
  }
  
  
  public static PVector Transform(PVector vertex, PVector position, float angle) {
  
    //Gives you the position of the vertex (which will always centered around 0,0)
    float positionX = vertex.x;
    float positionY = vertex.y;
    
    //Tells you the angle through which you want to rotate, and the sin and cosine
    // values for that angle
    float sin = sin(angle);
    float cos = cos(angle);
    
    
    //Rotates the vertex around 0,0 by that amount
    float rotationX = positionX * cos - positionY * sin;
    float rotationY = positionX * sin + positionY * cos;
    
    //then transforms the vertex by the position, which will always be the bodies position
    float transformX = rotationX + position.x;
    float transformY = rotationY + position.y;
    
    //returns the transformed vertex
    return new PVector(transformX, transformY);
    
    
  }
  
  //Overloaded method for Transform
  public static PVector Transform(float x, float y, float angle) {
    float positionX = x;
    float positionY = y;
    float sin = sin(angle);
    float cos = cos(angle);
    
    float rotationX = positionX * cos - positionY * sin;
    float rotationY = positionX * sin + positionY * cos;
    
    float transformX = rotationX + x;
    float transformY = rotationY + y;
    
    return new PVector(transformX, transformY);
  }
  
  public static PVector zeroTransform = Transform(0, 0, 0);

  public static boolean Equals(float a, float b) {

    return Math.abs(a - b) < precision;

  }

  public static boolean Equals(PVector a, PVector b) {
    return PVector.sub(a, b).magSq() < precision * precision; //magSq is faster than mag
  }

public static PVector SnapToCircle(Rigidbody rigidbody, PVector point) {
    PVector circleCenter = rigidbody.getPosition();
    PVector direction = PVector.sub(point, circleCenter);
    direction.normalize();
    direction.mult(rigidbody.getRadius());
    return direction;
}

public static PVector SnapToPolygon(Rigidbody rigidbody, PVector point) {
    PVector closestOnPolygon = new PVector();
    float minDistanceSq = Float.MAX_VALUE;

    PVector[] vertices = rigidbody.GetTransformedVertices();

    for(int i = 0; i < vertices.length; i++) {
        PVector start = vertices[i];
        PVector end = vertices[(i + 1) % vertices.length];
        PVector closest = getClosestPointOnLine(start, end, point);

        float distanceSq = PVector.sub(point, closest).magSq();

        if(distanceSq < minDistanceSq) {
            minDistanceSq = distanceSq;
            closestOnPolygon.set(closest);
        }
    }
    return PVector.sub(closestOnPolygon, rigidbody.getPosition());
  }

  private static PVector getClosestPointOnLine(PVector start, PVector end, PVector point) {
    PVector line = PVector.sub(end, start);
    float len = line.mag();
    line.normalize();

    PVector v = PVector.sub(point, start);
    float d = PVector.dot(v, line);
    d = constrain(d, 0, len);
    return PVector.add(start, line.mult(d));
    }
}