public class UI_HotBar {


    private PShape HOT_SHAPE;
    private float[] TEXT_POSITION_X;
    private float[] TEXT_POSITION_Y;

    private float[] SLOT_POSITION;

    private float SCALE_FACTOR = width/1512f;

    private int activeSlotID;


    /*
    ======================================== Forces ================================================
    */

    public UI_HotBar() {
        this.initializeHotbar();
    }

    public void draw() {
        this.drawHotbar();
    }


/*
======================================== Initialization ============================================
*/
    public void initializeHotbar() {
        rectMode(CENTER);

        this.SLOT_POSITION = new float[UI_Constants.HOTBAR_SLOT_COUNT];
        this.TEXT_POSITION_X = new float[UI_Constants.HOTBAR_SLOT_COUNT];
        this.TEXT_POSITION_Y = new float[UI_Constants.HOTBAR_SLOT_COUNT];


        this.HOT_SHAPE = createShape(GROUP);
            this.HOT_SHAPE.setName("HOTBAR");
    

        float totalPadding = UI_Constants.HOTBAR_CONTAINER_WIDTH - UI_Constants.HOTBAR_TOTAL_SLOT_WIDTH;

        float padding = totalPadding / (UI_Constants.HOTBAR_SLOT_COUNT + 1);

        float startX = UI_Constants.HOTBAR_CONTAINER_POSITION_X - UI_Constants.HOTBAR_CONTAINER_WIDTH/ 2;

        for(int i = 0; i < UI_Constants.HOTBAR_SLOT_COUNT; i++) {
            float xPos = startX + i * (padding + UI_Constants.HOTBAR_SLOT_WIDTH) + UI_Constants.HOTBAR_SLOT_WIDTH / 2;
            float yPos = UI_Constants.HOTBAR_CONTAINER_POSITION_Y;

            SLOT_POSITION[i] = xPos;

            PShape SLOT_GROUP = createShape(GROUP);

            PShape SLOT = createShape(RECT, xPos, yPos, UI_Constants.HOTBAR_SLOT_WIDTH, 
                                                        UI_Constants.HOTBAR_SLOT_HEIGHT, 
                                                        UI_Constants.HOTBAR_SLOT_ROUNDING);

                if(i == this.activeSlotID) {
                    SLOT.setFill(UI_Constants.HOTBAR_SLOT_SELECTED_COLOR);
                    SLOT.setStroke(UI_Constants.HOTBAR_SLOT_SELECTED_STROKE);
                } else {
                    SLOT.setFill(UI_Constants.HOTBAR_SLOT_UNSELECTED_COLOR);
                    SLOT.setStroke(UI_Constants.HOTBAR_SLOT_UNSELECTED_STROKE);
                }

                SLOT.setStrokeWeight(UI_Constants.HOTBAR_STROKE_WEIGHT);

                if(i < 4) {
                    PShape SLOT_ICON_SELECTED = loadShape("HotbarSlot" + (i + 1) + "Selected.svg");
                        SLOT_ICON_SELECTED.setName("SLOT_ICON_SELECTED");
                        SLOT_ICON_SELECTED.translate(xPos, yPos);

                    PShape SLOT_ICON = loadShape("HotbarSlot" + (i + 1) + ".svg");
                        SLOT_ICON.setName("SLOT_ICON");
                        SLOT_ICON.translate(xPos, yPos);

                    SLOT_GROUP.addChild(SLOT);
                    SLOT_GROUP.addChild(SLOT_ICON);
                    SLOT_GROUP.addChild(SLOT_ICON_SELECTED);

                } else {
                    SLOT_GROUP.addChild(SLOT);
                }
            this.HOT_SHAPE.addChild(SLOT_GROUP);
        }

        this.HOT_SHAPE.translate(UI_Constants.HOTBAR_CONTAINER_POSITION_X, UI_Constants.HOTBAR_CONTAINER_POSITION_Y);
        this.HOT_SHAPE.scale(SCALE_FACTOR); 
        this.HOT_SHAPE.translate(-UI_Constants.HOTBAR_CONTAINER_POSITION_X, -UI_Constants.HOTBAR_CONTAINER_POSITION_Y);
        this.initializeText();
    }


    public void initializeText() {
        textFont(UI_Constants.HOTBAR_TEXT_FONT);
        textSize(UI_Constants.HOTBAR_TEXT_SIZE);
        textAlign(CENTER, CENTER);

        for(int i = 0; i < UI_Constants.HOTBAR_SLOT_COUNT; i++) {
            float textEdgePadding = UI_Constants.HOTBAR_SLOT_WIDTH / 2 - textWidth(String.valueOf(i + 1)) / 2 - UI_Constants.HOTBAR_TEXT_PADDING_X;
            float textXPos = this.SLOT_POSITION[i] + textEdgePadding;
            float textYPos = UI_Constants.HOTBAR_CONTAINER_POSITION_Y + textEdgePadding - (textAscent() - textDescent()) * UI_Constants.GLOBAL_TEXT_ALIGN_FACTOR_Y;
            
            this.TEXT_POSITION_X[i] = textXPos;
            this.TEXT_POSITION_Y[i] = textYPos;
        }
    }




/*
====================================== Element Updates =============================================
*/

    public void onSlotChange(int slotID) {
        int previousSlotID = this.activeSlotID;

        if(activeSlotID == slotID) {
            return;
        }

    if (this.activeSlotID != -1 && this.activeSlotID < 4) {
        this.HOT_SHAPE.getChild(this.activeSlotID).getChild(0).setFill(UI_Constants.HOTBAR_SLOT_UNSELECTED_COLOR);
        this.HOT_SHAPE.getChild(this.activeSlotID).getChild(0).setStroke(UI_Constants.HOTBAR_SLOT_UNSELECTED_STROKE);
        this.HOT_SHAPE.getChild(this.activeSlotID).getChild(1).setVisible(true);
        this.HOT_SHAPE.getChild(this.activeSlotID).getChild(2).setVisible(false);
    } else {
        this.HOT_SHAPE.getChild(this.activeSlotID).getChild(0).setFill(UI_Constants.HOTBAR_SLOT_UNSELECTED_COLOR);
        this.HOT_SHAPE.getChild(this.activeSlotID).getChild(0).setStroke(UI_Constants.HOTBAR_SLOT_UNSELECTED_STROKE);
    }

    if(slotID == -1) {
        this.activeSlotID = -1;
        return;
    } else {
        this.activeSlotID = slotID;
    }

    if(this.activeSlotID < 4) {
        this.HOT_SHAPE.getChild(slotID).getChild(0).setFill(UI_Constants.HOTBAR_SLOT_SELECTED_COLOR);
        this.HOT_SHAPE.getChild(slotID).getChild(0).setStroke(UI_Constants.HOTBAR_SLOT_SELECTED_STROKE);
        this.HOT_SHAPE.getChild(slotID).getChild(1).setVisible(false);
        this.HOT_SHAPE.getChild(slotID).getChild(2).setVisible(true);
    } else {
        this.HOT_SHAPE.getChild(slotID).getChild(0).setFill(UI_Constants.HOTBAR_SLOT_SELECTED_COLOR);
        this.HOT_SHAPE.getChild(slotID).getChild(0).setStroke(UI_Constants.HOTBAR_SLOT_SELECTED_STROKE);
    }   

    boolean resetMouseObject = 
                            ((previousSlotID == 4 || previousSlotID == 5 || previousSlotID == 6) && (this.activeSlotID != 4 && this.activeSlotID != 5 && this.activeSlotID != 6))
                            ||
                            ((previousSlotID == 2 || previousSlotID == 3) && (this.activeSlotID != 2 && this.activeSlotID != 3))
                            ;

    if(resetMouseObject) {
        Mouse.getMouseObjectResults().clear();
        UI_PropertiesForceWindow window = (UI_PropertiesForceWindow) UI_Manager.getWindowByName("Properties (forces)");
        if(window.MOUSE_SPRING_ADDED) {
            window.removeMouseSpring();
        }
    }

    UI_Window window;
    switch(this.activeSlotID) {
        case 0:
            UI_Manager.closeAllWindows();
            break;
        case 1:
            UI_Manager.closeAllWindows();
        case 2:
            window = UI_Manager.getWindowByName("Properties (rigidbody)");

            window.onSlotChange(previousSlotID);
            UI_Manager.bringToFront(window);
            //UI_Manager.repositionWindow(window);
            window.onWindowSelect();
            break;
        case 3:
            window = UI_Manager.getWindowByName("Properties (rigidbody)");

            window.onSlotChange(previousSlotID);
            UI_Manager.bringToFront(window);
            //UI_Manager.repositionWindow(window);
            window.onWindowSelect();
            break;
        case 4:
            window = UI_Manager.getWindowByName("Properties (forces)");

            window.onSlotChange(previousSlotID);
            UI_Manager.bringToFront(window);
            //UI_Manager.repositionWindow(window);
            window.onWindowSelect();
            break;
        case 5:
            window = UI_Manager.getWindowByName("Properties (forces)");

            window.onSlotChange(previousSlotID);
            UI_Manager.bringToFront(window);
            //UI_Manager.repositionWindow(window);
            window.onWindowSelect();
            break;
        case 6:
            window = UI_Manager.getWindowByName("Properties (forces)");

            window.onSlotChange(previousSlotID);
            UI_Manager.bringToFront(window);
            //UI_Manager.repositionWindow(window);
            window.onWindowSelect();
            break;
    }
    

    if(previousSlotID == 1) {
        UI_PropertiesEditorWindow win = (UI_PropertiesEditorWindow)UI_Manager.getWindowByName("Properties Editor (rigidbody)");
        win.Window_Visibility = false;
        win.inEditMode = false;
        IS_PAUSED = false;
        IS_PAUSED_LOCK = false;
    }
}

/*
=========================================== Drawing ================================================
*/

    public void drawHotbar() {
        shape(this.HOT_SHAPE);
        this.drawHotbarText();

    }

    public void drawHotbarText() {
        pushMatrix();
        translate(UI_Constants.HOTBAR_CONTAINER_POSITION_X, UI_Constants.HOTBAR_CONTAINER_POSITION_Y);
        scale(SCALE_FACTOR); 
        translate(-UI_Constants.HOTBAR_CONTAINER_POSITION_X, -UI_Constants.HOTBAR_CONTAINER_POSITION_Y);

        textFont(UI_Constants.HOTBAR_TEXT_FONT);
        textAlign(CENTER, CENTER);
        textSize(UI_Constants.HOTBAR_TEXT_SIZE);

        for(int i = 0; i < UI_Constants.HOTBAR_SLOT_COUNT; i++) {
            if(this.activeSlotID == i) {
                fill(UI_Constants.HOTBAR_LABEL_SELECTED_TEXT_COLOR);
            } else {
                fill(UI_Constants.HOTBAR_LABEL_UNSELECTED_TEXT_COLOR);
            }
            text(i + 1, this.TEXT_POSITION_X[i], this.TEXT_POSITION_Y[i]);
        }
        popMatrix();
    }

    


/*
====================================== Getters & Setters ===========================================
*/  

    public void setActiveSlotID(int slotID) {
        this.onSlotChange(slotID);
    }
    public PShape getHotbarShape() {
        return this.HOT_SHAPE;
    }

    public float[] getSlotPosition() {
        return this.SLOT_POSITION;
    }

    public float[] getTextPositionX() {
        return this.TEXT_POSITION_X;
    }

    public float[] getTextPositionY() {
        return this.TEXT_POSITION_Y;
    }

    public int getActiveSlotID() {
        return this.activeSlotID;
    }

}
