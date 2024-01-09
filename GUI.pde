    public class GUI {
        int globalGroupBackgroundHeight = 200;
        int globalGroupWidth = 230;

        int globalSliderWidth = 150;
        int globalSliderHeight = 20;

        //sets the bar height for the tob of the group
        int globalGroupBarHeight = 20;

        //the global padding used for the borders and to position the groups
        int globalPaddingX = 40;
        int globalPaddingY = 40;


        //global initial position for the elements of the group
        int globalInitialPositionX = 10;
        int globalInitialPositionY = 20;
        
        //the global padding used to position elements within the groups (this is relative to group coordinates)
        int globalGroupElementPaddingX = 10;
        int globalGrouldElementPaddingY = 10;

        //the control group background color
        int globalGroupColor = color(250, 50);

        //this basically tells you the spacing between the elements of the group
        int globalGroupElementSpacingX = 30;
        int globalGroupElementSpacingY = 30;

/*
====================================================================================================
========================================= User Interface ===========================================
====================================================================================================
*/
        public GUI(ControlP5 userInterface) {
                Tab Rigidbodies = userInterface.addTab("Rigidbodies")
                                .setLabel("Rigidbodies")
                                .setId(0);

                Tab Forces = userInterface.addTab("Forces")
                                .setLabel("Forces")
                                .setId(1);

                    
                Group RigidbodyGeneration = userInterface.addGroup("RigidbodyGeneration")
                                .setPosition(width - globalGroupWidth - globalPaddingX, globalPaddingY)
                                .setBackgroundHeight(globalGroupBackgroundHeight)
                                .setBarHeight(globalGroupBarHeight)
                                .setBackgroundColor(globalGroupColor)
                                .setWidth(globalSliderWidth + globalPaddingX*2)
                                 //.disableCollapse()
                                .setTab("Rigidbodies")
                                ;


                        Toggle Circle = userInterface.addToggle("Circle")
                                        .setPosition(globalInitialPositionX, globalInitialPositionY)
                                        .setSize(globalSliderWidth, globalSliderHeight)
                                        .setLabel("Circle")
                                        .setGroup(RigidbodyGeneration)
                                        .setValue(false)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                        if(userInterface.getController("Circle").getValue() == 1){
                                                            ShapeType shapeType = ShapeType.CIRCLE;
                                                            interactivityListener.setShapeType(shapeType);
                                                        }
                                                    }
                                                })
                                        ;
                        Toggle Box = userInterface.addToggle("Box")
                                        .setPosition(globalInitialPositionX, globalInitialPositionY + globalGroupElementSpacingY)
                                        .setSize(globalSliderWidth, globalSliderHeight)
                                        .setLabel("Box")
                                        .setGroup(RigidbodyGeneration)
                                        .setValue(false)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                        if(userInterface.getController("Box").getValue() == 1){
                                                            ShapeType shapeType = ShapeType.BOX;
                                                            interactivityListener.setShapeType(shapeType);
                                                        }
                                                    }
                                                })
                                        ;
                        Slider Density = userInterface.addSlider("Density")
                                        .setPosition(globalInitialPositionX, globalInitialPositionY + globalGroupElementSpacingY * 2)
                                        .setSize(globalSliderWidth,globalSliderHeight)
                                        .setLabel("Density")
                                        .setRange(MIN_BODY_DENSITY, MAX_BODY_DENSITY)
                                        .setValue((MAX_BODY_DENSITY + MIN_BODY_DENSITY)*0.5f)
                                        .setGroup(RigidbodyGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                        float density = userInterface.getController("Density").getValue();
                                                        interactivityListener.setDensity(density);
                                                        }
                                                })
                                        ;
                        

                        /*
                        Slider Rigidbody = userInterface.addSlider("controlTab Mass")
                                        .setPosition(globalInitialPositionX, globalInitialPositionY + globalGroupElementSpacingY * elementNumber)
                                        .setSize(globalSliderWidth, globalSliderHeight)
                                        .setLabel("Mass")
                                        .setRange(0, 2000)
                                        .setValue(1000)
                                        .setGroup(controlsGroup)
                                        ;
                                        elementNumber++;

                        Slider controlRadius = userInterface.addSlider("controlTab Radius")
                                        .setPosition(globalInitialPositionX, globalInitialPositionY + globalGroupElementSpacingY * elementNumber)
                                        .setSize(200,20)
                                        .setLabel("Radius")
                                        .setRange(0, 200)
                                        .setValue(100)
                                        .setGroup(controlsGroup)
                                        ;
                                        elementNumber++;

                        Button controlResetSimulation = userInterface.addButton("controlTab Reset Simulation")
                                        .setPosition(globalInitialPositionX, globalInitialPositionY + globalGroupElementSpacingY * elementNumber)
                                        .setSize(200,20)
                                        .setLabel("Reset Simulation")
                                        .setGroup(controlsGroup)
                                        .onClick(new CallbackListener() {
                                                 void controlEvent(CallbackEvent theEvent) {
                                                        simulation.resetSimulation();
                                                }
                                        })
                                        ;
                                        elementNumber++;



                        Toggle controlShowVelocityVectors = userInterface.addToggle("controlTab Show Velocity Vectors")
                                        .setPosition(globalInitialPositionX, globalInitialPositionY + globalGroupElementSpacingY * elementNumber)
                                        .setSize(200,20)
                                        .setLabel("Show Velocity Vectors")
                                        .setGroup(controlsGroup)
                                        .setValue(false)
                                        ;
                                        elementNumber++;


                        Toggle controlShowAccelerationVectors = userInterface.addToggle("controlTab Show Acceleration Vectors")
                                        .setPosition(globalInitialPositionX, globalInitialPositionY + globalGroupElementSpacingY * elementNumber)
                                        .setSize(200,20)
                                        .setLabel("Show Acceleration Vectors")
                                        .setGroup(controlsGroup)
                                        .setValue(false)
                                        ;
                                        elementNumber++;


                        Toggle controlFixedBody = userInterface.addToggle("controlTab Fixed Body")
                                        .setPosition(globalInitialPositionX, globalInitialPositionY + globalGroupElementSpacingY * elementNumber)
                                        .setSize(200,20)
                                        .setLabel("Fixed Body")
                                        .setGroup(controlsGroup)
                                        .setValue(false)
                                        ;
                                        elementNumber++;

                        Slider controlGravityScale = userInterface.addSlider("controlTab Gravity Scale")
                                        .setPosition(globalInitialPositionX, globalInitialPositionY + globalGroupElementSpacingY * elementNumber)
                                        .setSize(200,20)
                                        .setLabel("Gravity Scale")
                                        .setRange(1, 10000000)
                                        .setValue(5000000)
                                        .setGroup(controlsGroup)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                        float gravityScaleValue = userInterface.getController(activeTab + " Gravity Scale").getValue();
                                                        gravitationalScalingCoefficient = gravityScaleValue;
                                                        }
                                                })
                                        ;
                                        elementNumber++;

                        Toggle controlShowCenterOfMass = userInterface.addToggle("controlTab Show Center of Mass")
                                        .setPosition(globalInitialPositionX, globalInitialPositionY + globalGroupElementSpacingY * elementNumber)
                                        .setSize(200,20)
                                        .setLabel("Show Center of Mass")
                                        .setGroup(controlsGroup)
                                        .setValue(false)
                                        ;
                                        elementNumber++;

                        Toggle controlLockViewToCenterOfMass = userInterface.addToggle("controlTab Lock View to Center of Mass")
                                        .setPosition(globalInitialPositionX, globalInitialPositionY + globalGroupElementSpacingY * elementNumber)
                                        .setSize(globalSliderWidth,20)
                                        .setLabel("Lock View to Center of Mass")
                                        .setGroup(controlsGroup)
                                        .setValue(false)
                                        ;
                                        elementNumber++;
                        Toggle controlShowTrail = userInterface.addToggle("controlTab Show Trail")
                                        .setPosition(globalInitialPositionX, globalInitialPositionY + globalGroupElementSpacingY * elementNumber)
                                        .setSize(globalSliderWidth,20)
                                        .setLabel("Show Trail")
                                        .setGroup(controlsGroup)
                                        .setValue(false)
                                        ;
                                        elementNumber++;
                        Toggle controlGenerateOrbitingPlanet = userInterface.addToggle("controlTab Generate Orbiting Planet")
                                        .setPosition(globalInitialPositionX, globalInitialPositionY + globalGroupElementSpacingY * elementNumber)
                                        .setSize(globalSliderWidth,20)
                                        .setLabel("Generate Orbiting Planet")
                                        .setGroup(controlsGroup)
                                        .setValue(false)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                       userInterface.getController("controlTab Fixed Body").setValue(0);
                                                }
                                        })
                                        ;
                                        elementNumber++;
                        Textfield controlPlanetMass = userInterface.addTextfield("controlTab Planet Mass")
                                        .setPosition(globalGroupElementPaddingX, globalInitialPositionY + globalGroupElementSpacingY * elementNumber)
                                        .setSize(50, 20)
                                        .setText("")
                                        .setGroup(controlsGroup)
                                        .setColor(color(255,255,255))
                                        .setVisible(true)
                                        .setLabel("Mass")
                                        ;
                        Textfield controlPlanetRadius = userInterface.addTextfield("controlTab Planet Radius")
                                        .setPosition(globalGroupElementPaddingX + 70, globalInitialPositionY + globalGroupElementSpacingY * elementNumber)
                                        .setSize(50, 20)
                                        .setText("")
                                        .setColor(color(255,255,255))
                                        .setVisible(true)
                                        .setGroup(controlsGroup)
                                        .setLabel("Radius")
                                        ;
                        Textfield controlPlanetDistance = userInterface.addTextfield("controlTab Planet Distance")
                                        .setPosition(globalGroupElementPaddingX + 140, globalInitialPositionY + globalGroupElementSpacingY * elementNumber)
                                        .setSize(50, 20)
                                        .setText("")
                                        .setColor(color(255,255,255))
                                        .setVisible(true)
                                        .setGroup(controlsGroup)
                                        .setLabel("Distance")
                                        ;
                                        elementNumber = 0;
                

             
                
                
                
                
                //Formatting
                userInterface.getController("controlTab Show Velocity Vectors").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
                userInterface.getController("controlTab Show Acceleration Vectors").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
                userInterface.getController("controlTab Fixed Body").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
                userInterface.getController("controlTab Reset Simulation").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
                userInterface.getController("controlTab Gravity Scale").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
                userInterface.getController("controlTab Show Center of Mass").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
                userInterface.getController("controlTab Lock View to Center of Mass").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
                userInterface.getController("controlTab Show Trail").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
                userInterface.getController("controlTab Generate Orbiting Planet").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
                        
        

                userInterface.getTab("default").hide();

                



    
        }
        */
        userInterface.getTab("default").hide();
        }
    }
