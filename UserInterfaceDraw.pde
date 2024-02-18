public class UserInterfaceDraw {

    public int TAB_TEXT_SIZE = 25;
    public int TAB_BUTTON_X_PADDING = 5;
    public int TAB_TEXT_X_PADDING = 100;
    public int TAB_TEXT_Y_PADDING;
    public float TAB_WIDTH_PERCENTAGE = 0.3f;
    public float TAB_HEIGHT_PERCENTAGE = 0.05f;
    
    
    public int TAB_BACKGROUND_SHAPE_WIDTH;
    public int TAB_BACKGROUND_SHAPE_HEIGHT;

    public int TAB_BACKGROUND_SHAPE_Y_PADDING = 20;
    public int TAB_BACKGROUND_SHAPE_X_PADDING;
    public int TAB_BACKGROUND_SHAPE_ROUNDING = 10;

    public int TAB_Q_BUTTON_WIDTH;
    public int TAB_Q_BUTTON_HEIGHT;
    public int TAB_Q_BUTTON_Y_PADDING;
    public int TAB_Q_BUTTON_X_PADDING;
    public int TAB_Q_BUTTON_ROUNDING = 10;

    public int TAB_E_BUTTON_WIDTH;
    public int TAB_E_BUTTON_HEIGHT;
    public int TAB_E_BUTTON_Y_PADDING;
    public int TAB_E_BUTTON_X_PADDING;
    public int TAB_E_BUTTON_ROUNDING = 10;

    public float TAB_SELECTOR_WIDTH;
    public float TAB_SELECTOR_HEIGHT;






    public final color BLUE_UNSELECTED = color(2, 60, 89);
    public final color BLUE_SELECTED = color(0, 123, 185);
    public final color WINDOW_BACKGROUND_COLOR = color(16, 18, 19);
    public final color UI_GROUP_BACKGROUND_COLOR = color(22, 23, 23);
    public final color UI_ELEMENT_BACKGROUND_UNSELECTED_COLOR = color(34, 35, 36); //For sliders as an example
    public final color UI_ELEMENT_SELECTED_COLOR = color(82, 82, 82);
    public final color UI_ELEMENT_UNSELECTED_HOVER_COLOR = color(120, 120, 120);
    public final color UI_ELEMENT_UNSELECTED_OUTLINE_COLOR = color(44, 44, 47);





    public PShape GetTabShape() {
        int TAB_BACKGROUND_SHAPE_WIDTH = (int) (width * TAB_WIDTH_PERCENTAGE);
        int TAB_BACKGROUND_SHAPE_HEIGHT = (int) (height * TAB_HEIGHT_PERCENTAGE);
        int TAB_BACKGROUND_SHAPE_X_PADDING = width/2 - TAB_BACKGROUND_SHAPE_WIDTH/2;
        this.TAB_BACKGROUND_SHAPE_WIDTH = TAB_BACKGROUND_SHAPE_WIDTH;
        this.TAB_BACKGROUND_SHAPE_HEIGHT = TAB_BACKGROUND_SHAPE_HEIGHT;
        this.TAB_BACKGROUND_SHAPE_X_PADDING = TAB_BACKGROUND_SHAPE_X_PADDING;
        this.TAB_BACKGROUND_SHAPE_ROUNDING = TAB_BACKGROUND_SHAPE_ROUNDING;

        int TAB_Q_BUTTON_WIDTH = TAB_BACKGROUND_SHAPE_HEIGHT;
        int TAB_Q_BUTTON_HEIGHT = TAB_BACKGROUND_SHAPE_HEIGHT;
        int TAB_Q_BUTTON_Y_PADDING = TAB_BACKGROUND_SHAPE_Y_PADDING;
        int TAB_Q_BUTTON_X_PADDING = TAB_BACKGROUND_SHAPE_X_PADDING - TAB_Q_BUTTON_WIDTH - TAB_BUTTON_X_PADDING;
        this.TAB_Q_BUTTON_WIDTH = TAB_Q_BUTTON_WIDTH;
        this.TAB_Q_BUTTON_HEIGHT = TAB_Q_BUTTON_HEIGHT;
        this.TAB_Q_BUTTON_Y_PADDING = TAB_Q_BUTTON_Y_PADDING;
        this.TAB_Q_BUTTON_X_PADDING = TAB_Q_BUTTON_X_PADDING;

        int TAB_E_BUTTON_WIDTH = TAB_BACKGROUND_SHAPE_HEIGHT;
        int TAB_E_BUTTON_HEIGHT = TAB_BACKGROUND_SHAPE_HEIGHT;
        int TAB_E_BUTTON_Y_PADDING = TAB_BACKGROUND_SHAPE_Y_PADDING;
        int TAB_E_BUTTON_X_PADDING = TAB_BACKGROUND_SHAPE_X_PADDING + TAB_BACKGROUND_SHAPE_WIDTH + TAB_BUTTON_X_PADDING;
        this.TAB_E_BUTTON_WIDTH = TAB_E_BUTTON_WIDTH;
        this.TAB_E_BUTTON_HEIGHT = TAB_E_BUTTON_HEIGHT;
        this.TAB_E_BUTTON_Y_PADDING = TAB_E_BUTTON_Y_PADDING;
        this.TAB_E_BUTTON_X_PADDING = TAB_E_BUTTON_X_PADDING;

        int TAB_TEXT_X_PADDING = TAB_BACKGROUND_SHAPE_HEIGHT/2;
        int TAB_TEXT_Y_PADDING = TAB_BACKGROUND_SHAPE_Y_PADDING + TAB_BACKGROUND_SHAPE_HEIGHT/2;
        this.TAB_TEXT_X_PADDING = TAB_TEXT_X_PADDING;
        this.TAB_TEXT_Y_PADDING = TAB_TEXT_Y_PADDING;

        float TAB_SELECTOR_WIDTH = TAB_BACKGROUND_SHAPE_WIDTH/4;
        float TAB_SELECTOR_HEIGHT = TAB_BACKGROUND_SHAPE_HEIGHT * 0.8;
        this.TAB_SELECTOR_WIDTH = TAB_SELECTOR_WIDTH;
        this.TAB_SELECTOR_HEIGHT = TAB_SELECTOR_HEIGHT;




        PShape TAB_SHAPE = createShape(RECT, TAB_BACKGROUND_SHAPE_X_PADDING, TAB_BACKGROUND_SHAPE_Y_PADDING, 
                                             TAB_BACKGROUND_SHAPE_WIDTH, TAB_BACKGROUND_SHAPE_HEIGHT, 
                                             TAB_BACKGROUND_SHAPE_ROUNDING);
            TAB_SHAPE.setName("TAB_SHAPE");
            TAB_SHAPE.setFill(this.UI_GROUP_BACKGROUND_COLOR);
            TAB_SHAPE.setStroke(this.UI_ELEMENT_UNSELECTED_OUTLINE_COLOR);
            TAB_SHAPE.setStrokeWeight(1.5);

        PShape Q = createShape(RECT, TAB_Q_BUTTON_X_PADDING, TAB_Q_BUTTON_Y_PADDING, 
                                  TAB_Q_BUTTON_WIDTH, TAB_Q_BUTTON_HEIGHT, 
                                  TAB_Q_BUTTON_ROUNDING);
            Q.setName("Q_Button");
            Q.setFill(this.UI_GROUP_BACKGROUND_COLOR);
            Q.setStroke(this.UI_ELEMENT_UNSELECTED_OUTLINE_COLOR);
            Q.setStrokeWeight(1.5);

        PShape E = createShape(RECT, TAB_E_BUTTON_X_PADDING, TAB_E_BUTTON_Y_PADDING, 
                                  TAB_E_BUTTON_WIDTH, TAB_E_BUTTON_HEIGHT, 
                                  TAB_E_BUTTON_ROUNDING);
            E.setName("E_Button");
            E.setFill(this.UI_GROUP_BACKGROUND_COLOR);
            E.setStroke(this.UI_ELEMENT_UNSELECTED_OUTLINE_COLOR);
            E.setStrokeWeight(1.5);
        PShape TabSelectorShape = createShape(RECT, 0, TAB_BACKGROUND_SHAPE_Y_PADDING + TAB_BACKGROUND_SHAPE_HEIGHT * 0.1, 
                                             TAB_BACKGROUND_SHAPE_WIDTH/4, TAB_BACKGROUND_SHAPE_HEIGHT * 0.8, 
                                             TAB_BACKGROUND_SHAPE_ROUNDING);
            TabSelectorShape.setName("Tab_Selector");
            TabSelectorShape.setFill(this.BLUE_SELECTED);
            TabSelectorShape.setStroke(this.BLUE_SELECTED);
    
        PShape TAB_PARENT = createShape(GROUP);
            TAB_PARENT.addChild(TAB_SHAPE);
            TAB_PARENT.addChild(Q);
            TAB_PARENT.addChild(E);
            TAB_PARENT.addChild(TabSelectorShape);

        return TAB_PARENT;
    }

    public void GetUpdatedToggleStateShape(PShape toggle, boolean state) {
        if(state) {
            toggle.setFill(this.UI_ELEMENT_SELECTED_COLOR);
        } else {
            toggle.setFill(this.UI_ELEMENT_BACKGROUND_UNSELECTED_COLOR);
        }
    }

    public PShape GetToggleShape(int width, int height) {
        PShape toggle = createShape(RECT, 0, 0, width, height, 3);
        toggle.setFill(this.UI_ELEMENT_BACKGROUND_UNSELECTED_COLOR);
        toggle.setStroke(UI_ELEMENT_UNSELECTED_OUTLINE_COLOR);
        return toggle;
    }
}
