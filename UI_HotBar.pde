public class UI_HotBar {


    private PShape HOT_SHAPE;
    private float[] TEXT_POSITION_X;
    private float[] TEXT_POSITION_Y;

    private float[] SLOT_POSITION;

    private int activeSlotID;


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
        textAlign(CENTER, CENTER);
        textSize(UI_Constants.TAB_TEXT_SIZE);
        rectMode(CENTER);
        blendMode(BLEND);

        this.SLOT_POSITION = new float[UI_Constants.HOTBAR_SLOT_COUNT];
        this.TEXT_POSITION_X = new float[UI_Constants.HOTBAR_SLOT_COUNT];
        this.TEXT_POSITION_Y = new float[UI_Constants.HOTBAR_SLOT_COUNT];


        this.HOT_SHAPE = createShape(GROUP);
            this.HOT_SHAPE.setName("HOTBAR");


        float totalPadding = UI_Constants.HOTBAR_CONTAINER_WIDTH - UI_Constants.HOTBAR_TOTAL_SLOT_WIDTH;
        float padding = totalPadding / (UI_Constants.HOTBAR_SLOT_COUNT + 1);

        float startX = UI_Constants.HOTBAR_CONTAINER_CENTER_POSITION_X - UI_Constants.HOTBAR_CONTAINER_WIDTH / 2;

        for(int i = 0; i < UI_Constants.HOTBAR_SLOT_COUNT; i++) {
            float xPos = startX + i * (padding + UI_Constants.HOTBAR_SLOT_WIDTH) + UI_Constants.HOTBAR_SLOT_WIDTH;
            float yPos = UI_Constants.HOTBAR_CONTAINER_CENTER_POSITION_Y;

            SLOT_POSITION[i] = xPos;

            PShape SLOT = createShape(RECT, xPos, yPos, UI_Constants.HOTBAR_SLOT_WIDTH, 
                                                        UI_Constants.HOTBAR_SLOT_HEIGHT, 
                                                        UI_Constants.HOTBAR_SLOT_ROUNDING);

                if(i == this.activeSlotID) {
                    SLOT.setFill(UI_Constants.BLUE_UNSELECTED);
                    SLOT.setStroke(UI_Constants.BLUE_SELECTED);
                } else {
                    SLOT.setFill(UI_Constants.GRAY_600);
                    SLOT.setStroke(UI_Constants.GRAY_400);
                }

                SLOT.setStrokeWeight(1.5);

            this.HOT_SHAPE.addChild(SLOT);
        }

        this.initializeText();
    }


    public void initializeText() {
        textSize(UI_Constants.HOTBAR_TEXT_SIZE);
        textAlign(CENTER, CENTER);

        for(int i = 0; i < UI_Constants.HOTBAR_SLOT_COUNT; i++) {
            float textEdgePadding = UI_Constants.HOTBAR_SLOT_WIDTH / 2 - textWidth(String.valueOf(i + 1)) / 2 - UI_Constants.HOTBAR_SLOT_TEXT_PADDING_PERCENTAGE_OF_HOTBAR_SLOT_WIDTH * UI_Constants.HOTBAR_SLOT_WIDTH;
            float textXPos = this.SLOT_POSITION[i] + textEdgePadding;
            float textYPos = UI_Constants.HOTBAR_CONTAINER_CENTER_POSITION_Y + textEdgePadding;

            this.TEXT_POSITION_X[i] = textXPos;
            this.TEXT_POSITION_Y[i] = textYPos;
        }



    }




/*
====================================== Element Updates =============================================
*/

    public void onSlotChange(int slotID) {
        this.HOT_SHAPE.getChild(this.activeSlotID).setFill(UI_Constants.GRAY_600);
        this.HOT_SHAPE.getChild(this.activeSlotID).setStroke(UI_Constants.GRAY_400);

        if(slotID == -1) {
            this.activeSlotID = -1;
            return;
        }

        this.activeSlotID = slotID;

        this.HOT_SHAPE.getChild(slotID).setFill(UI_Constants.BLUE_UNSELECTED);
        this.HOT_SHAPE.getChild(slotID).setStroke(UI_Constants.BLUE_SELECTED);
    }


/*
=========================================== Drawing ================================================
*/

    public void drawHotbar() {
        shape(this.HOT_SHAPE);
        this.drawHotbarText();
    }


    public void drawHotbarText() {
        textSize(UI_Constants.HOTBAR_TEXT_SIZE);
        textAlign(CENTER, CENTER);

        for(int i = 0; i < UI_Constants.HOTBAR_SLOT_COUNT; i++) {
            text(i + 1, this.TEXT_POSITION_X[i], this.TEXT_POSITION_Y[i]);
        }

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
