

GUI gui;
PShape background;
void setup() {
/*--------------------- Timing Utilities ---------------------*/
    lastFrameTime = millis();
/*------------------------------------------------------------*/


/*--------------------- Camera Utilities ---------------------*/
    size(1500, 1000);
    
    windowMove(10, 4);
    fullScreen();
    frameRate(240);
    interactivityListener = new InteractivityListener();
    
/*------------------------------------------------------------*/

/*---------------------------- UI ----------------------------*/
  userInterface = new ControlP5(this);
  gui = new GUI(userInterface);
/*------------------------------------------------------------*/

/*------------------- Background ---------------------------*/
    background = loadShape("background.svg");
/*-------------------------- Rigidbodies ------------------------*/
  rigidbodyList = new ArrayList<Rigidbody>();
/*------------------------------------------------------------*/


    Rigidbody springBody = RigidbodyGenerator.CreateBoxBody(4f, 1f, 1f, 0.5f, false, true,
                                                          0.05f, new PVector(0, 0, 0),
                                                           new PVector(255, 255, 255));
    Rigidbody test = RigidbodyGenerator.CreateCircleBody(1f, 1f, 0.5f, false, true,
                                                            0.05f, new PVector(0, 0, 0),
                                                            new PVector(255, 255, 255));

    Rigidbody spinningBody = RigidbodyGenerator.CreateCircleBody(2f, 1f, 0.5f, false, true,
                                                            0.05f, new PVector(0, 0, 0),
                                                            new PVector(255, 255, 255));
    
    spinningBody.SetInitialPosition(new PVector(0, -5));
    Motor motor = new Motor(spinningBody, 0.5);

    //spinningBody.addForceToForceRegistry(motor);
    spinningBody.setIsTranslationallyStatic(true);

    test.SetInitialPosition(new PVector(-10, -5.1));

    springBody.SetInitialPosition(new PVector(-10, -5));
    springBody.setIsRotationallyStatic(false);

    Spring springLeft = new Spring(springBody, new PVector(2,0), new PVector(-8, -10));
    Spring springRight = new Spring(springBody, new PVector(-2,0), new PVector(-12, -10));
    //Rod connectingRod = new Rod(test, spinningBody, new PVector(0,0), new PVector(2f,0));

    springLeft.setSpringLength(10);
    springLeft.setEquilibriumLength(0.5f);
    springLeft.setSpringConstant(100);
    springLeft.setLockTranslationToYAxis(true);



    springRight.setSpringLength(10);
    springRight.setSpringConstant(100);
    springRight.setEquilibriumLength(0.5f);
    springRight.setLockTranslationToYAxis(true);
    

    
    springBody.addForceToForceRegistry(springLeft);
    springBody.addForceToForceRegistry(springRight);

    //test.addForceToForceRegistry(connectingRod);

    test.addForceToForceRegistry(new Gravity(test));
    springBody.addForceToForceRegistry(new Gravity(springBody));


    AddBodyToBodyEntityList(springBody);
    AddBodyToBodyEntityList(test);
    AddBodyToBodyEntityList(spinningBody);


}


void draw() {
  int currentFrameTime = millis();

  /*NEVER DELETE THIS */
  gui.getActiveTab();
  /* PLEASE */
  interactivityListener.applyTransform();
  background(#101213);
  pushMatrix();
  translate(-1920/12.5, -1080/12.5);
  scale(0.05f);
  shape(background, 0, 0);
  popMatrix();

  render.draw();

  /*--------------------- Cursor Trail ---------------------*/

  if(IsMouseOverUI()) {
    interactivityListener.setDrawCursorTrail(false);
    cursor();
} else {
    interactivityListener.setDrawCursorTrail(true);
    interactivityListener.drawInteractions();
    noCursor();
  }


  
  dt = (currentFrameTime - lastFrameTime) / 1000f;
  Step(dt, 128);

  interactivityListener.resetTransform();

  displayTimings();

  lastFrameTime = currentFrameTime;


}



