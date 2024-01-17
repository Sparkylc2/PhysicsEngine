public class Gravity implements ForceRegistry {
  private final Rigidbody rigidbody;

  public Gravity(Rigidbody rigidbody) {
    this.rigidbody = rigidbody;
  }

  @Override
  public PVector getForce(Rigidbody rigidbody, PVector position) {

    if(this.rigidbody != rigidbody) {
      throw new IllegalArgumentException("Rigidbody is not the same as the one this force is applied to");
    }

    return PVector.mult(GRAVITY_VECTOR, rigidbody.getMass());
  }

  @Override
  public void draw() {
    // do nothing
  }

@Override
 public PVector getApplicationPoint(Rigidbody rigidbody, PVector position) {
    
    if(this.rigidbody != rigidbody) {
      throw new IllegalArgumentException("Rigidbody is not the same as the one this force is applied to");
    }
    return position.copy();
 }

}