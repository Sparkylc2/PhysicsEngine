public class Rigidbody {

  //Capital letter denotes read only
  private String ID;
  private PVector position = new PVector();
  private PVector previousPosition = new PVector();
  private PVector linearVelocity = new PVector();
  private float angle;
  private float angularVelocity;
    
  private ShapeType ShapeType;
  private float Mass;
  private float InvMass;
  private float Density;
  private float Restitution;
  private float Area;
  private float RotationalInertia;
  private float InvRotationalInertia;
  private float Radius;
  private float Width;
  private float Height;
  private float coefficientOfStaticFriction;
  private float coefficientOfKineticFriction;
  

  private PVector[] Vertices = new PVector[0];
  private AABB aabb;
  private PVector[] transformedVertices = new PVector[0];

  private ArrayList<Rigidbody> collisionExclusionList = new ArrayList<Rigidbody>();

  private Shape shapeRenderer;
  private float strokeWeight;
  private PVector strokeColour = new PVector();
  private PVector fillColour = new PVector();
  
  private boolean transformUpdateRequired;
  private boolean aabbUpdateRequired;
  
  private boolean isStatic;
  private boolean isTranslationallyStatic;
  private boolean isRotationallyStatic;
  private boolean isVisible;
  private boolean isCollidable;


  
  private float netTorque = 0f;
  private PVector netForce = new PVector();
  
  private ArrayList<ForceRegistry> forceRegistry = new ArrayList<ForceRegistry>();
  
  
  
  
  
  
  /*
  ==================================================================================================
  ==================================CONSTRUCTORS====================================================
  ==================================================================================================
  */
  public Rigidbody() {
      //this.aabbUpdateRequired = true;
      //this.transformUpdateRequired = true;
  }
  
  private Rigidbody(float density, float mass, float rotationalIntertia, float restitution,
    float area, float radius, float width, float height, PVector[] vertices, boolean isStatic,
    boolean isCollidable, float strokeWeight, PVector strokeColour, PVector fillColour, ShapeType shapeType)
  {
    this.ID = UUID.randomUUID().toString();
    this.Mass = mass;
    this.RotationalInertia = rotationalIntertia;
    this.InvMass = mass > 0 ? 1 / mass : 0;
    this.InvRotationalInertia = rotationalIntertia > 0 ? 1 / rotationalIntertia : 0;


    this.Density = density;
    this.Restitution = restitution;
    this.Area = area;
    this.Radius = radius;
    this.Width = width;
    this.Height = height;

    this.coefficientOfStaticFriction = 0.8f;
    this.coefficientOfKineticFriction = 0.3f;
  

    this.ShapeType = shapeType;
    this.strokeWeight = strokeWeight;
    this.strokeColour = strokeColour;
    this.fillColour = fillColour;


    this.isStatic = isStatic;
    this.isCollidable = true;
    this.isVisible = true;

    this.position = new PVector();
    this.linearVelocity = new PVector();
    this.angle = 0f;
    this.angularVelocity = 0f;
    
    
    if (shapeType == ShapeType.BOX) {

      this.Vertices = vertices;
      this.transformedVertices = new PVector[this.Vertices.length];
      this.aabb = this.GetAABB();
      
    } else {

        this.Vertices = null;
        this.transformedVertices = null;
    }
    
    //Sets InvMass for static objects to 0

    
    this.aabbUpdateRequired = true;
    this.transformUpdateRequired = true;
  }





  
  
  
  /*
  ==================================================================================================
  ========================== BODY & COLLIDER GEOMETRY METHODS ======================================
  ==================================================================================================
  */
  private PVector[] CreateBoxVertices(float width, float height) {
    float left = -width / 2;
    float right = width / 2;
    float top = height / 2;
    float bottom = -height / 2;
    
    PVector[] vertices = new PVector[4];
    vertices[0] = new PVector(left, top);
    vertices[1] = new PVector(right, top);
    vertices[2] = new PVector(right, bottom);
    vertices[3] = new PVector(left, bottom);
    return vertices;
  }
  
  public PVector[] GetTransformedVertices() {
    if (this.transformUpdateRequired) {

      for (int i = 0; i < this.Vertices.length; i++) {

        PVector vertex = this.Vertices[i];

        this.transformedVertices[i] = PhysEngMath.Transform(vertex, this.position, this.angle);
      }
    }
    
    /*
    The way this transform system works, is that it caches the transformed vertices,
    and only transforms them once a change has been made. This means that,
    if no change is made is made, cached vertices are returned.
    if the transform is updated, the vertices are transformed, and the cache is updated.
    */
    this.aabbUpdateRequired = true;
    this.transformUpdateRequired = false;
    return this.transformedVertices;
  }
  
  
  public Rigidbody CreateCircleBody(float radius, float density,
    float restitution, boolean isStatic, boolean isCollidable, float strokeWeight,
    PVector strokeColour, PVector fillColour) {

    Rigidbody rigidbody;
    
    float area = (float) PI * radius * radius;
    

    if (area < MIN_BODY_AREA || area > MAX_BODY_AREA) {

      throw new IllegalArgumentException("Body area is too small or large");
    }

    if (density < MIN_BODY_DENSITY || density > MAX_BODY_DENSITY) {

      throw new IllegalArgumentException("Density is too small or large");
    } 

    restitution = PhysEngMath.Clamp(restitution, 0, 1);


    float mass = 0f;
    float rotationalIntertia = 0f;

    if(!isStatic) {
      mass = area * density;
      rotationalIntertia =  abs(0.5f * mass * radius * radius);
    }
    


    rigidbody = new Rigidbody(density, mass, rotationalIntertia, restitution, area, radius, 0, 0,
                              null, isStatic, isCollidable, strokeWeight,
                              strokeColour, fillColour, ShapeType.CIRCLE);
    
    return rigidbody;
  }
  


  public Rigidbody CreateBoxBody(float width, float height, float density,
    float restitution, boolean isStatic, boolean isCollidable, float strokeWeight,
    PVector strokeColour, PVector fillColour) {
    Rigidbody rigidbody;
    
    float area = width * height;
    
    //Argument exceptions for area and density
    if (area < MIN_BODY_AREA || area > MAX_BODY_AREA) {

      throw new IllegalArgumentException("Body area is too small or large");
    }

    if (density < MIN_BODY_DENSITY || density > MAX_BODY_DENSITY) {

      throw new IllegalArgumentException("Density is too small or large");
    } 
    
    //Clamps restitution between 0 and 1
    restitution = PhysEngMath.Clamp(restitution, 0, 1);
    
    //calculates mass from density and area
    float mass = 0f;
    float rotationalIntertia = 0f;

    if(!isStatic) {
      mass = area * density;
      rotationalIntertia = 0.5f * mass * width * width + height * height;
    }

    PVector[] vertices = CreateBoxVertices(width, height);
    
    rigidbody = new Rigidbody(density, mass, rotationalIntertia, restitution, area, 0, width,
                              height, vertices, isStatic, isCollidable, strokeWeight, strokeColour,
                              fillColour, ShapeType.BOX);
    
    return rigidbody;
  }


  public Rigidbody CreatePolygon(PVector[] vertices, float density,
    float restitution, boolean isStatic, boolean isTranslationallyStatic,
    boolean isRotationallyStatic, boolean isCollidable, float strokeWeight,
    PVector strokeColour, PVector fillColour) {

    Rigidbody rigidbody;

    float area = this.calculateArea(vertices);
    
    //Argument exceptions for area and density
    if (area < MIN_BODY_AREA || area > MAX_BODY_AREA) {

      throw new IllegalArgumentException("Body area is too small or large");
    }

    if (density < MIN_BODY_DENSITY || density > MAX_BODY_DENSITY) {

      throw new IllegalArgumentException("Density is too small or large");
    } 
    
    //Clamps restitution between 0 and 1
    restitution = PhysEngMath.Clamp(restitution, 0, 1);
    
    //calculates mass from density and area
    float mass = 0f;
    float rotationalIntertia = 0f;

    if(isStatic) {
      mass = 0f;
      rotationalIntertia = 0f;
    } else if(isTranslationallyStatic) {
      mass = 0f;
      rotationalIntertia = calculateMomentOfInertia(vertices, mass);
    } else if(isRotationallyStatic) {
      mass = area * density;
      rotationalIntertia = 0f;
    } else {
      mass = area * density;
      rotationalIntertia = calculateMomentOfInertia(vertices, mass);
    }

    
    rigidbody = new Rigidbody(density, mass, rotationalIntertia, restitution, area, 0, width,
                              height, vertices, isStatic, isCollidable, strokeWeight, strokeColour,
                              fillColour, ShapeType.BOX);
    
    return rigidbody;
  }


  public AABB GetAABB() {
    if(this.aabbUpdateRequired) {

    float minX = Float.MAX_VALUE;
    float minY = Float.MAX_VALUE;

    float maxX = -Float.MAX_VALUE;
    float maxY = -Float.MAX_VALUE;
    
    if(this.ShapeType == ShapeType.CIRCLE) {
      
      minX = this.position.x - this.Radius;
      minY = this.position.y - this.Radius;
      maxX = this.position.x + this.Radius;
      maxY = this.position.y + this.Radius;

    } else if (this.ShapeType == ShapeType.BOX) {

      PVector[] vertices = this.GetTransformedVertices();
      for (PVector vertex : vertices) {
        if (vertex.x < minX) {
            minX = vertex.x;
          }
          if (vertex.x > maxX) {
            maxX = vertex.x;
          }
          if (vertex.y < minY) {
            minY = vertex.y;
          }
          if (vertex.y > maxY) {
            maxY = vertex.y;
          }
        }
    }

    this.aabb = new AABB(new PVector(minX, minY), new PVector(maxX, maxY));
    this.aabbUpdateRequired = false;

  }
  return this.aabb;
}


public float calculateArea(PVector[] vertices) {
  float area = 0;
  int n = vertices.length;

  for (int i = 0, j = n - 1; i < n; j = i++) {
    area += vertices[i].x * vertices[j].y - vertices[j].x * vertices[i].y;
  }
  return Math.abs(area / 2.0);
}


public float calculateMass(PVector[] vertices) {
  float area = calculateArea(vertices);
  return area * this.Density;
}


public float calculateMomentOfInertia(PVector[] vertices, float mass) {
  float I = 0;
  float area = calculateArea(vertices);
  int n = vertices.length;
  PVector centroid = calculateCentroid(vertices);

  for (int i = 0, j = n - 1; i < n; j = i++) {
    float xi = vertices[i].x - centroid.x, yi = vertices[i].y - centroid.y;
    float xj = vertices[j].x - centroid.x, yj = vertices[j].y - centroid.y;
    float cross = Math.abs(xi * yj - xj * yi);
    I += cross * (xi * xi + yi * yi + xi * xj + yi * yj + xj * xj + yj * yj);
  }
  I *= mass / (6 * area);
  return I;
}


public PVector calculateCentroid(PVector[] vertices) {
    float signedArea = 0;
    float cx = 0;
    float cy = 0;
    for (int i = 0, j = vertices.length - 1; i < vertices.length; j = i++) {
        float temp = (vertices[i].x * vertices[j].y) - (vertices[j].x * vertices[i].y);
        signedArea += temp;
        cx += (vertices[i].x + vertices[j].x) * temp;
        cy += (vertices[i].y + vertices[j].y) * temp;
    }
    signedArea /= 2;
    cx /= (6 * signedArea);
    cy /= (6 * signedArea);
    return new PVector(cx, cy);
}


public void adjustRigidbodyPosition(PVector[] vertices) {
    PVector newCOM = calculateCentroid(vertices);

    for(PVector vertex : vertices) {
        vertex.sub(newCOM);
    }
}

private boolean doEdgesIntersect(PVector p1, PVector p2, PVector p3, PVector p4) {

    float denominator = (p4.y - p3.y) * (p2.x - p1.x) - (p4.x - p3.x) * (p2.y - p1.y);
    if (denominator == 0) {
        return false; // Lines are parallel
    }

    float ua = ((p4.x - p3.x) * (p1.y - p3.y) - (p4.y - p3.y) * (p1.x - p3.x)) / denominator;
    float ub = ((p2.x - p1.x) * (p1.y - p3.y) - (p2.y - p1.y) * (p1.x - p3.x)) / denominator;

    if (ua >= 0 && ua <= 1 && ub >= 0 && ub <= 1) {
        return true; 
    }

    return false;
}

private boolean validatePolygonVertices(PVector[] vertices) {
    for (int i = 0; i < vertices.length; i++) {
        for (int j = i + 1; j < vertices.length; j++) {
            int nextI = (i + 1) % vertices.length;
            int nextJ = (j + 1) % vertices.length;

            if (nextI != j && i != nextJ) {
                if (doEdgesIntersect(vertices[i], vertices[nextI], vertices[j], vertices[nextJ])) {
                    return false; // Found intersecting edges
                }
            }
        }
    }
    return true;
}


public void updateCircle(float radius) {

    this.Radius = radius;
    this.Area = (float) PI * this.Radius * this.Radius;
    this.Vertices = null;

    this.transformedVertices = null;

    if(this.isStatic) {
      this.Mass = 0f;
      this.InvMass = 0f;
      this.RotationalInertia = 0f;
      this.InvRotationalInertia = 0f;
    } else if(this.isTranslationallyStatic) {
      this.Mass = this.Density * this.Area;
      this.InvMass = 0f;
      this.RotationalInertia = 0.5f * this.Mass * this.Radius * this.Radius;
      this.InvRotationalInertia = 1 / this.RotationalInertia;
    } else if(this.isRotationallyStatic) {
      this.Mass = this.Area * this.Density;
      this.InvMass = this.Mass;
      this.RotationalInertia = 0f;
      this.InvRotationalInertia = 0f;
    }

    this.transformUpdateRequired = true;
    this.aabbUpdateRequired = true;
}

public void updatePolygon(PVector[] newVertices) {

    newVertices = PhysEngMath.OrderVerticesClockwise(newVertices);

    if(!this.validatePolygonVertices(newVertices)){
      System.out.println("Vertices Invalid");
      return;
    }

    this.Vertices = newVertices;
    this.transformedVertices = new PVector[this.Vertices.length];
    PVector newCOM = calculateCentroid(this.Vertices);

    for(int i = 0; i < this.Vertices.length; i++) {
          this.Vertices[i].sub(newCOM);
    }

    float newMass = calculateMass(this.Vertices);
    float newMomentOfInertia = calculateMomentOfInertia(this.Vertices, newMass);

    if(this.isStatic) {
      this.Mass = 0f;
      this.InvMass = 0f;
      this.RotationalInertia = 0f;
      this.InvRotationalInertia = 0f;
    } else if(this.isTranslationallyStatic) {
      this.Mass = newMass;
      this.InvMass = 0f;
      this.RotationalInertia = newMomentOfInertia;
      this.InvRotationalInertia = this.RotationalInertia > 0 ? 1 / this.RotationalInertia : 0;
    } else if(this.isRotationallyStatic) {
      this.Mass = newMass;
      this.InvMass = this.Mass > 0f ? 1 / this.Mass : 0f;
      this.InvRotationalInertia = 0f;
      this.RotationalInertia = newMomentOfInertia;
    } else {
      this.Mass = newMass;
      this.InvMass = this.Mass > 0 ? 1 / this.Mass : 0;
      this.RotationalInertia = newMomentOfInertia;
      this.InvRotationalInertia = this.RotationalInertia > 0 ? 1 / this.RotationalInertia : 0;
    }

    float newArea = calculateArea(this.Vertices);

    this.Area = newArea;

    this.transformUpdateRequired = true;
    this.aabbUpdateRequired = true;
}


public void deserializeRigidbody(String ID, ShapeType ShapeType, PVector position, PVector linearVelocity, float angle, 
                                 float angularVelocity, float Density, float Restitution, float radius, float width, 
                                 float height, float coefficientOfStaticFriction, float coefficientOfKineticFriction,
                                 PVector[] vertices, boolean isStatic, boolean isTranslationallyStatic, boolean isRotationallyStatic,
                                 boolean isCollidable, boolean isVisible, float strokeWeight, PVector strokeColour, PVector fillColour) {
    this.ID = ID; 

    this.position.set(position);
    this.linearVelocity.set(linearVelocity);
    this.angle = angle;
    this.angularVelocity = angularVelocity;

    this.Density = Density;
    this.Restitution = Restitution;
    this.ShapeType = ShapeType;

    this.isStatic = isStatic;
    this.isTranslationallyStatic = isTranslationallyStatic;
    this.isRotationallyStatic = isRotationallyStatic;

    this.isCollidable = isCollidable;
    this.isVisible = isVisible;

    this.strokeWeight = strokeWeight;
    this.strokeColour = strokeColour;
    this.fillColour = fillColour;

    this.coefficientOfStaticFriction = coefficientOfStaticFriction;
    this.coefficientOfKineticFriction = coefficientOfKineticFriction;

    if(ShapeType == ShapeType.POLYGON || ShapeType == ShapeType.BOX) {

        this.updatePolygon(vertices);
        this.Width = width;
        this.Height = height;

    } else if(ShapeType == ShapeType.CIRCLE) {
        this.updateCircle(radius);
    }
  }





  /*
  ==================================================================================================
  ==================================METHODS=========================================================
  ==================================================================================================
  */
  public void Move(PVector amount) {
    this.position.add(amount);

    this.transformUpdateRequired = true;
    this.aabbUpdateRequired = true;
  }
  
  public void MoveTo(PVector position) {
    this.position = position;

    this.transformUpdateRequired = true;
    this.aabbUpdateRequired = true;
  }

  public void SetInitialPosition(PVector position) {
    this.position.set(position);
    this.previousPosition.set(position);
    this.transformUpdateRequired = true;
    this.aabbUpdateRequired = true;
  }
  
  public void Rotate(float amount) {
    this.angle += amount;

    this.transformUpdateRequired = true;
    this.aabbUpdateRequired = true;
  }

  public void RotateTo(float angle) {
    this.angle = angle;

    this.transformUpdateRequired = true;
    this.aabbUpdateRequired = true;
  }


/*----------------------------- Mouse Detection Stuff ------------------------------------*/
  
public boolean contains(float x, float y) {

    if(this.ShapeType == ShapeType.CIRCLE) {
      return this.containsCircle(x, y);
    } else {
      return this.containsPolygon(x, y);
    }
}

public boolean containsCircle(float x, float y) {
    float distance = PVector.dist(this.position, new PVector(x, y));

    return (distance <= this.Radius);
}


public boolean containsPolygon(float x, float y) {
    boolean inside = false;
    PVector[] vertices = this.transformedVertices;

    for (int i = 0, j = vertices.length - 1; i < vertices.length; j = i++) {
        if ((vertices[i].y > y) != (vertices[j].y > y) &&
            (x < (vertices[j].x - vertices[i].x) * (y - vertices[i].y) / (vertices[j].y - vertices[i].y) + vertices[i].x)) {
            inside = !inside;
        }
    }
    
    return inside;
}



/*-------------------------------------------------------------------------------------*/
  

  /*
  ==================================================================================================
  ==================================UPDATE==========================================================
  ==================================================================================================
  */
  public void update(float dt, int iterations) {
    if(IS_PAUSED) {
      return;
    }
    if(isStatic) {
        return;
    }

    this.aabbUpdateRequired = true;
    this.transformUpdateRequired = true;
    dt /= (float)iterations;                
    this.RK4Position(dt);
    this.angularIntegration(dt);
    }


  /*
  ==================================================================================================
  ================================== INTEGRATOR ====================================================
  ==================================================================================================
  */

     public void RK4Position(float dt) {

        /*-------------- RK4 Position And Velocity Integration --------------*/
        PVector k1_v = PVector.mult(calculateAcceleration(this.position), dt);
        PVector k1_r = PVector.mult(this.linearVelocity, dt);

        PVector k2_v = PVector.mult(calculateAcceleration(PVector.add(this.position, PVector.mult(k1_r, 0.5f))), dt);
        PVector k2_r = PVector.mult(PVector.add(this.linearVelocity, PVector.mult(k1_v, 0.5f)), dt);

        PVector k3_v = PVector.mult(calculateAcceleration(PVector.add(this.position, PVector.mult(k2_r, 0.5f))), dt);
        PVector k3_r = PVector.mult(PVector.add(this.linearVelocity, PVector.mult(k2_v, 0.5f)), dt);

        PVector k4_v = PVector.mult(calculateAcceleration(PVector.add(this.position, k3_r)), dt);
        PVector k4_r = PVector.mult(PVector.add(this.linearVelocity, k3_v), dt);
        /*-------------------------------------------------------------------*/


        /*-------------- Reusable Vectors --------------*/
        PVector two_k2_r = PVector.mult(k2_r, 2);
        PVector two_k3_r = PVector.mult(k3_r, 2);

        PVector two_k2_v = PVector.mult(k2_v, 2);
        PVector two_k3_v = PVector.mult(k3_v, 2);
        /*-----------------------------------------------*/


        /*-------------- Final Position and Velocity --------------*/
        PVector finalPosition = PVector.add(this.position, PVector.div(PVector.add(k1_r, PVector.add(two_k2_r, PVector.add(two_k3_r, k4_r))), 6));
        PVector finalVelocity = PVector.add(this.linearVelocity, PVector.div(PVector.add(k1_v, PVector.add(two_k2_v, PVector.add(two_k3_v, k4_v))), 6));
        /*---------------------------------------------------------*/


        /*----------------- Update To New Values -----------------*/
        this.position = finalPosition;
        this.linearVelocity = finalVelocity;
        this.transformUpdateRequired = true;
        /*--------------------------------------------------------*/

  }


  public void angularIntegration(float dt) {

    this.angularVelocity += this.netTorque * this.InvRotationalInertia * dt;
    this.angle += this.angularVelocity*dt;


  }




    public PVector calculateAcceleration(PVector position) {

        /*--------------- Force Reset --------------*/
        this.netForce.set(0,0,0);
        this.netTorque = 0f;
        /*------------------------------------------*/

        /*------------ Net Force Calculation ------------*/
        for (ForceRegistry force : this.forceRegistry) {

            PVector currentForce = force.getForce(this, position);
            this.netForce.add(currentForce);

            PVector leverArm = PVector.sub(force.getApplicationPoint(this, this.position), this.position);
            this.netTorque += leverArm.cross(currentForce).z;

        }
        /*-----------------------------------------------*/

        /*------------ Acceleration Calculation ------------*/
        return this.netForce.mult(this.InvMass);
        /*--------------------------------------------------*/

    }

  
  /*
  ==================================================================================================
  ==================================READ-ONLY FIELDS================================================
  ==================================================================================================
  */
  
  public float getMass() {
    return this.Mass;
  }

  public void setMass(float mass) {
    this.Mass = mass;
    this.InvMass = 1/mass;
    this.RotationalInertia = (this.ShapeType == ShapeType.BOX) ? 0.5f * Mass * width * width + height * height : 0.5f * Mass * this.Radius * this.Radius;
    this.InvRotationalInertia = (this.RotationalInertia > 0) ? 1 / this.RotationalInertia : 0;
  }


  public float getDensity() {
    return this.Density;
  }

  public void setDensity(float density) {
    this.Density = density;
    this.setMass(this.Area * this.Density);
  }
  
  public float getRestitution() {
    return this.Restitution;
  }

  public void setRestitution(float restitution) {
    this.Restitution = restitution;
  }
  
  public void setArea(float area) {
    this.Area = area;
  }

  public float getArea() {
    return this.Area;
  }
  
  public float getRadius() {
    return this.Radius;
  }

  public void setRadius(float radius) {
    this.Radius = radius;
    this.Area = (float) PI * this.Radius * this.Radius;
    setDensity(this.Density);
  }

  public float getWidth() {
    return this.Width;
  }

  public void setWidth(float width) {
    if(this.ShapeType == ShapeType.BOX) {
      this.Width = width;
      this.Area = this.Width*this.Height;
      setDensity(this.Density);
      this.Vertices = CreateBoxVertices(this.Width, this.Height);
      this.transformUpdateRequired = true;
    }
  }

  public float getHeight() {
    return this.Height;
  }
  
  public void setHeight(float height) {
    this.Height = height;
    this.Area = this.Width*this.Height;
    setDensity(this.Density);
    this.Vertices = CreateBoxVertices(this.Width, this.Height);
    this.transformUpdateRequired = true;
  }

  public ShapeType getShapeType() {
    return this.ShapeType;
  }

  public void setShapeType(ShapeType shapeType) {
    this.ShapeType = shapeType;
  }

  public void setVertices(PVector[] vertices) {
    this.Vertices = vertices;
  }

  public PVector[] getVertices() {
    return this.Vertices;
  }

  public void setTransformedVerticesLength(int length) {
    this.transformedVertices = new PVector[length];
  }
  
  public float getInvMass() {
    return this.InvMass;
  }

  public float getRotationalInertia() {
    return this.RotationalInertia;
  }

  public float getInvRotationalInertia() {
    return this.InvRotationalInertia;
  }




  
  /*
  ==================================================================================================
  ==================================GETTERS & SETTERS===============================================
  ==================================================================================================
  */
  public String getID(){
    return this.ID;
  }

  public void setID(String ID) {
    this.ID = ID;
  }

  public boolean getTransformUpdateRequired() {
    return this.transformUpdateRequired;
  }
  
  public void setTransformUpdateRequired(boolean transformUpdateRequired) {
    this.transformUpdateRequired = transformUpdateRequired;
  }

  public boolean getAABBUpdateRequired() {
    return this.aabbUpdateRequired;
  }

  public void setAABBUpdateRequired(boolean aabbUpdateRequired) {
    this.aabbUpdateRequired = aabbUpdateRequired;
  }
  
  public PVector getPosition() {
    return this.position;
  }
  
  public void setPosition(PVector position) {
    this.transformUpdateRequired = true;
    this.aabbUpdateRequired = true;
    this.position.set(position);
  }
  public PVector getVelocity() {
    return this.linearVelocity;
  }
  
  public void setVelocity(PVector velocity) {
    this.linearVelocity = velocity;
  }
  
  public float getStrokeWeight() {
    return this.strokeWeight;
  }
  
  public void setStrokeWeight(float strokeWeight) {
    this.strokeWeight = strokeWeight;
  }
  
  public PVector getStrokeColour() {
    return this.strokeColour;
  }
  
  public void setStrokeColour(PVector strokeColour) {
    this.strokeColour = strokeColour;
  }
  //Overloaded method for setting stroke colour with 3 floats
  public void setStrokeColour(float r, float g, float b) {
    this.strokeColour = new PVector(r, g, b);
  }
  
  public PVector getFillColour() {
    return this.fillColour;
  }
  
  
  public void setFillColour(PVector fillColour) {
    this.fillColour = fillColour;
  }
  //Overloaded method for setting fill colour with 3 floats
  public void setFillColour(float r, float g, float b) {
    this.fillColour = new PVector(r, g, b);
  }
  
  public ArrayList<ForceRegistry> getForceRegistry() {
    return this.forceRegistry;
  }
  
  public ForceRegistry getForceFromForceRegistry(int index) {
    return this.forceRegistry.get(index);
  }
  
  public int getForceRegistrySize() {
    return this.forceRegistry.size();
  }
  
  public void addForceToForceRegistry(ForceRegistry forceRegistry) {
    this.forceRegistry.add(forceRegistry);
  }

  public void clearForceRegistry() {
    this.forceRegistry.clear();
  }

  public void removeForceFromForceRegistry(ForceRegistry forceRegistry) {
    this.forceRegistry.remove(forceRegistry);
  }
  
  public void removeForceFromForceRegistry(int index) {
    this.forceRegistry.remove(index);
  }
  
  public boolean getIsStatic() {
    return this.isStatic;
  }
  
  public void setIsStatic(boolean isStatic) {
    this.isStatic = isStatic;
    if(isStatic) {
      this.InvMass = 0f;
      this.InvRotationalInertia = 0f;
    }
  }

  public boolean getIsVisible() {
    return this.isVisible;
  }

  public void setIsVisible(boolean isVisible) {
    this.isVisible = isVisible;
  }
    public float getAngle() {
    return this.angle;
  }

  public void setAngle(float angle) {
    this.transformUpdateRequired = true;
    this.angle = angle;
  }

  public void addBodyToCollisionExclusionList(Rigidbody rigidbody) {
    this.collisionExclusionList.add(rigidbody);
  }

  public ArrayList<Rigidbody> getCollisionExclusionList() {
    return this.collisionExclusionList;
  }

  public float getAngularVelocity(){
    return this.angularVelocity;
  }

  public void setAngularVelocity(float angularVelocity) {
    this.angularVelocity = angularVelocity;
  }


public float getCoefficientOfKineticFriction() {
    return this.coefficientOfKineticFriction;
}

public void setCoefficientOfKineticFriction(float coefficientOfKineticFriction) {
    this.coefficientOfKineticFriction = coefficientOfKineticFriction;
}

public float getCoefficientOfStaticFriction() {
    return this.coefficientOfStaticFriction;
}

public void setCoefficientOfStaticFriction(float coefficientOfStaticFriction) {
    this.coefficientOfStaticFriction = coefficientOfStaticFriction;
}

public boolean getIsTranslationallyStatic() {
    return this.isTranslationallyStatic;
}

public void setIsTranslationallyStatic(boolean isTranslationallyStatic) {
    this.isTranslationallyStatic = isTranslationallyStatic;

    if(this.isTranslationallyStatic) {
      this.InvMass = 0f;
    }
}

public boolean getIsRotationallyStatic() {
    return this.isRotationallyStatic;
}

public void setIsRotationallyStatic(boolean isRotationallyStatic) {
    this.isRotationallyStatic = isRotationallyStatic;
    if(this.isRotationallyStatic) {
      this.InvRotationalInertia = 0f;
    }
}

  
public boolean getCollidability() {
    return this.isCollidable;
}

public void setCollidability(boolean isCollidable) {
    this.isCollidable = isCollidable;
}
}