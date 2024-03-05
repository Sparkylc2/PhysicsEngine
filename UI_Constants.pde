public class UI_Constants {
/*---------------------------------------- Color -------------------------------------------------*/
    public final int BLUE_UNSELECTED = color(2, 60, 89);
    public final int BLUE_SELECTED = color(0, 123, 185);
    public final int GRAY_600 = color(22, 23, 23);
    public final int GRAY_500 = color(34, 35, 36);
    public final int GRAY_400 = color(44, 44, 47);
    public final int GRAY_300 = color(82, 82, 82);
    public final int GRAY_250 = color(107, 107, 107);
    public final int GRAY_200 = color(120, 120, 120);
    public final int GRAY_150 = color(158, 158, 158);
    public final int GRAY_100 = color(164, 164, 164);
    public final int GRAY_50 = color(176, 176, 176);
    public final int GRAY_25 = color(183, 183, 183);
    public final int GRAY_10 = color(196, 196, 196);
    public final int WHITE = color(255, 255, 255);
    public final int TRANSPARENT = color(0, 0, 0, 0);

/*---------------------------------------- Font -------------------------------------------------*/
    public final PFont INTER_BOLD = createFont(sketchPath() + "/data/fonts/Inter-Bold.ttf", 48, TEXT_SMOOTHING);
    public final PFont INTER_MEDIUM = createFont(sketchPath() + "/data/fonts/Inter-Medium.ttf", 48, TEXT_SMOOTHING);
    public final PFont INTER_REGULAR = createFont(sketchPath() + "/data/fonts/Inter-Regular.ttf", 48, TEXT_SMOOTHING);

    // public final PFont INTER_BOLD = createFont(sketchPath() + "/data/fonts/Inter-Bold.ttf", 48, this.SMOOTHING);
    // public final PFont INTER_MEDIUM = createFont(sketchPath() + "/data/fonts/Inter-Medium.ttf", 48, this.SMOOTHING);
    // public final PFont INTER_REGULAR = createFont(sketchPath() + "/data/fonts/Inter-Regular.ttf", 48, this.SMOOTHING);

    public final PFont[] FONTS = {INTER_BOLD, INTER_MEDIUM, INTER_REGULAR};

/*------------------------------------------ Tab -------------------------------------------------*/
    public final float TAB_WIDTH = 355;
    public final float TAB_HEIGHT = 40; 

    public final float TAB_PADDING_Y = 12;
    public final float TAB_POSITION_X = displayWidth / 2;

    public final float TAB_POSITION_Y = TAB_PADDING_Y + TAB_HEIGHT / 2;

    public final int TAB_ROUNDING = 15;
    public final int TAB_FILL = GRAY_600;
    public final int TAB_STROKE = GRAY_400;

    public final int TAB_TEXT_SIZE = 16;
    public final String[] TAB_NAME = {"Settings", "Properties", "Creations", "Help"};
    public final PFont TAB_TEXT_FONT = INTER_BOLD;

    public final int TAB_TEXT_SELECTED_COLOR = WHITE;
    public final int TAB_TEXT_UNSELECTED_COLOR = GRAY_50;

    public final float TAB_STROKE_WEIGHT = 1.5;


/*-------------------------------------- Tab Buttons ---------------------------------------------*/

    public final float TAB_BUTTON_WIDTH = 40;
    public final float TAB_BUTTON_HEIGHT = 40;

    public final float TAB_BUTTON_PADDING_X = 5;
    public final float TAB_BUTTON_POSITION_Y = TAB_POSITION_Y;

    public final float TAB_BUTTON_Q_POSITION_X = TAB_POSITION_X - TAB_WIDTH / 2 - TAB_BUTTON_WIDTH / 2 - TAB_BUTTON_PADDING_X;
    public final float TAB_BUTTON_E_POSITION_X = TAB_POSITION_X + TAB_WIDTH / 2 + TAB_BUTTON_WIDTH / 2 + TAB_BUTTON_PADDING_X;

    public final int TAB_BUTTON_ROUNDING = 15;

    public final int TAB_BUTTON_UNSELECTED_FILL = GRAY_600;
    public final int TAB_BUTTON_UNSELECTED_STROKE = GRAY_400;

    public final int TAB_BUTTON_SELECTED_FILL = GRAY_300;
    public final int TAB_BUTTON_SELECTED_STROKE = GRAY_400;

    public final float TAB_BUTTON_STROKE_WEIGHT = 1.5;

    public final int TAB_BUTTON_TEXT_SIZE = 16;
    public final PFont TAB_BUTTON_TEXT_FONT = INTER_REGULAR;
    public final int TAB_BUTTON_TEXT_COLOR = GRAY_50;

/*-------------------------------------- Tab Selector ---------------------------------------------*/
    public final float TAB_SELECTOR_HEIGHT = 26;
    public final float TAB_SELECTOR_POSITION_Y = TAB_POSITION_Y;
    public final int TAB_SELECTOR_ROUNDING = 7;

    public final int TAB_SELECTOR_FILL = BLUE_SELECTED;
    public final boolean TAB_SELECTOR_STROKE = false;


/*-------------------------------------- HotBar ---------------------------------------------------*/
    public final int HOTBAR_SLOT_COUNT = 7;

    public final float HOTBAR_SLOT_WIDTH = 69;
    public final float HOTBAR_SLOT_HEIGHT = 69;

    public final float HOTBAR_CONTAINER_WIDTH = 567;
    public final float HOTBAR_CONTAINER_HEIGHT = 69;

    public final float HOTBAR_TOTAL_SLOT_WIDTH = HOTBAR_SLOT_WIDTH * HOTBAR_SLOT_COUNT;

    public final float HOTBAR_CONTAINER_POSITION_X = displayWidth / 2;

    public final float HOTBAR_CONTAINER_POSITION_Y;

    public final int HOTBAR_SLOT_ROUNDING = 10;

    public final int HOTBAR_SLOT_UNSELECTED_COLOR = GRAY_600;
    public final int HOTBAR_SLOT_UNSELECTED_STROKE = GRAY_400;

    public final int HOTBAR_SLOT_SELECTED_COLOR = BLUE_UNSELECTED;
    public final int HOTBAR_SLOT_SELECTED_STROKE = BLUE_SELECTED;

    public final float HOTBAR_STROKE_WEIGHT = 1.5;

    public final int HOTBAR_TEXT_SIZE = 16;
    public final float HOTBAR_TEXT_PADDING_X = 6;
    public final float HOTBAR_TEXT_PADDING_Y = 6;
    public final PFont HOTBAR_TEXT_FONT = INTER_BOLD;

    public final int HOTBAR_LABEL_UNSELECTED_TEXT_COLOR = GRAY_50;
    public final int HOTBAR_LABEL_SELECTED_TEXT_COLOR = WHITE;

/*------------------------------------- Window ---------------------------------------------------*/

/*
======================================== Global Constants ==========================================
*/


    public final float GLOBAL_STROKE_WEIGHT = 1.5;
    public final int GLOBAL_TEXT_ALIGN_FACTOR_Y;

/*
======================================== Initialization ============================================
*/  

    public UI_Constants() {

    /*
    ======================================== Tab Initialization ====================================
    */
            if(System.getProperty("os.name").toLowerCase().contains("mac")) {
                GLOBAL_TEXT_ALIGN_FACTOR_Y = 1/6;
                HOTBAR_CONTAINER_POSITION_Y =  802;
            } else if(System.getProperty("os.name").toLowerCase().contains("windows")){
                GLOBAL_TEXT_ALIGN_FACTOR_Y = 1/8;
                HOTBAR_CONTAINER_POSITION_Y = 990;
            } else {
                GLOBAL_TEXT_ALIGN_FACTOR_Y = 1/8;
                HOTBAR_CONTAINER_POSITION_Y = 990;
            }

        
    /*
    ======================================== HotBar Initialization =============================
    */
    }

    public PShape createElementListener(PShape Element_Shape) {
        float[] Element_Params = Element_Shape.getParams();

        PShape Element_Listener = createShape();
        Element_Listener.beginShape();
            Element_Listener.vertex(Element_Params[0] - Element_Params[2] / 2, Element_Params[1] - Element_Params[3] / 2);
            Element_Listener.vertex(Element_Params[0] + Element_Params[2] / 2, Element_Params[1] - Element_Params[3] / 2);
            Element_Listener.vertex(Element_Params[0] + Element_Params[2] / 2, Element_Params[1] + Element_Params[3] / 2);
            Element_Listener.vertex(Element_Params[0] - Element_Params[2] / 2, Element_Params[1] + Element_Params[3] / 2);
        Element_Listener.endShape(CLOSE);
        Element_Listener.setFill(false);
        Element_Listener.setStroke(false);
        Element_Listener.setName("Toggle_Shape_Base_Listener");
        return Element_Listener;
    }
}
