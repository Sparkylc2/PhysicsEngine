public class UI_PropertiesEditorWindow extends UI_Window {


    private String OS = System.getProperty("os.name").toLowerCase();
    private boolean mac = false;

    private Rigidbody rigidbodyToEdit = null;

    private ArrayList<Rigidbody> selectedRigidbodies = new ArrayList<Rigidbody>();

    private ArrayList<Rigidbody> rigidbodiesToCopy = new ArrayList<Rigidbody>();


    private float mouseDownTime;
    private boolean inEditMode = false;

    private boolean inDragSelectMode = false;
    private boolean isSelectionBeingDragged = false;
    private AABB dragBox = null;
    private PVector initialDragPosition = new PVector();


    private boolean inCopySelectMode = false;
    private PVector initialCopyMousePosition = new PVector();

    private int vertexIndexToDrag = -1;
    private boolean circleVertexToDrag = false;





    private float prvDnsty;
    private float prvRsttn;
    private boolean prvStatic;
    private boolean prvFixRot;
    private boolean prvFixPos;
    private float prvAngle;



    public UI_PropertiesEditorWindow() {
        super("Properties Editor (rigidbody)", 2);
        if(OS.contains("mac")) {
            this.mac = true;
        }
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

        this.initializeEditor();
    }

    public void initializeEditor() {
        this.clearAllElements();
        this.addElement(new UI_Slider("Density", (UI_Window)this, MIN_BODY_DENSITY, MAX_BODY_DENSITY, this.rigidbodyToEdit.getDensity()));
        this.addElement(new UI_Slider("Restitution", (UI_Window)this, 0, 1, this.rigidbodyToEdit.getRestitution()));
        this.addElement(new UI_Toggle("Static", (UI_Window)this, "Staticity", this.rigidbodyToEdit.getIsStatic()));
        this.addElement(new UI_Toggle("Fixed Rotation", (UI_Window)this, "Staticity", this.rigidbodyToEdit.getIsRotationallyStatic()));
        this.addElement(new UI_Toggle("Fixed Position", (UI_Window)this, "Staticity", this.rigidbodyToEdit.getIsTranslationallyStatic()));
        this.addElement(new UI_Slider("Angle", (UI_Window)this, -360, 360, this.rigidbodyToEdit.getAngle()));


        this.prvDnsty = this.rigidbodyToEdit.getDensity();
        this.prvRsttn = this.rigidbodyToEdit.getRestitution();
        this.prvStatic = this.rigidbodyToEdit.getIsStatic();
        this.prvFixRot = this.rigidbodyToEdit.getIsRotationallyStatic();
        this.prvFixPos = this.rigidbodyToEdit.getIsTranslationallyStatic();
        this.prvAngle = this.rigidbodyToEdit.getAngle();
    }



/*
========================================= Drawing ========================================
*/ 
    @Override
    public void interactionDraw() {

        if(this.inEditMode) {
            this.elementChangeListener();
            this.selectLock();
        }

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

        if(this.dragBox != null && this.dragBox.calculateArea() > 0.1) {
            this.dragBox.drawAABB();
            return;
        }

        if(this.inCopySelectMode) {
            this.drawCopiedRigidbodies();
            this.updateCopiedRigidbodyPosition();
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

    public void drawCopiedRigidbodies() {
        if(this.inCopySelectMode) {
            for(Rigidbody rigidbody: this.rigidbodiesToCopy) {
                ShapeType shapeType = rigidbody.getShapeType();
                if(shapeType == ShapeType.BOX || shapeType == ShapeType.POLYGON) {
                    this.drawPolygon(rigidbody);
                } else if(shapeType == ShapeType.CIRCLE) {
                    this.drawCircle(rigidbody);
                }
            }
        }
    }


    public void drawPolygon(Rigidbody rigidbody) {
        PVector[] vertices = rigidbody.getVertices();
        fill(255, 255, 255, 166);
        stroke(0, 0, 0, 166);
        pushMatrix();
        translate(rigidbody.getPosition().x, rigidbody.getPosition().y);
        rotate(rigidbody.getAngle());
        beginShape();
        for(PVector vertex : vertices) {
            vertex(vertex.x, vertex.y);
        }
        endShape(CLOSE);
        popMatrix();
    }


    public void drawCircle(Rigidbody rigidbody) {
        fill(255, 255, 255, 166);
        stroke(0, 0, 0, 166);
        PVector position = rigidbody.getPosition();
        float radius = rigidbody.getRadius();

        pushMatrix();
        translate(position.x, position.y);
        ellipse(0, 0, radius * 2, radius * 2);
        popMatrix();
    }

/*
========================================= Vertex Methods ========================================
*/

    public int selectVertex(float radius) {
        PVector[] rigidbodyVertices = this.rigidbodyToEdit.GetTransformedVertices();

        for(int i = 0; i < rigidbodyVertices.length; i++) {
            if(PVector.sub(Camera.screenToWorld(), rigidbodyVertices[i]).magSq() < radius) {
                return i;
            }
        }
        return -1;
    }

    public boolean selectCircleVertex(float radius) {
        PVector vertex = PhysEngMath.Transform(new PVector(this.rigidbodyToEdit.getRadius(), 0), this.rigidbodyToEdit.getPosition(), this.rigidbodyToEdit.getAngle());
        if(PVector.sub(Camera.screenToWorld(), vertex).magSq() < radius) {
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

        if(this.checkConvexity(vertexList)) {
            this.rigidbodyToEdit.updatePolygon(vertexList);
            return true;
        } else { 
            return true;
        }

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



    public boolean addVertexOnClick() {

        if(!this.inEditMode) {
            return false;
        }

        ShapeType rigidbodyShapeType = this.rigidbodyToEdit.getShapeType();

        if(rigidbodyShapeType == ShapeType.CIRCLE) {
            return false;
        }

        PVector vertex = PhysEngMath.ReverseTransform(Camera.screenToWorld(), this.rigidbodyToEdit.getPosition().copy().mult(-1), -this.rigidbodyToEdit.getAngle());
        PVector[] rigidbodyVertices = this.rigidbodyToEdit.getVertices();
        PVector[] newRigidbodyVertices = new PVector[rigidbodyVertices.length + 1];

        for(int i = 0; i < rigidbodyVertices.length; i++) {
            newRigidbodyVertices[i] = rigidbodyVertices[i];
        }

        newRigidbodyVertices[newRigidbodyVertices.length - 1] = vertex;

        if(this.checkConvexity(PhysEngMath.OrderVerticesClockwise(newRigidbodyVertices))) {
            this.rigidbodyToEdit.updatePolygon(newRigidbodyVertices);
            return true;
        }
        return false;
    } 


    public void deleteVertex(int index) {
        ArrayList<PVector> vertexList = new ArrayList<PVector>(Arrays.asList(this.rigidbodyToEdit.getVertices()));
        vertexList.remove(index);
        this.rigidbodyToEdit.updatePolygon(vertexList.toArray(new PVector[vertexList.size()]));
    }



    public void dragSelect() {
        this.inDragSelectMode = false;
        this.dragBox = new AABB(Mouse.getMouseDownCoordinates(), Mouse.getMouseCoordinates(), true);
        if(this.dragBox.calculateArea() < 0.1) {
            this.dragBox = null;
            IS_PAUSED = false;
            IS_PAUSED_LOCK = false;

            Rigidbody newRigidbody = Mouse.getRigidbodyUnderMouse();

            if(!this.inEditMode && newRigidbody!= null) {
                this.enterEditMode(newRigidbody);
                return;
            } 

            if(this.inEditMode && newRigidbody != this.rigidbodyToEdit && newRigidbody != null) {
                this.editModeSwitchRigidbody(newRigidbody);
                return;
            } 

            return;
        }

        for(Rigidbody rigidbody : rigidbodyList) {
            if(Collisions.IntersectAABB(dragBox,rigidbody.GetAABB())) {
                rigidbody.setStrokeColour(255, 0, 0);
                this.selectedRigidbodies.add(rigidbody);
            }
        }

        if(this.selectedRigidbodies.size() == 0) {
            this.dragBox = null;
            IS_PAUSED = false;
            IS_PAUSED_LOCK = false;
            return;
        } else {
            this.dragBox.recalculateMaxAndMin(this.selectedRigidbodies);
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


    public boolean checkConvexity(PVector[] Vertices) {
        if(Vertices.length < 4) {
            return true;
        }

        boolean isPositive = false;

        for(int i = 0; i < Vertices.length; i++) {
            PVector current = Vertices[i];
            PVector next = Vertices[(i + 1) % Vertices.length];
            PVector nextNext = Vertices[(i + 2) % Vertices.length];

            PVector edge1 = PVector.sub(next, current);
            PVector edge2 = PVector.sub(nextNext, next);

            float cross = edge1.cross(edge2).z;

            if(i == 0) {
                isPositive = cross > 0;
            } else if((cross > 0) != isPositive) {
                return false;
            }
        }

        return true;
    }



    public boolean selectShapeVertex() {
        if(this.inEditMode) {
            ShapeType shapeType = this.rigidbodyToEdit.getShapeType();
            if(shapeType == ShapeType.BOX || shapeType == ShapeType.POLYGON) {
                this.vertexIndexToDrag = this.selectVertex(VERTEX_SNAP_RADIUS);
                return true;
            } else if(shapeType == ShapeType.CIRCLE) {
                this.circleVertexToDrag = this.selectCircleVertex(VERTEX_SNAP_RADIUS);
                return true;
            }

            return false;
        }

        return false;
    }



    public void elementChangeListener() {
        for(UI_Element element : this.Window_Elements) {
            switch(element.getElementName()) {
                case "Density":
                    if(!PhysEngMath.Equals(this.prvDnsty, element.getValue())) {
                        this.rigidbodyToEdit.setDensity(element.getValue());
                    }
                    break;
                case "Restitution":
                    if(!PhysEngMath.Equals(this.prvRsttn, element.getValue())) {
                        this.rigidbodyToEdit.setRestitution(element.getValue());
                    }
                    break;
                case "Static":
                    if(this.prvStatic != element.getState()) {
                        this.rigidbodyToEdit.setIsStatic(element.getState());
                    }
                    break;
                case "Fixed Rotation":
                    if(this.prvFixRot != element.getState()) {
                        this.rigidbodyToEdit.setIsRotationallyStatic(element.getState());
                    }
                    break;
                case "Fixed Position":
                    if(this.prvFixPos != element.getState()) {
                        this.rigidbodyToEdit.setIsTranslationallyStatic(element.getState());
                    }
                    break;
                case "Angle":
                    if(!PhysEngMath.Equals(this.prvAngle, element.getValue())) {
                        this.rigidbodyToEdit.setAngle(radians(element.getValue()));
                    }
                    break;
            }
        }
    }

/*
========================================= Mouse Interaction =======================================
*/  

    @Override
    public void interactionMousePress() {
        this.mouseDownTime = millis();
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

        if(this.selectShapeVertex()) {
            return;
        }

    }
    @Override
    public void interactionMouseRelease() {
        this.mouseDownTime = -1;
        /*----------------- Resets ----------------*/
        this.vertexIndexToDrag = -1;
        this.circleVertexToDrag = false;

        this.isSelectionBeingDragged = false;
        /*----------------------------------------*/

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
        if(!this.mac) {
            if(millis() - this.mouseDownTime > 300) {
                return;
            }
        }
        /*----------------------------------------*/

        if(this.enterEditModeOnClick()) {
            return;
        }

        if(this.addVertexOnClick()) {
            return;
        }

        if(this.selectedRigidbodiesOnClick()) {
            return;
        }

        if(this.copiedRigidbodiesOnClick()) {
            return;
        }
    }




    public boolean enterEditModeOnClick() {
        Rigidbody newRigidbody = Mouse.getRigidbodyUnderMouse();

        if(!this.inEditMode && newRigidbody!= null) {
            this.enterEditMode(newRigidbody);
            return true;
        } 

        if(this.inEditMode && newRigidbody != this.rigidbodyToEdit && newRigidbody != null) {
            this.editModeSwitchRigidbody(newRigidbody);
            return true;
        } 

        return false;
    }


    public void enterEditMode(Rigidbody newRigidbody) {
        VERTEX_SNAP_RADIUS = 0.5f;
        this.rigidbodyToEdit = newRigidbody;
        this.inEditMode = true;
        this.inDragSelectMode = false;
        this.dragBox = null;
        this.vertexIndexToDrag = -1;
        this.clearSelectedRigidbodies();
        this.onEditorActive();
    }

    public void editModeSwitchRigidbody(Rigidbody newRigidbody) {
        this.rigidbodyToEdit = newRigidbody;
        this.clearSelectedRigidbodies();
        this.onEditorActive();
    }


    public boolean selectedRigidbodiesOnClick() {
        if(this.selectedRigidbodies.size() != 0 && !this.inCopySelectMode) {
            IS_PAUSED_LOCK = false;
            IS_PAUSED = false;
            this.clearSelectedRigidbodies();
            this.dragBox = null;
            return true;
        }
        return false;
    }



    public void updateCopiedRigidbodyPosition() {
        if(this.inCopySelectMode) {
            for(Rigidbody rigidbody : this.rigidbodiesToCopy) {
                rigidbody.addPosition(PVector.sub(Camera.screenToWorld(), this.initialCopyMousePosition));
            }
            this.initialCopyMousePosition.set(Camera.screenToWorld());
        }
    }

    public void updateCopiedPosRelToAABBCenterToMouse() {

        if(this.dragBox == null) {
            throw new RuntimeException("DragBox is null");
        }

        PVector AABBCenter = this.dragBox.calculateCenter();
        PVector difference = PVector.sub(Camera.screenToWorld(), AABBCenter);

        for(Rigidbody rigidbody : this.rigidbodiesToCopy) {
            rigidbody.addPosition(difference);
        }
    }

    public void selectedRigidbodiesOnCopy() {

        if(this.selectedRigidbodies.size() != 0 && this.dragBox != null) {
            for(Rigidbody rigidbody : this.selectedRigidbodies) {
                Rigidbody copiedRigidbody = new Rigidbody();
                copiedRigidbody.copy(rigidbody);
                this.rigidbodiesToCopy.add(copiedRigidbody);
            }

            this.updateCopiedPosRelToAABBCenterToMouse();

            this.inCopySelectMode = true;
            this.inDragSelectMode = false;
            this.inEditMode = false;
            this.vertexIndexToDrag = -1;
            this.clearSelectedRigidbodies();
            this.dragBox = null;
            this.initialCopyMousePosition.set(Camera.screenToWorld());
        }
    }

    public boolean copiedRigidbodiesOnClick() {
        if(this.inCopySelectMode) {
            this.inCopySelectMode = false;
            this.onWindowClose();
            return true;
        } 
        return false;
    }

    public void copiedRigidbodiesOnPaste() {
        ArrayList<Rigidbody> newCopyList = new ArrayList<Rigidbody>();

        for(Rigidbody rigidbody : this.rigidbodiesToCopy) {
            Rigidbody newRigidbody = new Rigidbody();
            newRigidbody.copy(rigidbody);
            newCopyList.add(newRigidbody);
            AddBodyToBodyEntityList(rigidbody);
        }

        this.clearCopiedRigidbodies();

        this.inCopySelectMode = true;
        this.rigidbodiesToCopy = newCopyList;
        this.initialCopyMousePosition.set(Camera.screenToWorld());
    }

    public void enterDragSelect() {
        this.inDragSelectMode = true;
        this.inEditMode = false;
        this.vertexIndexToDrag = -1;
        this.clearSelectedRigidbodies();
        this.dragBox = null;
        IS_PAUSED = true;
        IS_PAUSED_LOCK = true;
    }



    public void clearSelectedRigidbodies() {
        for(Rigidbody rigidbody : this.selectedRigidbodies) {
            rigidbody.setStrokeColour(0, 0, 0);
        }
        this.selectedRigidbodies.clear();
    }

    public void clearCopiedRigidbodies() {
        for(Rigidbody rigidbody : this.rigidbodiesToCopy) {
            rigidbody.setStrokeColour(0, 0, 0);
        }
        this.rigidbodiesToCopy.clear();
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

        this.rigidbodyToEdit = null;

        this.clearCopiedRigidbodies();
        this.clearSelectedRigidbodies();
        Mouse.getMouseObjectResults().clear();
        IS_PAUSED = false;
        IS_PAUSED_LOCK = false;
        VERTEX_SNAP_RADIUS = 0.25f;
    }

    public void onWindowCloseNoPause() {
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

        this.rigidbodiesToCopy.clear();

        this.clearSelectedRigidbodies();
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


    public void selectLock() {
        this.isActiveWindow = true;
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
            case KeyEvent.VK_C: 
                if(KeyHandler.isKeyDown(KeyEvent.VK_CONTROL)) {
                    this.selectedRigidbodiesOnCopy();
                }
                break;
            case KeyEvent.VK_V:
                if(KeyHandler.isKeyDown(KeyEvent.VK_CONTROL)) {
                    this.copiedRigidbodiesOnPaste();
                }
                break;
        }
    }

    /*
    ========================================= Getters & Setters ========================================
    */

    public boolean getInEditMode() {
        return this.inEditMode;
    }

    public ArrayList<Rigidbody> getSelectedRigidbodies() {
        return this.selectedRigidbodies;
    }
}

