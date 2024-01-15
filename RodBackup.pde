/*
public class Rod implements ForceRegistry {

    private float length;
    private float stiffness = 2f;
    private float damping = 100f;

    private PVector localAnchorA;
    private PVector localAnchorB;
    private PVector anchorPoint;
    
    private float initialAngleDifference;
    private float initialRod;
    private float initialRigidbodyAngle;

    private boolean isHingeable;
    private boolean isTwoBodyRod;

    private Rigidbody rigidbodyA;
    private Rigidbody rigidbodyB;

    public Rod(Rigidbody rigidbodyA, PVector localAnchorA, PVector anchorPoint) {

        this.rigidbodyA = rigidbodyA;

        this.anchorPoint = anchorPoint;
        this.localAnchorA = localAnchorA;

        this.isTwoBodyRod = false;


    }

    public Rod(Rigidbody rigidbodyA, Rigidbody rigidbodyB, PVector localAnchorA, PVector localAnchorB) {

        this.rigidbodyA = rigidbodyA;
        this.rigidbodyB = rigidbodyB;

        this.localAnchorA = localAnchorA;
        this.localAnchorB = localAnchorB;
        
        this.isTwoBodyRod = true;


        //Logic for hinging
        PVector direction = PVector.sub(PhysEngMath.Transform(localAnchorB, rigidbodyB.getPosition(), rigidbodyB.getAngle()), PhysEngMath.Transform(localAnchorA, rigidbodyA.getPosition(), rigidbodyA.getAngle()));
        float initialRigidbodyAngle = rigidbodyA.getAngle();
        float initialRodAngle = PApplet.atan2(direction.y, direction.x);

        this.initialAngleDifference = initialRodAngle - initialRigidbodyAngle;
        this.initialAngleDifference = (this.initialAngleDifference + PI) % TWO_PI - PI;
        this.length = direction.mag();
    }


    @Override
public PVector getForce(Rigidbody rigidbody, PVector position) {
    if(this.rigidbodyA != rigidbody) {
      throw new IllegalArgumentException("Rigidbody is not the same as the one this force is applied to");
    }

    PVector direction;
    PVector force = new PVector(0, 0);
    PVector worldAnchorA;
    PVector worldAnchorB;

    if(isTwoBodyRod) {
        worldAnchorA = PhysEngMath.Transform(localAnchorA, position, rigidbodyA.getAngle());
        worldAnchorB = PhysEngMath.Transform(localAnchorB, rigidbodyB.getPosition(), rigidbodyB.getAngle());
        direction = PVector.sub(worldAnchorB, worldAnchorA);
    } else {
        worldAnchorA = PhysEngMath.Transform(localAnchorA, position, rigidbodyA.getAngle());
        worldAnchorB = anchorPoint;
        direction = PVector.sub(worldAnchorB, worldAnchorA);
    }


//TODO FIX THIS
  if(!this.isHingeable) {
    float currentRodAngle = PApplet.atan2(direction.y, direction.x);
    rigidbodyA.setAngle(currentRodAngle + initialAngleDifference);
}


    float currentLength = direction.mag();
    float lengthDifference = length - currentLength;
    direction.normalize();

    force = PVector.mult(direction, -lengthDifference * stiffness * 1000);

    if(isTwoBodyRod){

    /*-------------------DAMPING-------------------*/
    /*
    PVector relativeVelocity = PVector.sub(rigidbodyB.getVelocity(), rigidbodyA.getVelocity());
    float rodVelocity = PVector.dot(relativeVelocity, direction);
    float dampingForceMagnitude = rodVelocity * damping;
    PVector dampingForce = PVector.mult(direction, dampingForceMagnitude);
    force.add(dampingForce);
    */
    /*----------------------------------------------*/
/*
    }



    return force;
}

@Override
public void draw() {

    if(isTwoBodyRod){

        PVector worldAnchorA = PhysEngMath.Transform(localAnchorA, rigidbodyA.getPosition(), rigidbodyA.getAngle());
        PVector worldAnchorB = PhysEngMath.Transform(localAnchorB, rigidbodyB.getPosition(), rigidbodyB.getAngle());

        strokeWeight(0.15);
        stroke(0);
        line(worldAnchorA.x, worldAnchorA.y, worldAnchorB.x, worldAnchorB.y);
        strokeWeight(0.1);
        stroke(255);
        line(worldAnchorA.x, worldAnchorA.y, worldAnchorB.x, worldAnchorB.y);
    } else {

        PVector worldAnchorA = getApplicationPoint(rigidbodyA, rigidbodyA.getPosition());
        PVector worldAnchorB = anchorPoint;
        strokeWeight(0.15);
        stroke(0);
        line(worldAnchorA.x, worldAnchorA.y, worldAnchorB.x, worldAnchorB.y);
        strokeWeight(0.1);
        stroke(255);
        line(worldAnchorA.x, worldAnchorA.y, worldAnchorB.x, worldAnchorB.y);

    }
}


@Override
public PVector getApplicationPoint(Rigidbody rigidbody, PVector position) {
    if(this.rigidbodyA != rigidbody) {
      throw new IllegalArgumentException("Rigidbody is not the same as the one this force is applied to");
    }

    PVector transformedAnchor = PhysEngMath.Transform(localAnchorA, position, rigidbodyA.getAngle());
    return transformedAnchor;
    }
*/
/*
====================================================================================================
===================================GETTERS AND SETTERS==============================================
====================================================================================================
*/
/*
public void setLength(float length) {
    this.length = length;
  }
public void setIsHingeable(boolean isHingeable) {
    this.isHingeable = isHingeable;
  }


public void setAnchorPoint(PVector anchorPoint) {
    this.anchorPoint = anchorPoint;
  }

public void setLocalAnchorA(PVector localAnchorA) {
    this.localAnchorA = localAnchorA;
  }

public void setLocalAnchorB(PVector localAnchorB) {
    this.localAnchorB = localAnchorB;
  }

public void setStiffness(float stiffness) {
    this.stiffness = stiffness;
  }

public void setDamping(float damping) {
    this.damping = damping;
  }

public void setTwoBodyRod(boolean isTwoBodyRod) {
    this.isTwoBodyRod = isTwoBodyRod;
  }


public float getLength() {
    return length;
  }

public boolean getIsHingeable() {
    return isHingeable;
  }

public PVector getAnchorPoint() {
    return anchorPoint;
  }

public PVector getLocalAnchorA() {
    return localAnchorA;
  }

public PVector getLocalAnchorB() {
    return localAnchorB;
  }

public float getStiffness() {
    return stiffness;
  }

public float getDamping() {
    return damping;
  }

public boolean getTwoBodyRod() {
    return isTwoBodyRod;
  }

public Rigidbody getRigidbodyA() {
    return rigidbodyA;
  }

public Rigidbody getRigidbodyB() {
    return rigidbodyB;
  }

}

  
*/