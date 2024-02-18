public class UserInterfaceTabObject {

    private UserInterfaceDraw uiDraw = new UserInterfaceDraw();

    /*------------------------------ Tab Graphics --------------------------------*/
    private PShape TabShape;
    private String[] TabNames = {"Settings", "Properties", "Creations", "Help"};
    private float[] textWidths;
    private float[] textPositions;
    private float[] tabSelectorPositions;
    private float padding;
    private int activeTabID = 0;
    private float easing = 0.5f;

    public void createTabGraphics() {
        this.TabShape = uiDraw.GetTabShape();
        this.setupTabText();
    }

    public void drawTabGraphics() {
        shape(this.TabShape, 0, 0);
        this.drawTabText();
        this.updateTabSelector();
        textSize(10);
    }

    public void setupTabText() {
        textSize(uiDraw.TAB_TEXT_SIZE);
        // Calculate the width of each text item
        this.textWidths = new float[TabNames.length];
        this.textPositions = new float[TabNames.length];
        this.tabSelectorPositions = new float[TabNames.length];
        float totalTextWidth = 0;
        for (int i = 0; i < TabNames.length; i++) {
            textWidths[i] = textWidth(TabNames[i]);
            totalTextWidth += textWidths[i];
        }
        float totalPaddingWidth = uiDraw.TAB_BACKGROUND_SHAPE_WIDTH - totalTextWidth - 2 * uiDraw.TAB_TEXT_X_PADDING;
        this.padding = totalPaddingWidth / (TabNames.length - 1);

        float x = uiDraw.TAB_TEXT_X_PADDING + uiDraw.TAB_BACKGROUND_SHAPE_X_PADDING; // uiDraw.TAB_TEXT_X_PADDING + 

        for (int i = 0; i < textWidths.length; i++) {
            this.textPositions[i] = x;
            float textCenterX = x + textWidths[i] / 2;
            this.tabSelectorPositions[i] = textCenterX - uiDraw.TAB_SELECTOR_WIDTH / 2;
            x += textWidths[i] + padding;
        }
    }

    public void drawTabText() {
        fill(255);
        textAlign(CENTER, CENTER);
        textSize(uiDraw.TAB_TEXT_SIZE);
        text("Q", uiDraw.TAB_Q_BUTTON_X_PADDING + uiDraw.TAB_Q_BUTTON_WIDTH/2, uiDraw.TAB_Q_BUTTON_Y_PADDING + uiDraw.TAB_Q_BUTTON_HEIGHT/2);
        text("E", uiDraw.TAB_E_BUTTON_X_PADDING + uiDraw.TAB_E_BUTTON_WIDTH/2, uiDraw.TAB_E_BUTTON_Y_PADDING + uiDraw.TAB_E_BUTTON_HEIGHT/2);
        textAlign(LEFT, CENTER);
        for(int i = 0; i < TabNames.length; i++) {
            text(TabNames[i], textPositions[i], uiDraw.TAB_BACKGROUND_SHAPE_Y_PADDING + uiDraw.TAB_BACKGROUND_SHAPE_HEIGHT/2);
        }
    }

/*
    public void updateTabSelector() {
        PShape Tab_Selector = this.TabShape.getChild("Tab_Selector");

        float targetX = this.tabSelectorPositions[this.currentTabID];

        float currentX = Tab_Selector.getParams()[0];
        float newX = lerp(currentX, targetX, easing);

        Tab_Selector.resetMatrix();
        Tab_Selector.translate(newX, 0);
    }
    */


public void updateTabSelector() {
    PShape Tab_Selector = this.TabShape.getChild("Tab_Selector");

    float currentWidth = uiDraw.TAB_SELECTOR_WIDTH;
    float textWidth = textWidth(TabNames[this.activeTabID]);
    float targetWidth = textWidth + 40;
    
    float newWidth = targetWidth;
    float scaleFactor = newWidth / currentWidth;
    
    float adjustment = (newWidth - currentWidth) / 2;
    
    Tab_Selector.resetMatrix();
    Tab_Selector.translate(this.tabSelectorPositions[this.activeTabID] - adjustment, 0);
    Tab_Selector.scale(scaleFactor, 1);

}
    
    public PShape getTabShape() {
        return this.TabShape;
    }

    public int getActiveTabID() {
        return this.activeTabID;
    }

    public void setActiveTabID(int id) {
        this.activeTabID = id;
    }
}
