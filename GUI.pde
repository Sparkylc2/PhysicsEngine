    public class GUI {
        
        //The size of the group
        public int globalGroupHeight = 225;
        public int globalGroupWidth = 230;
        private int globalGroupBarHeight = 20;

        //The padding of the group from the edges of the screen
        public int globalScreenGroupPaddingX = 40;
        public int globalScreenGroupPaddingY = 40;


        
        //The padding for elements from the edge of the group
        private int globalGroupPaddingX = 10;
        private int globalGroupPaddingY = 10;
        
        //The padding between elements in the group
        private int globalInterElementPaddingX = 10;
        private int globalInterElementPaddingY = 10;

    
        //the group background color
        private int globalGroupColor = color(250, 50);

        private int rowCount = 10;

        //Checks which tab is open
        private boolean isRigidbodiesTabOpen;
        private boolean isForcesTabOpen;
     
        /*---------------------------- Default Values Initialization ------------------------*/

        /*---------------------------- Rigidbodies Tab -------------------------------------*/
        private float defaultRectangleWidth = 2f;
        private float defaultRectangleHeight = 2f;
        private float defaultCircleRadius = 1f;

        private float defaultDensity = 10f;
        private float defaultRestitution = 0.5f;

        private PVector defaultFillColour = new PVector(255, 255, 255);
        private PVector defaultStrokeColour = new PVector(0, 0, 0);
        private float defaultStrokeWeight = 0.05;

        private boolean defaultIsStatic = false;
        private boolean defaultIsTransStatic = false;
        private boolean defaultIsRotStatic = false;

        private boolean defaultAddGravity = true;
        private float defaultAngle = 0f;
        private float defaultAngularVelocity = 0f;

        private boolean isFillColourSelectedDefault = true;

        private boolean defaultCircleSelector = false;
        private boolean defaultRectangleSelector = false;
        private boolean defaultPolygonSelector = false;

    /*---------------------------- Forces Tab -------------------------------------*/
        private boolean defaultSpringSelector = false;
        private boolean defaultRodSelector = false;
        private boolean defaultMotorSelector = false;

        private float defaultSpringConstant = 50f;
        private float defaultSpringDamping = 0.5f;
        private float defaultSpringEquilibriumLength = 1f;

        private boolean defaultLockToXAxis = false;
        private boolean defaultLockToYAxis = false;

        private boolean defaultSpringIsPerfect = false;
        private boolean defaultSpringIsHingeable = true;

        private boolean defaultRodIsHingeable = true;

        private boolean defaultSnapToCenter = true;
        private boolean defaultSnapToEdge = false;

        private float defaultMotorTargetAngularVelocity = 0f;
        private boolean defaultMotorDrawMotor = false;
        private boolean defaultMotorDrawMotorForce = true;



/*
====================================================================================================
========================================= User Interface ===========================================
====================================================================================================
*/
        public GUI(ControlP5 userInterface) {
    /*---------------------- Interactivity Listener Initialization -----------------*/
        if(defaultCircleSelector == true){

            interactivityListener.setShapeType(ShapeType.CIRCLE);
        } else if(defaultRectangleSelector == true){

            interactivityListener.setShapeType(ShapeType.BOX);
        } else if(defaultPolygonSelector == true){

            interactivityListener.setShapeType(ShapeType.POLYGON);
        }



        interactivityListener.setWidth(defaultRectangleWidth);
        interactivityListener.setHeight(defaultRectangleHeight);
        interactivityListener.setRadius(defaultCircleRadius);

        interactivityListener.setDensity(defaultDensity);
        interactivityListener.setRestitution(defaultRestitution);

        interactivityListener.setFillColor(defaultFillColour);
        interactivityListener.setStrokeColor(defaultStrokeColour);
        interactivityListener.setStrokeWeight(defaultStrokeWeight);

        interactivityListener.setAngle(defaultAngle);
        interactivityListener.setAngularVelocity(defaultAngularVelocity);

        interactivityListener.setIsStatic(defaultIsStatic);
        interactivityListener.setIsTranslationallyStatic(defaultIsTransStatic);
        interactivityListener.setIsRotationallyStatic(defaultIsRotStatic);
        interactivityListener.setAddGravity(defaultAddGravity);
        
        interactivityListener.setSpringConstant(defaultSpringConstant);
        interactivityListener.setSpringDamping(defaultSpringDamping);
        interactivityListener.setSpringEquilibriumLength(defaultSpringEquilibriumLength);

        interactivityListener.setLockToXAxis(defaultLockToXAxis);
        interactivityListener.setLockToYAxis(defaultLockToYAxis);

        interactivityListener.setSpringIsPerfect(defaultSpringIsPerfect);
        interactivityListener.setSpringIsHingeable(defaultSpringIsHingeable);
        interactivityListener.setRodIsHingeable(defaultRodIsHingeable);
        
        interactivityListener.setSnapToCenter(defaultSnapToCenter);
        interactivityListener.setSnapToEdge(defaultSnapToEdge);


        interactivityListener.setMotorTargetAngularVelocity(defaultMotorTargetAngularVelocity);
        interactivityListener.setMotorDrawMotor(defaultMotorDrawMotor);
        interactivityListener.setMotorDrawMotorForce(defaultMotorDrawMotorForce);

    /*----------------------------------------------------------------------------*/

                Tab Rigidbodies = userInterface.addTab("Rigidbodies")
                                .setLabel("Rigidbodies")
                                .setId(0)
                                .activateEvent(true)
                                .addListener(new ControlListener() {
                                    void controlEvent(ControlEvent theEvent) {
                                        if(theEvent.isTab() && theEvent.getTab().getId() == 0) {
                                            interactivityListener.setGenerateRigidbodies(true);
                                            interactivityListener.setGenerateForces(false);
                                        }
                                    }
                                })
                                ;

                Tab Forces = userInterface.addTab("Forces")
                                .setLabel("Forces")
                                .setId(1)
                                .activateEvent(true)
                                .addListener(new ControlListener() {
                                    void controlEvent(ControlEvent theEvent) {
                                        if(theEvent.isTab() && theEvent.getTab().getId() == 1) {
                                            interactivityListener.setGenerateRigidbodies(false);
                                            interactivityListener.setGenerateForces(true);
                                        }
                                    }
                                })
                                ;

                Tab Editor = userInterface.addTab("Editor")
                                .setLabel("Editor")
                                .setId(2);

                Tab Debug = userInterface.addTab("Debug")
                                .setLabel("Debug")
                                .setId(2);

/*----------------------------------- Rigidbodies Tab ------------------------------------------*/
                Group RigidbodyGeneration = userInterface.addGroup("Rigidbody")
                                .setPosition(calculateGroupPositionX(), calculateGroupPositionY())
                                .setBackgroundHeight(globalGroupHeight)
                                .setBarHeight(globalGroupBarHeight)
                                .setBackgroundColor(globalGroupColor)
                                .setWidth(globalGroupWidth)
                                 //.disableCollapse()
                                .setTab("Rigidbodies")

                                ;

                        Toggle Circle = userInterface.addToggle("Circle")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(3)), calculateButtonPositionY(1, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(3), calculateButtonHeight(rowCount))
                                        .setLabel("Circle")
                                        .setGroup(RigidbodyGeneration)
                                        .setValue(false)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {

                                                        CircleShapeSelectorOnChange();
                                                    }
                                                })
                                            ;

                        Toggle Rectangle = userInterface.addToggle("Box")
                                        .setPosition(calculateButtonPositionX(2, calculateButtonWidth(3)), calculateButtonPositionY(1, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(3), calculateButtonHeight(rowCount))
                                        .setLabel("Rectangle")
                                        .setGroup(RigidbodyGeneration)
                                        .setValue(false)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {

                                                        RectangleShapeSelectorOnChange();
                                                    }
                                                })
                                            ;

                        Toggle Polygon = userInterface.addToggle("Polygon")
                                        .setPosition(calculateButtonPositionX(3, calculateButtonWidth(3)), calculateButtonPositionY(1, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(3), calculateButtonHeight(rowCount))
                                        .setLabel("Polygon")
                                        .setGroup(RigidbodyGeneration)
                                        .setValue(false)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                    //TODO: IMPLEMENT THIS FOR POLYGON
                                                    }
                                                })
                                            ;
                                        
                        Slider Density = userInterface.addSlider("Density")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(2)), calculateButtonPositionY(2, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(2),calculateButtonHeight(rowCount))
                                        .setLabel("Density")
                                        .setVisible(false)
                                        .setRange(MIN_BODY_DENSITY, MAX_BODY_DENSITY)
                                        .setValue(defaultDensity)
                                        .setGroup(RigidbodyGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {

                                                        DensityElementOnChange();
                                                    }
                                                })
                                            ;

                        Slider Restitution = userInterface.addSlider("Restitution")
                                        .setPosition(calculateButtonPositionX(2, calculateButtonWidth(2)), calculateButtonPositionY(2, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(2),calculateButtonHeight(rowCount))
                                        .setLabel("Restitution")
                                        .setVisible(false)
                                        .setRange(0.01, 1)
                                        .setValue(defaultRestitution)
                                        .setGroup(RigidbodyGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {

                                                        RestitutionElementOnChange();
                                                    }
                                                })
                                            ;

                        Slider RectangleWidth = userInterface.addSlider("RectangleWidth")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(2)), calculateButtonPositionY(3, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(2),calculateButtonHeight(rowCount))
                                        .setLabel("Width")
                                        .setVisible(false)
                                        .setRange(MIN_BODY_WIDTH, MAX_BODY_WIDTH)
                                        .setValue(defaultRectangleWidth)
                                        .setGroup(RigidbodyGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {

                                                        RectangleWidthElementOnChange();
                                                    }
                                                })
                                            ;

                        Slider RectangleHeight = userInterface.addSlider("RectangleHeight")
                                        .setPosition(calculateButtonPositionX(2, calculateButtonWidth(2)), calculateButtonPositionY(3, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(2),calculateButtonHeight(rowCount))
                                        .setLabel("Height")
                                        .setVisible(false)
                                        .setRange(MIN_BODY_HEIGHT, MAX_BODY_HEIGHT)
                                        .setValue(defaultRectangleHeight)
                                        .setGroup(RigidbodyGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {

                                                        RectangleHeightElementOnChange();
                                                    }
                                                })
                                            ;

                        Slider CircleRadius = userInterface.addSlider("CircleRadius")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(1)), calculateButtonPositionY(3, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(1),calculateButtonHeight(rowCount))
                                        .setLabel("Radius")
                                        .setVisible(false)
                                        .setRange(MIN_BODY_RADIUS, MAX_BODY_RADIUS)
                                        .setValue(defaultCircleRadius)
                                        .setGroup(RigidbodyGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {

                                                        CircleRadiusElementOnChange();
                                                    }
                                                })
                                            ;

                        Toggle fillColour = userInterface.addToggle("FillColour")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(3)), calculateButtonPositionY(4, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(3),calculateButtonHeight(rowCount))
                                        .setLabel("Fill Colour")
                                        .setVisible(false)
                                        .setGroup(RigidbodyGeneration)
                                        .setValue(false)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {

                                                       FillColourSelectorOnChange();
                                                    }
                                                })
                                            ;

                        Toggle strokeColour = userInterface.addToggle("StrokeColour")
                                        .setPosition(calculateButtonPositionX(2, calculateButtonWidth(3)), calculateButtonPositionY(4, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(3),calculateButtonHeight(rowCount))
                                        .setLabel("Stroke Colour")
                                        .setVisible(false)
                                        .setGroup(RigidbodyGeneration)
                                        .setValue(false)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {

                                                        StrokeColourSelectorOnChange();
                                                    }
                                                })
                                            ;

                        Slider strokeWeight = userInterface.addSlider("StrokeWeight")
                                        .setPosition(calculateButtonPositionX(3, calculateButtonWidth(3)), calculateButtonPositionY(4, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(3),calculateButtonHeight(rowCount))
                                        .setLabel("Stroke")
                                        .setVisible(false)
                                        .setRange(0, 0.5f)
                                        .setValue(0.05f)
                                        .setGroup(RigidbodyGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {

                                                        StrokeWeightElementOnChange();
                                                    }
                                                })
                                            ;

                        Slider redSliderFill = userInterface.addSlider("RedFill")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(3)), calculateButtonPositionY(5, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(3),calculateButtonHeight(rowCount))
                                        .setLabel("Red")
                                        .setVisible(false)
                                        .setRange(0, 255)
                                        .setValue(defaultFillColour.x)
                                        .setGroup(RigidbodyGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                        
                                                        FillSliderElementOnChange();
                                                    }
                                                })
                                            ;

                        Slider greenSliderFill = userInterface.addSlider("GreenFill")
                                        .setPosition(calculateButtonPositionX(2, calculateButtonWidth(3)), calculateButtonPositionY(5, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(3),calculateButtonHeight(rowCount))
                                        .setLabel("Green")
                                        .setVisible(false)
                                        .setRange(0, 255)
                                        .setValue(defaultFillColour.y)
                                        .setGroup(RigidbodyGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {

                                                        FillSliderElementOnChange();
                                                    }
                                                })
                                            ;

                        Slider blueSliderFill = userInterface.addSlider("BlueFill")
                                        .setPosition(calculateButtonPositionX(3, calculateButtonWidth(3)), calculateButtonPositionY(5, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(3),calculateButtonHeight(rowCount))
                                        .setLabel("Blue")
                                        .setVisible(false)
                                        .setRange(0, 255)
                                        .setValue(defaultFillColour.z)
                                        .setGroup(RigidbodyGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                        
                                                        FillSliderElementOnChange();
                                                    }
                                                })
                                            ;

                        Slider redSliderStroke = userInterface.addSlider("RedStroke")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(3)), calculateButtonPositionY(5, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(3),calculateButtonHeight(rowCount))
                                        .setLabel("Red")
                                        .setVisible(false)
                                        .setRange(0, 255)
                                        .setValue(defaultStrokeColour.x)
                                        .setGroup(RigidbodyGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {

                                                        StrokeSliderElementOnChange();
                                                    }
                                                })
                                            ;

                        Slider greenSliderStroke = userInterface.addSlider("GreenStroke")
                                        .setPosition(calculateButtonPositionX(2, calculateButtonWidth(3)), calculateButtonPositionY(5, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(3),calculateButtonHeight(rowCount))
                                        .setLabel("Green")
                                        .setVisible(false)
                                        .setRange(0, 255)
                                        .setValue(defaultStrokeColour.y)
                                        .setGroup(RigidbodyGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                        
                                                        StrokeSliderElementOnChange();
                                                    }
                                                })
                                            ;

                        Slider blueSliderStroke = userInterface.addSlider("BlueStroke")
                                        .setPosition(calculateButtonPositionX(3, calculateButtonWidth(3)), calculateButtonPositionY(5, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(3),calculateButtonHeight(rowCount))
                                        .setLabel("Blue")
                                        .setVisible(false)
                                        .setRange(0, 255)
                                        .setValue(defaultStrokeColour.z)
                                        .setGroup(RigidbodyGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                        
                                                        StrokeSliderElementOnChange();
                                                    }
                                                })
                                            ;

                        Bang colorBox = userInterface.addBang("ColorBox")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(1)), calculateButtonPositionY(6, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(1),calculateButtonHeight(rowCount))
                                        .setLabel("Color")
                                        .setColorForeground(color(defaultFillColour.x, defaultFillColour.y, defaultFillColour.z))
                                        .setColorActive(color(defaultFillColour.x, defaultFillColour.y, defaultFillColour.z))
                                        .setVisible(false)
                                        .setLabelVisible(false)
                                        .setGroup(RigidbodyGeneration)
                                        ;

                        Toggle isStatic = userInterface.addToggle("isStatic")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(3)), calculateButtonPositionY(7, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(3),calculateButtonHeight(rowCount))
                                        .setLabel("Static")
                                        .setVisible(false)
                                        .setGroup(RigidbodyGeneration)
                                        .setValue(defaultIsStatic)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                        IsStaticSelectorElementOnChange();
                                                    }
                                                })
                                            ;

                        Toggle isTranslationallyStatic = userInterface.addToggle("transStatic")
                                        .setPosition(calculateButtonPositionX(2, calculateButtonWidth(3)), calculateButtonPositionY(7, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(3),calculateButtonHeight(rowCount))
                                        .setLabel("TransStatic")
                                        .setVisible(false)
                                        .setGroup(RigidbodyGeneration)
                                        .setValue(defaultIsTransStatic)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                        IsTransStaticSelectorElementOnChange();
                                                    }
                                                })
                                            ;

                        Toggle isRotationallyStatic = userInterface.addToggle("rotStatic")
                                        .setPosition(calculateButtonPositionX(3, calculateButtonWidth(3)), calculateButtonPositionY(7, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(3),calculateButtonHeight(rowCount))
                                        .setLabel("RotStatic")
                                        .setVisible(false)
                                        .setGroup(RigidbodyGeneration)
                                        .setValue(defaultIsRotStatic)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                        IsRotStaticSelectorElementOnChange();
                                                    }
                                                })
                                            ;

                        Slider angle = userInterface.addSlider("Angle")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(2)), calculateButtonPositionY(8, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(2),calculateButtonHeight(rowCount))
                                        .setLabel("Angle")
                                        .setVisible(false)
                                        .setRange(0, 360)
                                        .setValue(defaultAngle)
                                        .setGroup(RigidbodyGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {

                                                       AngleSliderElementOnChange();
                                                    }
                                                })
                                            ;

                        Slider angularVelocity = userInterface.addSlider("AngularVelocity")
                                        .setPosition(calculateButtonPositionX(2, calculateButtonWidth(2)), calculateButtonPositionY(8, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(2),calculateButtonHeight(rowCount))
                                        .setLabel("Angular Vel")
                                        .setVisible(false)
                                        .setRange(-10, 10)
                                        .setValue(defaultAngularVelocity)
                                        .setGroup(RigidbodyGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                            
                                                        AngularVelocitySliderElementOnChange();
                                                    }
                                                })
                                        ;
                        Toggle addGravity = userInterface.addToggle("AddGravity")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(1)), calculateButtonPositionY(9, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(1),calculateButtonHeight(rowCount))
                                        .setLabel("Add Gravity")
                                        .setVisible(false)
                                        .setValue(defaultAddGravity)
                                        .setGroup(RigidbodyGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                        AddGravitySelectorElementOnChange();
                                                    }
                                                })
                                            ;

                        

/*----------------------------------- Forces Tab ------------------------------------------*/
            Group ForceGeneration = userInterface.addGroup("Force")
                            .setPosition(calculateGroupPositionX(), calculateGroupPositionY())
                            .setBackgroundHeight(globalGroupHeight)
                            .setBarHeight(globalGroupBarHeight)
                            .setBackgroundColor(globalGroupColor)
                            .setWidth(globalGroupWidth)
                             //.disableCollapse()
                            .setTab("Forces")
                            ;
                        Toggle addSpring = userInterface.addToggle("AddSpring")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(3)), calculateButtonPositionY(1, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(3),calculateButtonHeight(rowCount))
                                        .setLabel("Spring")
                                        .setValue(defaultSpringSelector)
                                        .setVisible(true)
                                        .setGroup(ForceGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                        SpringForceSelectorOnChange();
                                                    }
                                                })
                                            ;
                        Toggle addRod = userInterface.addToggle("AddRod")
                                        .setPosition(calculateButtonPositionX(2, calculateButtonWidth(3)), calculateButtonPositionY(1, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(3),calculateButtonHeight(rowCount))
                                        .setLabel("Rod")
                                        .setValue(defaultRodSelector)
                                        .setVisible(true)
                                        .setGroup(ForceGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                        RodForceSelectorOnChange();
                                                    }
                                                })
                                            ;
                        Toggle addMotor = userInterface.addToggle("AddMotor")
                                        .setPosition(calculateButtonPositionX(3, calculateButtonWidth(3)), calculateButtonPositionY(1, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(3),calculateButtonHeight(rowCount))
                                        .setLabel("Motor")
                                        .setValue(defaultMotorSelector)
                                        .setVisible(true)
                                        .setGroup(ForceGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                        MotorForceSelectorOnChange();
                                                    }
                                                })
                                            ;
                        Slider springConstant = userInterface.addSlider("SpringConstant")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(1)), calculateButtonPositionY(2, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(1),calculateButtonHeight(rowCount))
                                        .setLabel("Spring Constant")
                                        .setVisible(false)
                                        .setRange(0, 300)
                                        .setValue(defaultSpringConstant)
                                        .setGroup(ForceGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                        SpringConstantSliderElementOnChange();
                                                    }
                                                })
                                            ;
                        Slider springEquilibriumLength = userInterface.addSlider("SpringEquilibriumLength")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(1)), calculateButtonPositionY(3, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(1),calculateButtonHeight(rowCount))
                                        .setLabel("Equilibrium Length")
                                        .setVisible(false)
                                        .setRange(0, 5)
                                        .setValue(defaultSpringEquilibriumLength)
                                        .setGroup(ForceGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                        SpringEquilibriumLengthSliderElementOnChange();
                                                    }
                                                })
                                            ;

                        Slider springDamping = userInterface.addSlider("SpringDamping")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(1)), calculateButtonPositionY(4, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(1),calculateButtonHeight(rowCount))
                                        .setLabel("Damping")
                                        .setVisible(false)
                                        .setRange(0, 1)
                                        .setValue(defaultSpringDamping)
                                        .setGroup(ForceGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                        SpringDampingSliderElementOnChange();
                                                    }
                                                })
                                            ;

                        Toggle springLockToX = userInterface.addToggle("SpringLockToX")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(1)), calculateButtonPositionY(5, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(1),calculateButtonHeight(rowCount))
                                        .setLabel("Lock translation to x-axis")
                                        .setVisible(false)
                                        .setValue(defaultLockToXAxis)
                                        .setGroup(ForceGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                        SpringLockToXSelectorElementOnChange();
                                                    }
                                                })
                                            ;
                        Toggle springLockToY = userInterface.addToggle("SpringLockToY")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(1)), calculateButtonPositionY(6, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(1),calculateButtonHeight(rowCount))
                                        .setLabel("Lock translation to y-axis")
                                        .setVisible(false)
                                        .setValue(defaultLockToYAxis)
                                        .setGroup(ForceGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                        SpringLockToYSelectorElementOnChange();
                                                    }
                                                })
                                            ;
                        Toggle springIsPerfect = userInterface.addToggle("SpringIsPerfect")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(2)), calculateButtonPositionY(7, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(2),calculateButtonHeight(rowCount))
                                        .setLabel("Perfect Spring")
                                        .setVisible(false)
                                        .setValue(defaultSpringIsPerfect)
                                        .setGroup(ForceGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                        SpringIsPerfectSelectorElementOnChange();
                                                    }
                                                })
                                            ;
                        Toggle springIsHingeable = userInterface.addToggle("SpringIsHingeable")
                                        .setPosition(calculateButtonPositionX(2, calculateButtonWidth(2)), calculateButtonPositionY(7, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(2),calculateButtonHeight(rowCount))
                                        .setLabel("Hingeable")
                                        .setVisible(false)
                                        .setValue(defaultSpringIsHingeable)
                                        .setGroup(ForceGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                        SpringIsHingeableSelectorElementOnChange();
                                                    }
                                                })
                                            ;
                        Toggle springSnapToCenter = userInterface.addToggle("SpringSnapToCenter")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(2)), calculateButtonPositionY(8, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(2),calculateButtonHeight(rowCount))
                                        .setLabel("Snap to Center")
                                        .setVisible(false)
                                        .setValue(defaultSnapToCenter)
                                        .setGroup(ForceGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                        SpringSnapToCenterSelectorElementOnChange();
                                                    }
                                                })
                                            ;
                        Toggle springSnapToEdge = userInterface.addToggle("SpringSnapToEdge")
                                        .setPosition(calculateButtonPositionX(2, calculateButtonWidth(2)), calculateButtonPositionY(8, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(2),calculateButtonHeight(rowCount))
                                        .setLabel("Snap to Edge")
                                        .setVisible(false)
                                        .setValue(defaultSnapToEdge)
                                        .setGroup(ForceGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                        SpringSnapToEdgeSelectorElementOnChange();
                                                    }
                                                })
                                            ;


                        Toggle rodIsHingeable = userInterface.addToggle("RodIsHingeable")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(1)), calculateButtonPositionY(2, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(1),calculateButtonHeight(rowCount))
                                        .setLabel("Hingeable")
                                        .setVisible(false)
                                        .setValue(defaultRodIsHingeable)
                                        .setGroup(ForceGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                        RodIsHingeableSelectorElementOnChange();
                                                    }
                                                })
                                            ;
                        Toggle rodSnapToCenter = userInterface.addToggle("RodSnapToCenter")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(2)), calculateButtonPositionY(3, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(2),calculateButtonHeight(rowCount))
                                        .setLabel("Snap to Center")
                                        .setVisible(false)
                                        .setValue(defaultSnapToCenter)
                                        .setGroup(ForceGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                        RodSnapToCenterSelectorElementOnChange();
                                                    }
                                                })
                                            ;
                        Toggle rodSnapToEdge = userInterface.addToggle("RodSnapToEdge")
                                        .setPosition(calculateButtonPositionX(2, calculateButtonWidth(2)), calculateButtonPositionY(3, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(2),calculateButtonHeight(rowCount))
                                        .setLabel("Snap to Edge")
                                        .setVisible(false)
                                        .setValue(defaultSnapToEdge)
                                        .setGroup(ForceGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                        RodSnapToEdgeSelectorElementOnChange();
                                                    }
                                                })
                                            ;
                        Slider motorTargetAngularVelocity = userInterface.addSlider("MotorTargetAngularVelocity")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(1)), calculateButtonPositionY(2, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(1),calculateButtonHeight(rowCount))
                                        .setLabel("Target Angular Velocity")
                                        .setVisible(false)
                                        .setRange(-10, 10)
                                        .setValue(defaultMotorTargetAngularVelocity)
                                        .setGroup(ForceGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                        MotorTargetAngularVelocitySliderElementOnChange();
                                                    }
                                                })
                                            ;
                        Toggle motorDrawMotor = userInterface.addToggle("MotorDrawMotor")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(2)), calculateButtonPositionY(3, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(2),calculateButtonHeight(rowCount))
                                        .setLabel("Draw Motor")
                                        .setVisible(false)
                                        .setValue(defaultMotorDrawMotor)
                                        .setGroup(ForceGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                        MotorDrawMotorSelectorElementOnChange();
                                                    }
                                                })
                                            ;
                        Toggle motorDrawMotorForce = userInterface.addToggle("MotorDrawMotorForce")
                                        .setPosition(calculateButtonPositionX(2, calculateButtonWidth(2)), calculateButtonPositionY(3, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(2),calculateButtonHeight(rowCount))
                                        .setLabel("Draw Motor Force")
                                        .setVisible(false)
                                        .setValue(defaultMotorDrawMotorForce)
                                        .setGroup(ForceGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                        MotorDrawMotorForceSelectorElementOnChange();
                                                    }
                                                })
                                            ;
/*
====================================================================================================
======================================== Formatting ================================================
====================================================================================================
*/

userInterface.getController("Circle").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
userInterface.getController("Box").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
userInterface.getController("Polygon").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);

userInterface.getController("RectangleWidth").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
userInterface.getController("RectangleHeight").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
userInterface.getController("CircleRadius").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);

userInterface.getController("Density").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
userInterface.getController("Restitution").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);

userInterface.getController("StrokeWeight").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
userInterface.getController("FillColour").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
userInterface.getController("StrokeColour").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);

userInterface.getController("RedStroke").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
userInterface.getController("GreenStroke").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
userInterface.getController("BlueStroke").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

userInterface.getController("RedFill").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
userInterface.getController("GreenFill").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
userInterface.getController("BlueFill").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

userInterface.getController("ColorBox").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

userInterface.getController("isStatic").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
userInterface.getController("transStatic").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
userInterface.getController("rotStatic").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);

userInterface.getController("Angle").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
userInterface.getController("AngularVelocity").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

userInterface.getController("AddGravity").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

userInterface.getController("AddSpring").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
userInterface.getController("AddRod").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
userInterface.getController("AddMotor").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);

userInterface.getController("SpringConstant").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
userInterface.getController("SpringEquilibriumLength").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
userInterface.getController("SpringDamping").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

userInterface.getController("SpringLockToX").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
userInterface.getController("SpringLockToY").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);

userInterface.getController("SpringIsPerfect").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
userInterface.getController("SpringIsHingeable").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);

userInterface.getController("SpringSnapToCenter").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
userInterface.getController("SpringSnapToEdge").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);

userInterface.getController("RodIsHingeable").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
userInterface.getController("RodSnapToCenter").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
userInterface.getController("RodSnapToEdge").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);

userInterface.getController("MotorTargetAngularVelocity").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
userInterface.getController("MotorDrawMotor").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
userInterface.getController("MotorDrawMotorForce").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);





userInterface.getTab("default").hide();

       // TODO: IMPLEMENT A STARTING ANGLE FOR THE RIGIDRODS, SO OBJECTS CAN BE JOINTED AT
       //ANGLES AND STAY FIXED

    }

/*
====================================================================================================
======================================== Helper Methods ============================================
====================================================================================================
*/
   public int calculateButtonWidth(int buttonCount) {
        return (globalGroupWidth - 2 * globalGroupPaddingX - (buttonCount - 1) * globalInterElementPaddingX) / buttonCount;
     }

    public int calculateButtonHeight(int rowCount) {
     rowCount--;
    return (globalGroupHeight - 2 * globalGroupPaddingY - (rowCount - 1) * globalInterElementPaddingY) / rowCount;
    }

    public int calculateButtonPositionX(int buttonNumber, int buttonWidth) {
     buttonNumber--;
     return  globalGroupPaddingX + buttonNumber * (buttonWidth + globalInterElementPaddingX);
    }
    public int calculateButtonPositionY(int rowNumber, int buttonHeight) {
     rowNumber--;
     return globalGroupPaddingX + rowNumber * (buttonHeight + globalInterElementPaddingY);
    }

    public int calculateGroupPositionX() {
     return width - globalGroupWidth - globalScreenGroupPaddingX;
    }
    public int calculateGroupPositionY() {
     return globalScreenGroupPaddingY;
    }


/*
====================================================================================================
======================================= Element Interactivity ======================================
====================================================================================================
*/
/*--------------------------------- Rigidbodies Tab ----------------------------------------------*/
/*------------------------------ Global Shape Selector Methods -----------------------------------*/
private void ShapeSelectorElementOnSelect() {

    interactivityListener.setGenerateRigidbodies(true);
    interactivityListener.setGenerateForces(false);


    userInterface.getController("Density").setVisible(true);
    userInterface.getController("Restitution").setVisible(true);

    if(isFillColourSelectedDefault) {
        userInterface.getController("RedFill").setVisible(true);
        userInterface.getController("GreenFill").setVisible(true);
        userInterface.getController("BlueFill").setVisible(true);

        userInterface.getController("RedStroke").setVisible(false);
        userInterface.getController("GreenStroke").setVisible(false);
        userInterface.getController("BlueStroke").setVisible(false);
           
        //Default enabled color selector
        userInterface.getController("FillColour").setValue(1);
    } else {
        userInterface.getController("RedFill").setVisible(false);
        userInterface.getController("GreenFill").setVisible(false);
        userInterface.getController("BlueFill").setVisible(false);

        userInterface.getController("RedStroke").setVisible(true);
        userInterface.getController("GreenStroke").setVisible(true);
        userInterface.getController("BlueStroke").setVisible(true);
            
        //Default enabled color selector
        userInterface.getController("StrokeColour").setValue(1);
    }

    userInterface.getController("ColorBox").setVisible(true);

    userInterface.getController("FillColour").setVisible(true);
    userInterface.getController("StrokeColour").setVisible(true);
    userInterface.getController("StrokeWeight").setVisible(true);
                                                            
    userInterface.getController("isStatic").setVisible(true);
    userInterface.getController("transStatic").setVisible(true);
    userInterface.getController("rotStatic").setVisible(true);

    userInterface.getController("Angle").setVisible(true);
    userInterface.getController("AngularVelocity").setVisible(true);
    userInterface.getController("AddGravity").setVisible(true);
    
}

private void ShapeSelectorElementOnDeselect() {

    userInterface.getController("RectangleWidth").setVisible(false);
    userInterface.getController("RectangleHeight").setVisible(false);

    userInterface.getController("CircleRadius").setVisible(false);

    userInterface.getController("Density").setVisible(false);
    userInterface.getController("Restitution").setVisible(false);

    userInterface.getController("RedFill").setVisible(false);
    userInterface.getController("GreenFill").setVisible(false);
    userInterface.getController("BlueFill").setVisible(false);

    userInterface.getController("RedStroke").setVisible(false);
    userInterface.getController("GreenStroke").setVisible(false);
    userInterface.getController("BlueStroke").setVisible(false);

    userInterface.getController("ColorBox").setVisible(false);

    userInterface.getController("StrokeWeight").setVisible(false);
    userInterface.getController("FillColour").setVisible(false);
    userInterface.getController("StrokeColour").setVisible(false);

    userInterface.getController("isStatic").setVisible(false);
    userInterface.getController("transStatic").setVisible(false);
    userInterface.getController("rotStatic").setVisible(false);

    userInterface.getController("Angle").setVisible(false);
    userInterface.getController("AngularVelocity").setVisible(false);

    userInterface.getController("AddGravity").setVisible(false);
}
/*-------------------------------- Global Colouring Element Methods ------------------------------*/
 private void ColouringElementOnDeselect() {
     if(userInterface.getController("FillColour").getValue() == 0
     && userInterface.getController("StrokeColour").getValue() == 0){
         
        userInterface.getController("RedFill").setVisible(false);
        userInterface.getController("GreenFill").setVisible(false);
        userInterface.getController("BlueFill").setVisible(false);

        userInterface.getController("RedStroke").setVisible(false);
        userInterface.getController("GreenStroke").setVisible(false);
        userInterface.getController("BlueStroke").setVisible(false);

        userInterface.getController("ColorBox").setVisible(false);
     }
 }

/* --------------------------------- Circle Shape Selector Element -------------------------------*/

private void CircleShapeSelectorOnChange() {
    if(userInterface.getController("Circle").getValue() == 1){

        ShapeSelectorElementOnSelect();
        CircleShapeSelectorElementOnSelect();
        CircleShapeSelectorInteractivityListener();

    } else if(userInterface.getController("Circle").getValue() == 0
            && userInterface.getController("Box").getValue() == 0
            && userInterface.getController("Polygon").getValue() == 0){
        
        ShapeSelectorElementOnDeselect();
    }
}

private void CircleShapeSelectorElementOnSelect() {

    userInterface.getController("Box").setValue(0);
    userInterface.getController("Polygon").setValue(0);

    userInterface.getController("RectangleWidth").setVisible(false);
    userInterface.getController("RectangleHeight").setVisible(false);

    userInterface.getController("RectangleWidth").setValue(0f);
    userInterface.getController("RectangleHeight").setValue(0f);

    userInterface.getController("CircleRadius").setVisible(true);
}

private void CircleShapeSelectorInteractivityListener() {

    interactivityListener.setShapeType(ShapeType.CIRCLE);
}

/* --------------------------------- Rectangle Shape Selector Element ----------------------------*/
private void RectangleShapeSelectorOnChange() {
    if(userInterface.getController("Box").getValue() == 1){
        
        ShapeSelectorElementOnSelect();
        RectangleShapeSelectorElementOnSelect();
        RectangleShapeSelectorElementInteractivityListener();

    } else if(userInterface.getController("Circle").getValue() == 0
            && userInterface.getController("Box").getValue() == 0
            && userInterface.getController("Polygon").getValue() == 0){
        
        ShapeSelectorElementOnDeselect();
    }
}
private void RectangleShapeSelectorElementOnSelect() {

    userInterface.getController("Circle").setValue(0);
    userInterface.getController("Polygon").setValue(0);

    userInterface.getController("RectangleWidth").setVisible(true);
    userInterface.getController("RectangleHeight").setVisible(true);


    userInterface.getController("CircleRadius").setVisible(false);
    userInterface.getController("CircleRadius").setValue(0f);
}


private void RectangleShapeSelectorElementInteractivityListener() {

    interactivityListener.setShapeType(ShapeType.BOX);

}
/* --------------------------------- Polygon Shape Selector Element ------------------------------*/
                            //TODO IMPLEMENT THIS

/*-------------------------------------- Density Element -----------------------------------------*/
private void DensityElementOnChange() {

    float density = userInterface.getController("Density").getValue();
    interactivityListener.setDensity(density);
}

/*-------------------------------------- Restitution Element -------------------------------------*/
private void RestitutionElementOnChange() {

    float restitution = userInterface.getController("Restitution").getValue();
    interactivityListener.setRestitution(restitution);
}

/*-------------------------------------- Box Width Element ---------------------------------------*/
private void RectangleWidthElementOnChange() {
    if(userInterface.getController("Box").getValue() == 1){

        float width = userInterface.getController("RectangleWidth").getValue();
        interactivityListener.setWidth(width);
    }
}

/*-------------------------------------- Box Height Element --------------------------------------*/
private void RectangleHeightElementOnChange() {
    if(userInterface.getController("Box").getValue() == 1) {

        float height = userInterface.getController("RectangleHeight").getValue();
        interactivityListener.setHeight(height);
    }
}

/*-------------------------------------- Circle Radius Element -----------------------------------*/
private void CircleRadiusElementOnChange() {
    if(userInterface.getController("Circle").getValue() == 1) {

        float radius = userInterface.getController("CircleRadius").getValue();
        interactivityListener.setRadius(radius);
    }
}

/*--------------------------------- Fill Colour Selector Element ---------------------------------*/
private void FillColourSelectorOnChange() {
    if(userInterface.getController("FillColour").getValue() == 1) {

        FillColourElementOnSelect();
    } else if (userInterface.getController("FillColour").getValue() == 0
            && userInterface.getController("StrokeColour").getValue() == 0) {
                
                ColouringElementOnDeselect();
    }
}

private void FillColourElementOnSelect() {

        userInterface.getController("StrokeColour").setValue(0);

        userInterface.getController("RedFill").setVisible(true);
        userInterface.getController("GreenFill").setVisible(true);
        userInterface.getController("BlueFill").setVisible(true);

        userInterface.getController("RedStroke").setVisible(false);
        userInterface.getController("GreenStroke").setVisible(false);
        userInterface.getController("BlueStroke").setVisible(false);

        userInterface.getController("ColorBox").setVisible(true);
}

/*--------------------------------- Stroke Colour Selector Element -------------------------------*/
private void StrokeColourSelectorOnChange() {

    if(userInterface.getController("StrokeColour").getValue() == 1) {

        StrokeColourElementOnSelect();
    } else if (userInterface.getController("FillColour").getValue() == 0
            && userInterface.getController("StrokeColour").getValue() == 0) {

                ColouringElementOnDeselect();
    }
}

private void StrokeColourElementOnSelect() {

    userInterface.getController("FillColour").setValue(0);

    userInterface.getController("RedStroke").setVisible(true);
    userInterface.getController("GreenStroke").setVisible(true);
    userInterface.getController("BlueStroke").setVisible(true);

    userInterface.getController("RedFill").setVisible(false);
    userInterface.getController("GreenFill").setVisible(false);
    userInterface.getController("BlueFill").setVisible(false);
    userInterface.getController("ColorBox").setVisible(true);
}

/*--------------------------------- Fill Slider Elements -----------------------------------------*/
private void FillSliderElementOnChange() {

    int red = (int)userInterface.getController("RedFill").getValue();
    int green = (int)userInterface.getController("GreenFill").getValue();
    int blue = (int)userInterface.getController("BlueFill").getValue();

    userInterface.getController("ColorBox").setColorForeground(color(red, green, blue));
    userInterface.getController("ColorBox").setColorActive(color(red, green, blue));

    interactivityListener.setFillColor(new PVector(red, green, blue));
}

/*--------------------------------- Stroke Slider Elements ------------------------------------*/
private void StrokeSliderElementOnChange() {

    int red = (int)userInterface.getController("RedStroke").getValue();
    int green = (int)userInterface.getController("GreenStroke").getValue();
    int blue = (int)userInterface.getController("BlueStroke").getValue();
    
    userInterface.getController("ColorBox").setColorForeground(color(red, green, blue));
    userInterface.getController("ColorBox").setColorActive(color(red, green, blue));
    interactivityListener.setStrokeColor(new PVector(red, green, blue));
}


/*--------------------------------- Stroke Weight Slider Element ---------------------------------*/
private void StrokeWeightElementOnChange() {

    float strokeWeight = userInterface.getController("StrokeWeight").getValue();
    interactivityListener.setStrokeWeight(strokeWeight);
}

/*--------------------------------- IsStatic Selector Element ------------------------------------*/
private void IsStaticSelectorElementOnChange() {

     if(userInterface.getController("isStatic").getValue() == 1){
        
        userInterface.getController("transStatic").setValue(0);
        userInterface.getController("rotStatic").setValue(0);

        interactivityListener.setIsTranslationallyStatic(false);
        interactivityListener.setIsRotationallyStatic(false);

        interactivityListener.setIsStatic(true);

    }
    else {

        interactivityListener.setIsStatic(false);
    }
}
/*--------------------------------- IsTransStatic Selector Element --------------------------------*/
private void IsTransStaticSelectorElementOnChange() {

    if(userInterface.getController("transStatic").getValue() == 1){

        userInterface.getController("rotStatic").setValue(0);
        userInterface.getController("isStatic").setValue(0);

        interactivityListener.setIsStatic(false);
        interactivityListener.setIsRotationallyStatic(false);

        interactivityListener.setIsTranslationallyStatic(true);

    } else {
        
        interactivityListener.setIsTranslationallyStatic(false);
    }
}

/*--------------------------------- IsRotStatic Selector Element ----------------------------------*/
private void IsRotStaticSelectorElementOnChange() {

    if(userInterface.getController("rotStatic").getValue() == 1){

        userInterface.getController("transStatic").setValue(0);
        userInterface.getController("isStatic").setValue(0);

        interactivityListener.setIsTranslationallyStatic(false);
        interactivityListener.setIsStatic(false);

        interactivityListener.setIsRotationallyStatic(true);

    } else {
        
        interactivityListener.setIsRotationallyStatic(false);
    }
}

/*--------------------------------- Angle Slider Element -----------------------------------------*/
private void AngleSliderElementOnChange() {

    float angle = userInterface.getController("Angle").getValue();
    interactivityListener.setAngle(radians(angle));
}

/*--------------------------------- Angular Velocity Slider Element -------------------------------*/
private void AngularVelocitySliderElementOnChange() {

    float angularVelocity = userInterface.getController("AngularVelocity").getValue();
    interactivityListener.setAngularVelocity(angularVelocity);
}
/*--------------------------------- Add Gravity Selector Element ----------------------------------*/
private void AddGravitySelectorElementOnChange() {
    
        if(userInterface.getController("AddGravity").getValue() == 1) {
    
            interactivityListener.setAddGravity(true);
        } else {
    
            interactivityListener.setAddGravity(false);
        }
}

/*--------------------------------- Forces Tab ---------------------------------------------------*/

private void ForceSelectorElementDeselect() {

    /*-------------------------------- Spring Elements -----------------------------------*/
    userInterface.getController("SpringConstant").setVisible(false);
    userInterface.getController("SpringEquilibriumLength").setVisible(false);
    userInterface.getController("SpringDamping").setVisible(false);

    userInterface.getController("SpringLockToX").setVisible(false);
    userInterface.getController("SpringLockToY").setVisible(false);

    userInterface.getController("SpringIsPerfect").setVisible(false);
    userInterface.getController("SpringIsHingeable").setVisible(false);

    userInterface.getController("SpringSnapToCenter").setVisible(false);
    userInterface.getController("SpringSnapToEdge").setVisible(false);

    /*-------------------------------- Rod Elements --------------------------------------*/
    userInterface.getController("RodIsHingeable").setVisible(false);
    userInterface.getController("RodSnapToCenter").setVisible(false);
    userInterface.getController("RodSnapToEdge").setVisible(false);


    /*-------------------------------- Motor Elements ------------------------------------*/
    userInterface.getController("MotorTargetAngularVelocity").setVisible(false);
    userInterface.getController("MotorDrawMotor").setVisible(false);
    userInterface.getController("MotorDrawMotorForce").setVisible(false);

}
/*--------------------------------- Spring Force Selector Element --------------------------------*/
private void SpringForceSelectorOnChange() {
    if(userInterface.getController("AddSpring").getValue() == 1) {

        ForceSelectorElementDeselect();
        interactivityListener.setForceType(ForceType.SPRING);
        interactivityListener.setGenerateRigidbodies(false);
        interactivityListener.setGenerateForces(true);

        userInterface.getController("AddRod").setValue(0);
        userInterface.getController("AddMotor").setValue(0);

        userInterface.getController("SpringConstant").setVisible(true);
        userInterface.getController("SpringEquilibriumLength").setVisible(true);
        userInterface.getController("SpringDamping").setVisible(true);

        userInterface.getController("SpringLockToX").setVisible(true);
        userInterface.getController("SpringLockToY").setVisible(true);

        userInterface.getController("SpringIsPerfect").setVisible(true);
        userInterface.getController("SpringIsHingeable").setVisible(true);

        userInterface.getController("SpringSnapToCenter").setVisible(true);
        userInterface.getController("SpringSnapToEdge").setVisible(true);


    } else if(userInterface.getController("AddSpring").getValue() == 0 && userInterface.getController("AddRod").getValue() == 0 && userInterface.getController("AddMotor").getValue() == 0) {

            ForceSelectorElementDeselect();
            interactivityListener.setGenerateRigidbodies(false);
            interactivityListener.setGenerateForces(false);
    }
}
/*--------------------------------- Rod Force Selector Element -----------------------------------*/
private void RodForceSelectorOnChange() {

        if(userInterface.getController("AddRod").getValue() == 1) {
        
        ForceSelectorElementDeselect();
        interactivityListener.setForceType(ForceType.ROD);
        interactivityListener.setGenerateRigidbodies(false);
        interactivityListener.setGenerateForces(true);

        userInterface.getController("AddSpring").setValue(0);
        userInterface.getController("AddMotor").setValue(0);

        userInterface.getController("RodIsHingeable").setVisible(true);
        userInterface.getController("RodSnapToCenter").setVisible(true);
        userInterface.getController("RodSnapToEdge").setVisible(true);

    } else if(userInterface.getController("AddSpring").getValue() == 0 && userInterface.getController("AddRod").getValue() == 0 && userInterface.getController("AddMotor").getValue() == 0) {

            ForceSelectorElementDeselect();
            interactivityListener.setGenerateRigidbodies(false);
            interactivityListener.setGenerateForces(false);
    }
}
/*--------------------------------- Motor Force Selector Element ---------------------------------*/
private void MotorForceSelectorOnChange() {
    if(userInterface.getController("AddMotor").getValue() == 1) {

        ForceSelectorElementDeselect();
        interactivityListener.setForceType(ForceType.MOTOR);
        interactivityListener.setGenerateRigidbodies(false);
        interactivityListener.setGenerateForces(true);

        userInterface.getController("AddSpring").setValue(0);
        userInterface.getController("AddRod").setValue(0);

        userInterface.getController("MotorTargetAngularVelocity").setVisible(true);
        userInterface.getController("MotorDrawMotor").setVisible(true);
        userInterface.getController("MotorDrawMotorForce").setVisible(true);

    } else if(userInterface.getController("AddSpring").getValue() == 0 && userInterface.getController("AddRod").getValue() == 0 && userInterface.getController("AddMotor").getValue() == 0) {
            ForceSelectorElementDeselect();
            interactivityListener.setGenerateRigidbodies(false);
            interactivityListener.setGenerateForces(false);
    }

}
/*--------------------------------- Spring Constant Slider Element --------------------------------*/
private void SpringConstantSliderElementOnChange() {
    float springConstant = userInterface.getController("SpringConstant").getValue();
    interactivityListener.setSpringConstant(springConstant);
}
/*--------------------------------- Spring Equilibrium Length Slider Element ----------------------*/
private void SpringEquilibriumLengthSliderElementOnChange() {
    float springEquilibriumLength = userInterface.getController("SpringEquilibriumLength").getValue();
    interactivityListener.setSpringEquilibriumLength(springEquilibriumLength);
}
/*--------------------------------- Spring Damping Slider Element --------------------------------*/
private void SpringDampingSliderElementOnChange() {
    float springDamping = userInterface.getController("SpringDamping").getValue();
    interactivityListener.setSpringDamping(springDamping);
}
/*--------------------------------- Spring Lock To X Selector Element -----------------------------*/
private void SpringLockToXSelectorElementOnChange() {
    boolean lockToX = userInterface.getController("SpringLockToX").getValue() == 1 ? true : false;
    interactivityListener.setLockToXAxis(lockToX);
}
/*--------------------------------- Spring Lock To Y Selector Element -----------------------------*/
private void SpringLockToYSelectorElementOnChange() {
    boolean lockToY = userInterface.getController("SpringLockToY").getValue() == 1 ? true : false;
    interactivityListener.setLockToYAxis(lockToY);
}

/*--------------------------------- Spring Is Perfect Selector Element ----------------------------*/
private void SpringIsPerfectSelectorElementOnChange() {
    boolean isPerfect = userInterface.getController("SpringIsPerfect").getValue() == 1 ? true : false;
    interactivityListener.setSpringIsPerfect(isPerfect);
}

/*--------------------------------- Spring Is Hingeable Selector Element --------------------------*/
private void SpringIsHingeableSelectorElementOnChange() {
    boolean isHingeable = userInterface.getController("SpringIsHingeable").getValue() == 1 ? true : false;
    interactivityListener.setSpringIsHingeable(isHingeable);
}
/*--------------------------------- Spring Snap To Center Selector Element ------------------------*/
private void SpringSnapToCenterSelectorElementOnChange() {
    if(userInterface.getController("SpringSnapToCenter").getValue() == 1) {
        userInterface.getController("SpringSnapToEdge").setValue(0);
    }
    boolean snapToCenter = userInterface.getController("SpringSnapToCenter").getValue() == 1 ? true : false;
    interactivityListener.setSnapToCenter(snapToCenter);
}

/*--------------------------------- Spring Snap To Edge Selector Element --------------------------*/
private void SpringSnapToEdgeSelectorElementOnChange() {

    if(userInterface.getController("SpringSnapToEdge").getValue() == 1) {
        userInterface.getController("SpringSnapToCenter").setValue(0);
    }
    boolean snapToEdge = userInterface.getController("SpringSnapToEdge").getValue() == 1 ? true : false;
    interactivityListener.setSnapToEdge(snapToEdge);
}

/*--------------------------------- Rod Is Hingeable Selector Element -----------------------------*/
private void RodIsHingeableSelectorElementOnChange() {
    boolean isHingeable = userInterface.getController("RodIsHingeable").getValue() == 1 ? true : false;
    interactivityListener.setRodIsHingeable(isHingeable);
}

/*--------------------------------- Rod Snap To Center Selector Element ---------------------------*/
private void RodSnapToCenterSelectorElementOnChange() {
    if(userInterface.getController("RodSnapToCenter").getValue() == 1) {
        userInterface.getController("RodSnapToEdge").setValue(0);
    }
    boolean snapToCenter = userInterface.getController("RodSnapToCenter").getValue() == 1 ? true : false;
    interactivityListener.setSnapToCenter(snapToCenter);

}

/*--------------------------------- Rod Snap To Edge Selector Element -----------------------------*/
private void RodSnapToEdgeSelectorElementOnChange() {
    if(userInterface.getController("RodSnapToEdge").getValue() == 1) {
        userInterface.getController("RodSnapToCenter").setValue(0);
    }

    boolean snapToEdge = userInterface.getController("RodSnapToEdge").getValue() == 1 ? true : false;
    interactivityListener.setSnapToEdge(snapToEdge);

}
/*--------------------------------- Motor Target Angular Velocity Slider Element -------------------*/
private void MotorTargetAngularVelocitySliderElementOnChange() {
    float targetAngularVelocity = userInterface.getController("MotorTargetAngularVelocity").getValue();
    interactivityListener.setMotorTargetAngularVelocity(targetAngularVelocity);
}

/*--------------------------------- Motor Draw Motor Selector Element -----------------------------*/
private void MotorDrawMotorSelectorElementOnChange() {
    boolean drawMotor = userInterface.getController("MotorDrawMotor").getValue() == 1 ? true : false;
    interactivityListener.setMotorDrawMotor(drawMotor);
}
/*--------------------------------- Motor Draw Motor Force Selector Element -----------------------*/
private void MotorDrawMotorForceSelectorElementOnChange() {
    boolean drawMotorForce = userInterface.getController("MotorDrawMotorForce").getValue() == 1 ? true : false;
    interactivityListener.setMotorDrawMotorForce(drawMotorForce);
}

/*
====================================================================================================
======================================== Getters and Setters =======================================
====================================================================================================
*/

public int getGroupHeight() {
    return this.globalGroupHeight;
}
public int getGroupWidth() {
    return this.globalGroupWidth;
}

    }