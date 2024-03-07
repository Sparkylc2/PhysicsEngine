public class Spring implements ForceRegistry {

    private Rigidbody rigidbodyA;
    private Rigidbody rigidbodyB;

    private PVector anchorPoint = new PVector();
    private PVector localAnchorA = new PVector();
    private PVector localAnchorB = new PVector();
    
    private boolean drawSpring = true;

    //Some default values
    private boolean lockTranslationToXAxis = false;
    private boolean lockTranslationToYAxis = false;
    
    private boolean isPerfectSpring = false;

    private float equilibriumLength = 1f; //Equilibrium length is a percentage of the total magnitude of the length
    private float springConstant = 50;
    private float damping = 0.5f;
    
    private float springLength;

    private boolean isTwoBodySpring;


    /*--------------- Reusable --------------- */
    private PVector worldAnchorA = new PVector();
    private PVector worldAnchorB = new PVector();

    private PVector velocityA = new PVector();
    private PVector velocityB = new PVector();

    private PVector direction = new PVector();


    public Spring () {
        this.rigidbodyA = null;
        this.rigidbodyB = null;
    }


    public Spring(Rigidbody rigidbody, PVector localAnchorA, PVector anchorPoint) {

        this.rigidbodyA = rigidbody;
        this.localAnchorA.set(localAnchorA);
        this.anchorPoint.set(anchorPoint);

        this.springLength = PhysEngMath.Transform(localAnchorA, rigidbodyA.getPosition(), rigidbodyA.getAngle()).sub(anchorPoint).mag();

        this.isTwoBodySpring = false;

    }

    public Spring(Rigidbody rigidbodyA, Rigidbody rigidbodyB, PVector localAnchorA, PVector localAnchorB) {
        
        this.rigidbodyA = rigidbodyA;
        this.rigidbodyB = rigidbodyB;
        
        this.localAnchorA.set(localAnchorA);
        this.localAnchorB.set(localAnchorB);
        
        this.springLength = PhysEngMath.Transform(localAnchorB, rigidbodyB.getPosition(), rigidbodyB.getAngle()).sub(PhysEngMath.Transform(localAnchorA, rigidbodyA.getPosition(), rigidbodyA.getAngle())).mag();

        this.isTwoBodySpring = true;

    }

    @Override
    public PVector getForce(Rigidbody rigidbody, PVector position) {
        float totalForceMagnitude = 0f;
        float displacement = 0f;

        if(isTwoBodySpring) {
            velocityA.set(rigidbodyA.getVelocity());
            velocityB.set(rigidbodyB.getVelocity());
    
            if(rigidbody == rigidbodyA) {
                worldAnchorA.set(PhysEngMath.Transform(this.localAnchorA, position, rigidbodyA.getAngle()));
                worldAnchorB.set(PhysEngMath.Transform(this.localAnchorB, rigidbodyB.getPosition(), rigidbodyB.getAngle()));

                if(lockTranslationToYAxis) rigidbodyA.setVelocity(velocityA.set(0, velocityA.y));
                else if(lockTranslationToXAxis) rigidbodyA.setVelocity(velocityA.set(velocityA.x, 0));

                this.direction.set(worldAnchorB.sub(worldAnchorA));
                displacement = direction.mag();


                if(!isPerfectSpring){                                                                                    
                    totalForceMagnitude = (displacement - this.springLength * this.equilibriumLength) * this.springConstant;
                    direction.normalize();
                    totalForceMagnitude += (direction.dot(velocityB.sub(velocityA)) * this.damping);
                } else {
                    totalForceMagnitude = (displacement - this.springLength * this.equilibriumLength) * this.springConstant;
                }
                return this.direction.mult(totalForceMagnitude);
    
            } else {
                worldAnchorA.set(PhysEngMath.Transform(this.localAnchorA, rigidbodyA.getPosition(), rigidbodyA.getAngle()));
                worldAnchorB.set(PhysEngMath.Transform(this.localAnchorB, position, rigidbodyB.getAngle()));
            
                this.direction.set(worldAnchorB.sub(worldAnchorA));
                displacement = direction.mag();
                direction.normalize();

                if(lockTranslationToYAxis) rigidbodyB.setVelocity(velocityB.set(0, velocityB.y));
                else if(lockTranslationToXAxis) rigidbodyB.setVelocity(velocityB.set(velocityB.x, 0));

                if(!isPerfectSpring){                                                                                    
                    totalForceMagnitude = (displacement - this.springLength * this.equilibriumLength) * this.springConstant;
                    totalForceMagnitude += (direction.dot(velocityB.sub(velocityA)) * this.damping);
                } else {
                    totalForceMagnitude = (displacement - this.springLength * this.equilibriumLength) * this.springConstant;
                }

                return this.direction.mult(-totalForceMagnitude);
            }
        } else {
            worldAnchorA.set(PhysEngMath.Transform(this.localAnchorA, position, rigidbodyA.getAngle()));
            worldAnchorB.set(anchorPoint);
    
            velocityA.set(rigidbodyA.getVelocity());
            velocityB.set(0,0);

            this.direction.set(worldAnchorB.sub(worldAnchorA));
            displacement = direction.mag();
            direction.normalize();

            if(lockTranslationToYAxis) rigidbodyA.setVelocity(velocityA.set(0, velocityA.y));
            else if(lockTranslationToXAxis) rigidbodyA.setVelocity(velocityA.set(velocityA.x, 0));
            
            if(!isPerfectSpring){                                                                                    
                totalForceMagnitude = (displacement - this.springLength * this.equilibriumLength) * this.springConstant;
                direction.normalize();
                totalForceMagnitude += (direction.dot(velocityB.sub(velocityA)) * this.damping);
            } else {
                totalForceMagnitude = (displacement- this.springLength * this.equilibriumLength) * this.springConstant;
            }

            return this.direction.mult(totalForceMagnitude);
        }
    
} 

  

//TODO: IMPLEMENT A WAY TO MAKE THE SPRING SCALE WITH ITS LENGTH, SO THAT VISUALLY A LARGE SPRING
//WILL HAVE THICKER LINES, AND MORE OFFSET, ETC
   /*
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
                worldAnchorB = this.anchorPoint;
            }

            direction = PVector.sub(worldAnchorA, worldAnchorB);
            length = direction.mag();
            direction.normalize();

            fill(255);

            float segments = 5;
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
            
            PVector segmentStart = new PVector();
            PVector segmentEnd = new PVector();
            PVector midPoint = new PVector();
            PVector midPoint1 = new PVector();
            PVector midPoint2 = new PVector();
            PVector directionSegmentLength = PVector.mult(direction, segmentLength);
            PVector offset1 = new PVector();
            PVector offset2 = new PVector();

            for(int i = 0; i < segments; i++) {

                segmentStart.set(PVector.add(worldAnchorB, PVector.mult(directionSegmentLength, i)));
                segmentEnd.set(PVector.add(worldAnchorB, PVector.mult(directionSegmentLength, i + 1)));

                // Calculate the midpoint of the segment
                midPoint.set(PVector.lerp(segmentStart, segmentEnd, 0.5f));

                if(i % 2 == 0) {
                    offset1.set(new PVector(-direction.y, direction.x).mult(offsetMagnitude));
                    offset2.set(new PVector(direction.y, -direction.x).mult(offsetMagnitude));
                } else {
                    offset1.set(new PVector(direction.y, -direction.x).mult(offsetMagnitude));
                    offset2.set(new PVector(-direction.y, direction.x).mult(offsetMagnitude));
                }

                // Add the offsets to the midpoint
                midPoint1.set(PVector.add(midPoint, offset1));
                midPoint2.set(PVector.add(midPoint, offset2));

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
        } else {
            return;
        }
    }
    */
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
            worldAnchorB = this.anchorPoint;
        }

        direction = PVector.sub(worldAnchorA, worldAnchorB);
        length = direction.mag();
        direction.normalize();

        fill(255);

        float segments = 5;
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
        
        PVector segmentStart = new PVector();
        PVector segmentEnd = new PVector();
        PVector midPoint = new PVector();
        PVector offset = new PVector();
        PVector directionSegmentLength = PVector.mult(direction, segmentLength);

        for(int i = 0; i < segments; i++) {

            segmentStart.set(PVector.add(worldAnchorB, PVector.mult(directionSegmentLength, i)));
            segmentEnd.set(PVector.add(worldAnchorB, PVector.mult(directionSegmentLength, i + 1)));

            // Calculate the midpoint of the segment
            midPoint.set(PVector.lerp(segmentStart, segmentEnd, 0.5f));

            // Alternate the offset direction to give appearance of spring
            if(i % 2 == 0) {
                offset.set(new PVector(-direction.y, direction.x).mult(offsetMagnitude));
            } else {
                offset.set(new PVector(direction.y, -direction.x).mult(offsetMagnitude));
            }

            // Add the offset to the midpoint
            PVector midPointOffset = PVector.add(midPoint, offset);

            // Draw the lines
            strokeWeight(0.2);
            stroke(0);
            line(segmentStart.x, segmentStart.y, midPointOffset.x, midPointOffset.y);
            line(midPointOffset.x, midPointOffset.y, segmentEnd.x, segmentEnd.y);
            strokeWeight(0.1);
            stroke(255);
            line(segmentStart.x, segmentStart.y, midPointOffset.x, midPointOffset.y);
            line(midPointOffset.x, midPointOffset.y, segmentEnd.x, segmentEnd.y);
        }
    } else {
        return;
    }
}
    

    @Override
    public PVector getApplicationPoint(Rigidbody rigidbody, PVector position) {
            if(rigidbody == rigidbodyA) {
                return PhysEngMath.Transform(localAnchorA, position, rigidbodyA.getAngle());
            } else {
                return PhysEngMath.Transform(localAnchorB, position, rigidbodyB.getAngle());
            }
    }

/*
====================================================================================================
================================== Getters & Setters ===============================================
====================================================================================================
*/
    public void setRigidbodyA(Rigidbody rigidbody){
        this.rigidbodyA = rigidbody;
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
    public void setDrawSpring(boolean drawSpring) {
        this.drawSpring = drawSpring;
    }
    public void setAnchorPoint(PVector anchorPoint) {
        this.anchorPoint.set(anchorPoint);
    }

    public void setAnchorPoint(float x, float y) {
        this.anchorPoint.set(x, y);
    }

    public void setLocalAnchorA(PVector localAnchorA) {
        this.localAnchorA.set(localAnchorA);
    }

    public void setLocalAnchorA(float x, float y) {
        this.localAnchorA.set(x, y);
    }

    public void setLocalAnchorB(PVector localAnchorB) {
        this.localAnchorB.set(localAnchorB);
    }

    public void setLocalAnchorB(float x, float y) {
        this.localAnchorB.set(x, y);
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

    public boolean getDrawSpring() {
        return this.drawSpring;
    }
    @Override
    public Rigidbody getRigidbodyA() {
        return this.rigidbodyA;
    }
    @Override
    public Rigidbody getRigidbodyB() {
        if(isTwoBodySpring) {
            return this.rigidbodyB;
        }
        return this.rigidbodyA;
    }

    public boolean getIsTwoBodySpring() {
        return this.isTwoBodySpring;
    }
}


