public class UI_Constants {

/*
======================================== Global Constants ==========================================
*/
    public final int BLUE_UNSELECTED = color(2, 60, 89);
    public final int BLUE_SELECTED = color(0, 123, 185);
    public final int GRAY_600 = color(22, 23, 23);
    public final int GRAY_500 = color(34, 35, 36);
    public final int GRAY_400 = color(42, 43, 43);
    public final int GRAY_300 = color(82, 82, 82);
    public final int GRAY_250 = color(107, 107, 107);
    public final int GRAY_200 = color(120, 120, 120);
    public final int GRAY_100 = color(150, 150, 150);
    public final int GRAY_PLACEHOLDER_TEXT = color(164, 164, 164);
    public final int GRAY_UNSELECTED_TEXT = color(183, 183, 183);
    public final int WHITE_TEXT = color(255, 255, 255);
    public final int TRANSPARENT = color(0, 0, 0, 0);

    public final PFont[] FONT = {createFont("Inter-Bold.ttf", 48), createFont("Inter-Medium.ttf", 48), createFont("Inter-Regular.ttf", 48)};
    public final float STROKE_WEIGHT = 1.5;

    
/*
======================================== Tab Constants =============================================
*/  
    public final float TAB_SCREENWIDTH_PERCENTAGE = 0.3f;
    public final float TAB_SCREENHEIGHT_PERCENTAGE = 0.05f;
    public final float TAB_BAR_SHAPE_PADDING_PERCENTAGE_Y = 0.025f;
    public final float TAB_BAR_SHAPE_PADDING_PERCENTAGE_X = 0.5f;

    public final int TAB_BAR_SHAPE_WIDTH;
    public final int TAB_BAR_SHAPE_HEIGHT;

    public final float TAB_BAR_SHAPE_CENTER_POSITION_X;
    public final float TAB_BAR_SHAPE_CENTER_POSITION_Y;

    public final int TAB_BAR_SHAPE_ROUNDING = 15;

/*
======================================== Tab Selector Constants ====================================
*/  
    public final float TAB_SELECTOR_HEIGHT_PERCENTAGE_OF_TAB_BAR_HEIGHT = 0.75f;
    public final float TAB_SELECTOR_HEIGHT;
    public final float TAB_SELECTOR_CENTER_POSITION_Y;

    public final int TAB_SELECTOR_ROUNDING = 7;

/*
======================================== Tab Button Constants ====================================
*/

    public final float TAB_BUTTON_PADDING_X_PERCENTAGE_OF_TAB_BAR_SHAPE_WIDTH = 0.05f;
    public final float TAB_BUTTON_PADDING_X;

    public final float TAB_BUTTON_WIDTH;
    public final float TAB_BUTTON_HEIGHT;

    public final float TAB_BUTTON_POSITION_Y;


    public final float TAB_BUTTON_Q_POSITION_X;
    public final float TAB_BUTTON_E_POSITION_X;

    public final float TAB_BUTTON_Q_TEXT_POSITION_X;
    public final float TAB_BUTTON_E_TEXT_POSITION_X;

    public final float TAB_BUTTON_TEXT_POSITION_Y;

    public final int TAB_BUTTON_ROUNDING = 15;

/*
======================================== Tab Text Constants ========================================
*/  

    public final int TAB_TEXT_SIZE;
    public final String[] TAB_NAME = {"Settings", "Properties", "Creations", "Help"};

    public final float TAB_TEXT_SIZE_PERCENTAGE_OF_TAB_BAR_HEIGHT = 0.42f;
    public final float TAB_TEXT_POSITION_Y;





/*
======================================== HotBar Constants ==========================================
*/  
    public final int HOTBAR_SLOT_COUNT = 7;
    public final float HOTBAR_TOTAL_SLOT_WIDTH;

    public final float HOTBAR_SLOT_HEIGHT;
    public final float HOTBAR_SLOT_WIDTH;

    public final float HOTBAR_CONTAINER_PADDING_PERCENTAGE_Y = 0.05f;
    public final float HOTBAR_CONTAINER_PADDING_PERCENTAGE_X = 0.5f;

    public final float HOTBAR_CONTAINER_WIDTH_PERCENTAGE_OF_SCREEN_WIDTH = 0.4f;
    public final float HOTBAR_CONTAINER_HEIGHT_PERCENTAGE_OF_SCREEN_HEIGHT = 0.075f;

    public final float HOTBAR_CONTAINER_WIDTH;
    public final float HOTBAR_CONTAINER_HEIGHT;

    public final float HOTBAR_CONTAINER_CENTER_POSITION_X;
    public final float HOTBAR_CONTAINER_CENTER_POSITION_Y;

    public final float HOTBAR_TEXT_SIZE_PERCENTAGE_OF_HOTBAR_HEIGHT = 0.175f;
    public final int HOTBAR_TEXT_SIZE;

    public final float HOTBAR_SLOT_TEXT_PADDING_PERCENTAGE_OF_HOTBAR_SLOT_WIDTH = 0.1f;
    public final float HOTBAR_SLOT_TEXT_PADDING_X;

    public final float HOTBAR_SLOT_TEXT_PADDING_PERCENTAGE_OF_HOTBAR_SLOT_HEIGHT = 0.05f;
    public final float HOTBAR_SLOT_TEXT_PADDING_Y;
    
    public final int HOTBAR_SLOT_ROUNDING = 10;




/*
======================================== Initialization ============================================
*/  

    public UI_Constants() {

    /*
    ======================================== Tab Initialization ====================================
    */
        this.TAB_BAR_SHAPE_WIDTH = (int) (width * this.TAB_SCREENWIDTH_PERCENTAGE);
        this.TAB_BAR_SHAPE_HEIGHT = (int) (height * this.TAB_SCREENHEIGHT_PERCENTAGE);

        this.TAB_BAR_SHAPE_CENTER_POSITION_Y = height * this.TAB_BAR_SHAPE_PADDING_PERCENTAGE_Y + this.TAB_BAR_SHAPE_HEIGHT/2;
        this.TAB_BAR_SHAPE_CENTER_POSITION_X = width/2;

        this.TAB_SELECTOR_HEIGHT = this.TAB_BAR_SHAPE_HEIGHT * this.TAB_SELECTOR_HEIGHT_PERCENTAGE_OF_TAB_BAR_HEIGHT;
        this.TAB_SELECTOR_CENTER_POSITION_Y = this.TAB_BAR_SHAPE_CENTER_POSITION_Y;

        this.TAB_TEXT_SIZE = (int)(this.TAB_BAR_SHAPE_HEIGHT * this.TAB_TEXT_SIZE_PERCENTAGE_OF_TAB_BAR_HEIGHT);

        this.TAB_BUTTON_PADDING_X = (this.TAB_BAR_SHAPE_WIDTH * this.TAB_BUTTON_PADDING_X_PERCENTAGE_OF_TAB_BAR_SHAPE_WIDTH);
        this.TAB_TEXT_POSITION_Y = this.TAB_BAR_SHAPE_CENTER_POSITION_Y;
    

        this.TAB_BUTTON_HEIGHT = this.TAB_BAR_SHAPE_HEIGHT;
        this.TAB_BUTTON_WIDTH = this.TAB_BAR_SHAPE_HEIGHT;
        this.TAB_BUTTON_POSITION_Y = this.TAB_BAR_SHAPE_CENTER_POSITION_Y;
        this.TAB_BUTTON_Q_POSITION_X = this.TAB_BAR_SHAPE_CENTER_POSITION_X - this.TAB_BAR_SHAPE_WIDTH/2 - this.TAB_BUTTON_WIDTH/2 - this.TAB_BUTTON_PADDING_X;
        this.TAB_BUTTON_E_POSITION_X = this.TAB_BAR_SHAPE_CENTER_POSITION_X + this.TAB_BAR_SHAPE_WIDTH/2 + this.TAB_BUTTON_WIDTH/2 + this.TAB_BUTTON_PADDING_X;

        this.TAB_BUTTON_Q_TEXT_POSITION_X = this.TAB_BUTTON_Q_POSITION_X;
        this.TAB_BUTTON_E_TEXT_POSITION_X = this.TAB_BUTTON_E_POSITION_X;

        this.TAB_BUTTON_TEXT_POSITION_Y = this.TAB_BAR_SHAPE_CENTER_POSITION_Y;

        
        /*
        ======================================== HotBar Initialization =============================
        */
        this.HOTBAR_CONTAINER_WIDTH = width * this.HOTBAR_CONTAINER_WIDTH_PERCENTAGE_OF_SCREEN_WIDTH;
        this.HOTBAR_CONTAINER_HEIGHT = height * this.HOTBAR_CONTAINER_HEIGHT_PERCENTAGE_OF_SCREEN_HEIGHT;

        this.HOTBAR_CONTAINER_CENTER_POSITION_X = width * this.HOTBAR_CONTAINER_PADDING_PERCENTAGE_X;
        this.HOTBAR_CONTAINER_CENTER_POSITION_Y = height * (1 - this.HOTBAR_CONTAINER_PADDING_PERCENTAGE_Y) - this.HOTBAR_CONTAINER_HEIGHT/2;

        this.HOTBAR_SLOT_HEIGHT = this.HOTBAR_CONTAINER_HEIGHT;
        this.HOTBAR_SLOT_WIDTH = this.HOTBAR_CONTAINER_HEIGHT;

        this.HOTBAR_TOTAL_SLOT_WIDTH = this.HOTBAR_SLOT_WIDTH * this.HOTBAR_SLOT_COUNT;

        this.HOTBAR_TEXT_SIZE = (int)(this.HOTBAR_CONTAINER_HEIGHT * this.HOTBAR_TEXT_SIZE_PERCENTAGE_OF_HOTBAR_HEIGHT);

        this.HOTBAR_SLOT_TEXT_PADDING_X = this.HOTBAR_SLOT_WIDTH * this.HOTBAR_SLOT_TEXT_PADDING_PERCENTAGE_OF_HOTBAR_SLOT_WIDTH;
        this.HOTBAR_SLOT_TEXT_PADDING_Y = this.HOTBAR_SLOT_HEIGHT * this.HOTBAR_SLOT_TEXT_PADDING_PERCENTAGE_OF_HOTBAR_SLOT_HEIGHT;
    }
}
