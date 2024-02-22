public abstract class UI_Element {

    /*--------------------------------- Padding --------------------------------------------------*/

    /* Represents the padding of the element shape from the edge of the window */
    public int Element_Container_Padding_X = 10;

    /* Represents the padding of the topmost element shape from the top of the window */
    public int Element_Container_Top_Padding_Y = 20;

    /* Represents the padding of a shape from a previous shapes edge element */
    public int Element_Element_Padding_Y = 12;

    /* Represents the padding of the text from either the edge of a shape, or the edge of a subelement */
    public int Element_Text_Padding_X = 10;

    /* Represents the padding of a tickbox in a toggle from the edge of the shape */
    public int Element_Tickbox_Padding_X = 5;

    /*------------------------------- Dimensions -------------------------------------------------*/

    /* This is for regular toggles and sliders, there will be different dimensions for other elements */
    public int Element_Width = 265;
    public int Element_Height = 33;

    public int Element_Tickbox_Width = 23;
    public int Element_Tickbox_Height = 23;

    public int Element_Rounding = 3;

    /*------------------------------- Position ---------------------------------------------------*/
    /*
      Each window element will have the same x position as the window it lies in due to centering,
      so only the y position must be changed.
    */

    /*------------------------------- Text -------------------------------------------------------*/
    public String Element_Text = "Default Text";
    public String Element_Value_Text = "Default Value Text";

    public PFont Element_Font = UI_Constants.FONT[2];
    public int Element_Text_Size = 16;

    /*------------------------------- Colour -----------------------------------------------------*/
    public int Element_Base_Unselected_Color = UI_Constants.GRAY_500;
    public int Element_Base_Unselected_Stroke_Color = UI_Constants.GRAY_400;

    public int Element_Base_Selected_Color = UI_Constants.GRAY_300;
    public int Element_Base_Selected_Stroke_Color = UI_Constants.GRAY_300;

    public float Element_Stroke_Weight = UI_Constants.STROKE_WEIGHT;



    public PShape createElementBaseShape(String Element_Base_Shape_Name,
                                          int Element_Width, int Element_Height,
                                          float Element_Position_X, float Element_Position_Y,
                                          int Element_Fill_Color, int Element_Stroke_Color, 
                                          float Element_Stroke_Weight, int Element_Rounding) {
        rectMode(CENTER);
        PShape Element_Base_Shape = createShape(RECT, Element_Position_X, Element_Position_Y, 
                                                      Element_Width, Element_Height, 
                                                      Element_Rounding);
            Element_Base_Shape.setName(Element_Base_Shape_Name);
            Element_Base_Shape.setFill(Element_Fill_Color);
            Element_Base_Shape.setStroke(Element_Stroke_Color);
            Element_Base_Shape.setStrokeWeight(Element_Stroke_Weight);


        return Element_Base_Shape;

    }

    public PShape createElementBaseListener(PShape Element_Shape) {
        float elementX = Element_Shape.getParams()[0];
        float elementY = Element_Shape.getParams()[1];
        float elementWidth = Element_Shape.getParams()[2];
        float elementHeight = Element_Shape.getParams()[3];

        
        PShape Element_Listener = createShape();
            Element_Listener.beginShape();
                vertex(elementX - elementWidth/2, elementY - elementHeight/2);
                vertex(elementX + elementWidth/2, elementY - elementHeight/2);
                vertex(elementX + elementWidth/2, elementY + elementHeight/2);
                vertex(elementX - elementWidth/2, elementY + elementHeight/2);
            Element_Listener.endShape(CLOSE);

            Element_Listener.setFill(false);
            Element_Listener.setStroke(false);
        return Element_Listener;
    }

    public PShape getShape() {
        return null;
    }

    public void onMousePress() {
        return;
    }
}
