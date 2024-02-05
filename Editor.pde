public class Editor {


	private Rigidbody rigidbody;
 	

 	private boolean inEditMode = false;
	private int count = 0;

	public Editor () {
	}


	public void onEditorSelect (Rigidbody rigidbody) {
		if(rigidbody.getShapeType() == ShapeType.CIRCLE) {
			return;
		}
		this.rigidbody = rigidbody;
		this.inEditMode = true;
	}


	//ID -1 corresponds to drawing the vertices in the main draw loop
	//ID 0 corresponds to a click
	//ID 1 corresponds to a drag
	//ID 2 corresponds to a delete press

	public void whileEditorSelect(int id) {
		if(inEditMode) {
			if(id == -1) {
				//int index = this.selectVertex(VERTEX_SNAP_RADIUS);
				//this.drawVertices(index);
				this.drawVertices();
				return;
			} else if(id == 0){
				this.addVertexClick();
			} else if(id == 1) {
				int index = this.selectVertex(VERTEX_SNAP_RADIUS);
				if(index != -1) {
					this.moveVertex(index);
				}
			} else if(id == 2) {
				int index = this.selectVertex(VERTEX_SNAP_RADIUS);
				if(index != -1) {
					this.deleteVertex(index);
				}
			}
		}
	}


	public int selectVertex(float radius) {
		PVector[] rigidbodyVertices = rigidbody.GetTransformedVertices();

		for(int i = 0; i < rigidbodyVertices.length; i++) {
			if(PVector.sub(PVector.add(rigidbody.getPosition(), PhysEngMath.SnapController(interactivityListener, rigidbody, interactivityListener.screenToWorld())), rigidbodyVertices[i]).magSq() < radius) {
				//System.out.println(i);
				return i;
			}
		}
		return -1;
	}

	public void addVertexClick() {
		PVector vertex = PhysEngMath.ReverseTransform(interactivityListener.screenToWorld(), this.rigidbody.getPosition().copy().mult(-1), -this.rigidbody.getAngle());
		PVector[] rigidbodyVertices = this.rigidbody.getVertices();
		PVector[] newRigidbodyVertices = new PVector[rigidbodyVertices.length + 1];

		for(int i = 0; i < rigidbodyVertices.length; i++) {
			newRigidbodyVertices[i] = rigidbodyVertices[i];
		}

		newRigidbodyVertices[newRigidbodyVertices.length - 1] = vertex;

		this.rigidbody.updatePolygon(newRigidbodyVertices);
	} 

	public void deleteVertex(int index) {
		ArrayList<PVector> vertexList = new ArrayList<PVector>(Arrays.asList(this.rigidbody.getVertices()));
		vertexList.remove(index);
		this.rigidbody.updatePolygon(vertexList.toArray(new PVector[vertexList.size()]));
	}


	public void drawVertices() {
		PVector[] currentVertices = this.rigidbody.GetTransformedVertices();
		for(PVector vertex : currentVertices) {
			pushMatrix();
			translate(vertex.x, vertex.y);

			fill(0, 255, 0);
			noStroke();
			ellipse(0, 0, 0.25, 0.25);
			popMatrix();

		}
	}

	public void moveVertex(int index) {
		PVector vertex = interactivityListener.screenToWorld();
		PVector[] rigidbodyCoreVertices = this.rigidbody.getVertices();

		PVector[] vertexList = Arrays.copyOf(rigidbodyCoreVertices, rigidbodyCoreVertices.length);

		vertexList[index] = PhysEngMath.ReverseTransform(vertex, this.rigidbody.getPosition().copy().mult(-1), -this.rigidbody.getAngle());

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

	public boolean getInEditMode() {
		return this.inEditMode;
	}

	public Rigidbody getSelectedRigidbody() {
		return this.rigidbody;
	}
}