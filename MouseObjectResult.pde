public class MouseObjectResult {
	private Rigidbody SelectedRigidbody;
	private PVector SelectedRigidbodyPosition;
	private PVector Coordinate;


	public MouseObjectResult(Rigidbody selectedRigidbody, PVector coordinate) {

		this.SelectedRigidbody = selectedRigidbody;

		if(this.SelectedRigidbody != null) {
			this.SelectedRigidbodyPosition = selectedRigidbody.getPosition();
		}

		this.Coordinate = coordinate;
	}


	public Rigidbody getSelectedRigidbody() {
		return this.SelectedRigidbody;
	}

	public PVector getWorldCoordinate() {
		return this.Coordinate;
	}

	public PVector getLocalCoordinate() {
		return PVector.sub(this.Coordinate, this.SelectedRigidbodyPosition);
	}

	public String toString() {
		return "MouseObjectResult: " + SelectedRigidbody + ", " + Coordinate;
	}


}