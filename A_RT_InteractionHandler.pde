public class RT_InteractionHandler extends TabInteractionHandlerAbstract {

    /*
    ID 0: RT_Circle_Toggle => Default: false
    ID 1: RT_Rectangle_Toggle => Default: false
    ID 2: RT_FillColour => Default: true
    ID 3: RT_StrokeColour => Default: false
    ID 4: RT_IsStatic => Default: false
    ID 5: RT_IsTranslationallyStatic => Default: false
    ID 6: RT_IsRotationallyStatic => Default: false
    ID 7: RT_AddGravity => Default: false
    ID 8: RT_Collidability => Default: false
    */

    private boolean MOUSE_LEFT_DOWN = false;

    private boolean[] TOGGLE_STATES = {false, false, true, false, false, false, false, true, true};


    /*
    ID 0: RT_Density_Slider => Default: 10
    ID 1: RT_Restitution_Slider => Default: 0.5
    ID 2: RT_Rectangle_Width_Slider => Default: 2
    ID 3: RT_Rectangle_Height_Slider => Default: 2
    ID 4: RT_Circle_Radius_Slider => Default: 1
    ID 5: RT_StrokeWeight_Slider => Default: 0.05
    ID 6: RT_RedFill_Slider => Default: 255
    ID 7: RT_GreenFill_Slider => Default: 255
    ID 8: RT_BlueFill_Slider => Default: 255
    ID 9: RT_RedStroke_Slider => Default: 0
    ID 10: RT_GreenStroke_Slider => Default: 0
    ID 11: RT_BlueStroke_Slider => Default: 0
    ID 12: RT_Angle_Slider => Default: 0
    ID 13: RT_AngularVelocity_Slider => Default: 0
    */
    private float[] SLIDER_VALUES = {10f, 0.5f, 2f, 2f, 1f, 0.05f, 255, 255, 255, 0, 0, 0, 0, 0};

    


/*
====================================================================================================
======================================= Main Methods ===============================================
====================================================================================================
*/

    public void GenerateRigidbody() {

        /* ------ Checks ------- */
        if(Mouse.getIsMouseOverUI() || (!IS_PAUSED && Mouse.getRigidbodyUnderMouse() != null)) {
            return;
        }
        if(!(this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1])) {
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
            
            
            PVector clamped = PhysEngMath.MouseVelocityCalculationAndClamp(Mouse.getMouseDownCoordinates(), Mouse.getMouseCoordinates(), 
                                                                        MIN_MOUSE_VELOCITY_MAG, MAX_MOUSE_VELOCITY_MAG);
            PVector endPoint = PVector.add(Mouse.getMouseDownCoordinates(), clamped);

            rigidbody.SetInitialPosition(endPoint);
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
            PVector clamped = PhysEngMath.MouseVelocityCalculationAndClamp(Mouse.getMouseDownCoordinates(), 
                                                                            Mouse.getMouseCoordinates(), 
                                                                            MIN_MOUSE_VELOCITY_MAG, 
                                                                            MAX_MOUSE_VELOCITY_MAG);

            rigidbody.SetInitialPosition(PVector.add(Mouse.getMouseDownCoordinates(), clamped));
            rigidbody.setVelocity(PhysEngMath.SquareVelocity(clamped).mult(-1));
            rigidbody.setIsTranslationallyStatic(this.TOGGLE_STATES[5]);
            rigidbody.setCollidability(this.TOGGLE_STATES[8]);
            rigidbody.setIsRotationallyStatic(this.TOGGLE_STATES[6]);
            rigidbody.RotateTo(radians(this.SLIDER_VALUES[12]));
            rigidbody.setAngularVelocity(this.SLIDER_VALUES[13]);

            if(this.TOGGLE_STATES[7]) {
                rigidbody.addForceToForceRegistry(new Gravity(rigidbody));
            }

            AddBodyToBodyEntityList(rigidbody);
            return;
        }
    }

    public void drawVelocityLine() {
        PVector mouseDownCoordinates = Mouse.getMouseDownCoordinates();
        PVector clamped = PhysEngMath.MouseVelocityCalculationAndClamp(mouseDownCoordinates, Mouse.getMouseCoordinates(), 
                                                                        MIN_MOUSE_VELOCITY_MAG, MAX_MOUSE_VELOCITY_MAG);
        PVector endPoint = PVector.add(mouseDownCoordinates, clamped);

        if(PVector.sub(mouseDownCoordinates, endPoint).magSq() > 0.1f){
            stroke(lerpColor(color(0, 255, 0), color(255, 0, 0), sq(map(clamped.mag(), MIN_MOUSE_VELOCITY_MAG, MAX_MOUSE_VELOCITY_MAG, 0, 1))));
            line(mouseDownCoordinates.x, mouseDownCoordinates.y, endPoint.x, endPoint.y);
        }
    }



    public void drawBodies() {
        if(!(this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1])) {
            return;
        }

        PVector clamped = new PVector();
        if(MOUSE_LEFT_DOWN == true) {
            clamped = PhysEngMath.MouseVelocityCalculationAndClamp(Mouse.getMouseDownCoordinates(), 
                                                                    Mouse.getMouseCoordinates(), 
                                                                    MIN_MOUSE_VELOCITY_MAG, 
                                                                    MAX_MOUSE_VELOCITY_MAG);
            clamped.add(Mouse.getMouseDownCoordinates());
        } else {
            clamped = Mouse.getMouseCoordinates();
        }


        
        pushMatrix();
        translate(clamped.x, clamped.y);
        rotate(radians(this.SLIDER_VALUES[12]));
        if(this.TOGGLE_STATES[0]) {
            float diameter = this.SLIDER_VALUES[4] * 2.0f;
            fill(this.SLIDER_VALUES[6], this.SLIDER_VALUES[7], this.SLIDER_VALUES[8], this.OPACITY);
            strokeWeight(this.SLIDER_VALUES[5]);
            stroke(this.SLIDER_VALUES[9], this.SLIDER_VALUES[10], this.SLIDER_VALUES[11], this.OPACITY);
            ellipseMode(CENTER);

            ellipse(0, 0, diameter,  diameter);

            PVector va = new PVector();
            PVector vb = new  PVector(this.SLIDER_VALUES[4], 0);
            va = PhysEngMath.Transform(va, new PVector(), radians(this.SLIDER_VALUES[12]));
            vb = PhysEngMath.Transform(vb, new PVector(), radians(this.SLIDER_VALUES[12]));
            line(va.x, va.y, vb.x, vb.y);

            //this.TOGGLE_STATES[1] && !this.copied
        } else if (this.TOGGLE_STATES[1]) {
            fill(this.SLIDER_VALUES[6], this.SLIDER_VALUES[7], this.SLIDER_VALUES[8], this.OPACITY);
            strokeWeight(this.SLIDER_VALUES[5]);
            stroke(this.SLIDER_VALUES[9], this.SLIDER_VALUES[10], this.SLIDER_VALUES[11], this.OPACITY);
            rectMode(CENTER);
            rect(0, 0, this.SLIDER_VALUES[2], this.SLIDER_VALUES[3]);
        
        } /*else if(this.shapeType == ShapeType.BOX) {
            fill(this.fillColour.x, this.fillColour.y, this.fillColour.z, this.OPACITY);
            stroke(this.strokeColour.x, this.strokeColour.y, this.strokeColour.z, this.OPACITY);
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

        if(MOUSE_LEFT_DOWN == true) {
            this.drawVelocityLine();
        }
    } 


    @Override
    public void onMousePressed() {
        if(mouseButton == LEFT) {
            this.MOUSE_LEFT_DOWN = true;
        }
    }
    @Override
    public void onMouseDragged() {
    }
    
    @Override
    public void onMouseReleased() {
        this.MOUSE_LEFT_DOWN = false;
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
            case "RT_Circle_Toggle":
                this.ToggleResponseHandler(ToggleEvent_Value == 1, 0);
                break;
            case "RT_Rectangle_Toggle":
                this.ToggleResponseHandler(ToggleEvent_Value == 1, 1);
                break;
            case "RT_FillColour_Toggle":
                this.ToggleResponseHandler(ToggleEvent_Value == 1, 2);
                break;
            case "RT_StrokeColour_Toggle":
                this.ToggleResponseHandler(ToggleEvent_Value == 1, 3);
                break;
            case "RT_IsStatic_Toggle":
                this.ToggleResponseHandler(ToggleEvent_Value == 1, 4);
                break;
            case "RT_IsTranslationallyStatic_Toggle":
                this.ToggleResponseHandler(ToggleEvent_Value == 1, 5);
                break;
            case "RT_IsRotationallyStatic_Toggle":
                this.ToggleResponseHandler(ToggleEvent_Value == 1, 6);
                break;
            case "RT_AddGravity_Toggle":
                this.ToggleResponseHandler(ToggleEvent_Value == 1, 7);
                break;
            case "RT_Collidability_Toggle":
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
                if(ToggleEventValue) {
                    this.HandleToggle(gui.RT_Circle_Toggle, 0, true, this.TOGGLE_STATES);
                    this.HandleToggle(gui.RT_Rectangle_Toggle, 1, false, this.TOGGLE_STATES);
                } else {
                    this.HandleToggle(gui.RT_Circle_Toggle, 0, false, this.TOGGLE_STATES);
                }
                this.VisibilityResponse();
                break;
            case 1:
                if(ToggleEventValue) {
                    this.HandleToggle(gui.RT_Circle_Toggle, 0, false, this.TOGGLE_STATES);
                    this.HandleToggle(gui.RT_Rectangle_Toggle, 1, true, this.TOGGLE_STATES);
                } else {
                    this.HandleToggle(gui.RT_Rectangle_Toggle, 1, false, this.TOGGLE_STATES);
                }
                this.VisibilityResponse();
                break;
            case 2:
                if(ToggleEventValue) {
                    this.HandleToggle(gui.RT_FillColour_Toggle, 2, true, this.TOGGLE_STATES);
                    this.HandleToggle(gui.RT_StrokeColour_Toggle, 3, false, this.TOGGLE_STATES);
                } else {
                    this.HandleToggle(gui.RT_FillColour_Toggle, 2, false, this.TOGGLE_STATES);
                }
                this.VisibilityResponse();
                break;
            case 3:
                if(ToggleEventValue) {
                    this.HandleToggle(gui.RT_FillColour_Toggle, 2, false, this.TOGGLE_STATES);
                    this.HandleToggle(gui.RT_StrokeColour_Toggle, 3, true, this.TOGGLE_STATES);
                } else {
                    this.HandleToggle(gui.RT_StrokeColour_Toggle, 3, false, this.TOGGLE_STATES);
                }
                this.VisibilityResponse();
                break;
            case 4:
                if(ToggleEventValue) {
                    this.HandleToggle(gui.RT_IsStatic_Toggle, 4, true, this.TOGGLE_STATES);
                    this.HandleToggle(gui.RT_IsTranslationallyStatic_Toggle, 5, false, this.TOGGLE_STATES);
                    this.HandleToggle(gui.RT_IsRotationallyStatic_Toggle, 6, false, this.TOGGLE_STATES);
                } else {
                    this.HandleToggle(gui.RT_IsStatic_Toggle, 4, false, this.TOGGLE_STATES);
                }
                break;
            case 5:
                if(ToggleEventValue) {
                    this.HandleToggle(gui.RT_IsStatic_Toggle, 4, false, this.TOGGLE_STATES);
                    this.HandleToggle(gui.RT_IsTranslationallyStatic_Toggle, 5, true, this.TOGGLE_STATES);
                    this.HandleToggle(gui.RT_IsRotationallyStatic_Toggle, 6, false, this.TOGGLE_STATES);
                } else {
                    this.HandleToggle(gui.RT_IsTranslationallyStatic_Toggle, 5, false, this.TOGGLE_STATES);
                }
                break;
            case 6:
                if(ToggleEventValue) {
                    this.HandleToggle(gui.RT_IsStatic_Toggle, 4, false, this.TOGGLE_STATES);
                    this.HandleToggle(gui.RT_IsTranslationallyStatic_Toggle, 5, false, this.TOGGLE_STATES);
                    this.HandleToggle(gui.RT_IsRotationallyStatic_Toggle, 6, true, this.TOGGLE_STATES);
                } else {
                    this.HandleToggle(gui.RT_IsRotationallyStatic_Toggle, 6, false, this.TOGGLE_STATES);
                }
                break;
            case 7:
                this.HandleToggle(gui.RT_AddGravity_Toggle, 7, ToggleEventValue, this.TOGGLE_STATES);
                break;
            case 8:
                this.HandleToggle(gui.RT_Collidability_Toggle, 8, ToggleEventValue, this.TOGGLE_STATES);
                break;
        }
    }

    @Override
    public void SliderListener(ControlEvent SliderEvent) {
        Controller SliderEvent_Controller = SliderEvent.getController();
            float SliderEvent_value = SliderEvent_Controller.getValue();
            String SliderEvent_Controller_Name = SliderEvent_Controller.getName();
        
        switch(SliderEvent_Controller_Name) {
            case "RT_Density_Slider":
                this.SliderResponseHandler(SliderEvent_value, 0);
                break;
            case "RT_Restitution_Slider":
                this.SliderResponseHandler(SliderEvent_value, 1);
                break;
            case "RT_Rectangle_Width_Slider":
                this.SliderResponseHandler(SliderEvent_value, 2);
                break;
            case "RT_Rectangle_Height_Slider":
                this.SliderResponseHandler(SliderEvent_value, 3);
                break;
            case "RT_Circle_Radius_Slider":
                this.SliderResponseHandler(SliderEvent_value, 4);
                break;
            case "RT_StrokeWeight_Slider":
                this.SliderResponseHandler(SliderEvent_value, 5);
                break;
            case "RT_RedFill_Slider":
                this.SliderResponseHandler(SliderEvent_value, 6);
                this.VisibilityResponse();
                break;
            case "RT_GreenFill_Slider":
                this.SliderResponseHandler(SliderEvent_value, 7);
                this.VisibilityResponse();
                break;  
            case "RT_BlueFill_Slider":
                this.SliderResponseHandler(SliderEvent_value, 8);
                this.VisibilityResponse();
                break;
            case "RT_RedStroke_Slider":
                this.SliderResponseHandler(SliderEvent_value, 9);
                this.VisibilityResponse();
                break;
            case "RT_GreenStroke_Slider":
                this.SliderResponseHandler(SliderEvent_value, 10);
                this.VisibilityResponse();
                break;
            case "RT_BlueStroke_Slider":
                this.SliderResponseHandler(SliderEvent_value, 11);
                this.VisibilityResponse();
                break;
            case "RT_Angle_Slider":
                this.SliderResponseHandler(SliderEvent_value, 12);
                break;
            case "RT_AngularVelocity_Slider":
                this.SliderResponseHandler(SliderEvent_value, 13);
                break;
        }
    }

    @Override
    public void SliderResponseHandler(float SliderEventValue, int SliderEventID) {
        this.SLIDER_VALUES[SliderEventID] = SliderEventValue;

        switch(SliderEventID) {
            case 0:
                this.HandleSlider(gui.RT_Density_Slider, 0, SliderEventValue, this.SLIDER_VALUES);
                break;
            case 1:
                this.HandleSlider(gui.RT_Restitution_Slider, 1, SliderEventValue, this.SLIDER_VALUES);
                break;
            case 2:
                this.HandleSlider(gui.RT_Rectangle_Width_Slider, 2, SliderEventValue, this.SLIDER_VALUES);
                break;
            case 3:
                this.HandleSlider(gui.RT_Rectangle_Height_Slider, 3, SliderEventValue, this.SLIDER_VALUES);
                break;
            case 4:
                this.HandleSlider(gui.RT_Circle_Radius_Slider, 4, SliderEventValue, this.SLIDER_VALUES);
                break;
            case 5:
                this.HandleSlider(gui.RT_StrokeWeight_Slider, 5, SliderEventValue, this.SLIDER_VALUES);
                break;
            case 6:
                this.HandleSlider(gui.RT_RedFill_Slider, 6, SliderEventValue, this.SLIDER_VALUES);
                break;
            case 7:
                this.HandleSlider(gui.RT_GreenFill_Slider, 7, SliderEventValue, this.SLIDER_VALUES);
                break;
            case 8:
                this.HandleSlider(gui.RT_BlueFill_Slider, 8, SliderEventValue, this.SLIDER_VALUES);
                break;
            case 9:
                this.HandleSlider(gui.RT_RedStroke_Slider, 9, SliderEventValue, this.SLIDER_VALUES);
                break;
            case 10:
                this.HandleSlider(gui.RT_GreenStroke_Slider, 10, SliderEventValue, this.SLIDER_VALUES);
                break;
            case 11:
                this.HandleSlider(gui.RT_BlueStroke_Slider, 11, SliderEventValue, this.SLIDER_VALUES);
                break;
            case 12:
                this.HandleSlider(gui.RT_Angle_Slider, 12, SliderEventValue, this.SLIDER_VALUES);
                break;
            case 13:
                this.HandleSlider(gui.RT_AngularVelocity_Slider, 13, SliderEventValue, this.SLIDER_VALUES);
                break;
            
        }
    }
         

    @Override
    public void DefaultValueInitialization() {
    }

    @Override
    public void VisibilityResponse() {
        gui.RT_Rectangle_Width_Slider.setVisible(this.TOGGLE_STATES[1]);
        gui.RT_Rectangle_Height_Slider.setVisible(this.TOGGLE_STATES[1]);

        gui.RT_Circle_Radius_Slider.setVisible(this.TOGGLE_STATES[0]);

        gui.RT_Density_Slider.setVisible(this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]);
        gui.RT_Restitution_Slider.setVisible(this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]);

        gui.RT_FillColour_Toggle.setVisible(this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]);
        gui.RT_StrokeColour_Toggle.setVisible(this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]);
        gui.RT_StrokeWeight_Slider.setVisible(this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]);

        gui.RT_RedFill_Slider.setVisible(this.TOGGLE_STATES[2] && (this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]));
        gui.RT_GreenFill_Slider.setVisible(this.TOGGLE_STATES[2] &&  (this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]));
        gui.RT_BlueFill_Slider.setVisible(this.TOGGLE_STATES[2] && (this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]));

        gui.RT_RedFill_Slider.setVisible(this.TOGGLE_STATES[2] && (this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]));
        gui.RT_GreenFill_Slider.setVisible(this.TOGGLE_STATES[2] && (this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]));
        gui.RT_BlueFill_Slider.setVisible(this.TOGGLE_STATES[2] && (this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]));

        gui.RT_RedStroke_Slider.setVisible(this.TOGGLE_STATES[3] && (this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]));
        gui.RT_GreenStroke_Slider.setVisible(this.TOGGLE_STATES[3] && (this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]));
        gui.RT_BlueStroke_Slider.setVisible(this.TOGGLE_STATES[3] && (this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]));

        gui.RT_Color_Bang.setVisible((this.TOGGLE_STATES[2] || this.TOGGLE_STATES[3]) && (this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]));

        if(this.TOGGLE_STATES[2] || this.TOGGLE_STATES[3]) {
                if(this.TOGGLE_STATES[2]) {
                    gui.RT_Color_Bang.setColorForeground(color(this.SLIDER_VALUES[6],this.SLIDER_VALUES[7], this.SLIDER_VALUES[8]));
                    gui.RT_Color_Bang.setColorActive(color(this.SLIDER_VALUES[6],this.SLIDER_VALUES[7], this.SLIDER_VALUES[8]));
                } else if(this.TOGGLE_STATES[3]) {
                    gui.RT_Color_Bang.setColorForeground(color(this.SLIDER_VALUES[9],this.SLIDER_VALUES[10], this.SLIDER_VALUES[11]));
                    gui.RT_Color_Bang.setColorActive(color(this.SLIDER_VALUES[9],this.SLIDER_VALUES[10], this.SLIDER_VALUES[11]));
                }
        }

        gui.RT_IsStatic_Toggle.setVisible(this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]);
        gui.RT_IsTranslationallyStatic_Toggle.setVisible(this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]);
        gui.RT_IsRotationallyStatic_Toggle.setVisible(this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]);

        gui.RT_Angle_Slider.setVisible(this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]);
        gui.RT_AngularVelocity_Slider.setVisible(this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]);

        gui.RT_AddGravity_Toggle.setVisible(this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]);
        gui.RT_Collidability_Toggle.setVisible(this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1]);
    }

        
/*
====================================================================================================
======================================= Key Response  ==============================================
====================================================================================================
*/



    /*
    ID 0: RT_Density_Slider
    ID 1: RT_Restitution_Slider
    ID 2: RT_Rectangle_Width_Slider
    ID 3: RT_Rectangle_Height_Slider
    ID 4: RT_Circle_Radius_Slider
    ID 5: RT_StrokeWeight_Slider
    ID 6: RT_RedFill_Slider
    ID 7: RT_GreenFill_Slider
    ID 8: RT_BlueFill_Slider
    ID 9: RT_RedStroke_Slider
    ID 10: RT_GreenStroke_Slider
    ID 11: RT_BlueStroke_Slider
    ID 12: RT_Angle_Slider
    ID 13: RT_AngularVelocity_Slider
    */

    @Override
    public void onKeyPressed() {
        if(this.isKeyDown(KeyEvent.VK_SHIFT)) {
           if(this.isKeyDown(KeyEvent.VK_W)) {
               if(this.TOGGLE_STATES[0]) {
                    this.HandleSlider(gui.RT_Circle_Radius_Slider, 4, this.SLIDER_VALUES[4] + 0.5f, this.SLIDER_VALUES);
               } else if(this.TOGGLE_STATES[1]) {
                    this.HandleSlider(gui.RT_Rectangle_Height_Slider, 3, this.SLIDER_VALUES[3] + 1f, this.SLIDER_VALUES);
               }
           } else if(this.isKeyDown(KeyEvent.VK_S)) {
               if(this.TOGGLE_STATES[0]) {  
                    this.HandleSlider(gui.RT_Circle_Radius_Slider, 4, this.SLIDER_VALUES[4] - 0.5f, this.SLIDER_VALUES);
               } else if(this.TOGGLE_STATES[1]) {
                    this.HandleSlider(gui.RT_Rectangle_Height_Slider, 3, this.SLIDER_VALUES[3] - 1f, this.SLIDER_VALUES);
               }
           } else if(this.isKeyDown(KeyEvent.VK_A)) {
               if(this.TOGGLE_STATES[0]) {
                    this.HandleSlider(gui.RT_Circle_Radius_Slider, 4, this.SLIDER_VALUES[4] - 0.5f, this.SLIDER_VALUES);
               } else if(this.TOGGLE_STATES[1]) {
                    this.HandleSlider(gui.RT_Rectangle_Width_Slider, 2, this.SLIDER_VALUES[2] - 1f, this.SLIDER_VALUES);
               }
           } else if(this.isKeyDown(KeyEvent.VK_D)) {
               if(this.TOGGLE_STATES[0]) {
                    this.HandleSlider(gui.RT_Circle_Radius_Slider, 4, this.SLIDER_VALUES[4] + 0.5f, this.SLIDER_VALUES);
               } else if(this.TOGGLE_STATES[1]) {
                    this.HandleSlider(gui.RT_Rectangle_Width_Slider, 2, this.SLIDER_VALUES[2] + 1f, this.SLIDER_VALUES);
               }
           } else if(this.isKeyDown(KeyEvent.VK_E)) {

                if(this.SLIDER_VALUES[12] + 10 > 360) {
                    this.HandleSlider(gui.RT_Angle_Slider, 12, ((this.SLIDER_VALUES[12] + 10) % 360) - 360, this.SLIDER_VALUES);
                } else {
                    this.HandleSlider(gui.RT_Angle_Slider, 12, this.SLIDER_VALUES[12] + 10, this.SLIDER_VALUES);
                }
           } else if(this.isKeyDown(KeyEvent.VK_Q)) {
                if(this.SLIDER_VALUES[12] - 10 < -360) {
                    this.HandleSlider(gui.RT_Angle_Slider, 12, ((this.SLIDER_VALUES[12] - 10) % 360) + 360, this.SLIDER_VALUES);
                } else {
                    this.HandleSlider(gui.RT_Angle_Slider, 12, this.SLIDER_VALUES[12] - 10, this.SLIDER_VALUES);
                }
           }
        } else {
           if(this.isKeyDown(KeyEvent.VK_W)) {
               if(this.TOGGLE_STATES[0]) {
                    this.HandleSlider(gui.RT_Circle_Radius_Slider, 4, this.SLIDER_VALUES[4] + 0.05f, this.SLIDER_VALUES);
               } else if(this.TOGGLE_STATES[1]) {
                    this.HandleSlider(gui.RT_Rectangle_Height_Slider, 3, this.SLIDER_VALUES[2] + 0.1f, this.SLIDER_VALUES);
               }
           } else if(this.isKeyDown(KeyEvent.VK_S)) {
               if(this.TOGGLE_STATES[0]) {  
                    this.HandleSlider(gui.RT_Circle_Radius_Slider, 4, this.SLIDER_VALUES[4] - 0.05f, this.SLIDER_VALUES);
               } else if(this.TOGGLE_STATES[1]) {
                    this.HandleSlider(gui.RT_Rectangle_Height_Slider, 3, this.SLIDER_VALUES[3] - 0.1f, this.SLIDER_VALUES);
               }
           } else if(this.isKeyDown(KeyEvent.VK_A)) {
               if(this.TOGGLE_STATES[0]) {
                    this.HandleSlider(gui.RT_Circle_Radius_Slider, 4, this.SLIDER_VALUES[4] - 0.05f, this.SLIDER_VALUES);
               } else if(this.TOGGLE_STATES[1]) {
                    this.HandleSlider(gui.RT_Rectangle_Width_Slider, 2, this.SLIDER_VALUES[2] - 0.1f, this.SLIDER_VALUES);
               }
           } else if(this.isKeyDown(KeyEvent.VK_D)) {
               if(this.TOGGLE_STATES[0]) {
                    this.HandleSlider(gui.RT_Circle_Radius_Slider, 4, this.SLIDER_VALUES[4] + 0.05f, this.SLIDER_VALUES);
               } else if(this.TOGGLE_STATES[1]) {
                    this.HandleSlider(gui.RT_Rectangle_Width_Slider, 2, this.SLIDER_VALUES[2] + 0.1f, this.SLIDER_VALUES);
               }
           } else if(this.isKeyDown(KeyEvent.VK_E)) {
                if(this.SLIDER_VALUES[12] + 1 > 360) {
                    this.HandleSlider(gui.RT_Angle_Slider, 12, ((this.SLIDER_VALUES[12] + 1) % 360) - 360, this.SLIDER_VALUES);
                } else {
                    this.HandleSlider(gui.RT_Angle_Slider, 12, this.SLIDER_VALUES[12] + 1, this.SLIDER_VALUES);
                }
           } else if(this.isKeyDown(KeyEvent.VK_Q)) {
                if(this.SLIDER_VALUES[12] - 1 < -360) {
                    this.HandleSlider(gui.RT_Angle_Slider, 12, ((this.SLIDER_VALUES[12] - 1) % 360) + 360, this.SLIDER_VALUES);
                } else {
                    this.HandleSlider(gui.RT_Angle_Slider, 12, this.SLIDER_VALUES[12] - 1, this.SLIDER_VALUES);
                }
           } else if(this.isKeyDown(KeyEvent.VK_1)) {
                if(!this.TOGGLE_STATES[0]) {
                    this.HandleToggle(gui.RT_Circle_Toggle, 0, true, this.TOGGLE_STATES);
                    this.HandleToggle(gui.RT_Rectangle_Toggle, 1, false, this.TOGGLE_STATES);
                    this.VisibilityResponse();
                } else {
                    this.HandleToggle(gui.RT_Circle_Toggle, 0, false, this.TOGGLE_STATES);
                    this.VisibilityResponse();
                }
               this.VisibilityResponse();
           } else if(this.isKeyDown(KeyEvent.VK_2)) {
               if(!this.TOGGLE_STATES[1]) {
                    this.HandleToggle(gui.RT_Circle_Toggle, 0, false, this.TOGGLE_STATES);
                    this.HandleToggle(gui.RT_Rectangle_Toggle, 1, true, this.TOGGLE_STATES);
                    this.VisibilityResponse();
                } else {
                    this.HandleToggle(gui.RT_Rectangle_Toggle, 1, false, this.TOGGLE_STATES);
                    this.VisibilityResponse();
                }
           } else if(this.isKeyDown(KeyEvent.VK_4)) {
                if(!this.TOGGLE_STATES[4]) {
                    this.HandleToggle(gui.RT_IsStatic_Toggle, 4, true, this.TOGGLE_STATES);
                    this.HandleToggle(gui.RT_IsTranslationallyStatic_Toggle, 5, false, this.TOGGLE_STATES);
                    this.HandleToggle(gui.RT_IsRotationallyStatic_Toggle, 6, false, this.TOGGLE_STATES);
                } else {
                    this.HandleToggle(gui.RT_IsStatic_Toggle, 4, false, this.TOGGLE_STATES);
                
                }
           } else if(this.isKeyDown(KeyEvent.VK_5)) {
                if(!this.TOGGLE_STATES[5]) {
                    this.HandleToggle(gui.RT_IsStatic_Toggle, 4, false, this.TOGGLE_STATES);
                    this.HandleToggle(gui.RT_IsTranslationallyStatic_Toggle, 5, true, this.TOGGLE_STATES);
                    this.HandleToggle(gui.RT_IsRotationallyStatic_Toggle, 6, false, this.TOGGLE_STATES);
                } else {
                    this.HandleToggle(gui.RT_IsTranslationallyStatic_Toggle, 5, false, this.TOGGLE_STATES);
                
                }
           } else if(this.isKeyDown(KeyEvent.VK_6)) {
                if(!this.TOGGLE_STATES[6]) {
                    this.HandleToggle(gui.RT_IsStatic_Toggle, 4, false, this.TOGGLE_STATES);
                    this.HandleToggle(gui.RT_IsTranslationallyStatic_Toggle, 5, false, this.TOGGLE_STATES);
                    this.HandleToggle(gui.RT_IsRotationallyStatic_Toggle, 6, true, this.TOGGLE_STATES);
                } else {
                    this.HandleToggle(gui.RT_IsRotationallyStatic_Toggle, 6, false, this.TOGGLE_STATES);
                }
           }
        }      
    }

/*
====================================================================================================
======================================= Getters and Setters ========================================
====================================================================================================
*/  
    public void setToggleState(int index, boolean state) {
        this.TOGGLE_STATES[index] = state;
    }

    public void setSliderValue(int index, float value) {
        this.SLIDER_VALUES[index] = value;
    }
}
