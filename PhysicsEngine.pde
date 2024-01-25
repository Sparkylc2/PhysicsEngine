

GUI gui;
PShape background;
Softbody softbody;
Cloth cloth;


void setup() {
/*--------------------- Timing Utilities ---------------------*/
    lastFrameTime = millis();
/*------------------------------------------------------------*/


/*--------------------- Camera Utilities ---------------------*/
    size(1500, 1000);
    
    windowMove(10, 4);
    frameRate(300);
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

    AddBodyToBodyEntityList(springBody);
    AddBodyToBodyEntityList(test);
    AddBodyToBodyEntityList(floor);
    AddBodyToBodyEntityList(spinningBody);


}


void draw() {
  int currentFrameTime = millis();

  /*NEVER DELETE THIS */
  gui.getActiveTab();
  /* PLEASE */

  interactivityListener.applyTransform();
  render.draw();
  
  for(Softbody softbody : softbodyList) {
    softbody.draw();
  }
  //cloth.updateCloth();

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
  Step(dt, 1024);

  interactivityListener.resetTransform();

  displayTimings();

  lastFrameTime = currentFrameTime;


}



