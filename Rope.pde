
public class Rope {
    
    private ArrayList<Rigidbody> ropeBodies;

    private Rigidbody rigidbodyA;
    private Rigidbody rigidbodyB;

    private PVector localAnchorA;
    private PVector localAnchorB;
    private PVector anchor;

    private float density = 1;

    private float damping;
    private float ropeMass;
    private float ropeLength;

    private PVector initialPosition;
    private PVector endPosition;

    private float stiffness;
    private float precision;

    private float type;


    public Rope(PVector initialPosition, float stiffness, float ropeLength, float damping, float precision, float ropeMass) {
        
        this.initialPosition = initialPosition;

        this.stiffness = stiffness;
        this.damping = damping;

        this.ropeLength = ropeLength;
        this.precision = precision;

        this.ropeMass = ropeMass;

        this.type = 1;

        GenerateRope();
    }

    public Rope(PVector initialPosition, PVector endPosition, float stiffness, float ropeLength, float damping, float precision, float ropeMass) {
        this.initialPosition = initialPosition;
        this.endPosition = endPosition;

        this.ropeLength = PVector.sub(initialPosition, endPosition).mag();

        this.stiffness = stiffness;
        this.damping = damping;

        this.ropeLength = ropeLength;
        this.precision = precision;

        this.ropeMass = ropeMass;

        this.type = 2;

        GenerateRope();
    }

    public Rope(Rigidbody rigidbodyA, PVector localAnchorA, PVector anchor, float stiffness, float ropeLength, float damping, float precision, float ropeMass) {
        
        this.rigidbodyA = rigidbodyA;

        this.ropeLength = PVector.sub(rigidbodyA.getPosition(), anchor).mag();

        this.localAnchorA = localAnchorA;
        this.anchor = anchor;

        this.stiffness = stiffness;
        this.damping = damping;

        this.ropeLength = ropeLength;
        this.precision = precision;

        this.ropeMass = ropeMass;

        this.type = 3;

        GenerateRope();
    }

    public Rope(Rigidbody rigidbodyA, Rigidbody rigidbodyB, PVector localAnchorA, PVector localAnchorB, float stiffness, float damping, float precision, float ropeMass) {
        
        this.rigidbodyA = rigidbodyA;
        this.rigidbodyB = rigidbodyB;

        this.ropeLength = PVector.sub(rigidbodyA.getPosition(), rigidbodyB.getPosition()).mag();

        this.localAnchorA = localAnchorA;
        this.localAnchorB = localAnchorB;

        this.stiffness = stiffness;
        this.damping = damping;

        this.ropeLength = ropeLength;
        this.precision = precision;

        this.ropeMass = ropeMass;

        this.type = 4;

        GenerateRope();
    }

    private void GenerateRope() {

        float radius = 1; //ropeLength / precision * 0.25f;
        density = 1;//ropeMass / (precision * (float)Math.PI * radius * radius);

        float spacing = ropeLength / precision;
        float damping = 1.5f;

        float springLength = spacing - 2*radius;
        float equilibriumLength = spacing - 2*radius;

        if(type == 4) {
            precision--;
        }

        for(int i = 0; i < precision; i++) {

            //A NULL POINTER EXCEPTION IS THROWN HERE
            Rigidbody body = RigidbodyGenerator.CreateCircleBody(1, 0, 1, false, true, 0.05f,
                                                            new PVector(0, 0, 0), new PVector(255, 255, 255));
            body.SetInitialPosition(new PVector(initialPosition.x, initialPosition.y  + (i + 1) * spacing));
            body.setIsVisible(true);
            ropeBodies.add(body);

        }

        for(int i = 0; i < precision; i++) {
            if(i != 0) {
                
                float springConstant = stiffness*(precision - i);

                Rigidbody previousBody = ropeBodies.get(i - 1);
                Rigidbody currentBody = ropeBodies.get(i);

                Spring previousBodySpring = new Spring(previousBody, currentBody, new PVector(0, radius), new PVector(0, -radius));
                Spring currentBodySpring = new Spring(currentBody, previousBody, new PVector(0, -radius), new PVector(0, radius));

                previousBodySpring.setSpringLength(springLength);
                currentBodySpring.setSpringLength(springLength);

                previousBodySpring.setSpringConstant(springConstant);
                currentBodySpring.setSpringConstant(springConstant);

                previousBodySpring.setDamping(damping);
                currentBodySpring.setDamping(damping);

                previousBodySpring.setEquilibriumLength(equilibriumLength);
                currentBodySpring.setEquilibriumLength(equilibriumLength);

                previousBody.addForceToForceRegistry(previousBodySpring);
                currentBody.addForceToForceRegistry(currentBodySpring);

                previousBody.addForceToForceRegistry(new Gravity(previousBody));
                currentBody.addForceToForceRegistry(new Gravity(currentBody));

                AddBodyToBodyEntityList(previousBody);
                AddBodyToBodyEntityList(currentBody);
            }

        if(type == 1) {

            Rigidbody rigidbody = ropeBodies.get(0);
            Spring initialSpring = new Spring(rigidbody, new PVector(0, -radius), new PVector(initialPosition.x, initialPosition.y));

            initialSpring.setSpringLength(springLength);
            initialSpring.setSpringConstant(stiffness);

            initialSpring.setDamping(damping);
            initialSpring.setEquilibriumLength(equilibriumLength);

            rigidbody.addForceToForceRegistry(initialSpring);

        } else if(type == 2) {

            Rigidbody rigidbody = ropeBodies.get(0);
            Spring initialSpring = new Spring(rigidbody, new PVector(0, -radius), new PVector(initialPosition.x, initialPosition.y));

            initialSpring.setSpringLength(springLength);
            initialSpring.setSpringConstant(stiffness);

            initialSpring.setDamping(damping);
            initialSpring.setEquilibriumLength(equilibriumLength);

            rigidbody.addForceToForceRegistry(initialSpring);

            Rigidbody rigidbody2 = ropeBodies.get(ropeBodies.size() - 1);
            Spring endSpring = new Spring(rigidbody2, new PVector(0, radius), new PVector(endPosition.x, endPosition.y));

            endSpring.setSpringLength(springLength);
            endSpring.setSpringConstant(stiffness);

            endSpring.setDamping(damping);
            endSpring.setEquilibriumLength(equilibriumLength);

            rigidbody2.addForceToForceRegistry(endSpring);
        } else if(type == 3) {

            Rigidbody rigidbody = ropeBodies.get(0);
            Spring initialSpring = new Spring(rigidbody, new PVector(0, -radius), new PVector(anchor.x, anchor.y));

            initialSpring.setSpringLength(springLength);
            initialSpring.setSpringConstant(stiffness);

            initialSpring.setDamping(damping);
            initialSpring.setEquilibriumLength(equilibriumLength);

            rigidbody.addForceToForceRegistry(initialSpring);

            Rigidbody rigidbody2 = ropeBodies.get(ropeBodies.size() - 1);
            Spring endSpringRigidbody2 = new Spring(rigidbody2, this.rigidbodyA, new PVector(0, radius), new PVector(localAnchorA.x, localAnchorA.y));
            Spring endSpringRigidbodyA = new Spring(this.rigidbodyA, rigidbody2, new PVector(localAnchorA.x, localAnchorA.y), new PVector(0, radius));

            endSpringRigidbody2.setSpringLength(springLength);
            endSpringRigidbody2.setSpringConstant(stiffness);

            endSpringRigidbody2.setDamping(damping);
            endSpringRigidbody2.setEquilibriumLength(equilibriumLength);

            endSpringRigidbodyA.setSpringLength(springLength);
            endSpringRigidbodyA.setSpringConstant(stiffness);

            endSpringRigidbodyA.setDamping(damping);
            endSpringRigidbodyA.setEquilibriumLength(equilibriumLength);

            rigidbody2.addForceToForceRegistry(endSpringRigidbody2);
            this.rigidbodyA.addForceToForceRegistry(endSpringRigidbodyA);

            } else if(type == 4) {
                    
                    Rigidbody rigidbody = ropeBodies.get(0);
                    Spring initialSpring = new Spring(rigidbody, this.rigidbodyA, new PVector(0, -radius), new PVector(localAnchorA.x, localAnchorA.y));
                    Spring initialSpringRigidbodyA = new Spring(this.rigidbodyA, rigidbody, new PVector(localAnchorA.x, localAnchorA.y), new PVector(0, -radius));
    
                    initialSpring.setSpringLength(springLength);
                    initialSpring.setSpringConstant(stiffness);
    
                    initialSpring.setDamping(damping);
                    initialSpring.setEquilibriumLength(equilibriumLength);
    
                    initialSpringRigidbodyA.setSpringLength(springLength);
                    initialSpringRigidbodyA.setSpringConstant(stiffness);
    
                    initialSpringRigidbodyA.setDamping(damping);
                    initialSpringRigidbodyA.setEquilibriumLength(equilibriumLength);
    
                    rigidbody.addForceToForceRegistry(initialSpring);
                    this.rigidbodyA.addForceToForceRegistry(initialSpringRigidbodyA);
    
                    Rigidbody rigidbody2 = ropeBodies.get(ropeBodies.size() - 1);
                    Spring endSpringRigidbody2 = new Spring(rigidbody2, this.rigidbodyB, new PVector(0, radius), new PVector(localAnchorB.x, localAnchorB.y));
                    Spring endSpringRigidbodyB = new Spring(this.rigidbodyB, rigidbody2, new PVector(localAnchorB.x, localAnchorB.y), new PVector(0, radius));
    
                    endSpringRigidbody2.setSpringLength(springLength);
                    endSpringRigidbody2.setSpringConstant(stiffness);
    
                    endSpringRigidbody2.setDamping(damping);
                    endSpringRigidbody2.setEquilibriumLength(equilibriumLength);
    
                    endSpringRigidbodyB.setSpringLength(springLength);
                    endSpringRigidbodyB.setSpringConstant(stiffness);
    
                    endSpringRigidbodyB.setDamping(damping);
                    endSpringRigidbodyB.setEquilibriumLength(equilibriumLength);
    
                    rigidbody2.addForceToForceRegistry(endSpringRigidbody2);
                    this.rigidbodyB.addForceToForceRegistry(endSpringRigidbodyB);
        }
    }
}


}
