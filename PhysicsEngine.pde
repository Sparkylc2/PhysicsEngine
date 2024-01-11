

GUI gui;

void setup() {
/*--------------------- Timing Utilities ---------------------*/
    lastFrameTime = millis();
/*------------------------------------------------------------*/


/*--------------------- Camera Utilities ---------------------*/
    size(1000, 1000);
    
    windowMove(10, 4);
    frameRate(240);
    interactivityListener = new InteractivityListener();
/*------------------------------------------------------------*/

/*---------------------------- UI ----------------------------*/
  userInterface = new ControlP5(this);
    gui = new GUI(userInterface);

/*------------------------------------------------------------*/


  rigidbodyList = new ArrayList<Rigidbody>();


/*
  Rigidbody floor = RigidbodyGenerator.CreateBoxBody(100,
                                                   2f, 0.1f, 0.1f, true, true,
                                                   0.05, new PVector(0, 0, 0),
                                                   new PVector(255, 255, 255));

  floor.SetInitialPosition(new PVector(0, 0));

  Rigidbody slantedFloor1 = RigidbodyGenerator.CreateBoxBody(30f,
                                                   1f, 0.1f, 0.1f, true, true,
                                                   0.05, new PVector(0, 0, 0),
                                                   new PVector(255, 255, 255));
  slantedFloor1.SetInitialPosition(new PVector(-10, -10));
    
   Rigidbody slantedFloor2 = RigidbodyGenerator.CreateBoxBody(30f,
                                                   2f, 0.1f, 0.1f, true, true,
                                                   0.05, new PVector(0, 0, 0),
                                                   new PVector(255, 255, 255));
  slantedFloor2.SetInitialPosition(new PVector(20, -20));
  slantedFloor1.Rotate(PI/6);
  slantedFloor2.Rotate(-PI/6);

    Rigidbody box = RigidbodyGenerator.CreateBoxBody(1f,
                                                     1f, 1f, 1f, false, true,
                                                     0.05, new PVector(0, 0, 0),
                                                     new PVector(255, 255, 255));
    box.addForceToForceRegistry(new Gravity());
    box.addForceToForceRegistry(new Spring(box, new PVector(0,0), new PVector(-10, -20)));



    Rigidbody rigidbodyA = RigidbodyGenerator.CreateBoxBody(1f, 1f, 1f, 1f, false, true,
                                                            0.05, new PVector(0, 0, 0),
                                                            new PVector(255, 255, 255));
    Rigidbody rigidbodyB = RigidbodyGenerator.CreateBoxBody(1f, 1f, 1f, 1f, false, true,
                                                            0.05, new PVector(0, 0, 0),
                                                            new PVector(255, 255, 255));

    rigidbodyA.SetInitialPosition(new PVector(0, -11));
    rigidbodyB.SetInitialPosition(new PVector(0, -10));


    Rod rigidRodA = new Rod(rigidbodyA, rigidbodyB, new PVector(0, 0),
                                           new PVector(0, 0));
    Rod rigidRodB = new Rod(rigidbodyB, rigidbodyA, new PVector(0, 0),
                                            new PVector(0, 0));


    rigidbodyA.addForceToForceRegistry(new Gravity());
    rigidbodyA.addForceToForceRegistry(rigidRodA);
    rigidbodyB.addForceToForceRegistry(new Gravity());
    rigidbodyB.addForceToForceRegistry(rigidRodB)
    
    AddBodyToBodyEntityList(rigidbodyA);
    AddBodyToBodyEntityList(rigidbodyB);
    AddBodyToBodyEntityList(slantedFloor1);
    AddBodyToBodyEntityList(slantedFloor2);
    AddBodyToBodyEntityList(floor);
    AddBodyToBodyEntityList(box);
    */


    //Rigidbody springBody = RigidbodyGenerator.CreateBoxBody(4f, 1f, 1f, 0.5f, false, true,
   //                                                         0.05f, new PVector(0, 0, 0),
    //                                                        new PVector(255, 255, 255));
    Rigidbody test = RigidbodyGenerator.CreateCircleBody(1f, 1f, 0.5f, false, true,
                                                            0.05f, new PVector(0, 0, 0),
                                                            new PVector(255, 255, 255));

    Rigidbody spinningBody = RigidbodyGenerator.CreateCircleBody(2f, 1f, 0.5f, false, true,
                                                            0.05f, new PVector(0, 0, 0),
                                                            new PVector(255, 255, 255));
    
    spinningBody.SetInitialPosition(new PVector(0, -5));
    Motor motor = new Motor(spinningBody, 0.5);

    spinningBody.addForceToForceRegistry(motor);
    spinningBody.setIsTranslationallyStatic(true);

    test.SetInitialPosition(new PVector(-10, -5.1));

    //springBody.SetInitialPosition(new PVector(-10, -5));
    //springBody.setIsRotationallyStatic(false);

    //Spring springLeft = new Spring(springBody, new PVector(2,0), new PVector(-8, -10));
    //Spring springRight = new Spring(springBody, new PVector(-2,0), new PVector(-12, -10));
    //Rod connectingRod = new Rod(test, spinningBody, new PVector(0,0), new PVector(2f,0));

    //springLeft.setSpringLength(10);
    //springLeft.setSpringConstant(100);
    //springLeft.setLockTranslationToYAxis(true);


    //springRight.setSpringLength(10);
    //springRight.setSpringConstant(100);
    //springRight.setLockTranslationToYAxis(true);
    

    
    //springBody.addForceToForceRegistry(springLeft);
    //springBody.addForceToForceRegistry(springRight);

    //test.addForceToForceRegistry(connectingRod);

    test.addForceToForceRegistry(new Gravity(test));
    //springBody.addForceToForceRegistry(new Gravity(springBody));


    //AddBodyToBodyEntityList(springBody);
    AddBodyToBodyEntityList(test);
    AddBodyToBodyEntityList(spinningBody);


}


void draw() {
    int currentFrameTime = millis();

  interactivityListener.applyTransform();

  render.draw();

  
  dt = (currentFrameTime - lastFrameTime) / 1000f;
  Step(dt, 20);

  interactivityListener.resetTransform();
  displayTimings();

  lastFrameTime = currentFrameTime;
  
}



