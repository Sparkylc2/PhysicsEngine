public class UI_TickSlider extends UI_Element {

    private UI_Window TickSlider_ParentWindow;

    private String[] TickSlider_Names;

    private float[] TickSlider_Names_Position_X;
    private float TickSlider_Names_Position_Y;
    private int TickSlider_NumNames;

    private String TickSlider_CurrentValue;
    private int TickSlider_CurrentValue_Index = -1;
    private int TickSlider_PreviousValue_Index = -1;

    private float TickSlider_Width = 280;
    private float TickSlider_Height = 30;

    private float TickSlider_Position_X;
    private float TickSlider_Position_Y;
    private float TickSlider_Tick_Width;


    private boolean mouseOverTickSliderOnMouseDown = false;

    public PShape TickSlider_Shape_Group = createShape(GROUP);


    public UI_TickSlider(String[] TickSlider_Names, UI_Window TickSlider_ParentWindow, String TickSlider_CurrentValue, float TickSlider_Position_X, float TickSlider_Position_Y, float TickSlider_Tick_Width) {
        
        this.TickSlider_ParentWindow = TickSlider_ParentWindow;

        this.TickSlider_Names = TickSlider_Names;
        this.TickSlider_Names_Position_X = new float[TickSlider_Names.length];
        this.TickSlider_NumNames = TickSlider_Names.length;


        this.TickSlider_CurrentValue = TickSlider_CurrentValue;

        for (int i = 0; i < this.TickSlider_Names.length; i++) {
            if (this.TickSlider_Names[i].equals(TickSlider_CurrentValue)) {
                this.TickSlider_CurrentValue_Index = i;
                break;
            }
        }

        this.TickSlider_PreviousValue_Index = this.TickSlider_CurrentValue_Index;

        this.TickSlider_Position_X = TickSlider_Position_X;
        this.TickSlider_Position_Y = TickSlider_Position_Y;
        this.TickSlider_Tick_Width = TickSlider_Tick_Width;

        if(this.TickSlider_CurrentValue_Index == -1) {
            this.TickSlider_CurrentValue = this.TickSlider_Names[0];
            this.TickSlider_CurrentValue_Index = 0;
        }

        this.initializeTickSlider();
    }




    public void initializeTickSlider() {
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

        float tickSliderShapeX = this.TickSlider_Position_X;
        float tickSliderShapeY = this.TickSlider_Position_Y;

        float tickSliderShapeWidth = this.TickSlider_Width;
        float tickSliderShapeHeight = this.TickSlider_Height;


        PShape TickSlider_Shape_Base = createShape(RECT, tickSliderShapeX, tickSliderShapeY, tickSliderShapeWidth, tickSliderShapeHeight, this.Element_Rounding);
            TickSlider_Shape_Base.setName("TickSlider_Shape_Base");
            TickSlider_Shape_Base.setStrokeWeight(this.Element_Stroke_Weight);
            TickSlider_Shape_Base.setFill(this.Element_Base_Unselected_Color);
            TickSlider_Shape_Base.setStroke(this.Element_Base_Unselected_Stroke_Color);

        PShape TickSlider_Shape_Base_Listener = UI_Constants.createElementListener(TickSlider_Shape_Base);
            TickSlider_Shape_Base_Listener.setName("TickSlider_Shape_Base_Listener");

        PShape TickSlider_Indicator_Left = createShape(TRIANGLE, tickSliderShapeX - tickSliderShapeWidth/2, tickSliderShapeY + tickSliderShapeHeight/2, tickSliderShapeX - tickSliderShapeWidth/2 - 8, tickSliderShapeY + tickSliderShapeHeight/2 + 17, tickSliderShapeX - tickSliderShapeWidth/2 + 8,tickSliderShapeY + tickSliderShapeHeight/2 + 17);
            TickSlider_Indicator_Left.setName("TickSlider_Indicator_Left");
            TickSlider_Indicator_Left.setStrokeWeight(0);
            TickSlider_Indicator_Left.setFill(UI_Constants.WHITE);
            TickSlider_Indicator_Left.setStroke(false);
            TickSlider_Indicator_Left.setVisible(false);
            TickSlider_Indicator_Left.translate(2, 0);

        PShape TickSlider_Indicator_Right = createShape(TRIANGLE, tickSliderShapeX + tickSliderShapeWidth/2, tickSliderShapeY + tickSliderShapeHeight/2, tickSliderShapeX + tickSliderShapeWidth/2 - 8, tickSliderShapeY + tickSliderShapeHeight/2 + 17, tickSliderShapeX + tickSliderShapeWidth/2 + 8,tickSliderShapeY + tickSliderShapeHeight/2 + 17);
            TickSlider_Indicator_Right.setName("TickSlider_Indicator_Right");
            TickSlider_Indicator_Right.setStrokeWeight(0);
            TickSlider_Indicator_Right.setFill(UI_Constants.WHITE);
            TickSlider_Indicator_Right.setStroke(false);
            TickSlider_Indicator_Right.setVisible(false);
            TickSlider_Indicator_Right.translate(-2, 0);

        PShape TickSlider_Indicator_Middle = createShape(TRIANGLE, tickSliderShapeX, tickSliderShapeY + tickSliderShapeHeight/2, tickSliderShapeX - 8, tickSliderShapeY + tickSliderShapeHeight/2 + 17, tickSliderShapeX + 8,tickSliderShapeY + tickSliderShapeHeight/2 + 17);
            TickSlider_Indicator_Middle.setName("TickSlider_Indicator_Middle");
            TickSlider_Indicator_Middle.setStrokeWeight(0);
            TickSlider_Indicator_Middle.setFill(UI_Constants.WHITE);
            TickSlider_Indicator_Middle.setVisible(false);
            TickSlider_Indicator_Middle.setStroke(false);
            TickSlider_Indicator_Middle.translate(0, 0);


        if(this.TickSlider_Names.length == 3) {
            PShape TickSlider_Shape_Tick = createShape(RECT, tickSliderShapeX, tickSliderShapeY, this.TickSlider_Tick_Width, tickSliderShapeHeight - 2, this.Element_Rounding);
                TickSlider_Shape_Tick.setName("TickSlider_Shape_Tick");
                TickSlider_Shape_Tick.setStrokeWeight(0);
                TickSlider_Shape_Tick.setStroke(false);

            if(this.TickSlider_CurrentValue_Index == 1) {
                TickSlider_Shape_Tick.setFill(UI_Constants.WHITE);
            } else {
                TickSlider_Shape_Tick.setFill(UI_Constants.GRAY_25);
            }

            this.TickSlider_Shape_Group.addChild(TickSlider_Shape_Base);
            this.TickSlider_Shape_Group.addChild(TickSlider_Shape_Base_Listener);
            this.TickSlider_Shape_Group.addChild(TickSlider_Indicator_Left);
            this.TickSlider_Shape_Group.addChild(TickSlider_Indicator_Middle);
            this.TickSlider_Shape_Group.addChild(TickSlider_Indicator_Right);
            this.TickSlider_Shape_Group.addChild(TickSlider_Shape_Tick);
        } else {
            this.TickSlider_Shape_Group.addChild(TickSlider_Shape_Base);
            this.TickSlider_Shape_Group.addChild(TickSlider_Shape_Base_Listener);
            this.TickSlider_Shape_Group.addChild(TickSlider_Indicator_Left);
            this.TickSlider_Shape_Group.addChild(TickSlider_Indicator_Middle);
            this.TickSlider_Shape_Group.addChild(TickSlider_Indicator_Right);

        }
        this.initializeTickSliderShape();
    }

    @Override 
    public void createElementText() {
        float[] tickSliderShapeParams = this.TickSlider_Shape_Group.getChild("TickSlider_Shape_Base").getParams();
        if(this.TickSlider_NumNames == 2) {
            this.TickSlider_Names_Position_X[0] = tickSliderShapeParams[0] - tickSliderShapeParams[2] / 2;
            this.TickSlider_Names_Position_X[1] = tickSliderShapeParams[0] + tickSliderShapeParams[2] / 2; 

            this.TickSlider_Names_Position_Y = tickSliderShapeParams[1] - tickSliderShapeParams[3] / 2 - 11;
        } else if(this.TickSlider_NumNames == 3) {
            this.TickSlider_Names_Position_X[0] = tickSliderShapeParams[0] - tickSliderShapeParams[2] / 2;
            this.TickSlider_Names_Position_X[1] = tickSliderShapeParams[0];
            this.TickSlider_Names_Position_X[2] = tickSliderShapeParams[0] + tickSliderShapeParams[2] / 2;

            this.TickSlider_Names_Position_Y = tickSliderShapeParams[1] - tickSliderShapeParams[3] / 2 - 11;
        }
    }


    

/*
======================================= Slider Interaction =========================================
*/  
    @Override
    public boolean onMousePress() {
        float x = mouseX - this.TickSlider_ParentWindow.getWindowPosition().x;
        float y = mouseY - this.TickSlider_ParentWindow.getWindowPosition().y;
        return this.TickSlider_Shape_Group.getChild("TickSlider_Shape_Base_Listener").contains(x, y);
    }

    @Override
    public void onMouseDrag() {
        if(this.mouseOverTickSliderOnMouseDown) {
            float x = mouseX - this.TickSlider_ParentWindow.getWindowPosition().x;
            float[] baseShapeParams = this.TickSlider_Shape_Group.getChild("TickSlider_Shape_Base").getParams();
            

            //The 1/2 is there because you need to shift over by width/2 
            float relativePosition = constrain((x - baseShapeParams[0] + baseShapeParams[2]*0.5) / baseShapeParams[2], 0, 1);

            if(this.TickSlider_NumNames == 3) {
                if(relativePosition < 0.25) {
                    this.TickSlider_CurrentValue = this.TickSlider_Names[0];
                    this.TickSlider_CurrentValue_Index = 0;
                } else if(relativePosition < 0.75) {
                    this.TickSlider_CurrentValue = this.TickSlider_Names[1];
                    this.TickSlider_CurrentValue_Index = 1;
                } else {
                    this.TickSlider_CurrentValue = this.TickSlider_Names[2];
                    this.TickSlider_CurrentValue_Index = 2;
                }
            } else {
                if(relativePosition < 0.5) {
                    this.TickSlider_CurrentValue = this.TickSlider_Names[0];
                    this.TickSlider_CurrentValue_Index = 0;
                } else {
                    this.TickSlider_CurrentValue = this.TickSlider_Names[1];
                    this.TickSlider_CurrentValue_Index = 1;
                }
            }
            this.updateTickSliderShape();
        }
    }

    @Override 
    public void onMouseRelease() {
        this.mouseOverTickSliderOnMouseDown = false;
    }
    

    @Override
    public void onSelect() {
        this.mouseOverTickSliderOnMouseDown = true;
    }

    @Override
    public void onDeselect() {
        this.mouseOverTickSliderOnMouseDown = false;
    }

/*
==================================== Slider Methods ================================================
*/
    public void initializeTickSliderShape() {
        rectMode(CORNER);
        boolean createShape = true;
        int roundingLT = this.Element_Rounding;
        int roundingRT = this.Element_Rounding;
        int roundingLB = this.Element_Rounding;
        int roundingRB = this.Element_Rounding;

        float[] tickSliderShapeParams = this.TickSlider_Shape_Group.getChild("TickSlider_Shape_Base").getParams();
        float tickSliderShapeX = tickSliderShapeParams[0] - tickSliderShapeParams[2] / 2;
        float tickSliderShapeY = tickSliderShapeParams[1] - tickSliderShapeParams[3] / 2;
        float tickSliderShapeHeight = tickSliderShapeParams[3];
        float tickSliderShapeWidth;

        if(this.TickSlider_Names.length == 3) {
            if(this.TickSlider_CurrentValue_Index == 0) {
                tickSliderShapeWidth = 0;
                createShape = false;
                this.TickSlider_Shape_Group.getChild("TickSlider_Indicator_Left").setVisible(true);
            } else if(this.TickSlider_CurrentValue_Index == 1) {
                roundingRT = 0;
                roundingRB = 0;
                tickSliderShapeWidth = tickSliderShapeParams[2] / 2;
                this.TickSlider_Shape_Group.getChild("TickSlider_Indicator_Middle").setVisible(true);
            } else {
                tickSliderShapeWidth = tickSliderShapeParams[2];
                this.TickSlider_Shape_Group.getChild("TickSlider_Indicator_Right").setVisible(true);
            }
        } else {
            if(this.TickSlider_CurrentValue_Index == 0) {
                tickSliderShapeWidth = 0;
                createShape = false;
                this.TickSlider_Shape_Group.getChild("TickSlider_Indicator_Left").setVisible(true);
            } else {
                tickSliderShapeWidth = tickSliderShapeParams[2];
                this.TickSlider_Shape_Group.getChild("TickSlider_Indicator_Right").setVisible(true);
            }
        }

        if(createShape) {
            PShape TickSlider_Value_Shape = createShape(RECT, tickSliderShapeX, tickSliderShapeY, tickSliderShapeWidth, tickSliderShapeHeight, roundingLT, roundingRT, roundingRB, roundingLB);
                TickSlider_Value_Shape.setName("TickSlider_Value_Shape");
                TickSlider_Value_Shape.setStrokeWeight(this.Element_Stroke_Weight);
                TickSlider_Value_Shape.setFill(this.Element_Base_Selected_Color);
                TickSlider_Value_Shape.setStroke(false);
                this.TickSlider_Shape_Group.addChild(TickSlider_Value_Shape);
        }

        this.addTick();
    }

    private void addTick() {
        if(this.TickSlider_Shape_Group.getChild("TickSlider_Shape_Tick") == null) {
            return;
        }

        rectMode(CENTER);
        this.TickSlider_Shape_Group.removeChild(this.TickSlider_Shape_Group.getChildIndex(this.TickSlider_Shape_Group.getChild("TickSlider_Shape_Tick")));

        PShape TickSlider_Shape_Tick = createShape(RECT, this.TickSlider_Position_X, this.TickSlider_Position_Y, this.TickSlider_Tick_Width, this.TickSlider_Height - 2, this.Element_Rounding);
                TickSlider_Shape_Tick.setName("TickSlider_Shape_Tick");
                TickSlider_Shape_Tick.setStrokeWeight(0);
                TickSlider_Shape_Tick.setStroke(false);
        if(this.TickSlider_CurrentValue_Index == 1) {
            TickSlider_Shape_Tick.setFill(UI_Constants.WHITE);
        } else {
            TickSlider_Shape_Tick.setFill(UI_Constants.GRAY_25);
        }

        this.TickSlider_Shape_Group.addChild(TickSlider_Shape_Tick);
    }

    public void updateTickSliderShape() {
        if(this.TickSlider_PreviousValue_Index == this.TickSlider_CurrentValue_Index) {
            return;
        }

        if(this.TickSlider_Shape_Group.getChild("TickSlider_Value_Shape") != null) {
            this.TickSlider_Shape_Group.removeChild(this.TickSlider_Shape_Group.getChildIndex(this.TickSlider_Shape_Group.getChild("TickSlider_Value_Shape")));
        }

        rectMode(CORNER);
        boolean createShape = true;

        int roundingLT = this.Element_Rounding;
        int roundingRT = this.Element_Rounding;
        int roundingLB = this.Element_Rounding;
        int roundingRB = this.Element_Rounding;

        float[] tickSliderShapeParams = this.TickSlider_Shape_Group.getChild("TickSlider_Shape_Base").getParams();
        float tickSliderShapeX = tickSliderShapeParams[0] - tickSliderShapeParams[2] / 2;
        float tickSliderShapeY = tickSliderShapeParams[1] - tickSliderShapeParams[3] / 2;
        float tickSliderShapeHeight = tickSliderShapeParams[3];

        float tickSliderShapeWidth;

        if(this.TickSlider_NumNames == 3) {
            if(this.TickSlider_CurrentValue_Index == 0) {
                tickSliderShapeWidth = 0;
                createShape = false;

                switch(this.TickSlider_PreviousValue_Index) {
                    case 1:
                        this.TickSlider_Shape_Group.getChild("TickSlider_Indicator_Middle").setVisible(false);
                        break;
                    case 2:
                        this.TickSlider_Shape_Group.getChild("TickSlider_Indicator_Right").setVisible(false);
                        break;
                }

                this.TickSlider_Shape_Group.getChild("TickSlider_Indicator_Left").setVisible(true);
            } else if(this.TickSlider_CurrentValue_Index == 1) {
                tickSliderShapeWidth = tickSliderShapeParams[2] / 2;
                roundingRT = 0;
                roundingRB = 0;

                switch(this.TickSlider_PreviousValue_Index){
                    case 0:
                        this.TickSlider_Shape_Group.getChild("TickSlider_Indicator_Left").setVisible(false);
                        break;
                    case 2:
                        this.TickSlider_Shape_Group.getChild("TickSlider_Indicator_Right").setVisible(false);
                        break;
                }

                this.TickSlider_Shape_Group.getChild("TickSlider_Indicator_Middle").setVisible(true);
            } else {
                tickSliderShapeWidth = tickSliderShapeParams[2];

                switch(this.TickSlider_PreviousValue_Index){
                    case 0:
                        this.TickSlider_Shape_Group.getChild("TickSlider_Indicator_Left").setVisible(false);
                        break;
                    case 1:
                        this.TickSlider_Shape_Group.getChild("TickSlider_Indicator_Middle").setVisible(false);
                        break;
                }

                this.TickSlider_Shape_Group.getChild("TickSlider_Indicator_Right").setVisible(true);
            }
        } else {
            if(this.TickSlider_CurrentValue_Index == 0) {
                tickSliderShapeWidth = 0;
                createShape = false;
                this.TickSlider_Shape_Group.getChild("TickSlider_Indicator_Right").setVisible(false);
                this.TickSlider_Shape_Group.getChild("TickSlider_Indicator_Left").setVisible(true);
            } else {
                tickSliderShapeWidth = tickSliderShapeParams[2];
                this.TickSlider_Shape_Group.getChild("TickSlider_Indicator_Left").setVisible(false);
                this.TickSlider_Shape_Group.getChild("TickSlider_Indicator_Right").setVisible(true);
            }
        }

        if(createShape) {
            PShape TickSlider_Value_Shape = createShape(RECT, tickSliderShapeX, tickSliderShapeY, tickSliderShapeWidth, tickSliderShapeHeight, roundingLT, roundingRT, roundingRB, roundingLB);
                TickSlider_Value_Shape.setName("TickSlider_Value_Shape");
                TickSlider_Value_Shape.setStrokeWeight(this.Element_Stroke_Weight);
                TickSlider_Value_Shape.setFill(this.Element_Base_Selected_Color);
                TickSlider_Value_Shape.setStroke(this.Element_Base_Selected_Stroke_Color);
            this.TickSlider_Shape_Group.addChild(TickSlider_Value_Shape);
        }

        this.addTick();

        this.TickSlider_PreviousValue_Index = this.TickSlider_CurrentValue_Index;
    }

/*
===================================== Slider Draw ==================================================
*/

    @Override
    public void drawText() {
        for(int i = 0; i < this.TickSlider_NumNames; i++) {
            if(i == this.TickSlider_CurrentValue_Index) {
                fill(UI_Constants.WHITE);
            } else {
                fill(UI_Constants.GRAY_25);
            }

            textFont(UI_Constants.INTER_BOLD);
            textSize(11);

            if(i == 0) {
                textAlign(LEFT, BASELINE);
            } else if(i == this.TickSlider_NumNames - 1) {
                textAlign(RIGHT, BASELINE);
            } else {
                textAlign(CENTER, BASELINE);
            }

            text(this.TickSlider_Names[i], this.TickSlider_Names_Position_X[i], this.TickSlider_Names_Position_Y);

        }
    }


/*
======================================= Toggle Getters and Setters =================================
*/  
    @Override   
    public String getElementName() {
        return this.TickSlider_CurrentValue;
    }
    @Override
    public String getGroupName() {
        return null;
    }

    @Override
    public PShape getShape() {
        return this.TickSlider_Shape_Group;
    }

    @Override
    public float getValue() {
        return -1;
    }

    @Override
    public boolean getState() {
        return false;
    }

    @Override
    public void setValue(float value) {
        if(this.TickSlider_NumNames == 2) {
            if(value < 0.5) {
                this.TickSlider_CurrentValue = this.TickSlider_Names[0];
                this.TickSlider_CurrentValue_Index = 0;
            } else {
                this.TickSlider_CurrentValue = this.TickSlider_Names[1];
                this.TickSlider_CurrentValue_Index = 1;
            }
        } else if(this.TickSlider_NumNames == 3) {
            if(value < 0.25) {
                this.TickSlider_CurrentValue = this.TickSlider_Names[0];
                this.TickSlider_CurrentValue_Index = 0;
            } else if(value < 0.75) {
                this.TickSlider_CurrentValue = this.TickSlider_Names[1];
                this.TickSlider_CurrentValue_Index = 1;
            } else {
                this.TickSlider_CurrentValue = this.TickSlider_Names[2];
                this.TickSlider_CurrentValue_Index = 2;
            }
        }
        this.updateTickSliderShape();
    }

    @Override
    public void incrementValue(float amount) {
        return;
    }

    @Override
    public void setState(boolean state) {
        return;
    }

}   
