public class InteractionCache {

    /*
    How this is going to work:
    Basically what your doing at the moment is trying to update the gui using a much neater, more modular,
    and efficient system. Your using the plugTo in conjunction with the eventListener to get which
    button is being pressed etc, and you want to have this all update in here. You want to only
    rely on this class to update values for everything, that includes mouse down,
    key down, and the gui. You want to have a method for each type of input, and then you want to
    update stuff like the editor, interactivity listener, etc, using these values. This should be
    the central hub for basically every interaction the user makes with the system, and this should
    be more effective.

    On your list of other things your doing, you need to implement drag and dropping of multi shape
    selections, including being able to copy and paste a selection. you want to maybe implement the rod
    gravity idea, and you also want to add convex polygon decomposition. you are also going to make
    a seperate editor tab, settings tab, help tab, etc. and importing custom creations. remember the id
    system, and how you are coordinating that. Also review how you treat keydown inputs, and remember to use
    switch cases when possible. Also remember to use the keylistener and mouselistener classes to
    update the interaction cache, and then use the interaction cache to update the gui and the editor.
    */

    
    private boolean[] keyDownCache = new boolean[256];


    /*
    Index 1: Mouse button left
    Index 2: Mouse button middle
    Index 3: Mouse button right
    */
    private boolean[] mouseDownCache = new boolean[3];


    /*
    ID 0: RigidbodyTab
    ID 1: ForceTab
    ID 2: EditorTab
    ID 3: CreationTab
    ID 4: SettingsTab
    ID 5: HelpTab
    */
    private int activeTabID = 0;


/*-------------------------------------- Rigidbody Tab -------------------------------------------*/
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
    private boolean[] RT_TOGGLE_STATES = new boolean[9];


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
    private float[] RT_SLIDER_VALUES = new float[14];


    public void onTabChange(int activeTabID) {
        this.activeTabID = activeTabID;
    }

/*
====================================================================================================
====================================== Rigidbody Generation ========================================
====================================================================================================
*/

    public void RT_ToggleListener(ControlEvent RT_ToggleEvent) {
        Controller RT_ToggleEvent_Controller = RT_ToggleEvent.getController();
            int value = (int)RT_ToggleEvent_Controller.getValue();
            String RT_ToggleEvent_Controller_Name = RT_ToggleEvent_Controller.getName();

            switch(RT_ToggleEvent_Controller_Name) {
                case "RT_CircleToggle":
                    this.RT_TOGGLE_STATES[0] = (value == 1) ? true : false;
                    this.RT_ToggleResponse(this.RT_TOGGLE_STATES[0], 0);
                    this.RT_ToggleInteractivityListenerResponse(this.RT_TOGGLE_STATES[0], 0);
                    break;
                case "RT_RectangleToggle":
                    this.RT_TOGGLE_STATES[1] = (value == 1) ? true : false;
                    this.RT_ToggleResponse(this.RT_TOGGLE_STATES[1], 1);
                    this.RT_ToggleInteractivityListenerResponse(this.RT_TOGGLE_STATES[1], 1);
                    break;
                case "RT_FillColourToggle":
                    this.RT_TOGGLE_STATES[2] = (value == 1) ? true : false;
                    this.RT_ToggleResponse(this.RT_TOGGLE_STATES[2], 2);
                    this.RT_ToggleInteractivityListenerResponse(this.RT_TOGGLE_STATES[2], 2);
                    break;
                case "RT_StrokeColourToggle":
                    this.RT_TOGGLE_STATES[3] = (value == 1) ? true : false;
                    this.RT_ToggleResponse(this.RT_TOGGLE_STATES[3], 3);
                    this.RT_ToggleInteractivityListenerResponse(this.RT_TOGGLE_STATES[3], 3);
                    break;
                case "RT_IsStaticToggle":
                    this.RT_TOGGLE_STATES[4] = (value == 1) ? true : false;
                    this.RT_ToggleResponse(this.RT_TOGGLE_STATES[4], 4);
                    this.RT_ToggleInteractivityListenerResponse(this.RT_TOGGLE_STATES[4], 4);
                    break;
                case "RT_IsTranslationallyStaticToggle":
                    this.RT_TOGGLE_STATES[5] = (value == 1) ? true : false;
                    this.RT_ToggleResponse(this.RT_TOGGLE_STATES[5], 5);
                    this.RT_ToggleInteractivityListenerResponse(this.RT_TOGGLE_STATES[5], 5);
                    break;
                case "RT_IsRotationallyStaticToggle":
                    this.RT_TOGGLE_STATES[6] = (value == 1) ? true : false;
                    this.RT_ToggleResponse(this.RT_TOGGLE_STATES[6], 6);
                    this.RT_ToggleInteractivityListenerResponse(this.RT_TOGGLE_STATES[6], 6);
                    break;
                case "RT_AddGravityToggle":
                    this.RT_TOGGLE_STATES[7] = (value == 1) ? true : false;
                    this.RT_ToggleResponse(this.RT_TOGGLE_STATES[7], 7);
                    this.RT_ToggleInteractivityListenerResponse(this.RT_TOGGLE_STATES[7], 7);
                    break;
                case "RT_CollidabilityToggle":
                    this.RT_TOGGLE_STATES[8] = (value == 1) ? true : false;
                    this.RT_ToggleResponse(this.RT_TOGGLE_STATES[8], 8);
                    this.RT_ToggleInteractivityListenerResponse(this.RT_TOGGLE_STATES[8], 8);
                    break;
                default:
                    throw new IllegalArgumentException("Invalid toggle event controller name: " + RT_ToggleEvent_Controller_Name);
            }
    }


    public void RT_ToggleInteractivityListenerResponse(boolean value, int ID) {
        switch(ID) {
            case 0:
                if(value) {
                    interactivityListener.setShapeType(ShapeType.CIRCLE);
                }
                break
            case 1:
                if(value) {
                    interactivityListener.setShapeType(ShapeType.BOX);
                }
                break;
            case 2:
                break;
            case 3:
                break:
            case 4: 
                interactivityListener.setIsStatic(value);
                break;
            case 5:
                interactivityListener.setIsTranslationallyStatic(value);
                break;
            case 6:
                interactivityListener.setIsRotationallyStatic(value);
                break;
            case 7:
                interactivityListener.setAddGravity(value);
            case 8:
                interactivityListener.setCollidability(value);
        }
    }


    public void RT_ToggleResponse(boolean value, int ID) {
        switch(ID) {
            case 0:
                if(value) {
                    gui.RT_RectangleToggle.setBroadcast(false);
                    gui.RT_CircleToggle.setBroadcast(false);

                    gui.RT_RectangleToggle.setValue(0);
                    this.RT_TOGGLE_STATES[1] = false;

                    gui.RT_CircleToggle.setValue(1);

                    gui.RT_RectangleToggle.setBroadcast(true);
                    gui.RT_CircleToggle.setBroadcast(true);
                } else {
                    gui.RT_CircleToggle.setBroadcast(false);

                    gui.RT_CircleToggle.setValue(0);
                    this.RT_TOGGLE_STATES[0] = false;

                    gui.RT_CircleToggle.setBroadcast(true);
                }
                break;
            case 1:
                if(value) {
                    gui.RT_CircleToggle.setBroadcast(false);
                    gui.RT_RectangleToggle.setBroadcast(false);

                    gui.RT_CircleToggle.setValue(0);
                    this.RT_TOGGLE_STATES[0] = false;

                    gui.RT_RectangleToggle.setValue(1);

                    gui.RT_CircleToggle.setBroadcast(true);
                    gui.RT_RectangleToggle.setBroadcast(true);
                } else {
                    gui.RT_RectangleToggle.setBroadcast(false);

                    gui.RT_RectangleToggle.setValue(0);
                    this.RT_TOGGLE_STATES[1] = false;

                    gui.RT_RectangleToggle.setBroadcast(true);
                }
                break;
            case 2:
                if(value) {

                    gui.RT_StrokeColourToggle.setBroadcast(false);
                    gui.RT_FillColourToggle.setBroadcast(false);

                    gui.RT_StrokeColourToggle.setValue(0);
                    this.RT_TOGGLE_STATES[3] = false;

                    gui.RT_FillColourToggle.setValue(1);

                    gui.RT_StrokeColourToggle.setBroadcast(true);
                    gui.RT_FillColourToggle.setBroadcast(true);
                } else {
                    gui.RT_FillColourToggle.setBroadcast(false);

                    gui.RT_FillColourToggle.setValue(0);
                    this.RT_TOGGLE_STATES[2] = false;

                    gui.RT_FillColourToggle.setBroadcast(true);
                }
                break;
            case 3:
                if(value) {
                    gui.RT_StrokeColourToggle.setBroadcast(false);
                    gui.RT_FillColourToggle.setBroadcast(false);

                    gui.RT_FillColourToggle.setValue(0);
                    this.RT_TOGGLE_STATES[2] = false;

                    gui.RT_StrokeColourToggle.setValue(1);

                    gui.RT_StrokeColourToggle.setBroadcast(true);
                    gui.RT_FillColourToggle.setBroadcast(true);

                } else {
                    gui.RT_StrokeColourToggle.setBroadcast(false);

                    gui.RT_StrokeColourToggle.setValue(0);
                    this.RT_TOGGLE_STATES[3] = false;

                    gui.RT_StrokeColourToggle.setBroadcast(true);
                }
                break;
            case 4:
                if(value) {
                    gui.RT_IsStaticToggle.setBroadcast(false);
                    gui.RT_IsTranslationallyStaticToggle.setBroadcast(false);
                    gui.RT_IsRotationallyStaticToggle.setBroadcast(false);

                    gui.RT_IsTranslationallyStaticToggle.setValue(0);
                    this.RT_TOGGLE_STATES[5] = false;

                    gui.RT_IsRotationallyStaticToggle.setValue(0);
                    this.RT_TOGGLE_STATES[6] = false;
                    
                    gui.RT_IsStaticToggle.setValue(1);

                    gui.RT_IsStaticToggle.setBroadcast(true);
                    gui.RT_IsTranslationallyStaticToggle.setBroadcast(true);
                    gui.RT_IsRotationallyStaticToggle.setBroadcast(true);

                } else {
                    gui.RT_IsStaticToggle.setBroadcast(false);

                    gui.RT_IsStaticToggle.setValue(0);
                    this.RT_TOGGLE_STATES[4] = false;

                    gui.RT_IsStaticToggle.setBroadcast(true);
                }
                break;
            case 5:
                if(value) {
                    gui.RT_IsStaticToggle.setBroadcast(false);
                    gui.RT_IsTranslationallyStaticToggle.setBroadcast(false);
                    gui.RT_IsRotationallyStaticToggle.setBroadcast(false);

                    gui.RT_IsStaticToggle.setValue(0);
                    this.RT_TOGGLE_STATES[4] = false;

                    gui.RT_IsRotationallyStaticToggle.setValue(0);
                    this.RT_TOGGLE_STATES[6] = false;

                    gui.RT_IsTranslationallyStaticToggle.setValue(1);

                    gui.RT_IsStaticToggle.setBroadcast(true);
                    gui.RT_IsTranslationallyStaticToggle.setBroadcast(true);
                    gui.RT_IsRotationallyStaticToggle.setBroadcast(true);
                } else {
                    gui.RT_IsTranslationallyStaticToggle.setBroadcast(false);

                    gui.RT_IsTranslationallyStaticToggle.setValue(0);
                    this.RT_TOGGLE_STATES[5] = false;

                    gui.RT_IsTranslationallyStaticToggle.setBroadcast(true);
                }
                break;
            case 6:
                if(value) {
                    gui.RT_IsStaticToggle.setBroadcast(false);
                    gui.RT_IsTranslationallyStaticToggle.setBroadcast(false);
                    gui.RT_IsRotationallyStaticToggle.setBroadcast(false);

                    gui.RT_IsStaticToggle.setValue(0);
                    this.RT_TOGGLE_STATES[4] = false;

                    gui.RT_IsTranslationallyStaticToggle.setValue(0);
                    this.RT_TOGGLE_STATES[5] = false;

                    gui.RT_IsRotationallyStaticToggle.setValue(1);

                    gui.RT_IsStaticToggle.setBroadcast(true);
                    gui.RT_IsTranslationallyStaticToggle.setBroadcast(true);
                    gui.RT_IsRotationallyStaticToggle.setBroadcast(true);
                } else {
                    gui.RT_IsRotationallyStaticToggle.setBroadcast(false);

                    gui.RT_IsRotationallyStaticToggle.setValue(0);
                    this.RT_TOGGLE_STATES[6] = false;

                    gui.RT_IsRotationallyStaticToggle.setBroadcast(true);
                }
                break;
            case 7:
                if(value) {
                    gui.RT_AddGravityToggle.setBroadcast(false);

                    gui.RT_AddGravityToggle.setValue(1);
                    this.RT_TOGGLE_STATES[7] = true;

                    gui.RT_AddGravityToggle.setBroadcast(true);
                } else {
                    gui.RT_AddGravityToggle.setBroadcast(false);

                    gui.RT_AddGravityToggle.setValue(0);
                    this.RT_TOGGLE_STATES[7] = false;

                    gui.RT_AddGravityToggle.setBroadcast(true);
                }
                break;
            case 8:
                if(value) {
                    gui.RT_CollidabilityToggle.setBroadcast(false);

                    gui.RT_CollidabilityToggle.setValue(1);
                    this.RT_TOGGLE_STATES[8] = true;

                    gui.RT_CollidabilityToggle.setBroadcast(true);
                } else {
                    gui.RT_CollidabilityToggle.setBroadcast(false);

                    gui.RT_CollidabilityToggle.setValue(0);
                    this.RT_TOGGLE_STATES[8] = false;

                    gui.RT_CollidabilityToggle.setBroadcast(true);
                }
                break;
        }
        
        switch(ID) {
            case 0:
                this.RT_Visibility_Response();
                break;
            case 1:
                this.RT_Visibility_Response();
                break;
            case 2:
                this.RT_Visibility_Response();
                break;
            case 3:
                this.RT_Visibility_Response();
                break;
        }
    }

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

    public void RT_SliderListener(ControlEvent RT_SliderEvent) {
        Controller RT_SliderEvent_Controller = RT_SliderEvent.getController();
        float value = (int)RT_SliderEvent_Controller.getValue();
        String RT_SliderEvent_Controller_Name = RT_SliderEvent_Controller.getName();

        switch(RT_SliderEvent_Controller_Name) {
            case "RT_DensitySlider":
                this.RT_SLIDER_VALUES[0] = value;
                this.RT_SliderInteractivityListenerResponse(this.RT_SLIDER_VALUES[0], 0);
                break;
            case "RT_RestitutionSlider":
                this.RT_SLIDER_VALUES[1] = value;
                this.RT_SliderInteractivityListenerResponse(this.RT_SLIDER_VALUES[1], 1);
                break;
            case "RT_RectangleWidthSlider":
                this.RT_SLIDER_VALUES[2] = value;
                this.RT_SliderInteractivityListenerResponse(this.RT_SLIDER_VALUES[2], 2);
                break;
            case "RT_RectangleHeightSlider":
                this.RT_SLIDER_VALUES[3] = value;
                this.RT_SliderInteractivityListenerResponse(this.RT_SLIDER_VALUES[3], 3);
                break;
            case "RT_CircleRadiusSlider":
                this.RT_SLIDER_VALUES[4] = value;
                this.RT_SliderInteractivityListenerResponse(this.RT_SLIDER_VALUES[4], 4);
                break;
            case "RT_StrokeWeightSlider":
                this.RT_SLIDER_VALUES[5] = value;
                this.RT_SliderInteractivityListenerResponse(this.RT_SLIDER_VALUES[5], 5);
                break;
            case "RT_RedFillSlider":
                this.RT_SLIDER_VALUES[6] = value;
                this.RT_SliderInteractivityListenerResponse(this.RT_SLIDER_VALUES[6], 6);
                break;
            case "RT_GreenFillSlider":
                this.RT_SLIDER_VALUES[7] = value;
                this.RT_SliderInteractivityListenerResponse(this.RT_SLIDER_VALUES[7], 7);
                break;
            case "RT_BlueFillSlider":
                this.RT_SLIDER_VALUES[8] = value;
                this.RT_SliderInteractivityListenerResponse(this.RT_SLIDER_VALUES[8], 8);
                break;
            case "RT_RedStrokeSlider":
                this.RT_SLIDER_VALUES[9] = value;
                this.RT_SliderInteractivityListenerResponse(this.RT_SLIDER_VALUES[9], 9);
                break;
            case "RT_GreenStrokeSlider":
                this.RT_SLIDER_VALUES[10] = value;
                this.RT_SliderInteractivityListenerResponse(this.RT_SLIDER_VALUES[10], 10);
                break;
            case "RT_BlueStrokeSlider":
                this.RT_SLIDER_VALUES[11] = value;
                this.RT_SliderInteractivityListenerResponse(this.RT_SLIDER_VALUES[11], 11);
                break;
            case "RT_AngleSlider":
                this.RT_SLIDER_VALUES[12] = value;
                this.RT_SliderInteractivityListenerResponse(this.RT_SLIDER_VALUES[12], 12);
            case "RT_AngularVelocitySlider":
                this.RT_SLIDER_VALUES[13] = value;
                this.RT_SliderInteractivityListenerResponse(this.RT_SLIDER_VALUES[13], 13);
        }
    }

    public void RT_SliderResponse(){
    }

    public void RT_SliderInteractivityListenerResponse(float value, int ID){
        switch (ID) {
            case 0:
                interactivityListener.setDensity(value);
            case 1:
                interactivityListener.setRestitution(value);
            case 2:
                interactivityListener.setWidth(value);
            case 3:
                interactivityListener.setHeight(value);
            case 4:
                interactivityListener.setRadius(value);
            case 5:
                interactivityListener.setStrokeWeight(value);
            case 6:
                interacitivity
        }

    }


    public void RT_Visibility_Response() {
        gui.RT_RectangleWidthSlider.setVisible(this.RT_TOGGLE_STATES[1]);
        gui.RT_RectangleHeightSlider.setVisible(this.RT_TOGGLE_STATES[1]);

        gui.RT_CircleRadiusSlider.setVisible(this.RT_TOGGLE_STATES[0]);

        gui.RT_DensitySlider.setVisible(this.RT_TOGGLE_STATES[0] || this.RT_TOGGLE_STATES[1]);
        gui.RT_RestitutionSlider.setVisible(this.RT_TOGGLE_STATES[0] || this.RT_TOGGLE_STATES[1]);

        gui.RT_FillColourToggle.setVisible(this.RT_TOGGLE_STATES[0] || this.RT_TOGGLE_STATES[1]);
        gui.RT_StrokeColourToggle.setVisible(this.RT_TOGGLE_STATES[0] || this.RT_TOGGLE_STATES[1]);
        gui.RT_StrokeWeightSlider.setVisible(this.RT_TOGGLE_STATES[0] || this.RT_TOGGLE_STATES[1]);

        gui.RT_RedFillSlider.setVisible(this.RT_TOGGLE_STATES[2] && this.getRT_OR_ToggleState(0, 1));
        gui.RT_GreenFillSlider.setVisible(this.RT_TOGGLE_STATES[2] && this.getRT_OR_ToggleState(0, 1));
        gui.RT_BlueFillSlider.setVisible(this.RT_TOGGLE_STATES[2] && this.getRT_OR_ToggleState(0, 1));

        gui.RT_RedStrokeSlider.setVisible(this.RT_TOGGLE_STATES[3] && this.getRT_OR_ToggleState(0, 1));
        gui.RT_GreenStrokeSlider.setVisible(this.RT_TOGGLE_STATES[3] && this.getRT_OR_ToggleState(0, 1));
        gui.RT_BlueStrokeSlider.setVisible(this.RT_TOGGLE_STATES[3] && this.getRT_OR_ToggleState(0, 1));

        gui.RT_ColorBang.setVisible(this.RT_TOGGLE_STATES[2] || this.RT_TOGGLE_STATES[3]);
                                        
        gui.RT_IsStaticToggle.setVisible(this.RT_TOGGLE_STATES[0] || this.RT_TOGGLE_STATES[1]);
        gui.RT_IsTranslationallyStaticToggle.setVisible(this.RT_TOGGLE_STATES[0] || this.RT_TOGGLE_STATES[1]);
        gui.RT_IsRotationallyStaticToggle.setVisible(this.RT_TOGGLE_STATES[0] || this.RT_TOGGLE_STATES[1]);

        gui.RT_AngleSlider.setVisible(this.RT_TOGGLE_STATES[0] || this.RT_TOGGLE_STATES[1]);
        gui.RT_AngularVelocitySlider.setVisible(this.RT_TOGGLE_STATES[0] || this.RT_TOGGLE_STATES[1]);

        gui.RT_AddGravityToggle.setVisible(this.RT_TOGGLE_STATES[0] || this.RT_TOGGLE_STATES[1]);
        gui.RT_CollidabilityToggle.setVisible(this.RT_TOGGLE_STATES[0] || this.RT_TOGGLE_STATES[1]);


    }











/*
====================================================================================================
====================================== Key & Mouse Listeners =======================================
====================================================================================================
*/
    public void onMousePressed(int button) {
        if(button < mouseDownCache.length) {
            mouseDownCache[button] = true;
            System.out.println("Mouse button " + button + " pressed");
        }
    }

    public void onMouseReleased(int button) {
        if(button < mouseDownCache.length) {
            mouseDownCache[button] = false;
            System.out.println("Mouse button " + button + " released");
        }
    }

    public boolean isMouseDown(int button) {
        if(button < mouseDownCache.length) {
            return mouseDownCache[button];
        }
        return false;
    }

    public void onKeyPressed(int keyCode) {
        if(keyCode < keyDownCache.length) {
            keyDownCache[keyCode] = true;
            System.out.println("Key " + keyCode + " pressed");
        }
    }

    public void onKeyReleased(int keyCode) {
        if(keyCode < keyDownCache.length) {
            keyDownCache[keyCode] = false;
            System.out.println("Key " + keyCode + " released");
        }
    }

    public boolean isKeyDown(int keyCode) {
        if(keyCode < keyDownCache.length) {
            return keyDownCache[keyCode];
        }
        return false;
    }


/*
====================================================================================================
====================================== Key Pressed Responses =======================================
====================================================================================================
*/
    public void keyPressedResponse() {
        switch(activeTabID) {
            case 0:
                rigidbodyTabPressedResponse();
                return;
            case 1:
                forceTabPressedResponse();
                return;
            case 2:
                editorTabPressedResponse();
                return;
            case 3:
                creationsTabPressedResponse();
                return;
            case 4:
                settingsTabPressedResponse();
                return;
            case 5:
                helpTabPressedResponse();
                return;
        }
    }


    public void rigidbodyTabPressedResponse() {
        if(isKeyDown(KeyEvent.VK_SHIFT)) {
                        if(isKeyDown(KeyEvent.VK_W)) {
                            if(this.RT_TOGGLE_STATES[0]) {
                                gui.RT_CircleRadiusSlider.setValue(gui.RT_CircleRadiusSlider.getValue() + 0.5f);
                                return;
                            } else if(this.RT_TOGGLE_STATES[1]) {
                                gui.RT_RectangleHeightSlider.setValue(gui.RT_RectangleHeightSlider.getValue() + 1f);
                                return;
                            }
                        }

                        if(isKeyDown(KeyEvent.VK_S)) {
                            if(this.RT_TOGGLE_STATES[0]) {
                                gui.RT_CircleRadiusSlider.setValue(gui.RT_CircleRadiusSlider.getValue() - 0.5f);
                                return;
                            } else if(this.RT_TOGGLE_STATES[1]) {
                                gui.RT_RectangleHeightSlider.setValue(gui.RT_RectangleHeightSlider.getValue() - 1f);
                                return;
                            }
                        }

                        if(isKeyDown(KeyEvent.VK_A)) {
                            if(this.RT_TOGGLE_STATES[0]) {
                                gui.RT_CircleRadiusSlider.setValue(gui.RT_CircleRadiusSlider.getValue() - 0.5f);
                                return;
                            } else if(this.RT_TOGGLE_STATES[1]) {
                                gui.RT_RectangleWidthSlider.setValue(gui.RT_RectangleWidthSlider.getValue() - 1f);
                                return;
                            }
                        }

                        if(isKeyDown(KeyEvent.VK_D)) {
                            if(this.RT_TOGGLE_STATES[0]) {
                                gui.RT_CircleRadiusSlider.setValue(gui.RT_CircleRadiusSlider.getValue() + 0.5f);
                                return;
                            } else if(this.RT_TOGGLE_STATES[1]) {
                                gui.RT_RectangleWidthSlider.setValue(gui.RT_RectangleWidthSlider.getValue() + 1f);
                                return;
                            }
                        }
        } else {
                        if(isKeyDown(KeyEvent.VK_W)) {
                            if(this.RT_TOGGLE_STATES[0]) {
                                gui.RT_CircleRadiusSlider.setValue(gui.RT_CircleRadiusSlider.getValue() + 0.05f);
                                return;
                            } else if(this.RT_TOGGLE_STATES[1]) {
                                gui.RT_RectangleHeightSlider.setValue(gui.RT_RectangleHeightSlider.getValue() + 0.1f);
                                return;
                            }
                        }

                        if(isKeyDown(KeyEvent.VK_S)) {
                            if(this.RT_TOGGLE_STATES[0]) {
                                gui.RT_CircleRadiusSlider.setValue(gui.RT_CircleRadiusSlider.getValue() - 0.05f);
                                return;
                            } else if(this.RT_TOGGLE_STATES[1]) {
                                gui.RT_RectangleHeightSlider.setValue(gui.RT_RectangleHeightSlider.getValue() - 0.1f);
                                return;
                            }
                        }

                        if(isKeyDown(KeyEvent.VK_A)) {
                            if(this.RT_TOGGLE_STATES[0]) {
                                gui.RT_CircleRadiusSlider.setValue(gui.RT_CircleRadiusSlider.getValue() - 0.05f);
                                return;
                            } else if(this.RT_TOGGLE_STATES[1]) {
                                gui.RT_RectangleWidthSlider.setValue(gui.RT_RectangleWidthSlider.getValue() - 0.1f);
                                return;
                            }
                        }

                        if(isKeyDown(KeyEvent.VK_D)) {
                            if(this.RT_TOGGLE_STATES[0]) {
                                gui.RT_CircleRadiusSlider.setValue(gui.RT_CircleRadiusSlider.getValue() + 0.05f);
                                return;
                            } else if(this.RT_TOGGLE_STATES[1]) {
                                gui.RT_RectangleWidthSlider.setValue(gui.RT_RectangleWidthSlider.getValue() + 0.1f);
                                return;
                            }
                        }

                        if(isKeyDown(KeyEvent.VK_1)) {
                            this.RT_TOGGLE_STATES[0] = !this.RT_TOGGLE_STATES[0];
                            this.RT_ToggleResponse(this.RT_TOGGLE_STATES[0], 0);
                        } 
                        
                        if(isKeyDown(KeyEvent.VK_2)) {
                            this.RT_TOGGLE_STATES[1] = !this.RT_TOGGLE_STATES[1];
                            this.RT_ToggleResponse(this.RT_TOGGLE_STATES[1], 1);
                        }

                }  
    }


   public void forceTabPressedResponse() {

   }

   public void editorTabPressedResponse() {
   }

    public void creationsTabPressedResponse() {
    }

    public void settingsTabPressedResponse() {
    }

    public void helpTabPressedResponse() {
    }



    public void deletePressedResponse(){
        Rigidbody rigidbody = Mouse.getRigidbodyUnderMouse();
        System.out.println("rigidbody: " + rigidbody);
        if(rigidbody != null) {
            ArrayList<ForceRegistry> forceRegistry = rigidbody.getForceRegistry();

            for(ForceRegistry force : forceRegistry) {
                Rigidbody rigidbodyA = force.getRigidbodyA();
                Rigidbody rigidbodyB = force.getRigidbodyB();

                if((rigidbodyA == null && rigidbodyB != null) || (rigidbodyA != null && rigidbodyB == null)) {
                    ALL_FORCES_ARRAYLIST.remove(force);
                } else if(rigidbodyA != rigidbody && rigidbodyA != null) {
                    rigidbodyA.removeForceFromForceRegistry(force);
                } else if(rigidbodyB != rigidbody && rigidbodyB != null) {
                    rigidbodyB.removeForceFromForceRegistry(force);
                }
                ALL_FORCES_ARRAYLIST.remove(force);
            }

            rigidbodyList.remove(rigidbody);
        }
    }

    public void backspacePressedResponse(){
        Rigidbody rigidbody = Mouse.getRigidbodyUnderMouse();
        if(rigidbody != null) {
            ArrayList<ForceRegistry> forceRegistry = rigidbody.getForceRegistry();

            for(ForceRegistry force : forceRegistry) {
                Rigidbody rigidbodyA = force.getRigidbodyA();
                Rigidbody rigidbodyB = force.getRigidbodyB();

                if((rigidbodyA == null && rigidbodyB != null) || (rigidbodyA != null && rigidbodyB == null)) {
                    ALL_FORCES_ARRAYLIST.remove(force);
                } else if(rigidbodyA != rigidbody && rigidbodyA != null) {
                    rigidbodyA.removeForceFromForceRegistry(force);
                } else if(rigidbodyB != rigidbody && rigidbodyB != null) {
                    rigidbodyB.removeForceFromForceRegistry(force);
                }
                ALL_FORCES_ARRAYLIST.remove(force);
            }

            rigidbodyList.remove(rigidbody);
        }
    }

    public void shiftPressedResponse(){

    }

    public void ctrlPressedResponse(){

    }

    public void altPressedResponse(){

    }

    public void tabPressedResponse(){

    }

    public void escPressedResponse(){

    }





/*
====================================================================================================
====================================== Getters and Setters =========================================
====================================================================================================
*/

    public int getActiveTabID() {
        return activeTabID;
    }

    public boolean getRT_ToggleState(int ID) {
        return RT_TOGGLE_STATES[ID];
    }

    public boolean getRT_AND_ToggleState(int ID1, int ID2) {
        return RT_TOGGLE_STATES[ID1] && RT_TOGGLE_STATES[ID2];
    }

    public boolean getRT_OR_ToggleState(int ID1, int ID2) {
        return RT_TOGGLE_STATES[ID1] || RT_TOGGLE_STATES[ID2];
    }
    
}