public class UI_Toggle extends UI_Element {
    

    private UI_Window Toggle_ParentWindow;
    private String Toggle_Name;
    private int Toggle_ID;
    private int Toggle_Window_ID;
    private boolean Toggle_State;


    private PVector Toggle_Container_Relative_Position = new PVector();
    private PVector Toggle_Container_Position = new PVector();


    private int Toggle_Stroke_Weight = 1;
    private int Toggle_Rounding = 3;
    private PShape Toggle_Shape_Group = createShape(GROUP);


    public UI_Toggle(String Toggle_Name, int Toggle_ID, UI_Window Toggle_ParentWindow) {
        this.Toggle_Name = Toggle_Name;
        this.Toggle_ID = Toggle_ID;

        this.Toggle_ParentWindow = Toggle_ParentWindow;
        this.Toggle_Window_ID = Toggle_ParentWindow.getWindowID();

        this.initializeToggle();
    }

    private void initializeToggle() {
        int numElements = this.Toggle_ParentWindow.getWindowElementArrayListSize();
        if(numElements == 0) {
            PShape Toggle_Shape_Base = this.createElementBaseShape(this.Toggle_Name, this.Element_Width, 
                                                                   this.Element_Height, 0, 
                                                                   -this.Toggle_ParentWindow.getWindowFormContainerHeight() / 2 + this.Element_Container_Top_Padding_Y + this.Element_Height / 2,
                                                                   this.Element_Base_Unselected_Color, this.Element_Base_Unselected_Stroke_Color,
                                                                   this.Element_Stroke_Weight, this.Element_Rounding);
            this.Toggle_Shape_Group.addChild(Toggle_Shape_Base);
        } else {
            PShape Toggle_Shape_Base = this.createElementBaseShape(this.Toggle_Name, this.Element_Width, 
                                                                   this.Element_Height, 0, 
                                                                   this.Element_Container_Top_Padding_Y + this.Element_Height * numElements + this.Element_Height / 2 + this.Element_Element_Padding_Y * (numElements - 1),
                                                                   this.Element_Base_Unselected_Color, this.Element_Base_Unselected_Stroke_Color,
                                                                   this.Element_Stroke_Weight, this.Element_Rounding);
            this.Toggle_Shape_Group.addChild(Toggle_Shape_Base);
        }
    }

    @Override
    public PShape getShape() {
        return this.Toggle_Shape_Group;
    }

}   
