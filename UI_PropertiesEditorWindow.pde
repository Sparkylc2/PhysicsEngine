public class UI_PropertiesEditorWindow extends UI_Window {



    private Rigidbody rigidbodyToEdit = null;

    private ArrayList<Rigidbody> selectedRigidbodies = new ArrayList<Rigidbody>();



    public boolean inEditMode = false;

    private boolean inDragSelectMode = false;
    private boolean isSelectionBeingDragged = false;
    private AABB dragBox = null;
    private PVector initialDragPosition = new PVector();

    private int vertexIndexToDrag = -1;
    private boolean circleVertexToDrag = false;


    public UI_PropertiesEditorWindow() {
        super("Properties Editor (rigidbody)", 2);
        this.initialize();
    }

/*
========================================= UI Elements  =============================================
*/
    public void initialize() {

    }


    public void onEditorActive() {
        if(this.rigidbodyToEdit == null) {
            throw new IllegalArgumentException("Rigidbody to edit is null");
        }

        IS_PAUSED = true;
        IS_PAUSED_LOCK = true;

        this.clearAllElements();
        this.Window_Visibility = true;
        this.onWindowSelect();

        if(this.rigidbodyToEdit.getShapeType() == ShapeType.CIRCLE) {
            this.initializeCircleEditor();
        } else if(this.rigidbodyToEdit.getShapeType() == ShapeType.BOX || this.rigidbodyToEdit.getShapeType() == ShapeType.POLYGON){
            this.initializeRectanglePolyEditor();
        }
    }

    public void initializeCircleEditor() {
        this.clearAllElements();
        this.addElement(new UI_Slider("Density", (UI_Window)this, MIN_BODY_DENSITY, MAX_BODY_DENSITY, this.rigidbodyToEdit.getDensity()));
        this.addElement(new UI_Slider("Restitution", (UI_Window)this, 0, 1, this.rigidbodyToEdit.getRestitution()));
        this.addElement(new UI_Slider("Radius", (UI_Window)this, 0.5f, 10, this.rigidbodyToEdit.getRadius()));
        this.addElement(new UI_Toggle("Static", (UI_Window)this, "Staticity", this.rigidbodyToEdit.getIsStatic()));
        this.addElement(new UI_Toggle("Fixed Rotation", (UI_Window)this, "Staticity", this.rigidbodyToEdit.getIsRotationallyStatic()));
        this.addElement(new UI_Toggle("Fixed Position", (UI_Window)this, "Staticity", this.rigidbodyToEdit.getIsTranslationallyStatic()));
        this.addElement(new UI_Slider("Angle", (UI_Window)this, -360, 360, this.rigidbodyToEdit.getAngle()));
    }

    public void initializeRectanglePolyEditor() {
        this.clearAllElements();
        this.addElement(new UI_Slider("Density", (UI_Window)this, MIN_BODY_DENSITY, MAX_BODY_DENSITY, this.rigidbodyToEdit.getDensity()));
        this.addElement(new UI_Slider("Restitution", (UI_Window)this, 0, 1, this.rigidbodyToEdit.getRestitution()));
        this.addElement(new UI_Toggle("Static", (UI_Window)this, "Staticity", this.rigidbodyToEdit.getIsStatic()));
        this.addElement(new UI_Toggle("Fixed Rotation", (UI_Window)this, "Staticity", this.rigidbodyToEdit.getIsRotationallyStatic()));
        this.addElement(new UI_Toggle("Fixed Position", (UI_Window)this, "Staticity", this.rigidbodyToEdit.getIsTranslationallyStatic()));
        this.addElement(new UI_Slider("Angle", (UI_Window)this, -360, 360, this.rigidbodyToEdit.getAngle()));
    }



/*
========================================= Drawing ========================================
*/ 
    @Override
    public void interactionDraw() {
        if(UI_Manager.getIsOverOrPressedWindows()) {
            return;
        }

        if(UI_Manager.HOT_BAR.getActiveSlotID() != 1) {
            return;
        }

        if(this.inEditMode) {
            this.onWindowSelect();
            this.drawVertices();
            return;
        }

        if(this.inDragSelectMode) {
            this.drawDragSelect();
            return;
        }

        if(this.dragBox != null) {
            this.dragBox.drawAABB();
        }
    }


    public void drawVertices() {
        ShapeType shapeType = this.rigidbodyToEdit.getShapeType();

        if(shapeType == ShapeType.BOX || shapeType == ShapeType.POLYGON) {
            this.drawPolygonVertices();
        } else if(shapeType == ShapeType.CIRCLE) {
            this.drawCircleVertex();
        }
    }


    public void drawPolygonVertices() {
        PVector[] currentVertices = this.rigidbodyToEdit.GetTransformedVertices();
            for(PVector vertex : currentVertices) {
                pushMatrix();
                translate(vertex.x, vertex.y);
                fill(0, 255, 0);
                noStroke();
                ellipse(0, 0, 0.25, 0.25);
                popMatrix();
            }

    }

    public void drawCircleVertex() {
        PVector vertex = new PVector(this.rigidbodyToEdit.getRadius(), 0);
        vertex = PhysEngMath.Transform(vertex, this.rigidbodyToEdit.getAngle());
        PVector position = this.rigidbodyToEdit.getPosition();

        pushMatrix();
        translate(position.x, position.y);
        fill(0, 255, 0);
        noStroke();
        ellipse(vertex.x, vertex.y, 0.25, 0.25);
        popMatrix();
    }


    public void drawDragSelect() {
        PVector start = Mouse.getMouseDownCoordinates();
        PVector end = Mouse.getMouseCoordinates();
        rectMode(CORNERS);
        noFill();
        stroke(255);
        dash.rect(start.x, start.y, end.x, end.y);
    }



    public void drawCircle(PVector position, float angle) {
        pushMatrix();
        translate(position.x, position.y);
        rotate(angle);
            float radius = this.getElementByName("Radius").getValue();
            float diameter = radius * 2.0f;

            fill(255, 255, 255, 166);
            stroke(0, 0, 0, 166);
            strokeWeight(0.1);
            ellipseMode(CENTER);
            ellipse(0, 0, diameter,  diameter);

            PVector va = new PVector();
            PVector vb = new  PVector(radius, 0);
            va = PhysEngMath.Transform(va, new PVector(), angle);
            vb = PhysEngMath.Transform(vb, new PVector(), angle);

            line(va.x, va.y, vb.x, vb.y);
        popMatrix();
    }


    public void drawPolygon(PVector position, PVector[] Vertices) {

    }


/*
========================================= Vertex Methods ========================================
*/

    public int selectVertex(float radius) {
        PVector[] rigidbodyVertices = this.rigidbodyToEdit.GetTransformedVertices();

        for(int i = 0; i < rigidbodyVertices.length; i++) {
            if(PVector.sub(Mouse.getMouseCoordinates(), rigidbodyVertices[i]).magSq() < radius) {
                return i;
            }
        }
        return -1;
    }

    public boolean selectCircleVertex(float radius) {
        PVector vertex = PhysEngMath.Transform(new PVector(this.rigidbodyToEdit.getRadius(), 0), this.rigidbodyToEdit.getPosition(), this.rigidbodyToEdit.getAngle());
        if(PVector.sub(Mouse.getMouseCoordinates(), vertex).magSq() < radius) {
            return true;
        } else {
            return false;
        }
    }


    public boolean moveVertex() {
        ShapeType shapeType = rigidbodyToEdit.getShapeType();
        
        if(shapeType == ShapeType.BOX || shapeType == ShapeType.POLYGON) {
           return this.movePolygonVertex();
        } else if(shapeType == ShapeType.CIRCLE) {
            return this.moveCircleVertex();
        } else {
            throw new IllegalArgumentException("Unknown ShapeType");
        }
    }

    public boolean movePolygonVertex() {
        if(this.vertexIndexToDrag == -1) {
                return false;
        }

        PVector vertex = Camera.screenToWorld();
        PVector[] rigidbodyCoreVertices = this.rigidbodyToEdit.getVertices();

        PVector[] vertexList = Arrays.copyOf(rigidbodyCoreVertices, rigidbodyCoreVertices.length);

        vertexList[this.vertexIndexToDrag] = PhysEngMath.ReverseTransform(vertex, this.rigidbodyToEdit.getPosition().copy().mult(-1), -this.rigidbodyToEdit.getAngle());

        this.rigidbodyToEdit.updatePolygon(vertexList);
        return true;
    }

    public boolean moveCircleVertex() {
        if(!this.circleVertexToDrag){
            return false;
        }
        PVector newVertex = Camera.screenToWorld();

        PVector newRadiusVector = PVector.sub(this.rigidbodyToEdit.getPosition(), newVertex);

        this.rigidbodyToEdit.updateCircle(newRadiusVector.mag());
        return true;
    }


    public void addVertex() {
        ShapeType rigidbodyShapeType = this.rigidbodyToEdit.getShapeType();

        if(rigidbodyShapeType == ShapeType.CIRCLE) {
            return;
        }

        PVector vertex = PhysEngMath.ReverseTransform(Camera.screenToWorld(), this.rigidbodyToEdit.getPosition().copy().mult(-1), -this.rigidbodyToEdit.getAngle());
        PVector[] rigidbodyVertices = this.rigidbodyToEdit.getVertices();
        PVector[] newRigidbodyVertices = new PVector[rigidbodyVertices.length + 1];

        for(int i = 0; i < rigidbodyVertices.length; i++) {
            newRigidbodyVertices[i] = rigidbodyVertices[i];
        }

        newRigidbodyVertices[newRigidbodyVertices.length - 1] = vertex;

        this.rigidbodyToEdit.updatePolygon(newRigidbodyVertices);
    } 


    public void deleteVertex(int index) {
        ArrayList<PVector> vertexList = new ArrayList<PVector>(Arrays.asList(this.rigidbodyToEdit.getVertices()));
        vertexList.remove(index);
        this.rigidbodyToEdit.updatePolygon(vertexList.toArray(new PVector[vertexList.size()]));
    }



    public void dragSelect() {
        this.inDragSelectMode = false;

        this.dragBox = new AABB(Mouse.getMouseDownCoordinates(), Mouse.getMouseCoordinates(), true);

        for(Rigidbody rigidbody : rigidbodyList) {
            if(Collisions.IntersectAABB(dragBox,rigidbody.GetAABB())) {
                this.selectedRigidbodies.add(rigidbody);
                rigidbody.setStrokeColour(255, 0, 0);
            }
        }


        if(this.selectedRigidbodies.size() == 0) {
            this.dragBox = null;
            IS_PAUSED = false;
            IS_PAUSED_LOCK = false;
        }
    }




    public boolean dragMove() {
        if(Collisions.IntersectAABBWithPoint(this.dragBox, Camera.screenToWorld())) {
            if(!isSelectionBeingDragged) {
                this.initialDragPosition.set(Camera.screenToWorld());
                this.isSelectionBeingDragged = true;
            } else {
                PVector mouseDragDifference = PVector.sub(Camera.screenToWorld(), this.initialDragPosition);
                this.dragBox.shiftAABB(mouseDragDifference);
                for(Rigidbody rigidbody : this.selectedRigidbodies) {
                    rigidbody.addPosition(mouseDragDifference);
                }
                this.initialDragPosition.set(Camera.screenToWorld());
            }
            return true;
        } else {
            return false;
        }
    }

/*
========================================= Mouse Interaction =======================================
*/  

    @Override
    public void interactionMousePress() {
        /*----------------- Checks ----------------*/
        if(UI_Manager.hasWindowBeenInteractedWith) {
            return;
        }
        if(UI_Manager.getIsOverOrPressedWindows()) {
            return;
        }
        if(UI_Manager.HOT_BAR.getActiveSlotID() != 1) {
            return;
        } 
        /*----------------------------------------*/

        if(this.inEditMode) {
            ShapeType shapeType = this.rigidbodyToEdit.getShapeType();
            if(shapeType == ShapeType.BOX || shapeType == ShapeType.POLYGON) {
                this.vertexIndexToDrag = this.selectVertex(VERTEX_SNAP_RADIUS);
            } else if(shapeType == ShapeType.CIRCLE) {
                this.circleVertexToDrag = this.selectCircleVertex(VERTEX_SNAP_RADIUS);
            }
        }
    }
    @Override
    public void interactionMouseRelease() {
        /*----------------- Checks ----------------*/
        if(UI_Manager.hasWindowBeenInteractedWith) {
            return;
        }
        if(UI_Manager.getIsOverOrPressedWindows()) {
            return;
        }
        if(UI_Manager.HOT_BAR.getActiveSlotID() != 1) {
            return;
        } 
        /*----------------------------------------*/
        this.vertexIndexToDrag = -1;
        this.circleVertexToDrag = false;

        this.isSelectionBeingDragged = false;

        //Drag select makes inDragSelectMode false
        if(this.inDragSelectMode) {
            this.dragSelect();
        }
    }


    @Override
    public void interactionMouseDrag() {
        /*----------------- Checks ----------------*/
        if(UI_Manager.hasWindowBeenInteractedWith) {
            return;
        }
        if(UI_Manager.getIsOverOrPressedWindows()) {
            return;
        }
        if(UI_Manager.HOT_BAR.getActiveSlotID() != 1) {
            return;
        }  
        /*----------------------------------------*/
        if(this.inEditMode) {
            if(!this.moveVertex()) {

                this.enterDragSelect();
            }
        } else if(!this.inEditMode && this.selectedRigidbodies.size() == 0) {
            this.enterDragSelect();
        } else if(!this.inEditMode && this.selectedRigidbodies.size() != 0) {
            if(!this.dragMove()) {

                this.enterDragSelect();
            }
        }
    }

    @Override
    public void interactionMouseClick() {
        /*----------------- Checks ----------------*/
        if(UI_Manager.hasWindowBeenInteractedWith) {
            return;
        }
        if(UI_Manager.getIsOverOrPressedWindows()) {
            return;
        }
        if(UI_Manager.HOT_BAR.getActiveSlotID() != 1) {
            return;
        } 
        /*----------------------------------------*/

        Rigidbody newRigidbody = Mouse.getRigidbodyUnderMouse();


        if(!this.inEditMode && newRigidbody!= null) {
            this.enterEditMode(newRigidbody);
            return;
        } 

        if(this.inEditMode && newRigidbody != this.rigidbodyToEdit && newRigidbody != null) {
            this.editModeSwitchRigidbody(newRigidbody);
            return;
        } 

        if(this.inEditMode) {
            this.addVertex();
            return;
        }

        if(this.selectedRigidbodies.size() != 0) {
            this.selectedRigidbodiesOnClick();
        }
    }



    public void enterEditMode(Rigidbody newRigidbody) {
        VERTEX_SNAP_RADIUS = 0.5f;
        this.rigidbodyToEdit = newRigidbody;
        this.inEditMode = true;
        this.inDragSelectMode = false;
        this.dragBox = null;
        this.clearSelectedRigidbodies();
        this.onEditorActive();
    }

    public void editModeSwitchRigidbody(Rigidbody newRigidbody) {
        this.rigidbodyToEdit = newRigidbody;
        this.clearSelectedRigidbodies();
        this.onEditorActive();
    }


    public void selectedRigidbodiesOnClick() {
        IS_PAUSED_LOCK = false;
        IS_PAUSED = false;
        this.clearSelectedRigidbodies();
        this.dragBox = null;
    }

    public void enterDragSelect() {
        this.inDragSelectMode = true;
        this.inEditMode = false;

        this.clearSelectedRigidbodies();
        this.dragBox = null;
        IS_PAUSED = true;
        IS_PAUSED_LOCK = true;
    }


    public void clearSelectedRigidbodies() {
        for(Rigidbody rigidbody : this.selectedRigidbodies) {
            rigidbody.setStrokeColour(0, 0, 0);
            System.out.println("Cleared Rigidbodies: " + millis() +"@ms");
        }
        this.selectedRigidbodies.clear();
    }

/*
======================================== Window Interaction ========================================
*/

    @Override
    public void onWindowClose() {
        this.Window_Visibility = false;
        this.isMouseOverWindow = false;
        this.isMouseOverWindowTextContainer = false;
        this.isMouseOverWindowFormContainer = false;
        this.wasMousePressedOverWindow = false;
        this.isActiveWindow = false;

        this.dragBox = null;
        this.inEditMode = false;
        this.inDragSelectMode = false;
        this.vertexIndexToDrag = -1;
        this.circleVertexToDrag = false;


        this.clearSelectedRigidbodies();
        IS_PAUSED = false;
        IS_PAUSED_LOCK = false;
        VERTEX_SNAP_RADIUS = 0.25f;
        this.rigidbodyToEdit = null;
    }


    @Override
    public void onWindowSelect() {
        this.deselectAllWindows();
        this.isActiveWindow = true;
        UI_Manager.bringToFront(this);
        this.Window_Container.getChild("Window_Container_Stroke").setStroke(UI_Constants.BLUE_SELECTED);
        this.Window_Container.getChild("Window_Text_Container").setFill(UI_Constants.BLUE_UNSELECTED);
    }





    
/*
========================================= Key Press ========================================
*/



    @Override
    public void onKeyPress(int keyCode) {
        int activeSlotID = UI_Manager.HOT_BAR.getActiveSlotID();
        boolean shiftDown = KeyHandler.isKeyDown(KeyEvent.VK_SHIFT);


        switch(keyCode) {
            case KeyEvent.VK_DELETE:
                if(this.rigidbodyToEdit == null) {
                    break;
                }

                int index = this.selectVertex(VERTEX_SNAP_RADIUS);
                if(index != -1) {
                    this.deleteVertex(index);
                }
                break;
            case KeyEvent.VK_ENTER:
                this.onWindowClose();
                break;
        }
    }
}

