public class UI_Toggle extends UI_Element {
    

    public UI_Window Toggle_ParentWindow;

    public String Toggle_Name;
    public float Toggle_Name_Position_X;
    public float Toggle_Name_Position_Y;

    public String Toggle_GroupName = null;
    public boolean Toggle_State;

    public PShape Toggle_Shape_Group = createShape(GROUP);


    public UI_Toggle(String Toggle_Name, UI_Window Toggle_ParentWindow) {

        this.Toggle_Name = Toggle_Name;
        this.Toggle_ParentWindow = Toggle_ParentWindow;

        this.initializeToggle();
    }


    public UI_Toggle(String Toggle_Name, UI_Window Toggle_ParentWindow, String Toggle_GroupName) {

        this.Toggle_Name = Toggle_Name;
        this.Toggle_ParentWindow = Toggle_ParentWindow;
        this.Toggle_GroupName = Toggle_GroupName;

        this.initializeToggle();
    }


    public void initializeToggle() {
        rectMode(CENTER);
        this.createElementBaseShape();
        this.createElementText();
    }




/*
======================================= Toggle Creation ============================================
*/  
    @Override
    public void createElementBaseShape() {
        rectMode(CENTER);
        int numElements = this.Toggle_ParentWindow.getWindowElementArrayListSize();

        float toggleShapeX;
        float toggleShapeY;
        float toggleShapeWidth;
        float toggleShapeHeight;

        float toggleTickboxX;
        float toggleTickboxY;
        float toggleTickboxWidth;
        float toggleTickboxHeight;

        if(numElements == 0) {
            toggleShapeX = 0;
            toggleShapeY = -this.Toggle_ParentWindow.getWindowFormContainerHeight() / 2 + this.Element_Container_Top_Padding_Y + this.Element_Height / 2;
            toggleShapeWidth = this.Element_Width;
            toggleShapeHeight = this.Element_Height;

            toggleTickboxX = toggleShapeX - toggleShapeWidth / 2 + this.Element_Tickbox_Padding_X + this.Element_Tickbox_Width / 2;
            toggleTickboxY = toggleShapeY;
            toggleTickboxWidth = this.Element_Tickbox_Width;
            toggleTickboxHeight = this.Element_Tickbox_Height;
            
        } else {
            toggleShapeX = 0;
            toggleShapeY = (this.Element_Height - this.Toggle_ParentWindow.getWindowFormContainerHeight()) /2 + (this.Element_Height + this.Element_Element_Padding_Y) * numElements + this.Element_Container_Top_Padding_Y;
            toggleShapeWidth = this.Element_Width;
            toggleShapeHeight = this.Element_Height;

            toggleTickboxX = toggleShapeX - toggleShapeWidth / 2 + this.Element_Tickbox_Padding_X + this.Element_Tickbox_Width / 2;
            toggleTickboxY = toggleShapeY;
            toggleTickboxWidth = this.Element_Tickbox_Width;
            toggleTickboxHeight = this.Element_Tickbox_Height;

        }

        PShape Toggle_Shape_Base = createShape(RECT, toggleShapeX, toggleShapeY, toggleShapeWidth, toggleShapeHeight, this.Element_Rounding);
            Toggle_Shape_Base.setName("Toggle_Shape_Base");
            Toggle_Shape_Base.setStrokeWeight(this.Element_Stroke_Weight);
            Toggle_Shape_Base.setFill(this.Element_Base_Unselected_Color);
            Toggle_Shape_Base.setStroke(this.Element_Base_Unselected_Stroke_Color);

        PShape Toggle_TickBox = createShape(RECT, toggleTickboxX, toggleTickboxY, toggleTickboxWidth, toggleTickboxHeight, this.Element_Rounding);
            Toggle_TickBox.setName("Toggle_Shape_TickBox");
            Toggle_TickBox.setStrokeWeight(this.Element_Stroke_Weight);
            Toggle_TickBox.setFill(UI_Constants.GRAY_600);
            Toggle_TickBox.setStroke(UI_Constants.GRAY_600);

        PShape Toggle_TickMark = createShape();
            Toggle_TickMark.beginShape();
                Toggle_TickMark.vertex(toggleTickboxX + 8, toggleTickboxY - 5);
                Toggle_TickMark.vertex(toggleTickboxX - 2, toggleTickboxY + 5);
                Toggle_TickMark.vertex(toggleTickboxX - 7, toggleTickboxY);
            Toggle_TickMark.endShape();

            Toggle_TickMark.setName("Toggle_Shape_TickMark");
            Toggle_TickMark.setFill(false);
            Toggle_TickMark.setStroke(false);
            Toggle_TickMark.setStroke(UI_Constants.GRAY_100);
            Toggle_TickMark.setStrokeWeight(2);

        PShape Toggle_Shape_Base_Listener = UI_Constants.createElementListener(Toggle_Shape_Base);


        this.Toggle_Shape_Group.addChild(Toggle_Shape_Base);
        this.Toggle_Shape_Group.addChild(Toggle_TickBox);
        this.Toggle_Shape_Group.addChild(Toggle_Shape_Base_Listener);
        this.Toggle_Shape_Group.addChild(Toggle_TickMark);

    }

    @Override 
    public void createElementText() {
        textFont(this.Element_Font);
        textSize(this.Element_Text_Size);
        textAlign(CENTER, CENTER);

        float[] TickboxParams = this.Toggle_Shape_Group.getChild("Toggle_Shape_TickBox").getParams();
        this.Toggle_Name_Position_X = TickboxParams[0] + TickboxParams[2] / 2 + 10 + textWidth(this.Toggle_Name) / 2;
        this.Toggle_Name_Position_Y = this.Toggle_Shape_Group.getChild("Toggle_Shape_Base").getParam(1);
    }

    

/*
======================================= Toggle Interaction =========================================
*/  
    @Override
    public boolean onMousePress() {
        float x = mouseX - this.Toggle_ParentWindow.getWindowPosition().x;
        float y = mouseY - this.Toggle_ParentWindow.getWindowPosition().y;

        return this.Toggle_Shape_Group.getChild("Toggle_Shape_Base_Listener").contains(x, y);
    }

    @Override 
    public void onMouseRelease() {

    }

    @Override
    public void onMouseDrag() {
        
    }
    

    @Override
    public void onSelect() {
        this.Toggle_State = true;
        this.Toggle_Shape_Group.getChild("Toggle_Shape_Base").setStroke(this.Element_Base_Selected_Stroke_Color);
        this.Toggle_Shape_Group.getChild("Toggle_Shape_Base").setFill(this.Element_Base_Selected_Color);
        this.Toggle_Shape_Group.getChild("Toggle_Shape_TickMark").setStroke(true);
    }

    @Override
    public void onDeselect() {
        this.Toggle_State = false;
        this.Toggle_Shape_Group.getChild("Toggle_Shape_Base").setStroke(this.Element_Base_Unselected_Stroke_Color);
        this.Toggle_Shape_Group.getChild("Toggle_Shape_Base").setFill(this.Element_Base_Unselected_Color);
        this.Toggle_Shape_Group.getChild("Toggle_Shape_TickMark").setStroke(false);
    }

/*
===================================== Toggle Draw ==================================================
*/

    @Override
    public void drawText() {
        fill(this.Element_Text_Color);
        textFont(this.Element_Font);
        textSize(this.Element_Text_Size);
        textAlign(CENTER, CENTER);

        text(this.Toggle_Name, this.Toggle_Name_Position_X, this.Toggle_Name_Position_Y);

    }


/*
======================================= Toggle Getters and Setters =================================
*/  
    @Override   
    public String getName() {
        return this.Toggle_Name;
    }
    @Override
    public String getGroupName() {
        return this.Toggle_GroupName;
    }

    @Override
    public PShape getShape() {
        return this.Toggle_Shape_Group;
    }

    @Override 
    public float getValue() {
        return 0;
    }

    @Override
    public boolean getState() {
        return this.Toggle_State;
    }

}   
