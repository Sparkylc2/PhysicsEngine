public class UI_Button extends UI_Element {
    

    public UI_Window Button_ParentWindow;

    public String Button_Name;
    public float Button_Name_Position_X;
    public float Button_Name_Position_Y;

    public boolean Button_State;

    public PShape Button_Shape_Group = createShape(GROUP);

    public UI_Button (String Button_Name, UI_Window Button_ParentWindow, boolean Button_State) {
        this.Button_Name = Button_Name;
        this.Button_State = Button_State;

        this.Button_Shape_Group.setName(this.Button_Name + "Group");
        this.Button_ParentWindow = Button_ParentWindow;

        this.initializeButton();
    }

    public void initializeButton() {
        this.Element_Width = 138;
        this.Element_Height = 34;
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
        ArrayList<UI_Element> elements = this.Button_ParentWindow.getWindowElements();

        int numElements = 0;

        for(UI_Element element : elements) {
            if(element instanceof UI_Button) {
                numElements++;
            }
        }

        float buttonShapeX = 0;
        float buttonShapeY = this.Button_ParentWindow.getWindowFormContainerHeight() / 2 - 65 - this.Element_Height / 2;
        float buttonShapeWidth = this.Element_Width;
        float buttonShapeHeight = this.Element_Height;


        if(this.Button_Name.equals("Save Level")) {
            this.Element_Width = 304;
            this.Element_Height = 31;
            buttonShapeWidth = this.Element_Width;
            buttonShapeHeight = this.Element_Height;
            buttonShapeX = 0;
            buttonShapeY = this.Button_ParentWindow.getWindowFormContainerHeight() / 2 - this.Element_Height / 2 - 16;
        } else if (this.Button_Name.equals("Rename Level")) {
            this.Element_Width = 304;
            this.Element_Height = 31;
            buttonShapeWidth = this.Element_Width;
            buttonShapeHeight = this.Element_Height;
            buttonShapeX = 0;
            buttonShapeY = this.Button_ParentWindow.getWindowFormContainerHeight() / 2 - this.Element_Height / 2 - 16;
        } else if(this.Button_Name.equals("Reset to defaults")){
            this.Element_Width = 650;
            this.Element_Height = 54;
            this.Element_Text_Size = 22;
            buttonShapeWidth = this.Element_Width;
            buttonShapeHeight = this.Element_Height;
            buttonShapeX = 0;
            buttonShapeY = this.Button_ParentWindow.getWindowFormContainerHeight() / 2 - this.Element_Height / 2 - 20;
        } else if(this.Button_Name.equals("Prev Page") || this.Button_Name.equals("Delete Level")) {
            buttonShapeX = -this.Button_ParentWindow.getWindowFormContainerWidth() / 2 + this.Element_Width / 2 + 17;
        } else if(this.Button_Name.equals("Next Page") || this.Button_Name.equals("Load Level")) {
            buttonShapeX = this.Button_ParentWindow.getWindowFormContainerWidth() / 2 - this.Element_Width / 2 - 17;
        } else if(numElements == 2) {
            this.Element_Width = 304;
            this.Element_Height = 31;
            buttonShapeWidth = this.Element_Width;
            buttonShapeHeight = this.Element_Height;
            buttonShapeX = 0;
            buttonShapeY = this.Button_ParentWindow.getWindowFormContainerHeight() / 2 - this.Element_Height / 2 - 16;
        } 



        PShape Button_Shape_Base = createShape(RECT, buttonShapeX, buttonShapeY, buttonShapeWidth, buttonShapeHeight, 12);
            Button_Shape_Base.setName("Button_Shape_Base");
            if(!this.Button_State) {
                Button_Shape_Base.setStrokeWeight(this.Element_Stroke_Weight);
                Button_Shape_Base.setFill(this.Element_Base_Unselected_Color);
                Button_Shape_Base.setStroke(this.Element_Base_Unselected_Stroke_Color);
            } else {
                Button_Shape_Base.setStrokeWeight(this.Element_Stroke_Weight);
                Button_Shape_Base.setFill(this.Element_Base_Selected_Color);
                Button_Shape_Base.setStroke(this.Element_Base_Selected_Stroke_Color);
            }

        PShape Button_Shape_Listener = UI_Constants.createElementListener(Button_Shape_Base);
            Button_Shape_Listener.setName("Button_Shape_Listener");

        this.Button_Shape_Group.addChild(Button_Shape_Base);
        this.Button_Shape_Group.addChild(Button_Shape_Listener);
    }

    @Override 
    public void createElementText() {
        textFont(this.Element_Font);
        textSize(this.Element_Text_Size);
        textAlign(CENTER, CENTER);

        this.Button_Name_Position_X = this.Button_Shape_Group.getChild("Button_Shape_Base").getParam(0);
        this.Button_Name_Position_Y = this.Button_Shape_Group.getChild("Button_Shape_Base").getParam(1) - (textAscent() - textDescent()) * UI_Constants.GLOBAL_TEXT_ALIGN_FACTOR_Y;
    }

    

/*
======================================= Toggle Interaction =========================================
*/  
    @Override
    public boolean onMousePress() {
        float x = mouseX - this.Button_ParentWindow.getWindowPosition().x;
        float y = mouseY - this.Button_ParentWindow.getWindowPosition().y;

        if(this.Button_Shape_Group.getChild("Button_Shape_Listener").contains(x, y)) {
            if(this.Button_Name.equals("Save Level")) {
                if(this.Button_State) {
                    this.onDeselect();
                } else {
                    this.onSelect();
                }
            } else {
                this.onSelect();
            }
            return true;
        } else {
            return false;
        }
    }

    @Override 
    public void onMouseRelease() {
        if(this.Button_Name.equals("Prev Page") && this.Button_State) {
            UI_CreationWindow creationWindow = (UI_CreationWindow) this.Button_ParentWindow;
                creationWindow.onFileDecrement();
            this.onDeselect();

        } else if(this.Button_Name.equals("Next Page") && this.Button_State) {
            UI_CreationWindow creationWindow = (UI_CreationWindow) this.Button_ParentWindow;
                creationWindow.onFileIncrement();
            this.onDeselect();
        } else if(this.Button_Name.equals("Load Level") && this.Button_State) {
            UI_CreationWindow creationWindow = (UI_CreationWindow) this.Button_ParentWindow;
                creationWindow.onLevelLoad();
            this.onDeselect();
        } else if(this.Button_Name.equals("Delete Level") && this.Button_State) {
            UI_CreationWindow creationWindow = (UI_CreationWindow) this.Button_ParentWindow;
                creationWindow.onLevelDelete();
            this.onDeselect();
        } else if(this.Button_Name.equals("Rename Level") && this.Button_State) {
            UI_CreationWindow creationWindow = (UI_CreationWindow) this.Button_ParentWindow;
                creationWindow.onRenameLevelSelect();
            this.onDeselect();
        } else if(this.Button_Name.equals("Reset to defaults") && this.Button_State) {
            UI_SettingsWindow settingsWindow = (UI_SettingsWindow) this.Button_ParentWindow;
                settingsWindow.qualitySettings.resetSettings();
            this.onDeselect();
        }
    }

    @Override
    public void onMouseDrag() {
        
    }
    

    @Override
    public void onSelect() {
        this.Button_State = true;

        this.Button_Shape_Group.getChild("Button_Shape_Base").setStroke(this.Element_Base_Selected_Stroke_Color);
        this.Button_Shape_Group.getChild("Button_Shape_Base").setFill(this.Element_Base_Selected_Color);
    }


    @Override
    public void onDeselect() {
        this.Button_State = false;

        this.Button_Shape_Group.getChild("Button_Shape_Base").setStroke(this.Element_Base_Unselected_Stroke_Color);
        this.Button_Shape_Group.getChild("Button_Shape_Base").setFill(this.Element_Base_Unselected_Color);
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

        text(this.Button_Name, this.Button_Name_Position_X, this.Button_Name_Position_Y);

    }


/*
======================================= Toggle Getters and Setters =================================
*/  
    @Override   
    public String getElementName() {
        return this.Button_Name;
    }

    @Override
    public PShape getShape() {
        return this.Button_Shape_Group;
    }

    @Override
    public boolean getState() {
        return this.Button_State;
    }
    @Override
    public String getGroupName() {
        return null;
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
    public void setState(boolean state) {
        if(state) {
            this.onSelect();
        } else {
            this.onDeselect();
        }
    }

}   
