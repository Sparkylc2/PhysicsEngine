
public static class PhysEngMath {

    private static final PVector emptyVector = new PVector(0, 0);
  //Precision for float comparison, equal to 0.00005 meters
  public static final float precision = 0.0001f;

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
  


  public static PVector Transform(PVector vertex, PVector position, float angle){
    float sin = sin(angle);
    float cos = cos(angle);
    
    return new PVector(vertex.x * cos - vertex.y * sin + position.x, vertex.x * sin + vertex.y * cos + position.y);
  }
  
  //Overloaded method for Transform
    public static PVector Transform(float x, float y, float angle) {
        float sin = sin(angle);
        float cos = cos(angle);
    
        return new PVector(x * cos - y * sin + x, x * sin + y * cos + y);
  }

  

  public static PVector zeroTransform = Transform(0, 0, 0);



    public static boolean Equals(float a, float b) {
        return Math.abs(a - b) < precision;
    }

public static boolean Equals(PVector a, PVector b) {
    return PVector.sub(a, b).magSq() < precision * precision; //magSq is faster than mag
  }



public static PVector SnapController(InteractivityListener interactivityListener, Rigidbody rigidbody, PVector point) {
    if (rigidbody.getShapeType() == ShapeType.CIRCLE) {
        if (interactivityListener.getSnapToCenter()) {
            return new PVector(0, 0);
        } else if (interactivityListener.getSnapToEdge()) {
            
            return point.sub(rigidbody.getPosition()).normalize().mult(rigidbody.getRadius()).copy();
        } else {
            return PVector.sub(point, rigidbody.getPosition());
        }
    } else {
        if (interactivityListener.getSnapToCenter()) {

            return new PVector(0, 0);

        } else if (interactivityListener.getSnapToEdge()) {

            PVector closestOnPolygon = new PVector();
            float minDistanceSq = Float.MAX_VALUE;
            PVector[] vertices = rigidbody.GetTransformedVertices();

            for (int i = 0; i < vertices.length; i++) {
                PVector closest = getClosestPointOnLine(vertices[i], vertices[(i + 1) % vertices.length], point);
                float distanceSq = point.sub(closest).magSq();

                if (distanceSq < minDistanceSq) {
                    minDistanceSq = distanceSq;
                    closestOnPolygon.set(closest);
                }
            }
            return PVector.sub(closestOnPolygon, rigidbody.getPosition());
        } else {
            return PVector.sub(point, rigidbody.getPosition());
        }
    }
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