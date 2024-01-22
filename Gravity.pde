public class Gravity implements ForceRegistry {
  private final Rigidbody rigidbody;

  public Gravity(Rigidbody rigidbody) {
    this.rigidbody = rigidbody;
  }

  @Override
  public PVector getForce(Rigidbody rigidbody, PVector position) {
    return PVector.mult(GRAVITY_VECTOR, rigidbody.getMass());
  }

  @Override
  public void draw() {
    // Do nothing
  }

    @Override
    public PVector getApplicationPoint(Rigidbody rigidbody, PVector position, float angle) {
      return position.copy();
    
    }

}
