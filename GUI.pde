    public class GUI {
        
        //The size of the group
        private int globalGroupHeight = 225;
        private int globalGroupWidth = 230;
        private int globalGroupBarHeight = 20;

        //The padding of the group from the edges of the screen
        private int globalScreenGroupPaddingX = 40;
        private int globalScreenGroupPaddingY = 40;


        
        //The padding for elements from the edge of the group
        private int globalGroupPaddingX = 10;
        private int globalGroupPaddingY = 10;
        
        //The padding between elements in the group
        private int globalInterElementPaddingX = 10;
        private int globalInterElementPaddingY = 10;

    
        //the group background color
        private int globalGroupColor = color(250, 50);

        private int rowCount = 9;
     
        /*---------------------------- Default Values Initialization ------------------------*/
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


/*
====================================================================================================
========================================= User Interface ===========================================
====================================================================================================
*/
        public GUI(ControlP5 userInterface) {
    /*---------------------- Interactivity Listener Initialization -----------------*/

        interactivityListener.setWidth(defaultRectangleWidth);
        interactivityListener.setHeight(defaultRectangleHeight);
        interactivityListener.setRadius(defaultCircleRadius);
        interactivityListener.setDensity(defaultDensity);
        interactivityListener.setRestitution(defaultRestitution);
        interactivityListener.setFillColour(defaultFillColour);
        interactivityListener.setStrokeColour(defaultStrokeColour);
        interactivityListener.setStrokeWeight(defaultStrokeWeight);

        interactivityListener.setIsStatic(defaultIsStatic);
        interactivityListener.setIsTranslationallyStatic(defaultIsTransStatic);
        interactivityListener.setIsRotationallyStatic(defaultIsRotStatic);

    /*----------------------------------------------------------------------------*/

                Tab Rigidbodies = userInterface.addTab("Rigidbodies")
                                .setLabel("Rigidbodies")
                                .setId(0);

                Tab Forces = userInterface.addTab("Forces")
                                .setLabel("Forces")
                                .setId(1);

                    
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
                                                        if(userInterface.getController("Circle").getValue() == 1){

                                                            userInterface.getController("Box").setValue(0);
                                                            userInterface.getController("Polygon").setValue(0);

                                                            userInterface.getController("RectangleWidth").setVisible(false);
                                                            userInterface.getController("RectangleHeight").setVisible(false);

                                                            userInterface.getController("CircleRadius").setVisible(true);
                                                            
                                                            userInterface.getController("Density").setVisible(true);
                                                            userInterface.getController("Restitution").setVisible(true);
                                                        

                                                            userInterface.getController("RedFill").setVisible(true);
                                                            userInterface.getController("GreenFill").setVisible(true);
                                                            userInterface.getController("BlueFill").setVisible(true);

                                                            userInterface.getController("RedStroke").setVisible(false);
                                                            userInterface.getController("GreenStroke").setVisible(false);
                                                            userInterface.getController("BlueStroke").setVisible(false);

                                                            userInterface.getController("ColorBox").setVisible(true);

                                                            userInterface.getController("FillColour").setVisible(true);
                                                            userInterface.getController("StrokeColour").setVisible(true);
                                                            userInterface.getController("StrokeWeight").setVisible(true);
                                                            
                                                            userInterface.getController("isStatic").setVisible(true);
                                                            userInterface.getController("transStatic").setVisible(true);
                                                            userInterface.getController("rotStatic").setVisible(true);

                                                            userInterface.getController("Angle").setVisible(true);
                                                            userInterface.getController("AngularVelocity").setVisible(true);

                                                            //Default enabled color selector
                                                            userInterface.getController("FillColour").setValue(1);


                                                            /*-------------- Interactivity Listener--------------*/
                                                            ShapeType shapeType = ShapeType.CIRCLE;

                                                            interactivityListener.setShapeType(shapeType);
                                                            /*--------------------------------------------------*/

                                                        }
                                                        if(userInterface.getController("Circle").getValue() == 0
                                                            && userInterface.getController("Box").getValue() == 0
                                                            && userInterface.getController("Polygon").getValue() == 0){

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
                                                            
                                                        }
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
                                                        if(userInterface.getController("Box").getValue() == 1){

                                                            userInterface.getController("Circle").setValue(0);
                                                            userInterface.getController("Polygon").setValue(0);

                                                            userInterface.getController("CircleRadius").setVisible(false);

                                                            userInterface.getController("RectangleWidth").setVisible(true);
                                                            userInterface.getController("RectangleHeight").setVisible(true);
                                                            
                                                            userInterface.getController("Density").setVisible(true);
                                                            userInterface.getController("Restitution").setVisible(true);
                                                        

                                                            userInterface.getController("RedFill").setVisible(true);
                                                            userInterface.getController("GreenFill").setVisible(true);
                                                            userInterface.getController("BlueFill").setVisible(true);

                                                            userInterface.getController("RedStroke").setVisible(false);
                                                            userInterface.getController("GreenStroke").setVisible(false);
                                                            userInterface.getController("BlueStroke").setVisible(false);

                                                            userInterface.getController("ColorBox").setVisible(true);

                                                            userInterface.getController("FillColour").setVisible(true);
                                                            userInterface.getController("StrokeColour").setVisible(true);
                                                            userInterface.getController("StrokeWeight").setVisible(true);
                                                            
                                                            userInterface.getController("isStatic").setVisible(true);
                                                            userInterface.getController("transStatic").setVisible(true);
                                                            userInterface.getController("rotStatic").setVisible(true);

                                                            userInterface.getController("Angle").setVisible(true);
                                                            userInterface.getController("AngularVelocity").setVisible(true);
                                                            
                                                            //Default enabled colour selector
                                                            userInterface.getController("FillColour").setValue(1);

                                                            /*-------------- Interactivity Listener--------------*/

                                                            ShapeType shapeType = ShapeType.BOX;

                                                            interactivityListener.setShapeType(shapeType);
                                                            /*--------------------------------------------------*/
                                                        }
                                                        if(userInterface.getController("Circle").getValue() == 0
                                                            && userInterface.getController("Box").getValue() == 0
                                                            && userInterface.getController("Polygon").getValue() == 0){

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
                                                        }
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

                                                        if(userInterface.getController("Polygon").getValue() == 1){
                                                            userInterface.getController("Box").setValue(0);
                                                            userInterface.getController("Circle").setValue(0);

                                                            //COPY AND PASTE THE REST OF THE STUFF FROM THE OTHER ONE HERE
                                                            ShapeType shapeType = ShapeType.POLYGON;
                                                            interactivityListener.setShapeType(shapeType);
                                                        }

                                                        if(userInterface.getController("Circle").getValue() == 0
                                                            && userInterface.getController("Box").getValue() == 0
                                                            && userInterface.getController("Polygon").getValue() == 0){

                                                                //COPY AND PASTE THE REST OF THE STUFF FROM THE OTHER ONE HERE

                                                   
                                                        }
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
                                                        float density = userInterface.getController("Density").getValue();
                                                        interactivityListener.setDensity(density);
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
                                                        float restitution = userInterface.getController("Restitution").getValue();
                                                        interactivityListener.setRestitution(restitution);
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
                                                        if(userInterface.getController("Box").getValue() == 1){
                                                        float width = userInterface.getController("RectangleWidth").getValue();
                                                        interactivityListener.setWidth(width);
                                                        }
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
                                                        if(userInterface.getController("Box").getValue() == 1){
                                                        float height = userInterface.getController("RectangleHeight").getValue();
                                                        interactivityListener.setHeight(height);
                                                        }
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
                                                        if(userInterface.getController("Circle").getValue() == 1){
                                                        float radius = userInterface.getController("CircleRadius").getValue();
                                                        interactivityListener.setRadius(radius);
                                                        }
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
                                                        if(userInterface.getController("FillColour").getValue() == 0 && userInterface.getController("StrokeColour").getValue() == 0){
                                                            
                                                            userInterface.getController("RedFill").setVisible(false);
                                                            userInterface.getController("GreenFill").setVisible(false);
                                                            userInterface.getController("BlueFill").setVisible(false);

                                                            userInterface.getController("RedStroke").setVisible(false);
                                                            userInterface.getController("GreenStroke").setVisible(false);
                                                            userInterface.getController("BlueStroke").setVisible(false);

                                                            userInterface.getController("ColorBox").setVisible(false);
                                                        }
                                                        else if(userInterface.getController("FillColour").getValue() == 1){

                                                            userInterface.getController("StrokeColour").setValue(0);

                                                            userInterface.getController("RedStroke").setVisible(false);
                                                            userInterface.getController("GreenStroke").setVisible(false);
                                                            userInterface.getController("BlueStroke").setVisible(false);

                                                            userInterface.getController("RedFill").setVisible(true);
                                                            userInterface.getController("GreenFill").setVisible(true);
                                                            userInterface.getController("BlueFill").setVisible(true);

                                                        }
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
                                                        if(userInterface.getController("FillColour").getValue() == 0 && userInterface.getController("StrokeColour").getValue() == 0){

                                                            userInterface.getController("RedFill").setVisible(false);
                                                            userInterface.getController("GreenFill").setVisible(false);
                                                            userInterface.getController("BlueFill").setVisible(false);

                                                            userInterface.getController("RedStroke").setVisible(false);
                                                            userInterface.getController("GreenStroke").setVisible(false);
                                                            userInterface.getController("BlueStroke").setVisible(false);

                                                            userInterface.getController("ColorBox").setVisible(false);
                                                        }
                                                        else if(userInterface.getController("StrokeColour").getValue() == 1){

                                                            userInterface.getController("FillColour").setValue(0);

                                                            userInterface.getController("RedStroke").setVisible(true);
                                                            userInterface.getController("GreenStroke").setVisible(true);
                                                            userInterface.getController("BlueStroke").setVisible(true);

                                                            userInterface.getController("RedFill").setVisible(false);
                                                            userInterface.getController("GreenFill").setVisible(false);
                                                            userInterface.getController("BlueFill").setVisible(false);
                                                            userInterface.getController("ColorBox").setVisible(true);

        
                                                        }
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
                                                        float strokeWeight = userInterface.getController("StrokeWeight").getValue();
                                                        interactivityListener.setStrokeWeight(strokeWeight);
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
                                                        int red = (int)userInterface.getController("RedFill").getValue();
                                                        int green = (int)userInterface.getController("GreenFill").getValue();
                                                        int blue = (int)userInterface.getController("BlueFill").getValue();

                                                        userInterface.getController("ColorBox").setColorForeground(color(red, green, blue));
                                                        userInterface.getController("ColorBox").setColorActive(color(red, green, blue));

                                                        interactivityListener.setFillColour(new PVector(red, green, blue));
                                                    
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
                                                        int red = (int)userInterface.getController("RedFill").getValue();
                                                        int green = (int)userInterface.getController("GreenFill").getValue();
                                                        int blue = (int)userInterface.getController("BlueFill").getValue();
                                    
                                                        userInterface.getController("ColorBox").setColorForeground(color(red, green, blue));
                                                        userInterface.getController("ColorBox").setColorActive(color(red, green, blue));

                                                        interactivityListener.setFillColour(new PVector(red, green, blue));
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
                                                        int red = (int)userInterface.getController("RedFill").getValue();
                                                        int green = (int)userInterface.getController("GreenFill").getValue();
                                                        int blue = (int)userInterface.getController("BlueFill").getValue();

                                                        userInterface.getController("ColorBox").setColorForeground(color(red, green, blue));
                                                        userInterface.getController("ColorBox").setColorActive(color(red, green, blue));
                                                         
                                                        interactivityListener.setFillColour(new PVector(red, green, blue));
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
                                                        int red = (int)userInterface.getController("RedStroke").getValue();
                                                        int green = (int)userInterface.getController("GreenStroke").getValue();
                                                        int blue = (int)userInterface.getController("BlueStroke").getValue();

                                                        userInterface.getController("ColorBox").setColorForeground(color(red, green, blue));
                                                        userInterface.getController("ColorBox").setColorActive(color(red, green, blue));
                                                        interactivityListener.setStrokeColour(new PVector(red, green, blue));
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
                                                        int red = (int)userInterface.getController("RedStroke").getValue();
                                                        int green = (int)userInterface.getController("GreenStroke").getValue();
                                                        int blue = (int)userInterface.getController("BlueStroke").getValue();
                                    
                                                        userInterface.getController("ColorBox").setColorForeground(color(red, green, blue));
                                                        userInterface.getController("ColorBox").setColorActive(color(red, green, blue));

                                                        interactivityListener.setStrokeColour(new PVector(red, green, blue));
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
                                                        int red = (int)userInterface.getController("RedStroke").getValue();
                                                        int green = (int)userInterface.getController("GreenStroke").getValue();
                                                        int blue = (int)userInterface.getController("BlueStroke").getValue();

                                                        userInterface.getController("ColorBox").setColorForeground(color(red, green, blue));
                                                        userInterface.getController("ColorBox").setColorActive(color(red, green, blue));

                                                        interactivityListener.setStrokeColour(new PVector(red, green, blue));
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
                                                        if(userInterface.getController("isStatic").getValue() == 1){
                                                            userInterface.getController("transStatic").setValue(0);
                                                            userInterface.getController("rotStatic").setValue(0);
                                                            interactivityListener.setIsStatic(true);
                                                        }
                                                        else {
                                                            interactivityListener.setIsStatic(false);
                                                        }
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
                                                        if(userInterface.getController("transStatic").getValue() == 1){

                                                            userInterface.getController("rotStatic").setValue(0);
                                                            userInterface.getController("isStatic").setValue(0);

                                                            interactivityListener.setIsTranslationallyStatic(true);
                                                        }
                                                        else {
                                                            interactivityListener.setIsTranslationallyStatic(false);
                                                        }
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
                                                        if(userInterface.getController("rotStatic").getValue() == 1){

                                                            userInterface.getController("transStatic").setValue(0);
                                                            userInterface.getController("isStatic").setValue(0);

                                                            interactivityListener.setIsRotationallyStatic(true);
                                                        }
                                                        else {
                                                            interactivityListener.setIsRotationallyStatic(false);
                                                        }
                                                    }
                                                })
                                                ;
                        Slider angle = userInterface.addSlider("Angle")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(2)), calculateButtonPositionY(8, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(2),calculateButtonHeight(rowCount))
                                        .setLabel("Angle")
                                        .setVisible(false)
                                        .setRange(0, 360)
                                        .setValue(0)
                                        .setGroup(RigidbodyGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                        float angle = userInterface.getController("Angle").getValue();
                                                        interactivityListener.setAngle(radians(angle));
                                                        }
                                                })
                                            ;
                        Slider angularVelocity = userInterface.addSlider("AngularVelocity")
                                        .setPosition(calculateButtonPositionX(2, calculateButtonWidth(2)), calculateButtonPositionY(8, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(2),calculateButtonHeight(rowCount))
                                        .setLabel("Angular Vel")
                                        .setVisible(false)
                                        .setRange(-10, 10)
                                        .setValue(0)
                                        .setGroup(RigidbodyGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                        float angularVelocity = userInterface.getController("AngularVelocity").getValue();
                                                        interactivityListener.setAngularVelocity(angularVelocity);
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

    void onColourPickerChange(int colour) {
    float red = red(colour);
    float green = green(colour);
    float blue = blue(colour);
    interactivityListener.setFillColour(new PVector(red, green, blue));
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