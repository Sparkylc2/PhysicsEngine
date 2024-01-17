public class Spring implements ForceRegistry {

  private Rigidbody rigidbodyA;
  private Rigidbody rigidbodyB;
  
  private PVector anchorPoint;
  private PVector localAnchorA;
  private PVector localAnchorB;


/*------------------- Reusable Stuff -------------------*/
  private PVector worldAnchorA;
  private PVector worldAnchorB;
  private PVector direction;
  private float directionMag;

  public boolean drawSpring = true;

    //Some default values
  private boolean lockTranslationToXAxis = false;
  private boolean lockTranslationToYAxis = false;
  
  private boolean isPerfectSpring = false;
  private boolean isHingeable = true;

  private float equilibriumLength = 1f; //Equilibrium length is a percentage of the total magnitude of the length
  private float springConstant = 50;
  private float damping = 0.5f;
  
  private float springLength;

  private boolean isTwoBodySpring;



  //TODO: IMPLEMENT THIS
  private float initialRotationA;
  private float initialRotationB;

  private PVector force;
  private int callCounter = 0;

public Spring(Rigidbody rigidbody, PVector localAnchorA, PVector anchorPoint) {

    this.rigidbodyA = rigidbody;

    this.localAnchorA = localAnchorA;
    this.anchorPoint = anchorPoint;

    this.springLength = PhysEngMath.Transform(localAnchorA, rigidbodyA.getPosition(), rigidbodyA.getAngle()).sub(anchorPoint).mag();

    this.isTwoBodySpring = false;
    this.isHingeable = true;

}

 public Spring(Rigidbody rigidbodyA, Rigidbody rigidbodyB, PVector localAnchorA, PVector localAnchorB) {

    this.rigidbodyA = rigidbodyA;
    this.rigidbodyB = rigidbodyB;

    this.localAnchorA = localAnchorA;
    this.localAnchorB = localAnchorB;

    this.springLength = PhysEngMath.Transform(localAnchorB, rigidbodyB.getPosition(), rigidbodyB.getAngle()).sub(PhysEngMath.Transform(localAnchorA, rigidbodyA.getPosition(), rigidbodyA.getAngle())).mag();

    this.isTwoBodySpring = true;
    this.isHingeable = true;

 }

    @Override
    public PVector getForce(Rigidbody rigidbody, PVector position) {
        if(isTwoBodySpring) {
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

        PVector force = new PVector();
        float totalForceMagnitude = 0f;

        PVector worldAnchorA;
        PVector worldAnchorB;
        float displacement;


        if(isTwoBodySpring) {
            if(rigidbody == rigidbodyA) {
                worldAnchorA = PhysEngMath.Transform(this.localAnchorA, position, rigidbodyA.getAngle());
                worldAnchorB = PhysEngMath.Transform(this.localAnchorB, rigidbodyB.getPosition(), rigidbodyB.getAngle());

                if(lockTranslationToYAxis) {
                    this.rigidbodyA.setVelocity(new PVector(0, this.rigidbodyA.getVelocity().y));
                } else if(lockTranslationToXAxis) {
                    this.rigidbodyA.setVelocity(new PVector(this.rigidbodyA.getVelocity().x, 0));
                }
            } else {
                worldAnchorA = PhysEngMath.Transform(this.localAnchorA, rigidbodyA.getPosition(), rigidbodyA.getAngle());
                worldAnchorB = PhysEngMath.Transform(this.localAnchorB, position, rigidbodyB.getAngle());

                if(lockTranslationToYAxis) {
                    this.rigidbodyB.setVelocity(new PVector(0, this.rigidbodyB.getVelocity().y));
                } else if(lockTranslationToXAxis) {
                    this.rigidbodyB.setVelocity(new PVector(this.rigidbodyB.getVelocity().x, 0));
                }
            }
        } else {
            worldAnchorA = PhysEngMath.Transform(this.localAnchorA, position, rigidbodyA.getAngle());
            worldAnchorB = this.anchorPoint;

            if(lockTranslationToYAxis) {
                rigidbodyA.setVelocity(new PVector(this.rigidbodyA.getVelocity().x, 0));
            } else if(lockTranslationToXAxis) {
                rigidbodyA.setVelocity(new PVector(0, this.rigidbodyA.getVelocity().y));
            }
        }


        direction = PVector.sub(worldAnchorB, worldAnchorA);
        displacement = direction.mag();
        direction.normalize();

        //Spring Force
        totalForceMagnitude += (displacement - this.springLength * this.equilibriumLength) * this.springConstant;
        if(!isPerfectSpring) {
            if(isTwoBodySpring) {
                /*------------------- Damping -------------------*/
                totalForceMagnitude += direction.dot(PVector.sub(rigidbodyB.getVelocity(), rigidbodyA.getVelocity())) * this.damping;
                /*-----------------------------------------------*/
            } else {
                /*------------------- Damping -------------------*/
                totalForceMagnitude += direction.dot(PVector.sub(new PVector(), rigidbodyA.getVelocity())) * this.damping;
                /*-----------------------------------------------*/
            }
        }

        force = PVector.mult(direction, totalForceMagnitude);
        return force;
    }

  

//TODO: IMPLEMENT A WAY TO MAKE THE SPRING SCALE WITH ITS LENGTH, SO THAT VISUALLY A LARGE SPRING
//WILL HAVE THICKER LINES, AND MORE OFFSET, ETC
    @Override
    public void draw() {
        if(this.drawSpring) {
            PVector worldAnchorA;
            PVector worldAnchorB;
            PVector direction;
            float length;



  if(isTwoBodySpring) {
    worldAnchorA = PhysEngMath.Transform(localAnchorA, rigidbodyA.getPosition(), rigidbodyA.getAngle());
    worldAnchorB = PhysEngMath.Transform(localAnchorB, rigidbodyB.getPosition(), rigidbodyB.getAngle());
  } else {

    worldAnchorA = PhysEngMath.Transform(localAnchorA, rigidbodyA.getPosition(), rigidbodyA.getAngle());
    worldAnchorB = anchorPoint;
  }

            direction = PVector.sub(worldAnchorA, worldAnchorB);
            length = direction.mag();
            direction.normalize();

            fill(255);

            float segments = 10;
            float segmentLength = length / segments;

            // Set the offset to a constant value
            float offsetMagnitude = 0.5; // Adjust this value to change the size of the zigzags

            // Draw the rod
            strokeWeight(0.3);
            stroke(0); // Black
            line(worldAnchorA.x, worldAnchorA.y, worldAnchorB.x, worldAnchorB.y);
            stroke(255); // White
            strokeWeight(0.1);
            line(worldAnchorA.x, worldAnchorA.y, worldAnchorB.x, worldAnchorB.y);

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
                strokeWeight(0.2);
                stroke(0);
                line(segmentStart.x, segmentStart.y, midPoint1.x, midPoint1.y);
                line(midPoint1.x, midPoint1.y, segmentEnd.x, segmentEnd.y);
                line(segmentStart.x, segmentStart.y, midPoint2.x, midPoint2.y);
                line(midPoint2.x, midPoint2.y, segmentEnd.x, segmentEnd.y);
                strokeWeight(0.1);
                stroke(255);
                line(segmentStart.x, segmentStart.y, midPoint1.x, midPoint1.y);
                line(midPoint1.x, midPoint1.y, segmentEnd.x, segmentEnd.y);
                line(segmentStart.x, segmentStart.y, midPoint2.x, midPoint2.y);
                line(midPoint2.x, midPoint2.y, segmentEnd.x, segmentEnd.y);
            }
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
================================== Getters & Setters ===============================================
====================================================================================================
*/

public void setIsHingeable(boolean isHingeable) {
    this.isHingeable = isHingeable;
}

public void setSpringConstant(float springConstant) {
    this.springConstant = springConstant;
 }

public void setSpringLength(float springLength) {
    this.springLength = springLength;
}
public void setEquilibriumLength(float equilibriumLength) {
    this.equilibriumLength = equilibriumLength;
}
public void setDamping(float damping) {
    this.damping = damping;
}

public void setLockTranslationToXAxis(boolean lockTranslationToXAxis) {
    this.lockTranslationToXAxis = lockTranslationToXAxis;
}

public void setLockTranslationToYAxis(boolean lockTranslationToYAxis) {
    this.lockTranslationToYAxis = lockTranslationToYAxis;
}

public void setPerfectSpring(boolean isPerfectSpring) {
    this.isPerfectSpring = isPerfectSpring;
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
public void setInitialRotationA(float initialRotationA) {
    this.initialRotationA = initialRotationA;
}
public void setInitialRotationB(float initialRotationB) {
    this.initialRotationB = initialRotationB;
}

public boolean getIsHingeable() {
    return this.isHingeable;
}

public float getSpringConstant() {
    return this.springConstant;
}

public float getSpringLength() {
    return this.springLength;
}

public float getEquilibriumLength() {
    return this.equilibriumLength;
}

public float getDamping() {
    return this.damping;
}

public boolean getLockTranslationToXAxis() {
    return this.lockTranslationToXAxis;
}

public boolean getLockTranslationToYAxis() {
    return this.lockTranslationToYAxis;
}

public boolean getPerfectSpring() {
    return this.isPerfectSpring;
}

public PVector getAnchorPoint() {
    return this.anchorPoint;
}

public PVector getLocalAnchorA() {
    return this.localAnchorA;
}

public PVector getLocalAnchorB() {
    return this.localAnchorB;
}

public float getInitialRotationA() {
    return this.initialRotationA;
}

public float getInitialRotationB() {
    return this.initialRotationB;
}

public Rigidbody getRigidbodyA() {
    return this.rigidbodyA;
}

public Rigidbody getRigidbodyB() {
    return this.rigidbodyB;
}

public boolean getIsTwoBodySpring() {
    return this.isTwoBodySpring;
}

}


