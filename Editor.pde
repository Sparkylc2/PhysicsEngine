public class Editor {


	private Rigidbody rigidbody;
 	

 	private boolean inEditMode = false;
	private int count = 0;

	public Editor () {
	}


	public void onEditorSelect (Rigidbody rigidbody) {
		this.rigidbody = rigidbody;
		this.inEditMode = true;
	}


	//ID -1 corresponds to drawing the vertices in the main draw loop
	//ID 0 corresponds to a click
	//ID 1 corresponds to a drag

	public void whileEditorSelect(int id) {
		if(inEditMode) {
			if(id == -1) {
				this.drawVertices();
				return;
			} else if(id == 0){
				this.addVertexClick();
			} else if(id == 1) {

				int index = this.selectVertexDrag();

				if(index != -1) {
					this.moveVertex(index);
				}
			}
		}
	}


	public int selectVertexDrag() {
		PVector[] rigidbodyVertices = rigidbody.GetTransformedVertices();

		for(int i = 0; i < rigidbodyVertices.length; i++) {
			if(PVector.sub(interactivityListener.screenToWorld(), rigidbodyVertices[i]).magSq() < 0.125f) {
				return i;
			}
		}

		return -1;

	}

	public void addVertexClick() {
		PVector vertex = PhysEngMath.Transform(interactivityListener.screenToWorld(), this.rigidbody.getPosition().copy().mult(-1), -this.rigidbody.getAngle());
		System.out.println("Adding A vertex");
		PVector[] rigidbodyVertices = this.rigidbody.getVertices();
		PVector[] newRigidbodyVertices = new PVector[rigidbodyVertices.length + 1];

		for(int i = 0; i < rigidbodyVertices.length; i++) {
			newRigidbodyVertices[i] = rigidbodyVertices[i];
		}

		newRigidbodyVertices[newRigidbodyVertices.length - 1] = vertex;

		this.rigidbody.updatePolygon(newRigidbodyVertices);
	} 


	public void drawVertices() {
		PVector[] currentVertices = this.rigidbody.GetTransformedVertices();

		for(PVector vertex : currentVertices) {
			/*
			if(vertex == null) {
				fill(0, 255, 0);
				noStroke();
				ellipse(0, 0, 0.75, 0.75);
			*/

			fill(255, 0, 0);
			noStroke();
			ellipse(vertex.x, vertex.y, 0.25, 0.25);
		}
	}

	public void moveVertex(int index) {
		PVector vertex = interactivityListener.screenToWorld();
		PVector[] rigidbodyCoreVertices = this.rigidbody.getVertices();

		PVector[] vertexList = Arrays.copyOf(rigidbodyCoreVertices, rigidbodyCoreVertices.length);

		vertexList[index] = PhysEngMath.Transform(vertex, this.rigidbody.getPosition().copy().mult(-1), -this.rigidbody.getAngle());
		//vertexList[index] = PhysEngMath.Transform(vertex, this.rigidbody.getPosition().copy().mult(-1), 0f);

		this.rigidbody.updatePolygon(vertexList);
	}

	public void onEditorDeselect() {
		this.rigidbody = null;
		this.inEditMode = false;
	}

	public void onClick() {

	}

	public void onDrag() {

	}

	public void onSelection() {

	}


	public void onRelease(){

	}
}