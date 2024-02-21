
public void setup() {
    if(System.getProperty("os.name").toLowerCase().contains("mac")) {
        windowMove(0, 22);
    }
    textFont(createFont("InterDisplay-SemiBold.ttf", 128, true), 10);
/*--------------------- Timing Utilities ---------------------*/
    FrameTimeUtility.init();
/*------------------------------------------------------------*/


/*
--------------------- OS Screen Setup ------------------------*/


    // Rest of your setup code...

   //size(1500, 1000, FX2D);
    //size(1250, 800);
    //size(1920, 1080);
    //fullScreen();
    frameRate(300);
/*--------------------- Camera Utilities ---------------------*/
    Camera = new Camera();
    
/*------------------------------------------------------------*/

/*---------------------------- UI ----------------------------*/
    //userInterface = new ControlP5(this);
    //gui = new GUI(userInterface);
    //gui.initialize();

    UI_Manager.init();
/*------------------------------------------------------------*/

/*-------------------------- Rigidbodies ------------------------*/
    rigidbodyList = new ArrayList<Rigidbody>();
/*------------------------------------------------------------*/


    Rigidbody floor = RigidbodyGenerator.CreateBoxBody(1000f, 5f, 1f, 0.5f, true, true, 0.05f, new PVector(0,0,0), new PVector(255,255,255));
    Rigidbody springBody = RigidbodyGenerator.CreateBoxBody(4f, 1f, 1f, 0.5f, false, true, 0.05f, new PVector(0, 0, 0), new PVector(255, 255, 255));
    Rigidbody test = RigidbodyGenerator.CreateCircleBody(1f, 1f, 0.5f, false, true, 0.05f, new PVector(0, 0, 0), new PVector(255, 255, 255));
    Rigidbody spinningBody = RigidbodyGenerator.CreateCircleBody(1f, 1f, 0.5f, false, true, 0.05f, new PVector(0, 0, 0), new PVector(255, 255, 255));


        
    floor.SetInitialPosition(new PVector(0, 10));
    test.SetInitialPosition(new PVector(-10, -5));
    springBody.SetInitialPosition(new PVector(-10, -5));
    spinningBody.SetInitialPosition(new PVector(0, -5));

    spinningBody.setIsTranslationallyStatic(true);


    Rod rod = new Rod(springBody, test, new PVector(), new PVector());
    Spring springLeft = new Spring(springBody, new PVector(2,0), new PVector(-8, -10));
    Spring springRight = new Spring(springBody, new PVector(-2,0), new PVector(-12, -10));

    rod.setIsJoint(true);


    springBody.addForceToForceRegistry(rod);
    test.addForceToForceRegistry(rod); 

    springBody.addForceToForceRegistry(springLeft);
    springBody.addForceToForceRegistry(springRight);

    test.addForceToForceRegistry(new Gravity(test));
    springBody.addForceToForceRegistry(new Gravity(springBody));
    spinningBody.addForceToForceRegistry(new Gravity(spinningBody));
    springBody.setIsTranslationallyStatic(true);

    AddBodyToBodyEntityList(springBody);
    AddBodyToBodyEntityList(test);
    AddBodyToBodyEntityList(floor);
    AddBodyToBodyEntityList(spinningBody);

}



public void draw() {
    FrameTimeUtility.calculateFrameTime();

        Camera.onFrameStart();
        CurrentTabInteractionHandler.passiveResponse();
        
            /*--------------------- Main Methods ---------------------*/
        
            Step(FrameTimeUtility.DT, SUB_STEP_COUNT);
        
            /*--------------------------------------------------------*/
        
        //gui.checkGUIRepositioning();
        Camera.onFrameEnd();
        UI_Manager.draw();
    
    FrameTimeUtility.displayTimings();
    FrameTimeUtility.updateFrameTime();
}


/*
public void controlEvent(ControlEvent theEvent) {
    if(theEvent.isTab()) {
        switch(theEvent.getTab().getId()) {
            case 0:
                CurrentTabInteractionHandler = RT_InteractionHandler;
                CurrentTabInteractionHandler.VisibilityResponse();
                this.Mouse.clearMouseObjectResults();
                break;
            case 1:
                CurrentTabInteractionHandler = FT_InteractionHandler;
                CurrentTabInteractionHandler.VisibilityResponse();
                this.Mouse.clearMouseObjectResults();
                break;
        }
    }
}
*/
