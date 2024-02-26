public class UI_PropertiesEditorWindow extends UI_Window {



    private Rigidbody rigidbodyToEdit = null;


    private boolean inEditMode = false;


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
========================================= Rigidbody Drawing ========================================
*/ 
    @Override
    public void interactionDraw() {
        if(UI_Manager.getIsOverOrPressedWindows()) {
            return;
        }
        if(UI_Manager.HOT_BAR.getActiveSlotID() != 1) {
            return;
        }


    }




/*
========================================= Rigidbody Creation =======================================
*/
    @Override
    public void interactionMouseRelease() {
        if(UI_Manager.hasWindowBeenInteractedWith) {
            return;
        }
        if(UI_Manager.getIsOverOrPressedWindows()) {
            return;
        }
        if(UI_Manager.HOT_BAR.getActiveSlotID() != 1) {
            this.inEditMode = false;
            return;
        }

        Rigidbody newRigidbody = Mouse.getRigidbodyUnderMouse();
        if(newRigidbody == null) {
            return;
        }



        if(!this.inEditMode) {
            this.rigidbodyToEdit = newRigidbody;
            this.onEditorActive();
            this.inEditMode = true;
            IS_PAUSED = true;
            IS_PAUSED_LOCK = true;
        } else if(this.inEditMode && newRigidbody != this.rigidbodyToEdit) {
            this.rigidbodyToEdit = newRigidbody;
            this.onEditorActive();
        } 
    }








    
/*
========================================= Rigidbody Drawing ========================================
*/



    @Override
    public void onKeyPress(int keyCode) {
        int activeSlotID = UI_Manager.HOT_BAR.getActiveSlotID();
        boolean shiftDown = KeyHandler.isKeyDown(KeyEvent.VK_SHIFT);

        switch(keyCode) {
            case KeyEvent.VK_A:
                if(activeSlotID == 2) {
                    if(shiftDown) {
                        this.getElementByName("Radius").incrementValue(-1f);
                    } else {
                        this.getElementByName("Radius").incrementValue(-0.25f);
                    }
                } else if(activeSlotID == 3) {
                    if(shiftDown) {
                        this.getElementByName("Width").incrementValue(-5f);
                    } else {
                        this.getElementByName("Width").incrementValue(-1f);
                    }
                }
                break;
            case KeyEvent.VK_D:
                if(activeSlotID == 2) {
                    if(shiftDown) {
                        this.getElementByName("Radius").incrementValue(1f);
                    } else {
                        this.getElementByName("Radius").incrementValue(0.25f);
                    }
                } else if(activeSlotID == 3) {
                    if(shiftDown) {
                        this.getElementByName("Width").incrementValue(5f);
                    } else {
                        this.getElementByName("Width").incrementValue(1f);
                    }
                }
                break;
            case KeyEvent.VK_W:
                if(activeSlotID == 2) {
                    if(shiftDown) {
                        this.getElementByName("Radius").incrementValue(1f);
                    } else {
                        this.getElementByName("Radius").incrementValue(0.25f);
                    }
                } else if(activeSlotID == 3) {
                    if(shiftDown) {
                        this.getElementByName("Height").incrementValue(5f);
                    } else {
                        this.getElementByName("Height").incrementValue(1f);
                    }
                }
                break;

            case KeyEvent.VK_S:
                if(activeSlotID == 2) {
                    if(shiftDown) {
                        this.getElementByName("Radius").incrementValue(-1f);
                    } else {
                        this.getElementByName("Radius").incrementValue(-0.25f);
                    }
                } else if(activeSlotID == 3) {
                    if(shiftDown) {
                        this.getElementByName("Height").incrementValue(-5f);
                    } else {
                        this.getElementByName("Height").incrementValue(-1f);
                    }
                }
                break;
        }

    }
}

