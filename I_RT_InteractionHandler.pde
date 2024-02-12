public class RT_InteractionHandler extends TabInteractionHandlerAbstract{

    /*
    ID 0: RT_CircleToggle
    ID 1: RT_RectangleToggle
    ID 2: RT_FillColour
    ID 3: RT_StrokeColour
    ID 4: RT_IsStatic
    ID 5: RT_IsTranslationallyStatic
    ID 6: RT_IsRotationallyStatic
    ID 7: RT_AddGravity
    ID 8: RT_Collidability
    */

    private Toggle[] TOGGLES = new Toggle[9];
    private boolean[] TOGGLE_STATES = new boolean[9];

    private Toggle[] CircleRectangleGroup = new Toggle[2];
    private int[] CircleRectangleGroupID = {0, 1};

    private Toggle[] FillStrokeGroup = new Toggle[2];
    private int[] FillStrokeGroupID = {2, 3};

    private Toggle[] StaticGroup = new Toggle[3];
    private int[] StaticGroupID = {4, 5, 6};


    /*
    ID 0: RT_DensitySlider
    ID 1: RT_RestitutionSlider
    ID 2: RT_RectangleWidthSlider
    ID 3: RT_RectangleHeightSlider
    ID 4: RT_CircleRadiusSlider
    ID 5: RT_StrokeWeightSlider
    ID 6: RT_RedFillSlider
    ID 7: RT_GreenFillSlider
    ID 8: RT_BlueFillSlider
    ID 9: RT_RedStrokeSlider
    ID 10: RT_GreenStrokeSlider
    ID 11: RT_BlueStrokeSlider
    ID 12: RT_AngleSlider
    ID 13: RT_AngularVelocitySlider
    */
    private float[] SLIDER_VALUES = new float[14];



    public boolean mouseDown = false;

    public PVector velocity = new PVector();
    public PVector endPoint = new PVector();
    private int opacity = 166;
    


/*
====================================================================================================
======================================= Main Methods ===============================================
====================================================================================================
*/

    public void GenerateRigidbody() {

        /* ------ Checks ------- */
        if(Mouse.getIsMouseOverUI()) {
            return;
        }
        if(mouseButton != LEFT) {
            return;
        }

        if(!(this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1])) {
            return;
        }
        if(!isPaused && Mouse.getRigidbodyUnderMouse() != null) {
            return;
        }
        /* -------------------- */

        
        
        if(this.TOGGLE_STATES[0]){
            Rigidbody rigidbody = RigidbodyGenerator.CreateCircleBody(this.SLIDER_VALUES[4], this.SLIDER_VALUES[0],
                                                                      this.SLIDER_VALUES[1], this.TOGGLE_STATES[4],
                                                                      this.TOGGLE_STATES[8], this.SLIDER_VALUES[5],
                                                                      new PVector(this.SLIDER_VALUES[9], 
                                                                                  this.SLIDER_VALUES[10],
                                                                                  this.SLIDER_VALUES[11]), 
                                                                      new PVector(this.SLIDER_VALUES[6], 
                                                                                  this.SLIDER_VALUES[7], 
                                                                                  this.SLIDER_VALUES[8]));
            rigidbody.SetInitialPosition(Mouse.getMouseCoordinates());
            rigidbody.setVelocity(PhysEngMath.SquareVelocity(PhysEngMath.MouseVelocityCalculationAndClamp(Mouse.getMouseDownCoordinates(), 
                                                                                                          Mouse.getMouseCoordinates(), 
                                                                                                          MIN_MOUSE_VELOCITY_MAG, 
                                                                                                          MAX_MOUSE_VELOCITY_MAG))
                                                                                                          .mult(-1));
            rigidbody.setIsTranslationallyStatic(this.TOGGLE_STATES[5]);
            rigidbody.setIsRotationallyStatic(this.TOGGLE_STATES[6]);
            rigidbody.setCollidability(this.TOGGLE_STATES[8]);
            rigidbody.RotateTo(this.SLIDER_VALUES[12]);
            rigidbody.setAngularVelocity(this.SLIDER_VALUES[13]);
            
            if(this.TOGGLE_STATES[7]) {
                rigidbody.addForceToForceRegistry(new Gravity(rigidbody));
            }

            AddBodyToBodyEntityList(rigidbody);
            return;
        }


        if(this.TOGGLE_STATES[1]) {
            Rigidbody rigidbody = RigidbodyGenerator.CreateBoxBody( this.SLIDER_VALUES[2], this.SLIDER_VALUES[3],
                                                                    this.SLIDER_VALUES[0], this.SLIDER_VALUES[1],
                                                                    this.TOGGLE_STATES[4], this.TOGGLE_STATES[8], 
                                                                    this.SLIDER_VALUES[5],
                                                                    new PVector(this.SLIDER_VALUES[9], 
                                                                                this.SLIDER_VALUES[10],
                                                                                this.SLIDER_VALUES[11]), 
                                                                    new PVector(this.SLIDER_VALUES[6], 
                                                                                this.SLIDER_VALUES[7], 
                                                                                this.SLIDER_VALUES[8]));
            
            rigidbody.SetInitialPosition(Mouse.getMouseCoordinates());
            rigidbody.setVelocity(PhysEngMath.SquareVelocity(PhysEngMath.MouseVelocityCalculationAndClamp(Mouse.getMouseDownCoordinates(), 
                                                                                                          Mouse.getMouseCoordinates(), 
                                                                                                          MIN_MOUSE_VELOCITY_MAG, 
                                                                                                          MAX_MOUSE_VELOCITY_MAG))
                                                                                                          .mult(-1));
            rigidbody.setIsTranslationallyStatic(this.TOGGLE_STATES[5]);
            rigidbody.setCollidability(this.TOGGLE_STATES[8]);
            rigidbody.setIsRotationallyStatic(this.TOGGLE_STATES[6]);
            rigidbody.RotateTo(this.SLIDER_VALUES[12]);
            rigidbody.setAngularVelocity(this.SLIDER_VALUES[13]);

            if(this.TOGGLE_STATES[7]) {
                rigidbody.addForceToForceRegistry(new Gravity(rigidbody));
            }

            AddBodyToBodyEntityList(rigidbody);
            return;
        }
    }

    public void drawVelocityLine() {

        /*This takes care of updating the new velocity values and endpoint values for the rigidbodies */
        PVector mouseDownCoordinates = Mouse.getMouseDownCoordinates();
        PVector currentMouseCoordinates = Mouse.getMouseCoordinates();
        PVector clamped = PhysEngMath.MouseVelocityCalculationAndClamp( mouseDownCoordinates, currentMouseCoordinates, 
                                                                        MIN_MOUSE_VELOCITY_MAG, MAX_MOUSE_VELOCITY_MAG);
        PVector endPoint = PVector.add(mouseDownCoordinates, clamped);

        if(PVector.sub(mouseDownCoordinates, endPoint).magSq() > 0.1f){
            float lerpVal = map(clamped.mag(), MIN_MOUSE_VELOCITY_MAG, MAX_MOUSE_VELOCITY_MAG, 0, 1);
            lerpVal = lerpVal * lerpVal; // This creates a quadratic effect

            int colour = lerpColor(color(0, 255, 0), color(255, 0, 0), lerpVal);
            stroke(colour);
            line(mouseDownCoordinates.x, mouseDownCoordinates.y, endPoint.x, endPoint.y);
        }
    }



    public void drawBodies() {
        if(!(this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1])) {
            return;
        }

        PVector mouseCoordinates = Mouse.getMouseCoordinates();

        pushMatrix();
        translate(mouseCoordinates.x, mouseCoordinates.y);
        rotate(this.SlIDER_VALUES[12]);
        if(this.shapeType == ShapeType.CIRCLE) {
            float diameter = this.SLIDER_VALUES[4] * 2.0f;
            fill(this.SLIDER_VALUES[6], this.SLIDER_VALUES[7], this.SLIDER_VALUES[8], this.opacity);
            strokeWeight(this.SLIDER_VALUES[5]);
            stroke(this.SLIDER_VALUES[9], this.SLIDER_VALUES[10], this.SLIDER_VALUES[11], this.opacity);
            ellipseMode(CENTER);

            ellipse(0, 0, diameter,  diameter);

            PVector va = new PVector();
            PVector vb = new  PVector(radius, 0);
            va = PhysEngMath.Transform(va, new PVector(), this.SLIDER_VALUES[12]);
            vb = PhysEngMath.Transform(vb, new PVector(), this.SLIDER_VALUES[12]);
            line(va.x, va.y, vb.x, vb.y);

        
        } else if (this.shapeType == ShapeType.BOX && !this.copied) {
            fill(this.SLIDER_VALUES[6], this.SLIDER_VALUES[7], this.SLIDER_VALUES[8], this.opacity);
            strokeWeight(this.SLIDER_VALUES[5]);
            stroke(this.SLIDER_VALUES[9], this.SLIDER_VALUES[10], this.SLIDER_VALUES[11], this.opacity);
            rectMode(CENTER);
            rect(0, 0, this.SLIDER_VALUES[2], this.SLIDER_VALUES[3]);
        
        } /*else if(this.shapeType == ShapeType.BOX) {
            fill(this.fillColour.x, this.fillColour.y, this.fillColour.z, this.opacity);
            stroke(this.strokeColour.x, this.strokeColour.y, this.strokeColour.z, this.opacity);
            strokeWeight(this.strokeWeight);

            beginShape();
            for(PVector vertex : vertices) {
                vertex(vertex.x, vertex.y);
            }
            endShape();
        }
        */

        popMatrix();
    }
/*
====================================================================================================
======================================= Mouse Response  ============================================
====================================================================================================
*/
    @Override
    public void passiveResponse() {
        this.drawBodies();
    } 

    @Override
    public void onMouseDragged() {
        drawVelocityLine();
    }
    
    @Override
    public void onMouseReleased() {
        this.GenerateRigidbody();
    }

/*
====================================================================================================
======================================= GUI Response  ==============================================
====================================================================================================
*/
    @Override
    public void ToggleListener(ControlEvent ToggleEvent) {
        Controller ToggleEvent_Controller = ToggleEvent.getController();
            int ToggleEvent_Value = (int)ToggleEvent_Controller.getValue();
            String ToggleEvent_Controller_Name = ToggleEvent_Controller.getName();

        switch(ToggleEvent_Controller_Name) {
            case "RT_CircleToggle":
                this.ToggleResponseHandler(ToggleEvent_Value == 1, 0);
                break;
            case "RT_RectangleToggle":
                this.ToggleResponseHandler(ToggleEvent_Value == 1, 1);
                break;
            case "RT_FillColourToggle":
                this.ToggleResponseHandler(ToggleEvent_Value == 1, 2);
                break;
            case "RT_StrokeColourToggle":
                this.ToggleResponseHandler(ToggleEvent_Value == 1, 3);
                break;
            case "RT_IsStaticToggle":
                this.ToggleResponseHandler(ToggleEvent_Value == 1, 4);
                break;
            case "RT_IsTranslationallyStaticToggle":
                this.ToggleResponseHandler(ToggleEvent_Value == 1, 5);
                break;
            case "RT_IsRotationallyStaticToggle":
                this.ToggleResponseHandler(ToggleEvent_Value == 1, 6);
                break;
            case "RT_AddGravityToggle":
                this.ToggleResponseHandler(ToggleEvent_Value == 1, 7);
                break;
            case "RT_CollidabilityToggle":
                this.ToggleResponseHandler(ToggleEvent_Value == 1, 8);
                break;
            default:
                throw new IllegalArgumentException("Invalid toggle event controller name: " + ToggleEvent_Controller_Name);
        }
    }
    @Override
    public void ToggleResponseHandler(boolean ToggleEventValue, int ToggleEventID) {
        this.TOGGLE_STATES[ToggleEventID] = ToggleEventValue;

        switch(ToggleEventID) {
            case 0:
                this.HandleToggles(0, ToggleEventValue, this.CircleRectangleGroup, this.CircleRectangleGroupID, this.TOGGLE_STATES);
                this.VisibilityResponse();
                break;
            case 1:
                this.HandleToggles(1, ToggleEventValue, this.CircleRectangleGroup, this.CircleRectangleGroupID, this.TOGGLE_STATES);
                this.VisibilityResponse();
                break;
            case 2:
                this.HandleToggles(2, ToggleEventValue, this.FillStrokeGroup, this.FillStrokeGroupID, this.TOGGLE_STATES);
                this.VisibilityResponse();
                break;
            case 3:
                this.HandleToggles(3, ToggleEventValue, this.FillStrokeGroup, this.FillStrokeGroupID, this.TOGGLE_STATES);
                this.VisibilityResponse();
                break;
            case 4:
                this.HandleToggles(4, ToggleEventValue, this.StaticGroup, this.StaticGroupID, this.TOGGLE_STATES);
                break;
            case 5:
                this.HandleToggles(5, ToggleEventValue, this.StaticGroup, this.StaticGroupID, this.TOGGLE_STATES);
                break;
            case 6:
                this.HandleToggles(6, ToggleEventValue, this.StaticGroup, this.StaticGroupID, this.TOGGLE_STATES);
                break;
            case 7:
                this.HandleToggle(gui.RT_AddGravityToggle, 7, ToggleEventValue, this.TOGGLE_STATES);
                break;
            case 8:
                this.HandleToggle(gui.RT_CollidabilityToggle, 8, ToggleEventValue, this.TOGGLE_STATES);
                break;
        }
    }

    @Override
    public void SliderListener(ControlEvent SliderEvent) {
        Controller SliderEvent_Controller = SliderEvent.getController();
            float SliderEvent_value = SliderEvent_Controller.getValue();
            String SliderEvent_Controller_Name = SliderEvent_Controller.getName();
        
        switch(SliderEvent_Controller_Name) {
            case "RT_DensitySlider":
                this.SliderResponseHandler(SliderEvent_value, 0);
                break;
            case "RT_RestitutionSlider":
                this.SliderResponseHandler(SliderEvent_value, 1);
                break;
            case "RT_RectangleWidthSlider":
                this.SliderResponseHandler(SliderEvent_value, 2);
                break;
            case "RT_RectangleHeightSlider":
                this.SliderResponseHandler(SliderEvent_value, 3);
                break;
            case "RT_CircleRadiusSlider":
                this.SliderResponseHandler(SliderEvent_value, 4);
                break;
            case "RT_StrokeWeightSlider":
                this.SliderResponseHandler(SliderEvent_value, 5);
                break;
            case "RT_RedFillSlider":
                this.SliderResponseHandler(SliderEvent_value, 6);
                this.VisibilityResponse();
                break;
            case "RT_GreenFillSlider":
                this.SliderResponseHandler(SliderEvent_value, 7);
                this.VisibilityResponse();
                break;  
            case "RT_BlueFillSlider":
                this.SliderResponseHandler(SliderEvent_value, 8);
                this.VisibilityResponse();
                break;
            case "RT_RedStrokeSlider":
                this.SliderResponseHandler(SliderEvent_value, 9);
                this.VisibilityResponse();
                break;
            case "RT_GreenStrokeSlider":
                this.SliderResponseHandler(SliderEvent_value, 10);
                this.VisibilityResponse();
                break;
            case "RT_BlueStrokeSlider":
                this.SliderResponseHandler(SliderEvent_value, 11);
                this.VisibilityResponse();
                break;
            case "RT_AngleSlider":
                this.SliderResponseHandler(SliderEvent_value, 12);
                break;
            case "RT_AngularVelocitySlider":
                this.SliderResponseHandler(SliderEvent_value, 13);
                break;
        }
    }

    @Override
    public void SliderResponseHandler(float SliderEventValue, int SliderEventID) {
        this.SLIDER_VALUES[SliderEventID] = SliderEventValue;

        switch(SliderEventID) {
            case 0:
                this.density = SliderEventValue;
                break;
            case 1:
                this.restitution = SliderEventValue;
                break;
            case 2:
                this.width = SliderEventValue;
                break;
            case 3:
                this.height = SliderEventValue;
                break;
            case 4:
                this.radius = SliderEventValue;
                break;
            case 5:
                this.strokeWeight = SliderEventValue;
                break;
            case 6:
                this.fillColour.x = SliderEventValue;
                break;
            case 7:
                this.fillColour.y = SliderEventValue;
                break;
            case 8:
                this.fillColour.z = SliderEventValue;
                break;
            case 9:
                this.strokeColour.x = SliderEventValue;
                break;
            case 10:
                this.strokeColour.y = SliderEventValue;
                break;
            case 11:
                this.strokeColour.z = SliderEventValue;
                break;
            case 12:
                this.angle = SliderEventValue;
                break;
            case 13:
                this.angularVelocity = SliderEventValue;
                break;
        }
    }


    @Override
    public void VisibilityResponse() {

        gui.RT_RectangleWidthSlider.setVisible(this.TOGGLE_STATES[1]);
        gui.RT_RectangleHeightSlider.setVisible(this.TOGGLE_STATES[1]);

        gui.RT_CircleRadiusSlider.setVisible(this.TOGGLE_STATES[0]);

        gui.RT_DensitySlider.setVisible(this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]);
        gui.RT_RestitutionSlider.setVisible(this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]);

        gui.RT_FillColourToggle.setVisible(this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]);
        gui.RT_StrokeColourToggle.setVisible(this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]);
        gui.RT_StrokeWeightSlider.setVisible(this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]);

        gui.RT_RedFillSlider.setVisible(this.TOGGLE_STATES[2] && (this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]));
        gui.RT_GreenFillSlider.setVisible(this.TOGGLE_STATES[2] &&  (this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]));
        gui.RT_BlueFillSlider.setVisible(this.TOGGLE_STATES[2] && (this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]));

        gui.RT_RedFillSlider.setVisible(this.TOGGLE_STATES[2] && (this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]));
        gui.RT_GreenFillSlider.setVisible(this.TOGGLE_STATES[2] && (this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]));
        gui.RT_BlueFillSlider.setVisible(this.TOGGLE_STATES[2] && (this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]));

        gui.RT_RedStrokeSlider.setVisible(this.TOGGLE_STATES[3] && (this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]));
        gui.RT_GreenStrokeSlider.setVisible(this.TOGGLE_STATES[3] && (this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]));
        gui.RT_BlueStrokeSlider.setVisible(this.TOGGLE_STATES[3] && (this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]));

        gui.RT_ColorBang.setVisible(this.TOGGLE_STATES[2] || this.TOGGLE_STATES[3]);

        if(this.TOGGLE_STATES[2] || this.TOGGLE_STATES[3]) {
                if(this.TOGGLE_STATES[2]) {
                    gui.RT_ColorBang.setColorForeground(color(this.SLIDER_VALUES[6],this.SLIDER_VALUES[7], this.SLIDER_VALUES[8]));
                    gui.RT_ColorBang.setColorActive(color(this.SLIDER_VALUES[6],this.SLIDER_VALUES[7], this.SLIDER_VALUES[8]));
                } else if(this.TOGGLE_STATES[3]) {
                    gui.RT_ColorBang.setColorForeground(color(this.SLIDER_VALUES[9],this.SLIDER_VALUES[10], this.SLIDER_VALUES[11]));
                    gui.RT_ColorBang.setColorActive(color(this.SLIDER_VALUES[9],this.SLIDER_VALUES[10], this.SLIDER_VALUES[11]));
                }
        }

        gui.RT_IsStaticToggle.setVisible(this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]);
        gui.RT_IsTranslationallyStaticToggle.setVisible(this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]);
        gui.RT_IsRotationallyStaticToggle.setVisible(this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]);

        gui.RT_AngleSlider.setVisible(this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]);
        gui.RT_AngularVelocitySlider.setVisible(this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]);

        gui.RT_AddGravityToggle.setVisible(this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]);
        gui.RT_CollidabilityToggle.setVisible(this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]);
    }

        
/*
====================================================================================================
======================================= Key Response  ==============================================
====================================================================================================
*/
    @Override
    public void keyPressedResponse() {
        if(this.isKeyDown(KeyEvent.VK_SHIFT)) {
           if(this.isKeyDown(KeyEvent.VK_W)) {
               if(this.TOGGLE_STATES[0]) {
                   gui.RT_CircleRadiusSlider.setValue(gui.RT_CircleRadiusSlider.getValue() + 0.5f);
               } else if(this.TOGGLE_STATES[1]) {
                   gui.RT_RectangleHeightSlider.setValue(gui.RT_RectangleHeightSlider.getValue() + 1f);
               }
           } else if(this.isKeyDown(KeyEvent.VK_S)) {
               if(this.TOGGLE_STATES[0]) {
                   gui.RT_CircleRadiusSlider.setValue(gui.RT_CircleRadiusSlider.getValue() - 0.5f);
               } else if(this.TOGGLE_STATES[1]) {
                   gui.RT_RectangleHeightSlider.setValue(gui.RT_RectangleHeightSlider.getValue() - 1f);
               }
           } else if(this.isKeyDown(KeyEvent.VK_A)) {
               if(this.TOGGLE_STATES[0]) {
                   gui.RT_CircleRadiusSlider.setValue(gui.RT_CircleRadiusSlider.getValue() - 0.5f);
               } else if(this.TOGGLE_STATES[1]) {
                   gui.RT_RectangleWidthSlider.setValue(gui.RT_RectangleWidthSlider.getValue() - 1f);
               }
           } else if(this.isKeyDown(KeyEvent.VK_D)) {
               if(this.TOGGLE_STATES[0]) {
                   gui.RT_CircleRadiusSlider.setValue(gui.RT_CircleRadiusSlider.getValue() + 0.5f);
               } else if(this.TOGGLE_STATES[1]) {
                   gui.RT_RectangleWidthSlider.setValue(gui.RT_RectangleWidthSlider.getValue() + 1f);
               }
           }
        } else {
            if(this.isKeyDown(KeyEvent.VK_1)) {
               this.HandleToggles(0, !this.TOGGLE_STATES[0], this.CircleRectangleGroup, this.CircleRectangleGroupID, this.TOGGLE_STATES);
           } else if(this.isKeyDown(KeyEvent.VK_2)) {
               this.HandleToggles(1, !this.TOGGLE_STATES[1], this.CircleRectangleGroup, this.CircleRectangleGroupID, this.TOGGLE_STATES);
           }
        }      
    }

/*
====================================================================================================
======================================= Getters and Setters ========================================
====================================================================================================
*/
    public void setToggles(Toggle[] toggles) {
        this.TOGGLES = toggles;
    }

    public void setCircleRectangleGroup(Toggle[] circleRectangleGroup) {
        this.CircleRectangleGroup = circleRectangleGroup;
    }

    public void setFillStrokeGroup(Toggle[] fillStrokeGroup) {
        this.FillStrokeGroup = fillStrokeGroup;
    }

    public void setStaticGroup(Toggle[] staticGroup) {
        this.StaticGroup = staticGroup;
    }
}