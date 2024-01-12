

public class InteractivityListener {

  public PVector position;
  public float zoom;

/*
====================================================================================================
================================= GUI Variables for Rigidbody Generation ===========================
====================================================================================================
*/
  private float width;
  private float height;

  private float radius;

  private float density;
  private float restitution;

  
  private float angle;
  private float angularVelocity;

  //TODO: IMPLEMENT THIS IN THE GUI
  private boolean generateRigidbodies = true;
  private boolean generateForces = false;

  private boolean isStatic;
  private boolean isTranslationallyStatic;
  private boolean isRotationallyStatic;
  private boolean isCollidable;

  private boolean addGravity;

  private float strokeWeight;
  private PVector strokeColor;
  private PVector fillColor;

  private ShapeType shapeType;

  public InteractivityListener() {
    position = new PVector(0, -50);
    zoom = 10f;
  }
/*
====================================================================================================
=============================== GUI Variables for Force Generation =================================
====================================================================================================
*/

/*------------------------------ Global Variables ----------------------------*/
    private Rigidbody selectedRigidbody; //Can treat this as rigidbodyA
    private Rigidbody mouseInteractionRigidbody; //Can treat this rigidbodyB for drawing forces
    private Rigidbody clickedRigidbody;
    private PVector anchorPoint;
    private PVector localAnchorA;
    private PVector localAnchorB;


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
    private float targetAngularVelocity;
    
    private boolean drawMotorForce;

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

/*
====================================================================================================
======================================= Rigidbody Generation Methods ================================
====================================================================================================
*/

public void GenerateRigidbody() {
     if(this.shapeType == ShapeType.BOX) {

            Rigidbody rigidbody = RigidbodyGenerator.CreateBoxBody( this.width, this.height,
                                                                    this.density, this.restitution,
                                                                    this.isStatic, this.isCollidable,
                                                                    this.strokeWeight, this.strokeColor,
                                                                    this.fillColor);
                                                    

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
}

/*
====================================================================================================
======================================= Force Generation Methods ===================================
====================================================================================================
*/

public void setInitialGenerationValues(){
    if(userInterface.getController("AddSpring").getValue() == 1) {
        PVector mouseCoord = screenToWorld(mouseX, mouseY);

        this.localAnchorA = PVector.sub(mouseCoord, this.selectedRigidbody.getPosition());
    }
}
public void AddNewForceToOneBody() {
    if(userInterface.getController("AddSpring").getValue() == 1) {
        PVector anchorPoint = screenToWorld(mouseX, mouseY);
        Spring spring = new Spring(this.selectedRigidbody, this.localAnchorA, anchorPoint);

        PVector springLength = PVector.add(this.selectedRigidbody.getPosition(), this.localAnchorA);
        springLength.sub(anchorPoint);

        spring.setSpringLength(springLength.mag());
        spring.setPerfectSpring(this.isPerfectSpring);
        spring.setIsHingeable(this.isSpringHingeable);
        spring.setEquilibriumLength(this.equilibriumLength);
        spring.setDamping(this.springDamping);
        spring.setSpringConstant(this.springConstant);
        spring.setLockTranslationToXAxis(this.lockTranslationToXAxis);
        spring.setLockTranslationToYAxis(this.lockTranslationToYAxis);
        this.selectedRigidbody.addForceToForceRegistry(spring);


    //TOOOOODOOOOOOOOOOOO
    } else if(userInterface.getController("AddRod").getValue() == 1) {
        PVector anchorPoint = screenToWorld(mouseX, mouseY);
        
        Rod rod = new Rod(this.selectedRigidbody, this.localAnchorA, anchorPoint);

        rod.setIsHingeable(this.isRodHingeable);

        this.selectedRigidbody.addForceToForceRegistry(rod);
    
    } else if(userInterface.getController("AddMotor").getValue() == 1) {
    }
}

public void AddNewForceToTwoBodies(Rigidbody clickedRigidbody){
    if(userInterface.getController("AddSpring").getValue() == 1) {
        PVector anchorPoint = screenToWorld(mouseX, mouseY);
        PVector localAnchorB = PVector.sub(anchorPoint, clickedRigidbody.getPosition());

        float springLength = PVector.add(this.selectedRigidbody.getPosition(), this.localAnchorA).mag();

        Spring spring1 = new Spring(selectedRigidbody, clickedRigidbody, this.localAnchorA, localAnchorB);
        Spring spring2 = new Spring(clickedRigidbody, this.selectedRigidbody, localAnchorB, this.localAnchorA);

        spring1.setPerfectSpring(this.isPerfectSpring);
        spring2.setPerfectSpring(this.isPerfectSpring);

        spring1.setSpringLength(springLength);
        spring2.setSpringLength(springLength);

        spring1.setIsHingeable(this.isSpringHingeable);
        spring2.setIsHingeable(this.isSpringHingeable);

        spring1.setEquilibriumLength(this.equilibriumLength);
        spring2.setEquilibriumLength(this.equilibriumLength);

        spring1.setDamping(this.springDamping);
        spring2.setDamping(this.springDamping);

        spring1.setSpringConstant(this.springConstant);
        spring2.setSpringConstant(this.springConstant);

        spring1.setLockTranslationToXAxis(this.lockTranslationToXAxis);
        spring2.setLockTranslationToXAxis(this.lockTranslationToXAxis);

        spring1.setLockTranslationToYAxis(this.lockTranslationToYAxis);
        spring2.setLockTranslationToYAxis(this.lockTranslationToYAxis);

        this.selectedRigidbody.addForceToForceRegistry(spring1);
        clickedRigidbody.addForceToForceRegistry(spring2);
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

public void setSelectedRigidbody(Rigidbody selectedRigidbody) {
  this.selectedRigidbody = selectedRigidbody;
}


public void setMouseInteractionRigidbody(Rigidbody mouseInteractionRigidbody) {
  this.mouseInteractionRigidbody = mouseInteractionRigidbody;
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

public void setRodIsHingeable(boolean isRodHingeable) {
  this.isRodHingeable = isRodHingeable;
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

public Rigidbody getSelectedRigidbody() {
  return this.selectedRigidbody;
}


public Rigidbody getMouseInteractionRigidbody() {
  return this.mouseInteractionRigidbody;
}

public boolean getAddGravity() {
  return this.addGravity;
}

public boolean getIsPerfectSpring() {
  return this.isPerfectSpring;
}

}



public void mouseWheel(MouseEvent event) {
    if(!userInterface.isMouseOver()) {
        float e = -event.getCount();
        interactivityListener.zoom(pow(1.1f, e), mouseX, mouseY);
    }
}

public void mouseDragged() {
  if(!userInterface.isMouseOver()){
    interactivityListener.move(pmouseX - mouseX, pmouseY - mouseY);
  }
}


public Rigidbody selectedRigidbody = null;

public void mouseClicked() {

    if(!userInterface.isMouseOver() && interactivityListener.getGenerateRigidbodies()) {
        interactivityListener.GenerateRigidbody();
    }
    
    if(!userInterface.isMouseOver() && interactivityListener.getGenerateForces()) {
        
        Rigidbody clickedRigidbody = getClickedRigidbody();
            if (clickedRigidbody != null) {
                if (interactivityListener.getSelectedRigidbody() == null) {
                    interactivityListener.setSelectedRigidbody(clickedRigidbody);
                    interactivityListener.setInitialGenerationValues();
                } else {
                    if(clickedRigidbody != interactivityListener.getSelectedRigidbody()) {
                        interactivityListener.AddNewForceToTwoBodies(clickedRigidbody);
                        interactivityListener.setSelectedRigidbody(null);
                    }
                }
            } else {
                if (interactivityListener.getSelectedRigidbody() != null) {
                    interactivityListener.AddNewForceToOneBody();
                    interactivityListener.setSelectedRigidbody(null);
                }
            }
        }
    }

public Rigidbody getClickedRigidbody() {
    PVector mousePosition = interactivityListener.screenToWorld(mouseX, mouseY);
    for (Rigidbody rigidbody : rigidbodyList) { // Replace with your list of rigidbodies
        if (rigidbody.contains(mousePosition.x, mousePosition.y)) {
            return rigidbody;
        }
    }

    return null;
}





