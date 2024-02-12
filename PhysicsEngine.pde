

GUI gui;
PShape background;
Softbody softbody;
Cloth cloth;
boolean loadLevel = false;


void setup() {
/*--------------------- Timing Utilities ---------------------*/
    lastFrameTime = millis();
/*------------------------------------------------------------*/


/*--------------------- Camera Utilities ---------------------*/
    size(1500, 1000);
    windowMove(10, 4);
    frameRate(300);
    Camera = new Camera();
    
/*------------------------------------------------------------*/

/*---------------------------- UI ----------------------------*/
    userInterface = new ControlP5(this);
    gui = new GUI(userInterface);
    GUI_GROUP_POSITION_X = gui.calculateGroupPositionX();
    GUI_GROUP_POSITION_Y = gui.calculateGroupPositionY();
    GUI_GLOBAL_GROUP_WIDTH = gui.globalGroupWidth;
    GUI_GLOBAL_GROUP_HEIGHT = gui.globalGroupHeight;
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
    springBody.setIsTranslationallyStatic(true);

    AddBodyToBodyEntityList(springBody);
    AddBodyToBodyEntityList(test);
    AddBodyToBodyEntityList(floor);
    AddBodyToBodyEntityList(spinningBody);

    //ALL_FORCES_ARRAYLIST.add(rod);
    //ALL_FORCES_ARRAYLIST.add(springLeft);
    //ALL_FORCES_ARRAYLIST.add(springRight);


    //softbody = new Softbody(new PVector(0, -50), 0, 2, 2);
    //softbody.CreateBoxSoftbody();
    //cloth = new Cloth(new PVector(-20, -50), new PVector(0, -50), 20);
    //cloth.CreateCloth();
}


void draw() {
    Mouse.updateMouse();

    if(loadLevel) {
        levelEditor.loadLevelState();
        loadLevel = false;
    }
  int currentFrameTime = millis();

  /*NEVER DELETE THIS */
  //gui.getActiveTab();
  /* PLEASE */

  Camera.applyTransform();
  render.draw();
   //editor.whileEditorSelect(-1);


  /*--------------------- Cursor Trail ---------------------*/

    /*
    float minX = min(Mouse.getMouseDownCoordinates().x, Mouse.getMouseCoordinates().x);
    float maxX = max(Mouse.getMouseDownCoordinates().x, Mouse.getMouseCoordinates().x);
    float minY = min(Mouse.getMouseDownCoordinates().y, Mouse.getMouseCoordinates().y);
    float maxY = max(Mouse.getMouseDownCoordinates().y, Mouse.getMouseCoordinates().y);

    beginShape();
    noFill();
    stroke(255, 0, 0);
    rect(minX, minY, maxX - minX, maxY - minY);
    endShape();
    */
/*
  if(IsMouseOverUI()) {
    .setDrawCursorTrail(false);
    cursor();
} else {
    interactivityListener.setDrawCursorTrail(true);
    interactivityListener.drawInteractions();
    noCursor();
  }
*/
  dt = (currentFrameTime - lastFrameTime) / 1000f;
  Step(dt, SUB_STEP_COUNT);

  Camera.resetTransform();

  displayTimings();

  lastFrameTime = currentFrameTime;


}

public void controlEvent(ControlEvent theEvent) {
    if(theEvent.isTab()) {
        switch(theEvent.getTab().getId()) {
            case 0:
                currentTabInteractionHandler = (TabInteractionHandler)RT_InteractionHandler;
        }
    }
}
