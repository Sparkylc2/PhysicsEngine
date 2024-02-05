/*
public class MouseObject {

	private ArrayList<MouseObjectResult> interactionResults = new ArrayList<MouseObjectResult>();

	private PVector mouseCoordinates = new PVector();
	private Rigidbody currentMouseOverRigidbody;


	private boolean isMouseOverUI = false;
  	private boolean showCursorTrail = true;
  	private ArrayList<PVector> cursorTrailArrayList = new ArrayList<PVector>();


	public MouseObject() {
		//Do nothing
		
	}


	public boolean IsMouseOverUI() {
  		if(GUI_GROUP_POSITION_X < mouseX && mouseX < GUI_GROUP_POSITION_X + GUI_GLOBAL_GROUP_WIDTH &&  GUI_GROUP_POSITION_Y < mouseY && mouseY <  GUI_GROUP_POSITION_Y + GUI_GLOBAL_GROUP_HEIGHT) {
    		return true;
    	} else {
    		return false;
    	}
	}

	public Rigidbody getRigidbodyUnderMouse() {
    	for (Rigidbody rigidbody : rigidbodyList) {
       		if(this.tempBody == rigidbody) {
           		continue;
       		}
       		if(!Collisions.IntersectAABBWithPoint(rigidbody.GetAABB(), mousePosition)){
           		continue;
       		}
			if (rigidbody.contains(this.mouseCoordinates.x, this.mouseCoordinates.y)) {
           		return rigidbody;
       		}
    	}
    	return null;
	}	

	public void addSelectedRigidbody() {

		if(this.interactionResults.size() > 2) {
			this.interactionResults.clear();
		}

		//Maybe instead of this.mouseCoordinates, call this.updateMouseCoordinates and then this.mouseCoordinates;
		this.interactionResults.add(new MouseObjectResult(this.getRigidbodyUnderMouse(), this.mouseCoordinates);
	}

	public void updateMouseCoordinates() {
		this.isMouseOverUI = this.IsMouseOverUI();

		if(!this.isMouseOverUI) {
			this.currentMouseOverRigidbody = this.getRigidbodyUnderMouse();
		} else {
			this.currentMouseOverRigidbody = null;
		}

		mouseCoordinates.set(PhysEngMath.WorldSnapController(interactivityListener, this.getRigidbodyUnderMouse(), interactivityListener.screenToWorld()));
	}





public void drawMouseOverRigidbody() {

    fill(255, 0, 0);
    strokeWeight(0.1f);
    stroke(255, 0, 0);
    ellipse(this.mouseCoordinates.x, this.mouseCoordinates.y, 0.1f, 0.1f);


    if(this.showCursorTrail) {
    	if(cursorTrailArrayList.size() < 20) {
    		cursorTrailArrayList.add(new PVector(mouseCoordinates.x, mouseCoordinates.y));
    	} else {
    		cursorTrailArrayList.set(cursorTrailArrayList.size()-1, cursorTrailArrayList.get(0).set).
    		cursorTrailArrayList.remove(0);
    		newCoordinate.set(this.mouseCoordinates.x, this.mouseCoordinates.y);
    		cursorTrailArrayList.add(newCoordinate);
    	}
    	PVector newCoordinate = cursorTrailArrayList.get(0);

        cursorTrailArrayList.add(new PVector(coordinate.x, coordinate.y));
        if (trail.size() > 20) {
            trail.remove(0);
        }
    
        noFill();
        stroke(255, 0, 0);
        strokeWeight(0.1f);
        beginShape();

        for (int i = 0; i < trail.size(); i++) {
            if (i == 0 || i == trail.size() - 1) {
                // The first and last points are control points and are not part of the actual curve
                curveVertex(trail.get(i).x, trail.get(i).y);
            } else {
                curveVertex(trail.get(i).x, trail.get(i).y);
            }
        }
        endShape();
    
        // Draw the current mouse position
        fill(255, 0, 0);
        ellipse(coordinate.x, coordinate.y, 0.1f, 0.1f);
    }
}






public void updateSelectedRigidbodies() {
    if(this.selectedRigidbodies.size() == 2) {

        //For one body selected
        if(this.selectedRigidbodies.get(0) != null && this.selectedRigidbodies.get(1) == null) {

            this.selectedRigidbody = this.selectedRigidbodies.get(0);

            this.selectedRigidbody1 = null;
            this.selectedRigidbody2 = null;
            this.tempBody = null;

            this.oneRigidbodySelected = true;
            this.twoRigidbodiesSelected = false;

        } else if(this.selectedRigidbodies.get(0) == null && this.selectedRigidbodies.get(1) != null){
            
            this.selectedRigidbody = this.selectedRigidbodies.get(1);

            this.selectedRigidbody1 = null;
            this.selectedRigidbody2 = null;
            this.tempBody = null;

            this.oneRigidbodySelected = true;
            this.twoRigidbodiesSelected = false;
        
        }else if(this.selectedRigidbodies.get(0) != null && this.selectedRigidbodies.get(1) != null) {

            this.selectedRigidbody1 = this.selectedRigidbodies.get(0);
            this.selectedRigidbody2 = this.selectedRigidbodies.get(1);

            this.selectedRigidbody = null;
            this.tempBody = null;

            this.oneRigidbodySelected = false;
            this.twoRigidbodiesSelected = true;

        } else if(this.selectedRigidbodies.get(0) == null && this.selectedRigidbodies.get(1) == null) {

            this.selectedRigidbody = null;
            this.selectedRigidbody1 = null;
            this.selectedRigidbody2 = null;
            this.tempBody = null;

            this.oneRigidbodySelected = false;
            this.twoRigidbodiesSelected = false;
        }
        this.selectedRigidbodies.clear();

    } else if(this.selectedRigidbodies.size() == 1) {
            
            if(this.selectedRigidbodies.get(0) != null) {
    
                this.tempBody = this.selectedRigidbodies.get(0);

                this.selectedRigidbody = null;
                this.selectedRigidbody1 = null;
                this.selectedRigidbody2 = null;
    
                this.oneRigidbodySelected = true;
                this.twoRigidbodiesSelected = false;
    
            } else if(this.selectedRigidbodies.get(0) == null) {
                
                this.tempBody = null;
                this.selectedRigidbody = null;
                this.selectedRigidbody1 = null;
                this.selectedRigidbody2 = null;
    
                this.oneRigidbodySelected = false;
                this.twoRigidbodiesSelected = false;
            }
    }
}


public void firstMouseClickInformation() {
    Rigidbody clickedBody = getClickedRigidbody();
    PVector mousePos = screenToWorld();

    if(clickedBody != null) {        
        this.localAnchorA = PhysEngMath.Transform(PhysEngMath.SnapController(this, clickedBody, mousePos), -clickedBody.getAngle());
        this.anchorPoint = mousePos;
        this.isFirstClickOnRigidbody = true;
    } else {
        this.anchorPoint = mousePos;
        this.isFirstClickOnRigidbody = false;
    }
}














	public PVector getMouseCoordinates() {
		return mouseCoordinates;
	}

	public boolean getIsMouseOverUI() {
		return isMouseOverUI;
	}
}
*/