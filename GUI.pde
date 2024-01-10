    public class GUI {
        
        //The size of the group
        private int globalGroupHeight = 200;
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

        private int rowCount = 8;
     
        /*--------------------------*/
        /*----- Stroke and Fill ----*/
        /*--------------------------*/
        private PVector lastFillColour = new PVector(255, 255, 255);
        private PVector lastStrokeColour = new PVector(255, 255, 255);
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
                                                            userInterface.getController("StrokeWeight").setVisible(true);
                                                            userInterface.getController("Red").setVisible(true);
                                                            userInterface.getController("Green").setVisible(true);
                                                            userInterface.getController("Blue").setVisible(true);
                                                            userInterface.getController("ColorBox").setVisible(true);
                                                            userInterface.getController("FillColour").setVisible(true);
                                                            userInterface.getController("StrokeColour").setVisible(true);
                                                            userInterface.getController("isStatic").setVisible(true);
                                                            userInterface.getController("transStatic").setVisible(true);
                                                            userInterface.getController("rotStatic").setVisible(true);


                        
                                                            ShapeType shapeType = ShapeType.CIRCLE;
                                                            interactivityListener.setShapeType(shapeType);
                                                        }
                                                        if(userInterface.getController("Circle").getValue() == 0
                                                            && userInterface.getController("Box").getValue() == 0
                                                            && userInterface.getController("Polygon").getValue() == 0){

                                                            userInterface.getController("RectangleWidth").setVisible(false);
                                                            userInterface.getController("RectangleHeight").setVisible(false);
                                                            userInterface.getController("CircleRadius").setVisible(false);
                                                            userInterface.getController("Density").setVisible(false);
                                                            userInterface.getController("Restitution").setVisible(false);
                                                            userInterface.getController("StrokeWeight").setVisible(false);
                                                            userInterface.getController("Red").setVisible(false);
                                                            userInterface.getController("Green").setVisible(false);
                                                            userInterface.getController("Blue").setVisible(false);
                                                            userInterface.getController("ColorBox").setVisible(false);
                                                            userInterface.getController("FillColour").setVisible(false);
                                                            userInterface.getController("StrokeColour").setVisible(false);
                                                            userInterface.getController("isStatic").setVisible(false);
                                                            userInterface.getController("transStatic").setVisible(false);
                                                            userInterface.getController("rotStatic").setVisible(false);
                                                            
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

                                                            userInterface.getController("RectangleWidth").setVisible(true);
                                                            userInterface.getController("RectangleHeight").setVisible(true);
                                                            userInterface.getController("CircleRadius").setVisible(false);

                                                            userInterface.getController("Density").setVisible(true);
                                                            userInterface.getController("Restitution").setVisible(true);
                                                            userInterface.getController("StrokeWeight").setVisible(true);
                                                            userInterface.getController("Red").setVisible(true);
                                                            userInterface.getController("Green").setVisible(true);
                                                            userInterface.getController("Blue").setVisible(true);
                                                            userInterface.getController("ColorBox").setVisible(true);
                                                            userInterface.getController("FillColour").setVisible(true);
                                                            userInterface.getController("StrokeColour").setVisible(true);
                                                            userInterface.getController("isStatic").setVisible(true);
                                                            userInterface.getController("transStatic").setVisible(true);
                                                            userInterface.getController("rotStatic").setVisible(true);


                                                            ShapeType shapeType = ShapeType.BOX;
                                                            interactivityListener.setShapeType(shapeType);
                                                        }
                                                        if(userInterface.getController("Circle").getValue() == 0
                                                            && userInterface.getController("Box").getValue() == 0
                                                            && userInterface.getController("Polygon").getValue() == 0){

                                                            userInterface.getController("RectangleWidth").setVisible(false);
                                                            userInterface.getController("RectangleHeight").setVisible(false);
                                                            userInterface.getController("CircleRadius").setVisible(false);
                                                            userInterface.getController("Density").setVisible(false);
                                                            userInterface.getController("Restitution").setVisible(false);
                                                            userInterface.getController("StrokeWeight").setVisible(false);
                                                            userInterface.getController("Red").setVisible(false);
                                                            userInterface.getController("Green").setVisible(false);
                                                            userInterface.getController("Blue").setVisible(false);
                                                            userInterface.getController("ColorBox").setVisible(false);
                                                            userInterface.getController("FillColour").setVisible(false);
                                                            userInterface.getController("StrokeColour").setVisible(false);
                                                            userInterface.getController("isStatic").setVisible(false);
                                                            userInterface.getController("transStatic").setVisible(false);
                                                            userInterface.getController("rotStatic").setVisible(false);
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

                                                            userInterface.getController("RectangleWidth").setVisible(false);
                                                            userInterface.getController("RectangleHeight").setVisible(false);
                                                            userInterface.getController("CircleRadius").setVisible(false);

                                                            userInterface.getController("Density").setVisible(true);
                                                            userInterface.getController("Restitution").setVisible(true);
                                                            userInterface.getController("StrokeWeight").setVisible(true);
                                                            userInterface.getController("Red").setVisible(true);
                                                            userInterface.getController("Green").setVisible(true);
                                                            userInterface.getController("Blue").setVisible(true);
                                                            userInterface.getController("ColorBox").setVisible(true);
                                                            userInterface.getController("FillColour").setVisible(true);
                                                            userInterface.getController("StrokeColour").setVisible(true);
                                                            userInterface.getController("isStatic").setVisible(true);
                                                            userInterface.getController("transStatic").setVisible(true);
                                                            userInterface.getController("rotStatic").setVisible(true);
                                                            
                                                            ShapeType shapeType = ShapeType.POLYGON;
                                                            interactivityListener.setShapeType(shapeType);
                                                        }

                                                        if(userInterface.getController("Circle").getValue() == 0
                                                            && userInterface.getController("Box").getValue() == 0
                                                            && userInterface.getController("Polygon").getValue() == 0){

                                                            userInterface.getController("RectangleWidth").setVisible(false);
                                                            userInterface.getController("RectangleHeight").setVisible(false);
                                                            userInterface.getController("CircleRadius").setVisible(false);
                                                            userInterface.getController("Density").setVisible(false);
                                                            userInterface.getController("Restitution").setVisible(false);
                                                            userInterface.getController("StrokeWeight").setVisible(false);
                                                            userInterface.getController("Red").setVisible(false);
                                                            userInterface.getController("Green").setVisible(false);
                                                            userInterface.getController("Blue").setVisible(false);
                                                            userInterface.getController("ColorBox").setVisible(false);
                                                            userInterface.getController("FillColour").setVisible(false);
                                                            userInterface.getController("StrokeColour").setVisible(false);
                                                            userInterface.getController("isStatic").setVisible(false);
                                                            userInterface.getController("transStatic").setVisible(false);
                                                            userInterface.getController("rotStatic").setVisible(false);
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
                                        .setValue((MAX_BODY_DENSITY + MIN_BODY_DENSITY)*0.5f)
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
                                        .setValue(0.5f)
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
                                        .setValue(2f)
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
                                        .setValue(2f)
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
                                        .setValue(2f)
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
                                                            
                                                            userInterface.getController("Red").setVisible(false);
                                                            userInterface.getController("Green").setVisible(false);
                                                            userInterface.getController("Blue").setVisible(false);
                                                            userInterface.getController("ColorBox").setVisible(false);
                                                        }
                                                        else if(userInterface.getController("FillColour").getValue() == 1){
                                                            
                                                            userInterface.getController("Red").setVisible(true);
                                                            userInterface.getController("Green").setVisible(true);
                                                            userInterface.getController("Blue").setVisible(true);
                                                            userInterface.getController("ColorBox").setVisible(true);

                                                            userInterface.getController("Red").setValue(lastFillColour.x);
                                                            userInterface.getController("Green").setValue(lastFillColour.y);
                                                            userInterface.getController("Blue").setValue(lastFillColour.z);

                                                            userInterface.getController("StrokeColour").setValue(0);
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
                                                            userInterface.getController("Red").setVisible(false);
                                                            userInterface.getController("Green").setVisible(false);
                                                            userInterface.getController("Blue").setVisible(false);
                                                            userInterface.getController("ColorBox").setVisible(false);
                                                        }
                                                        else if(userInterface.getController("StrokeColour").getValue() == 1){
                                                            userInterface.getController("Red").setVisible(true);
                                                            userInterface.getController("Green").setVisible(true);
                                                            userInterface.getController("Blue").setVisible(true);
                                                            userInterface.getController("ColorBox").setVisible(true);

                                                            userInterface.getController("Red").setValue(lastStrokeColour.x);
                                                            userInterface.getController("Green").setValue(lastStrokeColour.y);
                                                            userInterface.getController("Blue").setValue(lastStrokeColour.z);

                                                            userInterface.getController("FillColour").setValue(0);
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



                        Slider redSlider = userInterface.addSlider("Red")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(3)), calculateButtonPositionY(5, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(3),calculateButtonHeight(rowCount))
                                        .setLabel("Red")
                                        .setVisible(false)
                                        .setRange(0, 255)
                                        .setValue(255)
                                        .setGroup(RigidbodyGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                        int red = (int)userInterface.getController("Red").getValue();
                                                        int green = (int)userInterface.getController("Green").getValue();
                                                        int blue = (int)userInterface.getController("Blue").getValue();

                                                        userInterface.getController("ColorBox").setColorForeground(color(red, green, blue));
                                                        userInterface.getController("ColorBox").setColorActive(color(red, green, blue));

                                                        if(userInterface.getController("FillColour").getValue() == 1){
                                                            lastFillColour = new PVector(red, green, blue);
                                                            interactivityListener.setFillColour(new PVector(red, green, blue));
                                                        } else if (userInterface.getController("StrokeColour").getValue() == 1){
                                                            lastStrokeColour = new PVector(red, green, blue);
                                                            interactivityListener.setStrokeColour(new PVector(red, green, blue));
                                                        }
                                                    
                                                }
                                                })
                                            ;

                        Slider greenSlider = userInterface.addSlider("Green")
                                        .setPosition(calculateButtonPositionX(2, calculateButtonWidth(3)), calculateButtonPositionY(5, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(3),calculateButtonHeight(rowCount))
                                        .setLabel("Green")
                                        .setVisible(false)
                                        .setRange(0, 255)
                                        .setValue(255)
                                        .setGroup(RigidbodyGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                        int red = (int)userInterface.getController("Red").getValue();
                                                        int green = (int)userInterface.getController("Green").getValue();
                                                        int blue = (int)userInterface.getController("Blue").getValue();
                                    
                                                        userInterface.getController("ColorBox").setColorForeground(color(red, green, blue));
                                                        userInterface.getController("ColorBox").setColorActive(color(red, green, blue));

                                                       if(userInterface.getController("FillColour").getValue() == 1){
                                                            lastFillColour = new PVector(red, green, blue);
                                                            interactivityListener.setFillColour(new PVector(red, green, blue));
                                                        } else if (userInterface.getController("StrokeColour").getValue() == 1){
                                                            lastStrokeColour = new PVector(red, green, blue);
                                                            interactivityListener.setStrokeColour(new PVector(red, green, blue));
                                                        }
                                                        }
                                                })
                                            ;

                        Slider blueSlider = userInterface.addSlider("Blue")
                                        .setPosition(calculateButtonPositionX(3, calculateButtonWidth(3)), calculateButtonPositionY(5, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(3),calculateButtonHeight(rowCount))
                                        .setLabel("Blue")
                                        .setVisible(false)
                                        .setRange(0, 255)
                                        .setValue(255)
                                        .setGroup(RigidbodyGeneration)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                        int red = (int)userInterface.getController("Red").getValue();
                                                        int green = (int)userInterface.getController("Green").getValue();
                                                        int blue = (int)userInterface.getController("Blue").getValue();

                                                        userInterface.getController("ColorBox").setColorForeground(color(red, green, blue));
                                                        userInterface.getController("ColorBox").setColorActive(color(red, green, blue));


                                                        if(userInterface.getController("FillColour").getValue() == 1){
                                                            lastFillColour = new PVector(red, green, blue);
                                                            interactivityListener.setFillColour(new PVector(red, green, blue));
                                                        } else if (userInterface.getController("StrokeColour").getValue() == 1){
                                                            lastStrokeColour = new PVector(red, green, blue);
                                                            interactivityListener.setStrokeColour(new PVector(red, green, blue));
                                                        }
                                                        }
                                                })
                                            ;
                        Bang colorBox = userInterface.addBang("ColorBox")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(1)), calculateButtonPositionY(6, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(1),calculateButtonHeight(rowCount))
                                        .setLabel("Color")
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
                                        .setValue(false)
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
                                        .setValue(false)
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
                                        .setValue(false)
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



                        
                        

                        /*
                       
                        
                        Textfield controlPlanetMass = userInterface.addTextfield("controlTab Planet Mass")
                                        .setPosition(globalGroupElementPaddingX, globalInitialPositionY + globalGroupElementSpacingY * elementNumber)
                                        .setSize(50, 20)
                                        .setText("")
                                        .setGroup(controlsGroup)
                                        .setColor(color(255,255,255))
                                        .setVisible(true)
                                        .setLabel("Mass")
                                        ;
                        
*/
/*
====================================================================================================
======================================== Formatting ================================================
====================================================================================================
*/

userInterface.getController("Circle").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
userInterface.getController("Box").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
userInterface.getController("Polygon").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
userInterface.getController("Density").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
userInterface.getController("Restitution").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
userInterface.getController("RectangleWidth").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
userInterface.getController("RectangleHeight").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
userInterface.getController("CircleRadius").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
userInterface.getController("Red").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
userInterface.getController("Green").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
userInterface.getController("Blue").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
userInterface.getController("ColorBox").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
userInterface.getController("StrokeWeight").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
userInterface.getController("FillColour").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
userInterface.getController("StrokeColour").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
userInterface.getController("isStatic").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
userInterface.getController("transStatic").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
userInterface.getController("rotStatic").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);



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