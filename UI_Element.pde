public abstract class UI_Element {

    /*--------------------------------- Padding --------------------------------------------------*/

    /* Represents the padding of the element shape from the edge of the window */
    public int Element_Container_Padding_X = 10;

    /* Represents the padding of the topmost element shape from the top of the window */
    public int Element_Container_Top_Padding_Y = 19;

    /* Represents the padding of a shape from a previous shapes edge element */
    public int Element_Element_Padding_Y = 13;

    /* Represents the padding of the text from either the edge of a shape, or the edge of a subelement */
    public int Element_Text_Padding_X = 10;

    /* Represents the padding of a tickbox in a toggle from the edge of the shape */
    public int Element_Tickbox_Padding_X = 5;

    /*------------------------------- Dimensions -------------------------------------------------*/

    /* This is for regular toggles and sliders, there will be different dimensions for other elements */
    public int Element_Width = 265;
    public int Element_Height = 31;

    public int Element_Tickbox_Width = 23;
    public int Element_Tickbox_Height = 23;

    public int Element_Rounding = 5;

    /*------------------------------- Position ---------------------------------------------------*/
    /*
      Each window element will have the same x position as the window it lies in due to centering,
      so only the y position must be changed.
    */

    /*------------------------------- Text -------------------------------------------------------*/
    public String Element_Text = "Default Text";
    public String Element_Value_Text = "Default Value Text";

    public PFont Element_Font = UI_Constants.INTER_REGULAR;
    public int Element_Text_Size = 16;
    public int Element_Text_Color = UI_Constants.WHITE;

    /*------------------------------- Colour -----------------------------------------------------*/
    public int Element_Base_Unselected_Color = UI_Constants.GRAY_500;
    public int Element_Base_Unselected_Stroke_Color = UI_Constants.GRAY_400;

    public int Element_Base_Selected_Color = UI_Constants.GRAY_300;
    public int Element_Base_Selected_Stroke_Color = UI_Constants.GRAY_500;

    public float Element_Stroke_Weight = 1.5;


    public abstract void createElementBaseShape();
    public abstract void createElementText();
    
    public abstract boolean onMousePress();
    public abstract void onMouseRelease();
    public abstract void onMouseDrag();

    public abstract void onSelect();
    public abstract void onDeselect();

    public abstract boolean getState();
    public abstract void setState(boolean state);
    public abstract float getValue();
    public abstract void setValue(float value);
    public abstract void incrementValue(float amount);
    public abstract void drawText();
    public abstract String getElementName();
    public abstract String getGroupName();
    public abstract PShape getShape();
}
