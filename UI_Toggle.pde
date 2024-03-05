public class UI_Toggle extends UI_Element {
    

    public UI_Window Toggle_ParentWindow;

    public String Toggle_Name;
    public float Toggle_Name_Position_X;
    public float Toggle_Name_Position_Y;


    public float Toggle_Position_X = -1;
    public float Toggle_Position_Y = -1;

    public String Toggle_GroupName = null;
    public boolean Toggle_State;

    public float Toggle_Scale = -1;

    public PShape Toggle_Shape_Group = createShape(GROUP);


    public UI_Toggle(String Toggle_Name, UI_Window Toggle_ParentWindow, boolean Toggle_State) {
        this.Toggle_Name = Toggle_Name;
        this.Toggle_Shape_Group.setName(this.Toggle_Name + "Group");
        this.Toggle_ParentWindow = Toggle_ParentWindow;

        this.Toggle_State = Toggle_State;

        this.initializeToggle();
    }

    public UI_Toggle(String Toggle_Name, UI_Window Toggle_ParentWindow, float Toggle_Position_X, float Toggle_Position_Y, boolean Toggle_State, float Toggle_Scale) {
        this.Toggle_Name = Toggle_Name;
        this.Toggle_Shape_Group.setName(this.Toggle_Name + "Group");
        this.Toggle_ParentWindow = Toggle_ParentWindow;

        this.Toggle_Scale = Toggle_Scale;
        this.Toggle_State = Toggle_State;

        this.Toggle_Position_X = Toggle_Position_X;
        this.Toggle_Position_Y = Toggle_Position_Y;

        this.initializeToggle();
    }


    public UI_Toggle(String Toggle_Name, UI_Window Toggle_ParentWindow, String Toggle_GroupName, boolean Toggle_State) {

        this.Toggle_Shape_Group.setName(this.Toggle_Name + "Group");
        
        this.Toggle_Name = Toggle_Name;
        this.Toggle_ParentWindow = Toggle_ParentWindow;
        this.Toggle_GroupName = Toggle_GroupName;

        this.Toggle_State = Toggle_State;

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

        if(this.Toggle_Position_X == -1 && this.Toggle_Position_Y == -1) {
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
        } else {
            toggleShapeX = this.Toggle_Position_X;
            toggleShapeY = this.Toggle_Position_Y;
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
            Toggle_TickMark.setStroke(UI_Constants.GRAY_150);

            Toggle_TickMark.setStrokeWeight(2);

        PShape Toggle_Shape_Base_Listener = UI_Constants.createElementListener(Toggle_Shape_Base);


        this.Toggle_Shape_Group.addChild(Toggle_Shape_Base);
        this.Toggle_Shape_Group.addChild(Toggle_TickBox);
        this.Toggle_Shape_Group.addChild(Toggle_Shape_Base_Listener);
        this.Toggle_Shape_Group.addChild(Toggle_TickMark);

        if(this.Toggle_State) {
            this.onSelect();
        } else {
            this.onDeselect();
        }

        if(this.Toggle_Scale != -1) {
            this.Toggle_Shape_Group.resetMatrix();
            this.Toggle_Shape_Group.scale(this.Toggle_Scale);
        }
    }

    @Override 
    public void createElementText() {
        textFont(this.Element_Font);
        textSize(this.Element_Text_Size);
        textAlign(CENTER, CENTER);

        float[] TickboxParams = this.Toggle_Shape_Group.getChild("Toggle_Shape_TickBox").getParams();
        this.Toggle_Name_Position_X = TickboxParams[0] + TickboxParams[2] / 2 + 10 + textWidth(this.Toggle_Name) / 2 + 5;
        this.Toggle_Name_Position_Y = this.Toggle_Shape_Group.getChild("Toggle_Shape_Base").getParam(1) - (textAscent() - textDescent()) * UI_Constants.GLOBAL_TEXT_ALIGN_FACTOR_Y;
    }

    

/*
======================================= Toggle Interaction =========================================
*/  
    @Override
    public boolean onMousePress() {
        float x = (mouseX - this.Toggle_ParentWindow.getWindowPosition().x) / this.Toggle_Scale;
        float y = (mouseY - this.Toggle_ParentWindow.getWindowPosition().y) / this.Toggle_Scale;

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
        this.Toggle_Shape_Group.getChild("Toggle_Shape_TickMark").setVisible(true);
    }

    @Override
    public void onDeselect() {
        this.Toggle_State = false;
        this.Toggle_Shape_Group.getChild("Toggle_Shape_Base").setStroke(this.Element_Base_Unselected_Stroke_Color);
        this.Toggle_Shape_Group.getChild("Toggle_Shape_Base").setFill(this.Element_Base_Unselected_Color);
        this.Toggle_Shape_Group.getChild("Toggle_Shape_TickMark").setVisible(false);
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

        if(this.Toggle_Scale != -1) {
            pushMatrix();
            scale(this.Toggle_Scale);
            text(this.Toggle_Name, this.Toggle_Name_Position_X, this.Toggle_Name_Position_Y);
            popMatrix();
        } else {
            text(this.Toggle_Name, this.Toggle_Name_Position_X, this.Toggle_Name_Position_Y);
        }

    }


/*
======================================= Toggle Getters and Setters =================================
*/  
    @Override   
    public String getElementName() {
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
    public void setValue(float value) {
        return;
    }

    @Override
    public void incrementValue(float amount) {

    }

    @Override
    public boolean getState() {
        return this.Toggle_State;
    }

    @Override
    public void setState(boolean state) {
        if(state) {
            this.onSelect();
        } else {
            this.onDeselect();
        }
    }

}   
