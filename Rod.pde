public class Rod implements ForceRegistry {
/*-------------------------------------------------------------------------------------------------*/
    private float length;
    private float stiffness = 1f;
    private float damping = 150f;

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

    private PVector force;
    private int callCounter = 0;
/*-------------------------------------------------------------------------------------------------*/
    public Rod(Rigidbody rigidbodyA, PVector localAnchorA, PVector anchorPoint) {

        this.rigidbodyA = rigidbodyA;

        this.anchorPoint = anchorPoint;
        this.localAnchorA = localAnchorA;

        this.isTwoBodyRod = false;

        PVector direction =  PVector.sub(anchorPoint, PhysEngMath.Transform(localAnchorA, rigidbodyA.getPosition(), rigidbodyA.getAngle()));
        this.length = direction.mag();


    }

    public Rod(Rigidbody rigidbodyA, Rigidbody rigidbodyB, PVector localAnchorA, PVector localAnchorB) {

        this.rigidbodyA = rigidbodyA;
        this.rigidbodyB = rigidbodyB;

        this.localAnchorA = localAnchorA;
        this.localAnchorB = localAnchorB;

        this.isTwoBodyRod = true;

        PVector direction = PVector.sub(PhysEngMath.Transform(localAnchorB, rigidbodyB.getPosition(), rigidbodyB.getAngle()), PhysEngMath.Transform(localAnchorA, rigidbodyA.getPosition(), rigidbodyA.getAngle()));
        this.length = direction.mag();

    }


@Override
public PVector getForce(Rigidbody rigidbody, PVector position) {
        if(isTwoBodyRod) {
            if(rigidbody == rigidbodyA) {
                return calculateForce(rigidbody, position);
            } else if(rigidbody == rigidbodyB) {
                return calculateForce(rigidbody, position).mult(-1);
            } else {
                throw new IllegalArgumentException("Rigidbody is not the same as the one this force is applied to");
            }
        } else {
            return calculateForce(rigidbody, position);
        }
}

private PVector calculateForce(Rigidbody rigidbody, PVector position) {

    // Calculate current distance between the anchor points
    PVector worldAnchorA;
    PVector worldAnchorB;

    if(isTwoBodyRod) {
        if(rigidbody == rigidbodyA) {
            worldAnchorA = PhysEngMath.Transform(localAnchorA, position, rigidbodyA.getAngle());
            worldAnchorB = PhysEngMath.Transform(localAnchorB, rigidbodyB.getPosition(), rigidbodyB.getAngle());
            
        } else if(rigidbody == rigidbodyB) {
            worldAnchorA = PhysEngMath.Transform(localAnchorA, rigidbodyA.getPosition(), rigidbodyA.getAngle());
            worldAnchorB = PhysEngMath.Transform(localAnchorB, position, rigidbodyB.getAngle());
        } else {
            throw new IllegalArgumentException("Rigidbody is not the same as the one this force is applied to");
        }
    } else {
        worldAnchorA = PhysEngMath.Transform(localAnchorA, position, rigidbodyA.getAngle());
        worldAnchorB = anchorPoint;
    }

    PVector displacement = PVector.sub(worldAnchorB, worldAnchorA);
    float currentLength = displacement.mag();

    float stretch = currentLength - this.length;
    
    PVector normalizedDisplacement = displacement.normalize();

    // High stiffness factor to simulate rigidity
    float stiffness = 1000000.0f; // Adjust this value as needed

    // Relative velocity in the direction of the rod
    PVector relativeVelocity = isTwoBodyRod ? PVector.sub(rigidbodyB.getVelocity(), rigidbodyA.getVelocity()) : rigidbodyA.getVelocity();

    float velocityAlongRod = PVector.dot(relativeVelocity, normalizedDisplacement);
    float dampingFactor = 5f;
    // Apply only the component of the velocity along the rod for damping
    PVector dampingForce = PVector.mult(normalizedDisplacement, velocityAlongRod * -dampingFactor);

    // Calculate force
    PVector force = PVector.mult(normalizedDisplacement, stiffness * stretch);
    force.add(dampingForce);

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
    if(rigidbody == this.rigidbodyA || rigidbody == this.rigidbodyB) {
        if(rigidbody == rigidbodyA) {
            return PhysEngMath.Transform(localAnchorA, position, rigidbodyA.getAngle());
        } else {
            return PhysEngMath.Transform(localAnchorB, position, rigidbodyB.getAngle());
        }
    } else{
        throw new IllegalArgumentException("Rigidbody is not the same as the one this force is applied to");
    }
}


/*
====================================================================================================
===================================GETTERS AND SETTERS==============================================
====================================================================================================
*/
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

  
