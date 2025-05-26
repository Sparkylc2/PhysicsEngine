public class ComplexGravity implements ForceRegistry {

    private Rigidbody rigidbody;



    public ComplexGravity(Rigidbody rigidbody) {
        this.rigidbody = rigidbody;
    }


    @Override
    public PVector getForce(Rigidbody rigidbody, PVector position) {
        PVector force = new PVector(0, 0);
        for(Rigidbody otherRigidbody : rigidbodyList) {
            force.add(PVector.mult(PVector.sub(otherRigidbody.getPosition(), position), otherRigidbody.getMass()));
        }
        return force;
    }

    @Override
    public void draw() {
        //Do nothing
    }
    
    @Override
    public PVector getApplicationPoint(Rigidbody rigidbody, PVector position) {
        return position;
    }

    @Override
    public Rigidbody getRigidbodyA() {
        return this.rigidbody;
    }

    @Override
    public Rigidbody getRigidbodyB() {
        return this.rigidbody;
    }
}

