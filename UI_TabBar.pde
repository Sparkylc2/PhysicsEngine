public class UI_TabBar {


    private PShape TAB_SHAPE;
    private final String[] TAB_NAME = {"Settings", "Properties", "Creations", "Help"};
    private PShape[] TAB_SELECTOR;
    private float[] TEXT_POSITION;
    private float TEXT_POSITION_Y;
    private float BUTTON_TEXT_POSITION_Y;
    private float SCALE_FACTOR = width/1512f;
    private int activeTabID = 0;



    public UI_TabBar() {
        textFont(UI_Constants.FONT[0]);
        textAlign(CENTER, CENTER);
        textSize(UI_Constants.TAB_TEXT_SIZE);
        this.TEXT_POSITION_Y = UI_Constants.TAB_TEXT_POSITION_Y - (textAscent() - textDescent()) / 8;

        textFont(UI_Constants.FONT[2]);
        textAlign(CENTER, CENTER);
        textSize(UI_Constants.TAB_TEXT_SIZE);
        this.BUTTON_TEXT_POSITION_Y = UI_Constants.TAB_BUTTON_TEXT_POSITION_Y - (textAscent() - textDescent()) / 8;
        this.initializeTabBar();
    }

    public void draw() {
        this.drawTabGraphics();
    }


/*
=========================================== Initialization =========================================
*/
    public void initializeTabBar() {   

        rectMode(CENTER);

        this.TEXT_POSITION = new float[UI_Constants.TAB_NAME.length];
        this.TAB_SELECTOR = new PShape[UI_Constants.TAB_NAME.length];


        PShape TAB_SHAPE = createShape(RECT, UI_Constants.TAB_BAR_SHAPE_CENTER_POSITION_X, 
                                             UI_Constants.TAB_BAR_SHAPE_CENTER_POSITION_Y,
                                             UI_Constants.TAB_BAR_SHAPE_WIDTH, 
                                             UI_Constants.TAB_BAR_SHAPE_HEIGHT, 
                                             UI_Constants.TAB_BAR_SHAPE_ROUNDING);
            TAB_SHAPE.setName("TAB_SHAPE");
            TAB_SHAPE.setFill(UI_Constants.GRAY_600);
            TAB_SHAPE.setStroke(UI_Constants.GRAY_400);
            TAB_SHAPE.setStrokeWeight(1.5);


        PShape Q = createShape(RECT, UI_Constants.TAB_BUTTON_Q_POSITION_X,
                                     UI_Constants.TAB_BUTTON_POSITION_Y,
                                     UI_Constants.TAB_BUTTON_WIDTH,
                                     UI_Constants.TAB_BUTTON_HEIGHT,
                                     UI_Constants.TAB_BUTTON_ROUNDING);
            Q.setName("Q_Button");
            Q.setFill(UI_Constants.GRAY_600);
            Q.setStroke(UI_Constants.GRAY_400);
            Q.setStrokeWeight(1.5);


        PShape E = createShape(RECT, UI_Constants.TAB_BUTTON_E_POSITION_X,
                                     UI_Constants.TAB_BUTTON_POSITION_Y,
                                     UI_Constants.TAB_BUTTON_WIDTH,
                                     UI_Constants.TAB_BUTTON_HEIGHT,
                                     UI_Constants.TAB_BUTTON_ROUNDING);
            E.setName("E_Button");
            E.setFill(UI_Constants.GRAY_600);
            E.setStroke(UI_Constants.GRAY_400);
            E.setStrokeWeight(1.5);


        PShape TAB_SELECTOR_GROUP = createShape(GROUP);
            TAB_SELECTOR_GROUP.setName("TAB_SELECTOR_GROUP");



        this.TAB_SHAPE = createShape(GROUP);
            this.TAB_SHAPE.addChild(TAB_SHAPE);
            this.TAB_SHAPE.addChild(Q);
            this.TAB_SHAPE.addChild(E);
            this.TAB_SHAPE.addChild(TAB_SELECTOR_GROUP);

        this.TAB_SHAPE.translate(UI_Constants.TAB_BAR_SHAPE_CENTER_POSITION_X, UI_Constants.TAB_BAR_SHAPE_CENTER_POSITION_Y - UI_Constants.TAB_BAR_SHAPE_PADDING_Y);
        this.TAB_SHAPE.scale(SCALE_FACTOR);
        this.TAB_SHAPE.translate(-UI_Constants.TAB_BAR_SHAPE_CENTER_POSITION_X, -UI_Constants.TAB_BAR_SHAPE_CENTER_POSITION_Y + UI_Constants.TAB_BAR_SHAPE_PADDING_Y);
        this.initializeTextAndTabSelector();
    }


    public void initializeTextAndTabSelector() {
        textFont(UI_Constants.FONT[0]);
        textAlign(CENTER, CENTER);
        textSize(UI_Constants.TAB_TEXT_SIZE);

        float totalTextWidth = 0;
        for(String text: UI_Constants.TAB_NAME) {
            totalTextWidth += textWidth(text);
        
        }

        float padding = (UI_Constants.TAB_BAR_SHAPE_WIDTH - totalTextWidth) / (UI_Constants.TAB_NAME.length + 1);
        float x = padding + UI_Constants.TAB_BAR_SHAPE_CENTER_POSITION_X - UI_Constants.TAB_BAR_SHAPE_WIDTH / 2;

        for(int i = 0; i < UI_Constants.TAB_NAME.length; i++) {
            String text = UI_Constants.TAB_NAME[i];

            float textPositionX = x + textWidth(text) / 2;
            float tabSelectorWidthPadding = padding;

            PShape TabSelectorShape = createShape(RECT, textPositionX, UI_Constants.TAB_BAR_SHAPE_CENTER_POSITION_Y, 
                                                        textWidth(text) + tabSelectorWidthPadding, UI_Constants.TAB_SELECTOR_HEIGHT,
                                                        UI_Constants.TAB_BAR_SHAPE_ROUNDING);

            TabSelectorShape.setFill(UI_Constants.BLUE_SELECTED);
            TabSelectorShape.setStroke(false);


            this.TAB_SELECTOR[i] = TabSelectorShape;
            this.TEXT_POSITION[i] = (textPositionX);

            x += textWidth(text) + padding;
        }

        this.initializeTabSelector();
    }


    public void initializeTabSelector() {
        PShape TAB_SELECTOR_GROUP = this.TAB_SHAPE.getChild("TAB_SELECTOR_GROUP");
        TAB_SELECTOR_GROUP.addChild(this.TAB_SELECTOR[this.activeTabID]);
    }
/*
====================================== Element Updates =============================================
*/

    public void handleActiveTabIDChangesFromKeyPress(int newActiveTabID) {
        this.activeTabID = (newActiveTabID < 0) ? this.TAB_NAME.length - 1 : (newActiveTabID >= this.TAB_NAME.length) ? 0 : newActiveTabID;
        this.updateTabSelector();
    }
    public void onQPressed() {
        PShape Q_Shape = this.TAB_SHAPE.getChild("Q_Button");
        Q_Shape.setFill(UI_Constants.GRAY_300);
        this.handleActiveTabIDChangesFromKeyPress(this.activeTabID - 1);
    }

    public void onQReleased() {
        PShape Q_Shape = this.TAB_SHAPE.getChild("Q_Button");
        Q_Shape.setFill(UI_Constants.GRAY_600);
    }

    public void onEPressed() {
        PShape E_Shape = this.TAB_SHAPE.getChild("E_Button");
        E_Shape.setFill(UI_Constants.GRAY_300);
        this.handleActiveTabIDChangesFromKeyPress(this.activeTabID + 1);
    }

    public void onEReleased() {
        PShape E_Shape = this.TAB_SHAPE.getChild("E_Button");
        E_Shape.setFill(UI_Constants.GRAY_600);
    }

    
    public void updateTabSelector() {
        this.TAB_SHAPE.getChild("TAB_SELECTOR_GROUP").removeChild(0);
        this.TAB_SHAPE.getChild("TAB_SELECTOR_GROUP").addChild(this.TAB_SELECTOR[this.activeTabID]);
    }



/*
=========================================== Drawing ================================================
*/
    public void drawTabText() {
        pushMatrix();
        translate(UI_Constants.TAB_BAR_SHAPE_CENTER_POSITION_X, UI_Constants.TAB_BAR_SHAPE_CENTER_POSITION_Y - UI_Constants.TAB_BAR_SHAPE_PADDING_Y);
        scale(SCALE_FACTOR);
        translate(-UI_Constants.TAB_BAR_SHAPE_CENTER_POSITION_X, -UI_Constants.TAB_BAR_SHAPE_CENTER_POSITION_Y + UI_Constants.TAB_BAR_SHAPE_PADDING_Y);
        fill(255);

        textFont(UI_Constants.FONT[2]);
        textAlign(CENTER, CENTER);
        textSize(UI_Constants.TAB_TEXT_SIZE);
        text("Q", UI_Constants.TAB_BUTTON_Q_POSITION_X, this.BUTTON_TEXT_POSITION_Y);
        text("E", UI_Constants.TAB_BUTTON_E_POSITION_X, this.BUTTON_TEXT_POSITION_Y);

        textFont(UI_Constants.FONT[0]);
        textAlign(CENTER, CENTER);
        textSize(UI_Constants.TAB_TEXT_SIZE);
        for(int i = 0; i < UI_Constants.TAB_NAME.length; i++) {
            text(UI_Constants.TAB_NAME[i], this.TEXT_POSITION[i], this.TEXT_POSITION_Y);
        }
        popMatrix();
    }

    public void drawTabGraphics() {
        shape(this.TAB_SHAPE, 0, 0);
        this.drawTabText();
    }

/*
=========================================== Getters and Setters ====================================
*/
    public PShape getTabShape() {
        return this.TAB_SHAPE;
    }

    public int getActiveTabID() {
        return this.activeTabID;
    }

    public void setActiveTabID(int id) {
        this.activeTabID = id;
        updateTabSelector();
    }
}

