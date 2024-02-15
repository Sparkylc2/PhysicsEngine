

//public class InteractivityListener {

  //public PVector position;
  //public float zoom;
//
  //public boolean showCursorTrail = true;
  //public int lastTime;
  //public ArrayList<PVector> trail = new ArrayList<PVector>();


/*--------- Stuff for the velocity calculation ----------------*/
  //public boolean mouseDown = false;
  //public PVector initialMousePosition = new PVector();
  //public PVector currentMousePosition = new PVector();
  //public PVector velocity = new PVector();
  //public PVector endPoint = new PVector();
/*---------- Stuff for mouse spring ----------- */
  //public Spring mouseSpring;
  //public boolean mouseSpringCreated = false;


/* Stuff for editing rigidbodies */
  //public boolean editRigidbody = false;
  //public boolean copied = false;
  //public boolean pasted = false;
/*
====================================================================================================
================================= GUI Variables for Rigidbody Generation ===========================
====================================================================================================
*/
  //private Rigidbody currentlySelectedRigidbody;
  //private float width;
  //private float height;
//
  //private float softbodyWidth;
  //private float softbodyHeight;
//
  //private PVector[] vertices;
//
  //private float radius;
  //private PVector rigidbodyPosition;
//
  //private float density;
  //private float restitution;
//
  //
  //private float angle;
  //private float angularVelocity;
//
  //private boolean generateRigidbodies;
  //private boolean generateForces;
//
  //  //TODO IMPLEMENT THIS
  //private boolean showObjectTrail;
//
  //private boolean isStatic;
  //private boolean isTranslationallyStatic;
  //private boolean isRotationallyStatic;
//
  //private boolean isCollidable;
//
  //private boolean addGravity;
//
  //private float strokeWeight;
  //private PVector strokeColor;
  //private PVector fillColor;
//
  //private ShapeType shapeType;
  //
//
  //public InteractivityListener() {
  //  position = new PVector(-50, -50);
  //  zoom = 10f;
  //}
/*
====================================================================================================
=============================== GUI Variables for Force Generation =================================
====================================================================================================
*/

/*------------------------------- Global Variables ----------------------------*/
    //private ForceType forceType;
//
//
    //private ArrayList<Rigidbody> selectedRigidbodies = new ArrayList<Rigidbody>();
//
    //private boolean isFirstClickOnRigidbody = false;
    //private boolean drawForces = false;
    //private boolean oneRigidbodySelected = false;
    //private boolean twoRigidbodiesSelected = false;
//
    //private int opacity = 166;
    //private Rigidbody tempBody;
//
    //private Rigidbody selectedRigidbody;
    //private Rigidbody selectedRigidbody1;
    //private Rigidbody selectedRigidbody2;
//
    //private PVector anchorPoint;
    //private PVector localAnchorA;
//
    //private boolean snapToCenter;
    //private boolean snapToEdge;
    //private boolean snapToVertices;
    //private boolean snapGeneral = true;
//
    //private boolean enableEditor;

/*----------------------------- Spring Variables -----------------------------*/
//
    //private boolean lockTranslationToXAxis;
    //private boolean lockTranslationToYAxis;
  //
    //private boolean isPerfectSpring;
//
    //private float equilibriumLength;
    //private float springLength;
    //private float springConstant;
    //private float springDamping;
//
    //private boolean isSpringHingeable;


/*--------------------------- Rod Variables ---------------------------------*/
    
    //private boolean isRodHingeable;
    //private boolean isTwoBodyRod;
    //private boolean isJoint;

/*--------------------------- Motor Variables ----------------------------*/
    //private float motorTargetAngularVelocity;
    //private boolean motorDrawMotor;
    //private boolean motorDrawMotorForce;

/*
====================================================================================================
======================================= GUI Methods ================================================
====================================================================================================
*/


/*
====================================================================================================
======================================= Rigidbody Generation Methods ================================
====================================================================================================
*/
/*

public void GenerateRigidbody() {
    if(!InteractionCache.getRT_OR_ToggleState(0, 1)) {
        return;
    }

    if(!isPaused && Mouse.getRigidbodyUnderMouse() != null) {
        return;
    }
    if(isInEditMode) {
        return;
    }

    if(!Mouse.getIsMouseOverUI()){
        
        if(InteractionCache.getRT_ToggleState(0)){
            Rigidbody rigidbody = RigidbodyGenerator.CreateCircleBody(this.radius, this.density,
                                                                      this.restitution, this.isStatic,
                                                                      this.isCollidable, this.strokeWeight,
                                                                      this.strokeColor, this.fillColor);
              
            rigidbody.SetInitialPosition(Mouse.getMouseCoordinates());
            rigidbody.setVelocity(PhysEngMath.SquareVelocity(this.velocity).mult(-1));
            rigidbody.setIsTranslationallyStatic(this.isTranslationallyStatic);
            rigidbody.setIsRotationallyStatic(this.isRotationallyStatic);
            rigidbody.setCollidability(this.isCollidable);
            rigidbody.RotateTo(this.angle);
            rigidbody.setAngularVelocity(this.angularVelocity);
            if(this.addGravity) {
                rigidbody.addForceToForceRegistry(new Gravity(rigidbody));
            }

            AddBodyToBodyEntityList(rigidbody);
        }

        if(InteractionCache.getRT_ToggleState(1)) {

            Rigidbody rigidbody = RigidbodyGenerator.CreateBoxBody( this.width, this.height,
                                                                    this.density, this.restitution,
                                                                    this.isStatic, this.isCollidable,
                                                                    this.strokeWeight, this.strokeColor,
                                                                    this.fillColor);

            rigidbody.setVelocity(PhysEngMath.SquareVelocity(this.velocity).mult(-1));
            rigidbody.SetInitialPosition(Mouse.getMouseCoordinates());
            rigidbody.setIsTranslationallyStatic(this.isTranslationallyStatic);
            rigidbody.setCollidability(this.isCollidable);
            rigidbody.setIsRotationallyStatic(this.isRotationallyStatic);
            rigidbody.RotateTo(this.angle);
            rigidbody.setAngularVelocity(this.angularVelocity);

            if(this.copied && !this.pasted) {
                rigidbody.updatePolygon(this.vertices);
                this.pasted = true;
                this.copied = false;
            }

            if(this.addGravity) {
                rigidbody.addForceToForceRegistry(new Gravity(rigidbody));
            }

            AddBodyToBodyEntityList(rigidbody);
        }

        this.velocity.set(0,0,0);

   }
}
*/
/*
====================================================================================================
======================================= Force Generation Methods ===================================
====================================================================================================
*/
/*

public void drawInteractions() {
    Mouse.DrawMouseCursor();

    if(InteractionCache.getActiveTabID() == 1){
        if(userInterface.getController("AddSpring").getValue() == 0 && userInterface.getController("AddRod").getValue() == 0 && userInterface.getController("AddMotor").getValue() == 0) {
            return;
        }
        drawForces();
    } else if(InteractionCache.getActiveTabID() == 0 && InteractionCache.getRT_OR_ToggleState(0,1)) {
        if(Mouse.getIsMouseDown() && !isInEditMode && !shiftPressed){
            drawVelocityLine();
        }
        if(InteractionCache.getActiveTabID() == 0){
            if(editRigidbody) {

            } else if(!mouseSpringAdded && !isInEditMode) {
                drawBodies();
            }
        }
    }
}
*/
/*
public void drawVelocityLine() {

    //This takes care of updating the new velocity values and endpoint values for the rigidbodies 
    PVector mouseDownCoordinates = Mouse.getMouseDownCoordinates();
    PVector currentMouseCoordinates = Mouse.getMouseCoordinates();

    this.velocity.set(PhysEngMath.MouseVelocityCalculationAndClamp(mouseDownCoordinates, currentMouseCoordinates, MIN_MOUSE_VELOCITY_MAG, MAX_MOUSE_VELOCITY_MAG));
    PVector endPoint = PVector.add(mouseDownCoordinates, this.velocity);
    
    if(PVector.sub(mouseDownCoordinates, endPoint).magSq() > 0.1f){
        float lerpVal = map(this.velocity.mag(), MIN_MOUSE_VELOCITY_MAG, MAX_MOUSE_VELOCITY_MAG, 0, 1);
        lerpVal = lerpVal * lerpVal; // This creates a quadratic effect

        int colour = lerpColor(color(0, 255, 0), color(255, 0, 0), lerpVal);
        stroke(colour);
        line(mouseDownCoordinates.x, mouseDownCoordinates.y, endPoint.x, endPoint.y);
    }
}
*/

/*
public void drawBodies() {
    PVector mouseCoordinates = Mouse.getMouseCoordinates();

    pushMatrix();
    translate(mouseCoordinates.x, mouseCoordinates.y);
    rotate(this.angle);
    if(this.shapeType == ShapeType.CIRCLE) {
        float diameter = this.radius * 2.0f;
        fill(this.fillColor.x, this.fillColor.y, this.fillColor.z, this.opacity);
        strokeWeight(this.strokeWeight);
        stroke(this.strokeColor.x, this.strokeColor.y, this.strokeColor.z, this.opacity);
        ellipseMode(CENTER);

        ellipse(0, 0, diameter,  diameter);

        PVector va = new PVector();
        PVector vb = new  PVector(radius, 0);
        va = PhysEngMath.Transform(va, new PVector(), this.angle);
        vb = PhysEngMath.Transform(vb, new PVector(), this.angle);
        line(va.x, va.y, vb.x, vb.y);

    } else if (this.shapeType == ShapeType.BOX && !this.copied) {
        fill(this.fillColor.x, this.fillColor.y, this.fillColor.z, this.opacity);
        stroke(this.strokeColor.x, this.strokeColor.y, this.strokeColor.z, this.opacity);
        strokeWeight(this.strokeWeight);
        rectMode(CENTER);
        rect(0, 0, this.width, this.height);
    } else if(this.shapeType == ShapeType.BOX) {
        fill(this.fillColor.x, this.fillColor.y, this.fillColor.z, this.opacity);
        stroke(this.strokeColor.x, this.strokeColor.y, this.strokeColor.z, this.opacity);
        strokeWeight(this.strokeWeight);

        beginShape();
        for(PVector vertex : vertices) {
            vertex(vertex.x, vertex.y);
        }
        endShape();
    }

    popMatrix();
}



public void drawForces() {
    if(isInEditMode) {
        return;
    }

    Rigidbody rigidbodyToDrawFrom;
    PVector worldAnchorA;
    PVector worldAnchorB;
    ArrayList<MouseObjectResult> mouseObjectResults = Mouse.getMouseObjectResults();
    if(mouseObjectResults.size() == 0 || mouseObjectResults.size() > 1) {
        return;
    }
        rigidbodyToDrawFrom = mouseObjectResults.get(0).getSelectedRigidbody();

        if(rigidbodyToDrawFrom != null) {
            worldAnchorA = PhysEngMath.Transform(mouseObjectResults.get(0).getTransformedLocalCoordinate(), rigidbodyToDrawFrom.getPosition(), rigidbodyToDrawFrom.getAngle());
            worldAnchorB = Mouse.getMouseCoordinates();
        } else {
            worldAnchorA = mouseObjectResults.get(0).getWorldCoordinate();
            worldAnchorB = Mouse.getMouseCoordinates();
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

            if(rigidbodyToDrawFrom == null) {
                return;
            }

            PVector position = rigidbodyToDrawFrom.getPosition();
            boolean isClockwise = this.motorTargetAngularVelocity > 0;

            float size = rigidbodyToDrawFrom.getRadius() * 0.5f;
            float arrowSize = size * 0.15f;
            float startAngle = 0;
            float endAngle = 3 * PI/2;// Change this to control the curvature of the arrow
            
            pushMatrix();
            translate(position.x, position.y);
            rotate(rigidbodyToDrawFrom.getAngle() + PI/6);

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
*/

/*
public void createForces() {
    /*
    if(InteractionCache.getActiveForceSelectedID() == -1 || InteractionCache.getActiveTabID() != 1) {
        return;
    }
    
    if(true) {
        return;
    }
    if(isInEditMode) {
        return;
    }

    ArrayList<MouseObjectResult> mouseObjectResults = Mouse.getMouseObjectResults();
    if(mouseObjectResults.size() == 0 || mouseObjectResults.size() == 1){
        return;
    }

    PVector mouseCoordinates = Mouse.getMouseCoordinates();

    Rigidbody rigidbody1 = mouseObjectResults.get(0).getSelectedRigidbody();
    Rigidbody rigidbody2 = mouseObjectResults.get(1).getSelectedRigidbody();
    PVector anchor1 = mouseObjectResults.get(0).getTransformedLocalCoordinate();
    PVector anchor2 = mouseObjectResults.get(1).getTransformedLocalCoordinate();

    Rigidbody[] rigidbodyArray = new Rigidbody[0];
    PVector[] anchorArray = new PVector[0];

    if(rigidbody1 != null && rigidbody2 == null) {
        rigidbodyArray = new Rigidbody[]{rigidbody1};
        anchorArray = new PVector[]{anchor1};
    } else if(rigidbody1 == null && rigidbody2 != null){
        rigidbodyArray = new Rigidbody[]{rigidbody2};
        anchorArray = new PVector[]{anchor2};
    } else if(rigidbody1 != null && rigidbody2 != null) {
        rigidbodyArray = new Rigidbody[]{rigidbody1, rigidbody2};
        anchorArray = new PVector[]{anchor1, anchor2};
    } else if(rigidbody1 == null && rigidbody2 == null) {
        return;
    }

    mouseObjectResults.clear();

    if(InteractionCache.getActiveForceSelectedID() == 0) {
        Spring spring;
            if(rigidbodyArray.length == 1) {
                spring = new Spring(rigidbodyArray[0], anchorArray[0], mouseCoordinates);

                ALL_FORCES_ARRAYLIST.add(spring);
                rigidbodyArray[0].addForceToForceRegistry(spring);

            } else if(rigidbodyArray.length == 2) {
                spring = new Spring(rigidbodyArray[0], rigidbodyArray[1], anchorArray[0], anchorArray[1]);

                ALL_FORCES_ARRAYLIST.add(spring);
                rigidbodyArray[0].addForceToForceRegistry(spring);
                rigidbodyArray[1].addForceToForceRegistry(spring);
            } else {
                throw new IllegalArgumentException("RigidbodyArray is 0");
            }

            spring.setEquilibriumLength(this.equilibriumLength);
            spring.setSpringConstant(this.springConstant);
            spring.setDamping(this.springDamping);

            spring.setLockTranslationToXAxis(this.lockTranslationToXAxis);
            spring.setLockTranslationToYAxis(this.lockTranslationToYAxis);
            spring.setPerfectSpring(this.isPerfectSpring);

    } else if(InteractionCache.getActiveForceSelectedID() == 1){

        Rod rod;
        if(rigidbodyArray.length == 1) {

            rod = new Rod(rigidbodyArray[0], anchorArray[0], mouseCoordinates);
            ALL_FORCES_ARRAYLIST.add(rod);
            
            rigidbodyArray[0].addForceToForceRegistry(rod);

        } else if(rigidbodyArray.length == 2) {

            rod = new Rod(rigidbodyArray[0], rigidbodyArray[1], anchorArray[0], anchorArray[1]);

            ALL_FORCES_ARRAYLIST.add(rod);
            rigidbodyArray[0].addForceToForceRegistry(rod);
            rigidbodyArray[1].addForceToForceRegistry(rod);
        } else {
            throw new IllegalArgumentException("RigidbodyArray is 0");
        }
        
        rod.setIsJoint(this.isJoint);

    } else if(InteractionCache.getActiveForceSelectedID() == 2) {

        Motor motor = new Motor(rigidbodyArray[0], this.motorTargetAngularVelocity);

        motor.setDrawMotor(this.motorDrawMotor);
        motor.setDrawMotorForce(this.motorDrawMotorForce);
        
        Iterator<ForceRegistry> iterator = rigidbodyArray[0].getForceRegistry().iterator();

        while (iterator.hasNext()) {
            ForceRegistry force = iterator.next();
            if (force instanceof Motor) {
                iterator.remove();
                ALL_FORCES_ARRAYLIST.remove(force);
            }
        }

        ALL_FORCES_ARRAYLIST.add(motor);
        rigidbodyArray[0].addForceToForceRegistry(motor);
    }
    
}
*/
    



/*
====================================================================================================
======================================= Getters & Setters ==========================================
====================================================================================================
*/
/*

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

public void setStrokeWeight(float strokeWeight) {
  this.strokeWeight = strokeWeight;
}

public void setStrokeColor(PVector strokeColor) {
  this.strokeColor = strokeColor;
}

public void setFillColor(PVector fillColor) {
  this.fillColor = fillColor;
}

public void setRedFillColour(int fillRed) {
    this.fillColor.set(fillRed, this.fillColor.y, this.fillColor.z);
}

public void setGreenFillColour(int fillGreen) {
    this.fillColor.set(this.fillColor.x, fillGreen, this.fillColor.z);
}

public void setBlueFillColour(int fillGreen) {
    this.fillColor.set(this.fillColor.x, fillGreen, this.fillColor.z);
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

public void setCollidability(boolean isCollidable) {
  this.isCollidable = isCollidable;
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

public void setRodIsJoint(boolean isJoint) {
    this.isJoint = isJoint;
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

public boolean getCollidability() {
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

public boolean getRodIsJoint(){
    return this.isJoint;
}

public ArrayList<Rigidbody> getSelectedRigidbodiesArrayList(){
    return this.selectedRigidbodies;
}

public int getOpacity() {
    return this.opacity;
}

public boolean getSnapGeneral(){
    return this.snapGeneral;
}

public void setSnapGeneral(boolean snapGeneral) {
    this.snapGeneral = snapGeneral;

}

}
*/





