public class Rod implements ForceRegistry {
/*-------------------------------------------------------------------------------------------------*/
    private float length;
    private float stiffness = 1000000.0f;
    private float damping = 1f;

    private float angleStiffness = 1000000.0f;
    private float angleDamping = 0f;


    private PVector localAnchorA = new PVector();
    private PVector localAnchorB = new PVector();
    private PVector anchorPoint = new PVector();

    private float initialAngleA = 0f;
    private float initialAngleB = 0f;

    private boolean isHingeable;
    private boolean isTwoBodyRod;

    private Rigidbody rigidbodyA;
    private Rigidbody rigidbodyB;


/*-------------------------------------------------------------------------------------------------*/
    private PVector worldAnchorA = new PVector();
    private PVector worldAnchorB = new PVector();

    private PVector relativeVelocity = new PVector();

    private PVector velocityA = new PVector();
    private PVector velocityB = new PVector();

    private PVector dampingForce = new PVector();
    private PVector direction = new PVector();
    private PVector rodForce = new PVector();
    private PVector force = new PVector();
    public float netTorque = 0f;
    private PVector rigidbodyOrientation = new PVector();

/*-------------------------------------------------------------------------------------------------*/
//Reusable stuff


    public Rod(Rigidbody rigidbodyA, PVector localAnchorA, PVector anchorPoint) {

        this.rigidbodyA = rigidbodyA;

        this.anchorPoint.set(anchorPoint);
        this.localAnchorA.set(localAnchorA);

        this.initialAngleA = rigidbodyA.getAngle();

        this.isTwoBodyRod = false;

        this.length = PhysEngMath.Transform(localAnchorA, rigidbodyA.getPosition(), rigidbodyA.getAngle()).sub(anchorPoint).mag();


    }

    public Rod(Rigidbody rigidbodyA, Rigidbody rigidbodyB, PVector localAnchorA, PVector localAnchorB) {

        this.rigidbodyA = rigidbodyA;
        this.rigidbodyB = rigidbodyB;

        this.initialAngleA = rigidbodyA.getAngle();
        this.initialAngleB = rigidbodyB.getAngle();

        this.localAnchorA.set(localAnchorA);
        this.localAnchorB.set(localAnchorB);

        this.isTwoBodyRod = true;
        this.length = PhysEngMath.Transform(localAnchorB, rigidbodyB.getPosition(), rigidbodyB.getAngle()).sub(PhysEngMath.Transform(localAnchorA, rigidbodyA.getPosition(), rigidbodyA.getAngle())).mag();

    }


@Override
public PVector getForce(Rigidbody rigidbody, PVector position) {

    float displacement;
    float currentAngleA;
    float currentAngleB;
    float dot;
    float currentRigidbodyAngle;
    this.netTorque = 0f;
    this.force.set(0,0,0);

    if(isTwoBodyRod) {
        if(rigidbody == rigidbodyA) {
                this.worldAnchorA.set(PhysEngMath.Transform(this.localAnchorA, position, this.rigidbodyA.getAngle()));
                this.worldAnchorB.set(PhysEngMath.Transform(this.localAnchorB, this.rigidbodyB.getPosition(), this.rigidbodyB.getAngle()));

                this.velocityA.set(rigidbodyA.getVelocity());
                this.velocityB.set(rigidbodyB.getVelocity());

                this.direction.set(this.worldAnchorB.sub(this.worldAnchorA));

                displacement = direction.mag();
                this.direction.normalize();

                this.relativeVelocity.set(PVector.sub(this.velocityA, this.velocityB));

                dot = PVector.dot(relativeVelocity, this.direction);

                if(dot > 0.8f) {
                    this.rigidbodyA.setVelocity(this.dampingForce.set(0,0)); 
                } else {
                    this.dampingForce.set(this.direction.copy().mult(-damping * dot));
                }

                /*
                if(!this.isHingeable) {
                    float rigidbodyAngle = rigidbodyA.getAngle();
                    this.rigidbodyOrientation.set(cos(rigidbodyAngle), sin(rigidbodyAngle));

                    float angleBetween = PVector.angleBetween(this.direction, this.rigidbodyOrientation);

                    if (direction.copy().cross(rigidbodyOrientation).z < 0) {
                        angleBetween = -angleBetween;
                    }

                    float angleDifference = angleBetween - this.initialAngleA;
                    //this.netTorque = -angleStiffness * angleDifference - angleDamping * rigidbody.getAngularVelocity();
                    //rigidbodyA.setAngle(rigidbodyA.getAngle()-angleDifference);
                    //force.add(0, 0, correctiveTorque);
                }
                */

                this.force.add(this.direction.mult(this.stiffness * (displacement - this.length)));
                this.force.add(this.dampingForce);
                
                return this.force;

            } else {
                this.worldAnchorA.set(PhysEngMath.Transform(this.localAnchorA, this.rigidbodyA.getPosition(), this.rigidbodyA.getAngle()));
                this.worldAnchorB.set(PhysEngMath.Transform(this.localAnchorB, position, this.rigidbodyB.getAngle()));

                this.velocityA.set(rigidbodyA.getVelocity());
                this.velocityB.set(rigidbodyB.getVelocity());


                this.direction.set(this.worldAnchorB.sub(this.worldAnchorA));
                displacement = direction.mag();
                this.direction.normalize();


                this.relativeVelocity.set(PVector.add(this.velocityA, this.velocityB));
                dot = PVector.dot(relativeVelocity, this.direction);

                if(dot > 0.8f) {
                    this.rigidbodyA.setVelocity(this.dampingForce.set(0,0));
                } else {
                    this.dampingForce.set(this.direction.copy().mult(-damping * dot));
                }
                /*
                if(!this.isHingeable) {
                    float rigidbodyAngle = rigidbodyB.getAngle();
                    this.rigidbodyOrientation.set(cos(rigidbodyAngle), sin(rigidbodyAngle));

                    float angleBetween = PVector.angleBetween(this.direction, this.rigidbodyOrientation);

                    if (this.direction.copy().cross(this.rigidbodyOrientation).z < 0) {
                        angleBetween = -angleBetween;
                    }

                    float angleDifference = angleBetween - this.initialAngleB;
                    //this.netTorque = -angleStiffness * angleDifference - angleDamping * rigidbody.getAngularVelocity();
                    //rigidbodyB.setAngle(rigidbodyB.getAngle()-angleDifference);
                    //force.add(0, 0, correctiveTorque);
                }
                */

                this.force.add(this.dampingForce);
                this.force.add(this.direction.mult(this.stiffness * (displacement - this.length)));
                
                return this.force.mult(-1);

            } 

    } else {

        this.worldAnchorA.set(PhysEngMath.Transform(this.localAnchorA, position, this.rigidbodyA.getAngle()));
        this.worldAnchorB.set(this.anchorPoint);

        this.velocityA.set(rigidbodyA.getVelocity());
        this.velocityB.set(0,0);    

        this.direction.set(this.worldAnchorB.sub(this.worldAnchorA));
        displacement = direction.mag();
        this.direction.normalize();

        this.relativeVelocity.set(this.velocityB.sub(this.velocityA));
        dot = PVector.dot(relativeVelocity, this.direction);

        if(dot > 0.8f) {
            rigidbodyA.setVelocity(velocityA.sub(this.direction.copy().mult(dot)));
        }

        /*
        if(!this.isHingeable) {
            float rigidbodyAngle = rigidbodyA.getAngle();
            this.rigidbodyOrientation.set(cos(rigidbodyAngle), sin(rigidbodyAngle));

            float angleBetween = PVector.angleBetween(this.direction, this.rigidbodyOrientation);

            if (this.direction.copy().cross(this.rigidbodyOrientation).z < 0) {
                angleBetween = -angleBetween;
            }

            float angleDifference = angleBetween - this.initialAngleA;
            //this.netTorque = -angleStiffness * angleDifference - angleDamping * rigidbody.getAngularVelocity();
            //r
            //rigidbodyB.setAngle(rigidbodyB.getAngle()-angleDifference);
            //force.add(0, 0, correctiveTorque);
        }
        */

        this.dampingForce.set(this.direction.copy().mult(-damping * PVector.dot(relativeVelocity, this.direction)));

        this.force.add(this.direction.mult(this.stiffness * (displacement - this.length)));
        this.force.add(this.dampingForce);
        
        return this.force;
                
    }
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

        PVector worldAnchorA = getApplicationPoint(rigidbodyA, rigidbodyA.getPosition(), rigidbodyA.getAngle());
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
public PVector getApplicationPoint(Rigidbody rigidbody, PVector position, float angle) {
        if(rigidbody == rigidbodyA) {
            return PhysEngMath.Transform(localAnchorA, position, angle);
        } else {
            return PhysEngMath.Transform(localAnchorB, position, angle);
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
public float getNetTorque() {
    return this.netTorque;
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

  
