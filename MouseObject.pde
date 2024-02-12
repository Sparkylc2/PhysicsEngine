
public class MouseObject {

	private ArrayList<MouseObjectResult> interactionResults = new ArrayList<MouseObjectResult>();

	private PVector mouseCoordinates = new PVector();
    private PVector previousMouseCoordinates = new PVector();


    private boolean mLeft, mRight, mCenter;
    private boolean isMouseDown = false;
    private PVector mouseDownCoordinates = new PVector();
    private boolean isMouseUp = false;
    private PVector mouseUpCoordinates = new PVector();

	private Rigidbody currentRigidbodyUnderMouse;


	private boolean isMouseOverUI = false;
  	private boolean showCursorTrail = true;
  	private ArrayList<PVector> cursorTrailArrayList = new ArrayList<PVector>();


	public MouseObject() {
        //do nothing
	}


    public void updateMouse() {
        this.updateMouseCoordinates();
        this.currentRigidbodyUnderMouse = this.getRigidbodyUnderMouse();
        this.isMouseOverUI = this.IsMouseOverUI();
    }

    public void updateMouseClick() {
    }

	public boolean IsMouseOverUI() {
  		if(GUI_GROUP_POSITION_X < mouseX && mouseX < GUI_GROUP_POSITION_X + GUI_GLOBAL_GROUP_WIDTH &&  GUI_GROUP_POSITION_Y < mouseY && mouseY <  GUI_GROUP_POSITION_Y + GUI_GLOBAL_GROUP_HEIGHT) {
    		return true;
    	} else {
    		return false;
    	}
	}


	public Rigidbody getRigidbodyUnderMouse() {
        PVector mouseCoordinates = Camera.screenToWorld();
    	for (Rigidbody rigidbody : rigidbodyList) {
            if(!Collisions.IntersectAABBWithPoint(rigidbody.GetAABB(), mouseCoordinates)) {
           		continue;
            }
            if (rigidbody.contains(mouseCoordinates.x, mouseCoordinates.y)) {
           		return rigidbody;
            }
    	}
    	return null;
	}	


	public void addSelectedRigidbody() {
		if(this.interactionResults.size() > 2) {
            this.interactionResults.clear();
		}
		this.interactionResults.add(new MouseObjectResult(this.currentRigidbodyUnderMouse, this.mouseCoordinates));
        if(this.interactionResults.size() == 2) {
            if(this.interactionResults.get(0).getSelectedRigidbody() == null && this.interactionResults.get(1).getSelectedRigidbody() == null) {
                this.interactionResults.clear();
            }
        }

	}

	public void updateMouseCoordinates() {
        this.previousMouseCoordinates.set(this.mouseCoordinates);
		this.mouseCoordinates.set(PhysEngMath.WorldSnapController(this.currentRigidbodyUnderMouse, Camera.screenToWorld()));
	}

    public void updateMouseDownCoordinates() {
        this.isMouseDown = true;
        this.isMouseUp = false;
        this.mouseDownCoordinates.set(PhysEngMath.WorldSnapController(this.currentRigidbodyUnderMouse, Camera.screenToWorld()));
    }

    public void updateMouseUpCoordinates() {
        this.isMouseUp = true;
        this.isMouseDown = false;
        this.addSelectedRigidbody();
        this.mouseUpCoordinates.set(PhysEngMath.WorldSnapController(this.currentRigidbodyUnderMouse, Camera.screenToWorld()));
    }





    public void DrawMouseCursor() {
        fill(255, 0, 0);
        strokeWeight(0.1f);
        stroke(255, 0, 0);
        ellipse(this.mouseCoordinates.x, this.mouseCoordinates.y, 0.1f, 0.1f);

        if(this.showCursorTrail) {
        	if(cursorTrailArrayList.size() < 20) {
        		cursorTrailArrayList.add(new PVector(mouseCoordinates.x, mouseCoordinates.y));
        	} else {
                cursorTrailArrayList.add(cursorTrailArrayList.get(0).set(this.mouseCoordinates.x, this.mouseCoordinates.y));
                cursorTrailArrayList.remove(0);
        	}

            noFill();
            beginShape();
                for(PVector cursorTrailVertex : cursorTrailArrayList) {
                    curveVertex(cursorTrailVertex.x, cursorTrailVertex.y);
                }
            endShape();
        }
    }


    public void setMouseCoordinates(PVector mouseCoordinates) {
        this.mouseCoordinates.set(mouseCoordinates);
    }

	public PVector getMouseCoordinates() {
		return this.mouseCoordinates;
	}

    public PVector getPreviousMouseCoordinates() {
        return this.previousMouseCoordinates;
    }
    
    public boolean getIsMouseDown() {
        return this.isMouseDown;
    }

    public PVector getMouseDownCoordinates() {
        return this.mouseDownCoordinates;
    }

    public boolean getIsMouseUp() {
        return this.isMouseUp;
    }
    public PVector getMouseUpCoordinates() {
        return this.mouseUpCoordinates;
    }

	public boolean getIsMouseOverUI() {
		return this.isMouseOverUI;
	}

    public Rigidbody getCurrentRigidbodyUnderMouse() {
        return this.currentRigidbodyUnderMouse;
    }

    public ArrayList<MouseObjectResult> getMouseObjectResults() {
        return this.interactionResults;
    }
}
