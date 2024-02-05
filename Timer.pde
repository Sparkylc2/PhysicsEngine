public class Timer {
	private Rigidbody rigidbody;
	private PVector startPosition;

	public Timer(Rigidbody rigidbody) {
		this.rigidbody = rigidbody;
		startPosition = rigidbody.getPosition();
	}

	public void reset() {
		rigidbody.setPosition(startPosition);
	}
}