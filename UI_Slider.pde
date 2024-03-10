public class UI_Slider extends UI_Element {

    public UI_Window Slider_ParentWindow;

    public String Slider_Name;
    public float Slider_Name_Position_X;
    public float Slider_Name_Position_Y;
    public float Slider_Value_Position_X;
    public float Slider_Value_Position_Y;

    public float Slider_Min_Value;
    public float Slider_Max_Value;
    public float Slider_Current_Value;


    public float scale = -1;
    public String Slider_GroupName = null;

    public boolean mouseOverSliderOnMouseDown = false;
    public PShape Slider_Shape_Group = createShape(GROUP);


    public UI_Slider(String Slider_Name, UI_Window Slider_ParentWindow, float Slider_Min_Value, float Slider_Max_Value, float Slider_Current_Value) {
        this.Slider_Name = Slider_Name;
        
        this.Slider_Shape_Group.setName(this.Slider_Name + "Group");
        this.Slider_ParentWindow = Slider_ParentWindow;

        this.Slider_Min_Value = Slider_Min_Value;
        this.Slider_Max_Value = Slider_Max_Value;
        this.Slider_Current_Value = Slider_Current_Value;

        this.initializeSlider();
    }


    public UI_Slider(String Slider_Name, UI_Window Slider_ParentWindow, String Slider_GroupName, float Slider_Min_Value, float Slider_Max_Value, float Slider_Current_Value) {
        
        this.Slider_Name = Slider_Name;
        this.Slider_ParentWindow = Slider_ParentWindow;
        this.Slider_GroupName = Slider_GroupName;

        this.Slider_Min_Value = Slider_Min_Value;
        this.Slider_Max_Value = Slider_Max_Value;
        this.Slider_Current_Value = Slider_Current_Value;

        this.initializeSlider();
    }


    public void initializeSlider() {
        rectMode(CENTER);
        this.createElementBaseShape();
        this.createElementText();
    }




/*
======================================= Slider Creation ============================================
*/  
    @Override
    public void createElementBaseShape() {
        rectMode(CENTER);
        int numElements = this.Slider_ParentWindow.getWindowElementArrayListSize();

        float sliderShapeX;
        float sliderShapeY;
        float sliderShapeWidth;
        float sliderShapeHeight;

        if(this.Slider_Name.equals("Coeff. of static friction")) {
            this.scale = 1.1;
            sliderShapeX = -this.Slider_ParentWindow.getWindowFormContainerDimensions().x / 4f - (280f / 2f) + (this.Element_Width * scale / 2f);
            sliderShapeY = -this.Slider_ParentWindow.getWindowFormContainerDimensions().y / 2f + 390;

            // this.Element_Width = 310f;
            // this.Element_Height = 34f;
            sliderShapeWidth = this.Element_Width;
            sliderShapeHeight = this.Element_Height;
        } else if(this.Slider_Name.equals("Coeff. of kinetic friction")) {
            this.scale = 1.1;
            sliderShapeX = -this.Slider_ParentWindow.getWindowFormContainerDimensions().x / 4f - 280f / 2f + (this.Element_Width * scale / 2f);
            sliderShapeY = -this.Slider_ParentWindow.getWindowFormContainerDimensions().y / 2f + 440;

            // this.Element_Width = 310f;
            // this.Element_Height = 34f;
            sliderShapeWidth = this.Element_Width;
            sliderShapeHeight = this.Element_Height;
        } else if(this.Slider_Name.equals("Gravity")) {
            this.scale = 1.1;
            sliderShapeX = -this.Slider_ParentWindow.getWindowFormContainerDimensions().x / 4f - 280f / 2 + (this.Element_Width * scale / 2f);
            sliderShapeY = -this.Slider_ParentWindow.getWindowFormContainerDimensions().y / 2f + 490;

            // this.Element_Width = 310f;
            // this.Element_Height = 34f;
            sliderShapeWidth = this.Element_Width;
            sliderShapeHeight = this.Element_Height;
        } else if(numElements == 0) {
            sliderShapeX = 0;
            sliderShapeY = -this.Slider_ParentWindow.getWindowFormContainerHeight() / 2 + this.Element_Container_Top_Padding_Y + this.Element_Height / 2;

            sliderShapeWidth = this.Element_Width;
            sliderShapeHeight = this.Element_Height;

        } else {
            sliderShapeX = 0;
            sliderShapeY = (this.Element_Height - this.Slider_ParentWindow.getWindowFormContainerHeight()) /2 + (this.Element_Height + this.Element_Element_Padding_Y) * numElements + this.Element_Container_Top_Padding_Y;
            sliderShapeWidth = this.Element_Width;
            sliderShapeHeight = this.Element_Height;
        }

        PShape Slider_Shape_Base = createShape(RECT, sliderShapeX, sliderShapeY, sliderShapeWidth, sliderShapeHeight, this.Element_Rounding);
            Slider_Shape_Base.setName("Slider_Shape_Base");
            Slider_Shape_Base.setStrokeWeight(this.Element_Stroke_Weight);
            Slider_Shape_Base.setFill(this.Element_Base_Unselected_Color);
            Slider_Shape_Base.setStroke(this.Element_Base_Unselected_Stroke_Color);
            if(this.scale != -1) {
                Slider_Shape_Base.scale(this.scale);
            }

        PShape Slider_Shape_Base_Listener = UI_Constants.createElementListener(Slider_Shape_Base);
            Slider_Shape_Base_Listener.setName("Slider_Shape_Base_Listener");

        this.Slider_Shape_Group.addChild(Slider_Shape_Base);
        this.Slider_Shape_Group.addChild(Slider_Shape_Base_Listener);

        this.initializeSliderShape();
    }

    @Override 
    public void createElementText() {
        textFont(this.Element_Font);
        textSize(this.Element_Text_Size);
        textAlign(CENTER, CENTER);
        float[] sliderShapeParams = this.Slider_Shape_Group.getChild("Slider_Shape_Base").getParams();

        this.Slider_Name_Position_X = sliderShapeParams[0] - sliderShapeParams[2] / 2 + textWidth(this.Slider_Name) / 2 + 10;
        this.Slider_Name_Position_Y = sliderShapeParams[1] - (textAscent() - textDescent()) * UI_Constants.GLOBAL_TEXT_ALIGN_FACTOR_Y;

        this.Slider_Value_Position_X = sliderShapeParams[0] + sliderShapeParams[2] / 2 - textWidth(nf(this.Slider_Current_Value, 0, 2)) / 2 - 10;
        this.Slider_Value_Position_Y = sliderShapeParams[1] - (textAscent() - textDescent()) * UI_Constants.GLOBAL_TEXT_ALIGN_FACTOR_Y;
    }


    public void updateValueTextPosition() {
        textFont(this.Element_Font);
        textSize(this.Element_Text_Size);
        textAlign(CENTER, CENTER);

        float[] sliderShapeParams = this.Slider_Shape_Group.getChild("Slider_Shape_Base").getParams();

        this.Slider_Value_Position_X = sliderShapeParams[0] + sliderShapeParams[2] / 2 - textWidth(nf(this.Slider_Current_Value, 0, 2)) / 2 - 10;
        this.Slider_Value_Position_Y = sliderShapeParams[1] - (textAscent() - textDescent()) * UI_Constants.GLOBAL_TEXT_ALIGN_FACTOR_Y;

    }

    

/*
======================================= Slider Interaction =========================================
*/  
    @Override
    public boolean onMousePress() {
        if(this.scale != -1) {
            float x = (mouseX - this.Slider_ParentWindow.getWindowPosition().x) / this.scale;
            float y = (mouseY - this.Slider_ParentWindow.getWindowPosition().y) / this.scale;
            return this.Slider_Shape_Group.getChild("Slider_Shape_Base_Listener").contains(x, y);
        } else {
            float x = mouseX - this.Slider_ParentWindow.getWindowPosition().x;
            float y = mouseY - this.Slider_ParentWindow.getWindowPosition().y;
            return this.Slider_Shape_Group.getChild("Slider_Shape_Base_Listener").contains(x, y);
        }
    }

    @Override
    public void onMouseDrag() {
        if(this.mouseOverSliderOnMouseDown) {
            float x = mouseX - this.Slider_ParentWindow.getWindowPosition().x;
            float[] baseShapeParams = this.Slider_Shape_Group.getChild("Slider_Shape_Base").getParams();
            this.Slider_Current_Value = map(x, baseShapeParams[0] - baseShapeParams[2] / 2, baseShapeParams[0] + baseShapeParams[2] / 2, this.Slider_Min_Value, this.Slider_Max_Value);
            this.Slider_Current_Value = constrain(this.Slider_Current_Value, this.Slider_Min_Value, this.Slider_Max_Value);
            this.updateSliderShape();
        }
    }

    @Override 
    public void onMouseRelease() {
        this.mouseOverSliderOnMouseDown = false;
    }
    

    @Override
    public void onSelect() {
        this.mouseOverSliderOnMouseDown = true;
    }

    @Override
    public void onDeselect() {
        this.mouseOverSliderOnMouseDown = false;
    }

/*
==================================== Slider Methods ================================================
*/
    public void initializeSliderShape() {
        rectMode(CORNER);
        float[] sliderShapeParams = this.Slider_Shape_Group.getChild("Slider_Shape_Base").getParams();
        float sliderShapeX = sliderShapeParams[0] - sliderShapeParams[2] / 2;
        float sliderShapeY = sliderShapeParams[1] - sliderShapeParams[3] / 2;
        float sliderShapeHeight = sliderShapeParams[3];

        float sliderShapeWidth = map(this.Slider_Current_Value, this.Slider_Min_Value, this.Slider_Max_Value, 0, sliderShapeParams[2]);

        PShape Slider_Shape = createShape(RECT, sliderShapeX, sliderShapeY, sliderShapeWidth, sliderShapeHeight, this.Element_Rounding);
            Slider_Shape.setName("Slider_Value_Shape");
            Slider_Shape.setStrokeWeight(this.Element_Stroke_Weight);
            Slider_Shape.setFill(this.Element_Base_Selected_Color);
            Slider_Shape.setStroke(this.Element_Base_Selected_Stroke_Color);
            if(this.scale != -1) {
                Slider_Shape.scale(this.scale);
            }

        this.Slider_Shape_Group.addChild(Slider_Shape);
    }

    public void updateSliderShape() {
        this.Slider_Shape_Group.removeChild(this.Slider_Shape_Group.getChildIndex(this.Slider_Shape_Group.getChild("Slider_Value_Shape")));

        rectMode(CORNER);
        float[] sliderShapeParams = this.Slider_Shape_Group.getChild("Slider_Shape_Base").getParams();
        float sliderShapeX = sliderShapeParams[0] - sliderShapeParams[2] / 2;
        float sliderShapeY = sliderShapeParams[1] - sliderShapeParams[3] / 2;
        float sliderShapeHeight = sliderShapeParams[3];

        float sliderShapeWidth = map(this.Slider_Current_Value, this.Slider_Min_Value, this.Slider_Max_Value, 0, sliderShapeParams[2]);

        PShape Slider_Shape = createShape(RECT, sliderShapeX, sliderShapeY, sliderShapeWidth, sliderShapeHeight, this.Element_Rounding);
            Slider_Shape.setName("Slider_Value_Shape");
            Slider_Shape.setStrokeWeight(this.Element_Stroke_Weight);
            Slider_Shape.setFill(this.Element_Base_Selected_Color);
            Slider_Shape.setStroke(this.Element_Base_Selected_Stroke_Color);
        if(this.scale != -1) {
            Slider_Shape.scale(this.scale);
        }
        
        this.Slider_Shape_Group.addChild(Slider_Shape);

        this.updateValueTextPosition();

    }

/*
===================================== Slider Draw ==================================================
*/

    @Override
    public void drawText() {
        fill(this.Element_Text_Color);
        textFont(this.Element_Font);
        textSize(this.Element_Text_Size);
        textAlign(CENTER, CENTER);
        if(this.scale != -1) {
            pushMatrix();
            scale(this.scale);
            text(this.Slider_Name, this.Slider_Name_Position_X, this.Slider_Name_Position_Y);
            text(nf(this.Slider_Current_Value, 0, 2), this.Slider_Value_Position_X, this.Slider_Value_Position_Y);
            popMatrix();
        } else {
            text(this.Slider_Name, this.Slider_Name_Position_X, this.Slider_Name_Position_Y);
            text(nf(this.Slider_Current_Value, 0, 2), this.Slider_Value_Position_X, this.Slider_Value_Position_Y);
        }
    }


/*
======================================= Toggle Getters and Setters =================================
*/  
    @Override   
    public String getElementName() {
        return this.Slider_Name;
    }
    @Override
    public String getGroupName() {
        return this.Slider_GroupName;
    }

    @Override
    public PShape getShape() {
        return this.Slider_Shape_Group;
    }

    @Override
    public float getValue() {
        return this.Slider_Current_Value;
    }

    @Override
    public boolean getState() {
        return false;
    }

    @Override
    public void setValue(float value) {
        this.Slider_Current_Value = constrain(value, this.Slider_Min_Value, this.Slider_Max_Value);
        this.updateSliderShape();
    }

    @Override
    public void incrementValue(float amount) {
        this.Slider_Current_Value = constrain(this.Slider_Current_Value + amount, this.Slider_Min_Value, this.Slider_Max_Value);
        this.updateSliderShape();
    }

    @Override
    public void setState(boolean state) {
        return;
    }

}   
