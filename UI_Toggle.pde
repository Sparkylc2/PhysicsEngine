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


    //REWRITE THIS JUST CHANGING THE Y COORD AND USING THE SAME LOGIC FOR EVERYTHING ELSE
    private void initializeToggle() {
        int numElements = this.Toggle_ParentWindow.getWindowElementArrayListSize();
        if(numElements == 0) {
            PShape Toggle_Shape_Base = this.createElementBaseShape(this.Toggle_Name, this.Element_Width, 
                                                                   this.Element_Height, 0, 
                                                                   -this.Toggle_ParentWindow.getWindowFormContainerHeight() / 2 + this.Element_Container_Top_Padding_Y + this.Element_Height / 2,
                                                                   this.Element_Base_Unselected_Color, this.Element_Base_Unselected_Stroke_Color,
                                                                   this.Element_Stroke_Weight, this.Element_Rounding);
                Toggle_Shape_Base.setName("Toggle_Shape_Base");
                
            PShape Toggle_TickBox = createShape(RECT, Toggle_Shape_Base.getParam(0) - Toggle_Shape_Base.getParam(2) / 2 + this.Element_Tickbox_Padding_X + this.Element_Tickbox_Width / 2, 
                                                      Toggle_Shape_Base.getParam(1), this.Element_Tickbox_Width, this.Element_Tickbox_Height, this.Element_Rounding);
                Toggle_TickBox.setName("TickBox");
                Toggle_TickBox.setFill(UI_Constants.GRAY_600);
                Toggle_TickBox.setStroke(UI_Constants.GRAY_600);
                Toggle_TickBox.setStrokeWeight(this.Element_Stroke_Weight);

            PShape Toggle_Shape_Base_Listener = this.createElementBaseListener(Toggle_Shape_Base);
                Toggle_Shape_Base_Listener.setName("Toggle_Shape_Base_Listener");


            this.Toggle_Shape_Group.addChild(Toggle_Shape_Base);
            this.Toggle_Shape_Group.addChild(Toggle_TickBox);
            this.Toggle_Shape_Group.addChild(Toggle_Shape_Base_Listener);
            
        } else {
            PShape Toggle_Shape_Base = this.createElementBaseShape(this.Toggle_Name, this.Element_Width, 
                                                                   this.Element_Height, 0, 
                                                                   (this.Element_Height - this.Toggle_ParentWindow.getWindowFormContainerHeight()) /2 + (this.Element_Height + this.Element_Element_Padding_Y) * numElements + this.Element_Container_Top_Padding_Y,
                                                                   this.Element_Base_Unselected_Color, this.Element_Base_Unselected_Stroke_Color,
                                                                   this.Element_Stroke_Weight, this.Element_Rounding);
                Toggle_Shape_Base.setName("Toggle_Shape_Base");
            PShape Toggle_TickBox = createShape(RECT, Toggle_Shape_Base.getParam(0) - Toggle_Shape_Base.getParam(2) / 2 + this.Element_Tickbox_Padding_X + this.Element_Tickbox_Width / 2, 
                                                      Toggle_Shape_Base.getParam(1), this.Element_Tickbox_Width, this.Element_Tickbox_Height, this.Element_Rounding);
                Toggle_TickBox.setName("TickBox");
                Toggle_TickBox.setFill(UI_Constants.GRAY_600);
                Toggle_TickBox.setStroke(UI_Constants.GRAY_600);
                Toggle_TickBox.setStrokeWeight(this.Element_Stroke_Weight);

            PShape Toggle_Shape_Base_Listener = this.createElementBaseListener(Toggle_Shape_Base);
                Toggle_Shape_Base_Listener.setName("Toggle_Shape_Base_Listener");


            this.Toggle_Shape_Group.addChild(Toggle_Shape_Base);
            this.Toggle_Shape_Group.addChild(Toggle_TickBox);
            this.Toggle_Shape_Group.addChild(Toggle_Shape_Base_Listener);
        }
    }

    @Override
    public void onMousePress() {
        float x = mouseX - this.Toggle_ParentWindow.getWindowPosition().x;
        float y = mouseY - this.Toggle_ParentWindow.getWindowPosition().y;

        if(this.Toggle_Shape_Group.getChild("Toggle_Shape_Base_Listener").contains(x, y)) {
            this.Toggle_State = !this.Toggle_State;
            if(this.Toggle_State) {
                this.Toggle_Shape_Group.getChild("Toggle_Shape_Base").setFill(UI_Constants.BLUE_SELECTED);
            } else {
                this.Toggle_Shape_Group.getChild("Toggle_Shape_Base").setFill(UI_Constants.BLUE_SELECTED);
            }
        }
    }
    @Override
    public PShape getShape() {
        return this.Toggle_Shape_Group;
    }

}   
