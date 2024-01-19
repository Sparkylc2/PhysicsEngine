public interface ForceRegistry {
    public PVector getForce(Rigidbody rigidbody, PVector position, float dt);
    public void draw();
    public PVector getApplicationPoint(Rigidbody rigidbody, PVector position);
}