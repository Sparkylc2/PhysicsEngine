

public class InteractivityListener {

  public PVector position;
  public float zoom;

  public boolean showCursorTrail = true;
  public int lastTime;
  public ArrayList<PVector> trail = new ArrayList<PVector>();
/*
====================================================================================================
================================= GUI Variables for Rigidbody Generation ===========================
====================================================================================================
*/
  private float width;
  private float height;

  private float softbodyWidth;
  private float softbodyHeight;

  private PVector[] vertices;

  private float radius;
  private PVector rigidbodyPosition;

  private float density;
  private float restitution;

  
  private float angle;
  private float angularVelocity;

  private boolean generateRigidbodies = true;
  private boolean generateForces = false;

    //TODO IMPLEMENT THIS
  private boolean showObjectTrail;

  private boolean isStatic;
  private boolean isTranslationallyStatic;
  private boolean isRotationallyStatic;
  private boolean isCollidable;

  private boolean addGravity;

  private float strokeWeight;
  private PVector strokeColor;
  private PVector fillColor;

  private ShapeType shapeType = ShapeType.SOFTBODY;
  

  public InteractivityListener() {
    position = new PVector(-50, -50);
    zoom = 10f;
  }
/*
====================================================================================================
=============================== GUI Variables for Force Generation =================================
====================================================================================================
*/

/*------------------------------ Global Variables ----------------------------*/
    private ForceType forceType;


    private ArrayList<Rigidbody> selectedRigidbodies = new ArrayList<Rigidbody>();

    private boolean isFirstClickOnRigidbody = false;
    private boolean drawForces = false;
    private boolean oneRigidbodySelected = false;
    private boolean twoRigidbodiesSelected = false;

    private int opacity = 166;
    private Rigidbody tempBody;

    private Rigidbody selectedRigidbody;
    private Rigidbody selectedRigidbody1;
    private Rigidbody selectedRigidbody2;

    private PVector anchorPoint;
    private PVector localAnchorA;

    private boolean snapToCenter;
    private boolean snapToEdge;
    private boolean snapToVertices;

    private boolean enableEditor;

/*----------------------------- Spring Variables -----------------------------*/

    private boolean lockTranslationToXAxis;
    private boolean lockTranslationToYAxis;
  
    private boolean isPerfectSpring;

    private float equilibriumLength;
    private float springLength;
    private float springConstant;
    private float springDamping;

    private boolean isSpringHingeable;


/*--------------------------- Rod Variables ---------------------------------*/
    
    private boolean isRodHingeable;
    private boolean isTwoBodyRod;

/*--------------------------- Motor Variables ----------------------------*/
    private float motorTargetAngularVelocity;
    private boolean motorDrawMotor;
    private boolean motorDrawMotorForce;

/*
====================================================================================================
======================================= GUI Methods ================================================
====================================================================================================
*/

  public void zoom(float amount, float mouseX, float mouseY) {
    PVector mouseBeforeZoom = screenToWorld(mouseX, mouseY);
    zoom *= amount;
    PVector mouseAfterZoom = screenToWorld(mouseX, mouseY);
    PVector shift = PVector.sub(mouseBeforeZoom, mouseAfterZoom);
    position.add(shift);
}


  public void applyTransform() {
    translate(width/2, height/2);
    scale(zoom);
    translate(-position.x, -position.y);
  }

  public void resetTransform() {
    translate(position.x, position.y);
    scale(1/zoom);
    translate(-width/2, -height/2);
  }
  
   public PVector screenToWorld(float x, float y) {
    float worldX = (x - width/2) / zoom + position.x;
    float worldY = (y - height/2) / zoom + position.y;
    return new PVector(worldX, worldY);
  }

  public void zoom(float amount) {
    zoom *= amount;
  }

  void move(float dx, float dy) {
    position.x += dx / zoom;
    position.y += dy / zoom;
  }

  public float[] getCameraExtents(float padding) {

  float left = screenToWorld(padding, padding).x;
  float right = screenToWorld(width - padding, padding).x;
  float top = screenToWorld(padding, padding).y;
  float bottom = screenToWorld(width - padding, height - padding).y;

  return new float[] {left, right, top, bottom};
}
//Overloaded method that returns the camera extents as PVector coordinates
public PVector[] getWorldBoundsWithPadding(float padding) {
  PVector topLeft = screenToWorld(padding, padding);
  PVector topRight = screenToWorld(width - padding, padding);
  PVector bottomLeft = screenToWorld(padding, height - padding);
  PVector bottomRight = screenToWorld(width - padding, height - padding);

  return new PVector[] {topLeft, topRight, bottomLeft, bottomRight};
}

public Rigidbody getClickedRigidbody() {
    
    PVector mousePosition = interactivityListener.screenToWorld(mouseX, mouseY);
    for (Rigidbody rigidbody : rigidbodyList) {
        if (rigidbody.contains(mousePosition.x, mousePosition.y)) {
            return rigidbody;
        }
    }

    return null;
}




/*
====================================================================================================
======================================= Generation Methods =========================================
====================================================================================================
*/

/*
====================================================================================================
======================================= Rigidbody Generation Methods ================================
====================================================================================================
*/
public void GenerateRigidbody() {
    if(getClickedRigidbody() == null){
     if(this.shapeType == ShapeType.BOX) {

            Rigidbody rigidbody = RigidbodyGenerator.CreateBoxBody( this.width, this.height,
                                                                    this.density, this.restitution,
                                                                    this.isStatic, this.isCollidable,
                                                                    this.strokeWeight, this.strokeColor,
                                                                    this.fillColor);
                                                    

            //YOU CAN CHANGE THIS TO EITHER MOUSE COORDS OR THE NEW THING UR TRYING
            rigidbody.SetInitialPosition(screenToWorld(mouseX, mouseY));
            rigidbody.setIsTranslationallyStatic(this.isTranslationallyStatic);
            rigidbody.setIsRotationallyStatic(this.isRotationallyStatic);
            rigidbody.RotateTo(this.angle);
            rigidbody.setAngularVelocity(this.angularVelocity);

            if(this.addGravity) {
                rigidbody.addForceToForceRegistry(new Gravity(rigidbody));
            }

            AddBodyToBodyEntityList(rigidbody);
  
        }
        if(this.shapeType == ShapeType.CIRCLE) {

            Rigidbody rigidbody = RigidbodyGenerator.CreateCircleBody(this.radius, this.density,
                                                                      this.restitution, this.isStatic,
                                                                      this.isCollidable, this.strokeWeight,
                                                                      this.strokeColor, this.fillColor);

                                        
            //SAME GOES FOR HERE
            rigidbody.SetInitialPosition(screenToWorld(mouseX, mouseY));
            rigidbody.setIsTranslationallyStatic(this.isTranslationallyStatic);
            rigidbody.setIsRotationallyStatic(this.isRotationallyStatic);
            rigidbody.RotateTo(this.angle);
            rigidbody.setAngularVelocity(this.angularVelocity);

            if(this.addGravity) {
                rigidbody.addForceToForceRegistry(new Gravity(rigidbody));
            }

            AddBodyToBodyEntityList(rigidbody);
        }

        if(this.shapeType == ShapeType.SOFTBODY) {
            Softbody softbody = new Softbody(screenToWorld(mouseX, mouseY), 0.0f, this.softbodyWidth, this.softbodyHeight);
            softbody.CreateBoxSoftbody();

        }

    }
}

/*
====================================================================================================
======================================= Force Generation Methods ===================================
====================================================================================================
*/


public void addSelectedRigidbody() {
    //Just in case
    if(this.selectedRigidbodies.size() > 2) {
        this.selectedRigidbodies.clear();
    }
    this.selectedRigidbodies.add(getClickedRigidbody());

    if(this.selectedRigidbodies.size() == 1) {
        firstMouseClickInformation();
    }
}

public PVector getMouseCoordinatesOverRigidbody() {
    if(!IsMouseOverUI()) {
        Rigidbody rigidbody = getClickedRigidbody();
        PVector mousePos = screenToWorld(mouseX, mouseY);
        if(rigidbody != null) {
            PVector localAnchorA = PhysEngMath.SnapController(this, rigidbody, mousePos);
            PVector worldAnchorA = PhysEngMath.Transform(localAnchorA, rigidbody.getPosition(), rigidbody.getAngle());
            return worldAnchorA.copy();
        } else {
            return mousePos;
        }
    } else {
        return null;
    }
}

public void drawMouseOverRigidbody() {

    Rigidbody rigidbody = getClickedRigidbody();
    PVector coordinate = getMouseCoordinatesOverRigidbody();

    fill(255, 0, 0);
    strokeWeight(0.1f);
    stroke(255, 0, 0);
    ellipse(coordinate.x, coordinate.y, 0.1f, 0.1f);

    if(showCursorTrail) {
        trail.add(new PVector(coordinate.x, coordinate.y));

    // If the trail is too long, remove the oldest position
    if (trail.size() > 20) {
        trail.remove(0);
    }

    // Draw the trail
    noFill();
    stroke(255, 0, 0);
    strokeWeight(0.1f);
    beginShape();
    for (int i = 0; i < trail.size(); i++) {
        if (i == 0 || i == trail.size() - 1) {
            // The first and last points are control points and are not part of the actual curve
            curveVertex(trail.get(i).x, trail.get(i).y);
        } else {
            curveVertex(trail.get(i).x, trail.get(i).y);
        }
    }
    endShape();

    // Draw the current mouse position
    fill(255, 0, 0);
    ellipse(coordinate.x, coordinate.y, 0.1f, 0.1f);
    }
}

public void drawInteractions() {
    drawMouseOverRigidbody();
    if(this.generateForces){
        drawForces();
    } else if(this.generateRigidbodies) {
        drawBodies();
    }
}

public void drawBodies() {
    if(this.generateRigidbodies) {

        PVector mouseCoordinates = screenToWorld(mouseX, mouseY);

        pushMatrix();
        rotate(this.angle);
        if(this.shapeType == ShapeType.CIRCLE) {
            float diameter = this.radius * 2.0f;
            fill(this.fillColor.x, this.fillColor.y, this.fillColor.z, this.opacity);
            strokeWeight(this.strokeWeight);
            stroke(this.strokeColor.x, this.strokeColor.y, this.strokeColor.z, this.opacity);
            ellipseMode(CENTER);
            ellipse(mouseCoordinates.x, mouseCoordinates.y,  diameter,  diameter);
            PVector va = new PVector();
            PVector vb = new  PVector(radius, 0);
            va = PhysEngMath.Transform(va, mouseCoordinates, this.angle);
            vb = PhysEngMath.Transform(vb, mouseCoordinates, this.angle);
            line(va.x, va.y, vb.x, vb.y);
        } else if (this.shapeType == ShapeType.BOX) {

            fill(this.fillColor.x, this.fillColor.y, this.fillColor.z, this.opacity);
            stroke(this.strokeColor.x, this.strokeColor.y, this.strokeColor.z, this.opacity);
            strokeWeight(this.strokeWeight);
            rectMode(CENTER);
            rect(mouseCoordinates.x, mouseCoordinates.y, this.width, this.height);
        }
    }
    popMatrix();
}

public void drawForces() {
    PVector worldAnchorA;
    PVector worldAnchorB;

    if(selectedRigidbodies.size() > 0) {
        if(isFirstClickOnRigidbody) {
            worldAnchorA = PhysEngMath.Transform(this.localAnchorA, this.tempBody.getPosition(), this.tempBody.getAngle());
            worldAnchorB = getMouseCoordinatesOverRigidbody();
        } else {
            worldAnchorA = this.anchorPoint;
            worldAnchorB = getMouseCoordinatesOverRigidbody();
        }
        
        if(this.forceType == ForceType.SPRING) {
            fill(255, 255, 255, opacity);
            PVector direction = PVector.sub(worldAnchorA, worldAnchorB);

            float length = direction.mag();
            direction.normalize();

            float segments = 10;
            float segmentLength = length / segments;

            float offsetMagnitude = 0.5f;

            //Draw the rod
            strokeWeight(0.3f);
            stroke(0, 0, 0, opacity); // Black
            line(worldAnchorA.x, worldAnchorA.y, worldAnchorB.x, worldAnchorB.y);
            stroke(255, 255, 255, opacity); // White
            strokeWeight(0.1f);
            line(worldAnchorA.x, worldAnchorA.y, worldAnchorB.x, worldAnchorB.y);
            
            //Draw the spring
            for(int i = 0; i < segments; i++) {
                PVector segmentStart = PVector.add(worldAnchorB, PVector.mult(direction, segmentLength * i));
                PVector segmentEnd = PVector.add(worldAnchorB, PVector.mult(direction, segmentLength * (i + 1)));

                // Calculate the midpoint of the segment
                PVector midPoint = PVector.lerp(segmentStart, segmentEnd, 0.5f);

                // Alternate the offset direction to give appearance of spring
                PVector offset1, offset2;
                if(i % 2 == 0) {
                    offset1 = PVector.mult(new PVector(-direction.y, direction.x), offsetMagnitude);
                    offset2 = PVector.mult(new PVector(direction.y, -direction.x), offsetMagnitude);
                } else {
                    offset1 = PVector.mult(new PVector(direction.y, -direction.x), offsetMagnitude);
                    offset2 = PVector.mult(new PVector(-direction.y, direction.x), offsetMagnitude);
                }

                // Add the offsets to the midpoint
                PVector midPoint1 = PVector.add(midPoint, offset1);
                PVector midPoint2 = PVector.add(midPoint, offset2);

                // Draw the lines
                strokeWeight(0.2f);
                stroke(0, 0, 0, opacity);
                line(segmentStart.x, segmentStart.y, midPoint1.x, midPoint1.y);
                line(midPoint1.x, midPoint1.y, segmentEnd.x, segmentEnd.y);
                line(segmentStart.x, segmentStart.y, midPoint2.x, midPoint2.y);
                line(midPoint2.x, midPoint2.y, segmentEnd.x, segmentEnd.y);
                strokeWeight(0.1f);
                stroke(255, 255, 255, opacity);
                line(segmentStart.x, segmentStart.y, midPoint1.x, midPoint1.y);
                line(midPoint1.x, midPoint1.y, segmentEnd.x, segmentEnd.y);
                line(segmentStart.x, segmentStart.y, midPoint2.x, midPoint2.y);
                line(midPoint2.x, midPoint2.y, segmentEnd.x, segmentEnd.y);
            }

        } else if(this.forceType == ForceType.ROD) {
            strokeWeight(0.15);
            stroke(0, 0, 0, opacity);
            line(worldAnchorA.x, worldAnchorA.y, worldAnchorB.x, worldAnchorB.y);
            strokeWeight(0.1);
            stroke(255, 255, 255, opacity);
            line(worldAnchorA.x, worldAnchorA.y, worldAnchorB.x, worldAnchorB.y);

        } else if(this.forceType == ForceType.MOTOR) {
            if(this.tempBody != null) {
            PVector position = this.tempBody.getPosition();
            boolean isClockwise = this.motorTargetAngularVelocity > 0;

            float size = this.tempBody.getRadius() * 0.5f;
            float arrowSize = size * 0.15f;
            float startAngle = 0;
            float endAngle = 3 * PI/2;// Change this to control the curvature of the arrow
            
            pushMatrix();
            translate(position.x, position.y);
            rotate(this.tempBody.getAngle() + PI/6);

            noFill();
            strokeWeight(0.1f);
            stroke(255, 0, 0, opacity);
            arc(0, 0, size, size, startAngle, endAngle);

            // Calculate the start and end of the arc
            float startX =  size * cos(startAngle)/2;
            float startY = size * sin(startAngle)/2;
            float endX = size * cos(endAngle)/2;
            float endY = size * sin(endAngle)/2;


            if(isClockwise) {
                strokeWeight(0.1f);
                stroke(255, 0, 0, opacity);
                triangle(endX, endY-arrowSize, endX, endY+arrowSize, endX+arrowSize*2, endY);
            } else {
                strokeWeight(0.1f);
                stroke(255, 0, 0, opacity);
                triangle(startX-arrowSize, startY, startX + arrowSize, startY, startX, startY - 2 * arrowSize);
            }
            popMatrix();
        }
        }
    }
}

public void updateSelectedRigidbodies() {
    if(this.selectedRigidbodies.size() == 2) {

        //For one body selected
        if(this.selectedRigidbodies.get(0) != null && this.selectedRigidbodies.get(1) == null) {

            this.selectedRigidbody = this.selectedRigidbodies.get(0);

            this.selectedRigidbody1 = null;
            this.selectedRigidbody2 = null;
            this.tempBody = null;

            this.oneRigidbodySelected = true;
            this.twoRigidbodiesSelected = false;

        } else if(this.selectedRigidbodies.get(0) == null && this.selectedRigidbodies.get(1) != null){
            
            this.selectedRigidbody = this.selectedRigidbodies.get(1);

            this.selectedRigidbody1 = null;
            this.selectedRigidbody2 = null;
            this.tempBody = null;

            this.oneRigidbodySelected = true;
            this.twoRigidbodiesSelected = false;
        
        }else if(this.selectedRigidbodies.get(0) != null && this.selectedRigidbodies.get(1) != null) {

            this.selectedRigidbody1 = this.selectedRigidbodies.get(0);
            this.selectedRigidbody2 = this.selectedRigidbodies.get(1);

            this.selectedRigidbody = null;
            this.tempBody = null;

            this.oneRigidbodySelected = false;
            this.twoRigidbodiesSelected = true;

        } else if(this.selectedRigidbodies.get(0) == null && this.selectedRigidbodies.get(1) == null) {

            this.selectedRigidbody = null;
            this.selectedRigidbody1 = null;
            this.selectedRigidbody2 = null;
            this.tempBody = null;

            this.oneRigidbodySelected = false;
            this.twoRigidbodiesSelected = false;
        }
        this.selectedRigidbodies.clear();

    } else if(this.selectedRigidbodies.size() == 1) {
            
            if(this.selectedRigidbodies.get(0) != null) {
    
                this.tempBody = this.selectedRigidbodies.get(0);

                this.selectedRigidbody = null;
                this.selectedRigidbody1 = null;
                this.selectedRigidbody2 = null;
    
                this.oneRigidbodySelected = true;
                this.twoRigidbodiesSelected = false;
    
            } else if(this.selectedRigidbodies.get(0) == null) {
                
                this.tempBody = null;
                this.selectedRigidbody = null;
                this.selectedRigidbody1 = null;
                this.selectedRigidbody2 = null;
    
                this.oneRigidbodySelected = false;
                this.twoRigidbodiesSelected = false;
            }
    }
}


public void createForces() {
    if(this.selectedRigidbody != null && this.selectedRigidbody1 == null && this.selectedRigidbody2 == null) {
        if(this.forceType == ForceType.SPRING) {
            Spring spring;
            float springLength;
            if(isFirstClickOnRigidbody) {

                PVector mouseCoordinates = screenToWorld(mouseX, mouseY);

                springLength = PVector.dist(mouseCoordinates, PVector.add(this.localAnchorA, this.selectedRigidbody.getPosition()));

                spring = new Spring(this.selectedRigidbody, this.localAnchorA, mouseCoordinates);

            } else {
                PVector mouseCoordinates = screenToWorld(mouseX, mouseY);

                this.localAnchorA = PhysEngMath.SnapController(this, this.selectedRigidbody, mouseCoordinates);

                springLength = PVector.dist(mouseCoordinates, this.anchorPoint);
                spring = new Spring(this.selectedRigidbody, this.localAnchorA, this.anchorPoint);
            }

            spring.setSpringLength(springLength);
            spring.setPerfectSpring(this.isPerfectSpring);
            spring.setEquilibriumLength(this.equilibriumLength);
            spring.setSpringConstant(this.springConstant);
            spring.setDamping(this.springDamping);
            spring.setIsHingeable(this.isSpringHingeable);

            this.selectedRigidbody.addForceToForceRegistry(spring);

        } else if(this.forceType == ForceType.ROD) {

            Rod rod;
            if(isFirstClickOnRigidbody) {

                PVector mouseCoordinates = screenToWorld(mouseX, mouseY);
                rod = new Rod(this.selectedRigidbody, this.localAnchorA, mouseCoordinates);

            } else {

                this.localAnchorA = PhysEngMath.SnapController(this, this.selectedRigidbody, screenToWorld(mouseX, mouseY));
                rod = new Rod(this.selectedRigidbody, this.localAnchorA, this.anchorPoint);
            }

            rod.setIsHingeable(this.isRodHingeable);

            this.selectedRigidbody.addForceToForceRegistry(rod);

        } else if(this.forceType == ForceType.MOTOR) {
            Motor motor = new Motor(this.selectedRigidbody, this.motorTargetAngularVelocity);
            motor.setDrawMotor(this.motorDrawMotor);
            motor.setDrawMotorForce(this.motorDrawMotorForce);
            
            Iterator<ForceRegistry> iterator = this.selectedRigidbody.getForceRegistry().iterator();
            
            while (iterator.hasNext()) {
                ForceRegistry force = iterator.next();
                
                if (force instanceof Motor) {
                    iterator.remove();
                }
            }
            this.selectedRigidbody.addForceToForceRegistry(motor);
        }

    } else if(this.selectedRigidbody1 != null && this.selectedRigidbody2 != null && this.selectedRigidbody == null && this.selectedRigidbody1 != this.selectedRigidbody2) {
        if(this.forceType == ForceType.SPRING) {

            Spring spring1;
            Spring spring2;

            float springLength;
            PVector localAnchorB = PhysEngMath.SnapController(this, this.selectedRigidbody2, screenToWorld(mouseX, mouseY));

            springLength = PVector.dist(screenToWorld(mouseX, mouseY), PVector.add(this.localAnchorA, this.selectedRigidbody1.getPosition()));

            spring1 = new Spring(this.selectedRigidbody1, this.selectedRigidbody2, this.localAnchorA, localAnchorB);
            spring2 = new Spring(this.selectedRigidbody2, this.selectedRigidbody1, localAnchorB, this.localAnchorA);
        
            spring1.setSpringLength(springLength);
            spring2.setSpringLength(springLength);

            spring1.setPerfectSpring(this.isPerfectSpring);
            spring2.setPerfectSpring(this.isPerfectSpring);

            spring1.setEquilibriumLength(this.equilibriumLength);
            spring2.setEquilibriumLength(this.equilibriumLength);

            spring1.setSpringConstant(this.springConstant);
            spring2.setSpringConstant(this.springConstant);

            spring1.setDamping(this.springDamping);
            spring2.setDamping(this.springDamping);

            spring1.setIsHingeable(this.isSpringHingeable);
            spring2.setIsHingeable(this.isSpringHingeable);

            this.selectedRigidbody1.addForceToForceRegistry(spring1);
            this.selectedRigidbody2.addForceToForceRegistry(spring2);

        } else if(this.forceType == ForceType.ROD) {
            Rod rod1;
            Rod rod2;

            float rodLength;
            PVector localAnchorB = PhysEngMath.SnapController(this, this.selectedRigidbody2, screenToWorld(mouseX, mouseY));

            rod1 = new Rod(this.selectedRigidbody1, this.selectedRigidbody2, this.localAnchorA, localAnchorB);
            rod2 = new Rod(this.selectedRigidbody2, this.selectedRigidbody1, localAnchorB, this.localAnchorA);

            rod1.setIsHingeable(this.isRodHingeable);
            rod2.setIsHingeable(this.isRodHingeable);

            this.selectedRigidbody1.addForceToForceRegistry(rod1);
            this.selectedRigidbody2.addForceToForceRegistry(rod2);
        }

} else if(this.selectedRigidbody1 != null && this.selectedRigidbody2 != null && this.selectedRigidbody1 == this.selectedRigidbody2) {
    
        if(this.forceType == ForceType.ROD) {
            PVector mouseCoordinates = screenToWorld(mouseX, mouseY);
            Rod rod = new Rod(this.selectedRigidbody1, this.localAnchorA, mouseCoordinates);
            rod.setIsHingeable(this.isRodHingeable);

            this.selectedRigidbody1.addForceToForceRegistry(rod);
        }
        else if(this.forceType == ForceType.MOTOR) {

            Motor motor = new Motor(this.selectedRigidbody1, this.motorTargetAngularVelocity);
            motor.setDrawMotor(this.motorDrawMotor);
            motor.setDrawMotorForce(this.motorDrawMotorForce);
            
            Iterator<ForceRegistry> iterator = this.selectedRigidbody1.getForceRegistry().iterator();
            
            while (iterator.hasNext()) {
                ForceRegistry force = iterator.next();
                
                if (force instanceof Motor) {
                    iterator.remove();
                }
            }
            this.selectedRigidbody1.addForceToForceRegistry(motor);
        }
    }
}


public void firstMouseClickInformation() {

    Rigidbody clickedBody = getClickedRigidbody();
    PVector mousePos = screenToWorld(mouseX, mouseY);

    if(clickedBody != null) {

        this.localAnchorA = PhysEngMath.SnapController(this, clickedBody, mousePos);
        this.anchorPoint = mousePos;
        this.isFirstClickOnRigidbody = true;
    } else {
        this.anchorPoint = mousePos;
        this.isFirstClickOnRigidbody = false;
    }
}




/*
====================================================================================================
======================================= Getters & Setters ==========================================
====================================================================================================
*/


public void setWidth(float width) {
  this.width = width;
}

public void setHeight(float height) {
  this.height = height;
}

public void setRadius(float radius) {
  this.radius = radius;
}

public void setDensity(float density) {
  this.density = density;
}

public void setRestitution(float restitution) {
  this.restitution = restitution;
}

public void setIsStatic(boolean isStatic) {
  this.isStatic = isStatic;
}

public void setCollidable(boolean isCollidable) {
  this.isCollidable = isCollidable;
}

public void setStrokeWeight(float strokeWeight) {
  this.strokeWeight = strokeWeight;
}

public void setStrokeColor(PVector strokeColor) {
  this.strokeColor = strokeColor;
}

public void setFillColor(PVector fillColor) {
  this.fillColor = fillColor;
}

public void setShapeType(ShapeType shapeType) {
  this.shapeType = shapeType;
}

public void setIsTranslationallyStatic(boolean isTranslationallyStatic) {
  this.isTranslationallyStatic = isTranslationallyStatic;
}

public void setIsRotationallyStatic(boolean isRotationallyStatic) {
  this.isRotationallyStatic = isRotationallyStatic;
}

public void setGenerateRigidbodies(boolean generateRigidbodies) {
  this.generateRigidbodies = generateRigidbodies;
}

public void setGenerateForces(boolean generateForces) {
  this.generateForces = generateForces;
}

public void setAngle(float angle) {
  this.angle = angle;
}

public void setAngularVelocity(float angularVelocity) {
  this.angularVelocity = angularVelocity;
}

public void setForceType(ForceType forceType) {
  this.forceType = forceType;
}

public void setAddGravity(boolean addGravity) {
  this.addGravity = addGravity;
}

public void setSpringIsPerfect(boolean isPerfectSpring) {
  this.isPerfectSpring = isPerfectSpring;
}

public void setSpringIsHingeable(boolean isSpringHingeable) {
  this.isSpringHingeable = isSpringHingeable;
}
public void setSpringEquilibriumLength(float equilibriumLength) {
  this.equilibriumLength = equilibriumLength;
}

public void setSpringDamping(float damping) {
  this.springDamping = damping;
}

public void setSpringConstant(float springConstant) {
  this.springConstant = springConstant;
}

public void setLockToXAxis(boolean lockTranslationToXAxis) {
  this.lockTranslationToXAxis = lockTranslationToXAxis;
}

public void setLockToYAxis(boolean lockTranslationToYAxis) {
  this.lockTranslationToYAxis = lockTranslationToYAxis;
}

public void setRigidbodyPosition(PVector position) {
  this.rigidbodyPosition = position;
}



public void setRodIsHingeable(boolean isRodHingeable) {
  this.isRodHingeable = isRodHingeable;
}

public void setSnapToCenter(boolean snapToCenter) {
  this.snapToCenter = snapToCenter;
}

public void setSnapToEdge(boolean snapToEdge) {
  this.snapToEdge = snapToEdge;
}

public void setSnapToVertices(boolean snapToVertices) {
  this.snapToVertices = snapToVertices;
}

public void setMotorDrawMotorForce(boolean motorDrawMotorForce) {
  this.motorDrawMotorForce = motorDrawMotorForce;
}

public void setMotorDrawMotor(boolean motorDrawMotor) {
  this.motorDrawMotor = motorDrawMotor;
}

public void setMotorTargetAngularVelocity(float motorTargetAngularVelocity) {
  this.motorTargetAngularVelocity = motorTargetAngularVelocity;
}

public void setSelectedRigidbody(Rigidbody selectedRigidbody) {
  this.selectedRigidbody = selectedRigidbody;
}

public void setSelectedRigidbody1() {
  this.selectedRigidbody1 = this.selectedRigidbody;
}

public void setSelectedRigidbody2(Rigidbody selectedRigidbody2) {
  this.selectedRigidbody2 = selectedRigidbody2;
}

public void setDrawCursorTrail(boolean showCursorTrail) {
  this.showCursorTrail = showCursorTrail;
}

public void setEnableEditor(boolean enableEditor) {
  this.enableEditor = enableEditor;
}

public void setVertices(PVector[] vertices) {
  this.vertices = vertices;
}

public void setSoftbodyWidth(float softbodyWidth) {
  this.softbodyWidth = softbodyWidth;
}

public void setSoftbodyHeight(float softbodyHeight) {
  this.softbodyHeight = softbodyHeight;
}

public float getWidth() {
  return this.width;
}

public float getHeight() {
  return this.height;
}

public float getRadius() {
  return this.radius;
}

public float getDensity() {
  return this.density;
}

public float getRestitution() {
  return this.restitution;
}

public boolean getIsStatic() {
  return this.isStatic;
}

public boolean getCollidable() {
  return this.isCollidable;
}

public float getStrokeWeight() {
  return this.strokeWeight;
}

public PVector getStrokeColor() {
  return this.strokeColor;
}

public PVector getFillColor() {
    return this.fillColor;
}

public ShapeType getShapeType() {
  return this.shapeType;
}

public boolean getIsTranslationallyStatic() {
  return this.isTranslationallyStatic;
}

public boolean getIsRotationallyStatic() {
  return this.isRotationallyStatic;
}

public boolean getGenerateRigidbodies() {
  return this.generateRigidbodies;
}

public boolean getGenerateForces() {
  return this.generateForces;
}

public float getAngle() {
  return this.angle;
}

public float getAngularVelocity() {
  return this.angularVelocity;
}

public boolean getAddGravity() {
  return this.addGravity;
}

public boolean getIsPerfectSpring() {
  return this.isPerfectSpring;
}


public boolean getSnapToEdge() {
    return this.snapToEdge;
}

public boolean getSnapToCenter() {
    return this.snapToCenter;
}

public boolean getSnapToVertices() {
    return this.snapToVertices;
}
public boolean getMotorDrawMotorForce() {
    return this.motorDrawMotorForce;
}

public boolean getMotorDrawMotor() {
    return this.motorDrawMotor;
}

public float getMotorTargetAngularVelocity() {
    return this.motorTargetAngularVelocity;
}

public Rigidbody getSelectedRigidbody() {
    return this.selectedRigidbody;
}

public Rigidbody getSelectedRigidbody1() {
    return this.selectedRigidbody1;
}

public Rigidbody getSelectedRigidbody2() {
    return this.selectedRigidbody2;
}

public boolean getEnableEditor() {
    return this.enableEditor;
}

public PVector[] getVertices() {
    return this.vertices;
}

public float getSoftbodyWidth(){
    return this.softbodyWidth;
}

public float getSoftbodyHeight(){
    return this.softbodyHeight;
}

}




