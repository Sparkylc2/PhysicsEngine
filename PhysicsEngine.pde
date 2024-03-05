
public void setup() {

    if(System.getProperty("os.name").toLowerCase().contains("mac")) {
        windowMove(0, 22);
    }
    textFont(createFont(sketchPath() + "/data/fonts/InterDisplay-SemiBold.ttf", 128, true), 10);
    dash = new DashedLines(this);
    dash.pattern(1, 0.5);
/*--------------------- Timing Utilities ---------------------*/
    FrameTimeUtility.init();
    frameRate(300);
/*--------------------- Camera Utilities ---------------------*/
    Camera = new Camera();
    playTimeTracker = new UI_QualitySettings();
    playTimeTracker.startPlaytimeTracking();
/*---------------------------- UI ----------------------------*/
    UI_Manager.init();
/*-------------------------- Rigidbodies ------------------------*/
    rigidbodyList = new ArrayList<Rigidbody>();
/*------------------------------------------------------------*/


    Rigidbody floor = RigidbodyGenerator.CreateBoxBody(1000f, 5f, 1f, 0.5f, true, true, 0.05f, new PVector(0,0,0), new PVector(255,255,255));
    Rigidbody springBody = RigidbodyGenerator.CreateBoxBody(4f, 1f, 1f, 0.5f, false, true, 0.05f, new PVector(0, 0, 0), new PVector(255, 255, 255));
    //Rigidbody test = RigidbodyGenerator.CreateCircleBody(1f, 1f, 0.5f, false, true, 0.05f, new PVector(0, 0, 0), new PVector(255, 255, 255));
    //Rigidbody spinningBody = RigidbodyGenerator.CreateCircleBody(1f, 1f, 0.5f, false, true, 0.05f, new PVector(0, 0, 0), new PVector(255, 255, 255));



    floor.SetInitialPosition(new PVector(0, 10));
    //test.SetInitialPosition(new PVector(-10, -5));
    springBody.setVelocity(new PVector(0,20));
    springBody.SetInitialPosition(new PVector(-10, -5));
    //spinningBody.SetInitialPosition(new PVector(0, -5));

    //spinningBody.setIsTranslationallyStatic(true);


    //Rod rod = new Rod(springBody, test, new PVector(), new PVector());
    Spring springLeft = new Spring(springBody, new PVector(2,0), new PVector(-8, -10));
    Spring springRight = new Spring(springBody, new PVector(-2,0), new PVector(-12, -10));

    //rod.setIsJoint(true);


    //springBody.addForceToForceRegistry(rod);
    //test.addForceToForceRegistry(rod); 

    springBody.addForceToForceRegistry(springLeft);
    springBody.addForceToForceRegistry(springRight);

    //test.addForceToForceRegistry(new Gravity(test));
    springBody.addForceToForceRegistry(new Gravity(springBody));
    //spinningBody.addForceToForceRegistry(new Gravity(spinningBody));
    //springBody.setIsTranslationallyStatic(true);

    AddBodyToBodyEntityList(springBody);
    //AddBodyToBodyEntityList(test);
    AddBodyToBodyEntityList(floor);
    //AddBodyToBodyEntityList(spinningBody);

}



public void draw() {
    FrameTimeUtility.calculateFrameTime();
        Camera.onFrameStart();
            /*--------------------- Main Methods ---------------------*/
            UI_Manager.interactionDraw();
            
            Step(FrameTimeUtility.DT, SUB_STEP_COUNT);
        
            /*--------------------------------------------------------*/
    
        Camera.onFrameEnd();
        UI_Manager.draw();
    
    FrameTimeUtility.displayTimings();
    FrameTimeUtility.updateFrameTime();
}


