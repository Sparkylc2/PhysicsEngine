

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

    spinningBody.addForceToForceRegistry(motor);
    spinningBody.setIsTranslationallyStatic(true);

    test.SetInitialPosition(new PVector(-10, -5.1));

    springBody.SetInitialPosition(new PVector(-10, -5));
    springBody.setIsRotationallyStatic(false);

    Spring springLeft = new Spring(springBody, new PVector(2,0), new PVector(-8, -10));
    Spring springRight = new Spring(springBody, new PVector(-2,0), new PVector(-12, -10));
    Rod connectingRod = new Rod(test, spinningBody, new PVector(0,0), new PVector(2f,0));

    springLeft.setSpringLength(10);
    springLeft.setSpringConstant(100);
    springLeft.setLockTranslationToYAxis(true);


    springRight.setSpringLength(10);
    springRight.setSpringConstant(100);
    springRight.setLockTranslationToYAxis(true);
    

    
    springBody.addForceToForceRegistry(springLeft);
    springBody.addForceToForceRegistry(springRight);

    test.addForceToForceRegistry(connectingRod);

    test.addForceToForceRegistry(new Gravity(test));
    springBody.addForceToForceRegistry(new Gravity(springBody));


    AddBodyToBodyEntityList(springBody);
    AddBodyToBodyEntityList(test);
    AddBodyToBodyEntityList(spinningBody);


ArrayList<Rigidbody> ropeBodies = new ArrayList<Rigidbody>();

// Define the initial position for the first Rigidbody
PVector initialPosition = new PVector(0, 0);

// Define the distance between each Rigidbody
float distanceBetweenBodies = 1f;
float ropeLength = 2;

// Create the Rigidbodies and Springs
for (int i = 0; i < 25; i++) {
    // Create a new Rigidbody at the current position
    Rigidbody body = RigidbodyGenerator.CreateCircleBody(0.5, 1f, 20, false, true,
                                                            0.05f, new PVector(0, 0, 0),
                                                            new PVector(255, 255, 255));
    body.setPosition(new PVector(initialPosition.x +  i * distanceBetweenBodies, initialPosition.y));
    ropeBodies.add(body);

    // If this isn't the first Rigidbody, create a Spring connecting it to the previous one
    if (i > 0) {
        Rigidbody previousBody = ropeBodies.get(i - 1);
        PVector localAnchorA = new PVector(distanceBetweenBodies / 2, 0);
        PVector localAnchorB = new PVector(-distanceBetweenBodies / 2, 0);
        Spring spring = new Spring(previousBody, body, localAnchorA, localAnchorB);
        Spring counterSpring = new Spring(body, previousBody, localAnchorB, localAnchorA);

        // Set the rest length to the desired spacing
        float desiredSpacing = 2; // Change this to your desired spacing
        spring.setSpringLength(desiredSpacing);
        counterSpring.setSpringLength(desiredSpacing);

        // Set the spring constant based on the position in the rope
        float springConstant = (25 - i) * 300; // Adjust this formula as needed
        spring.setSpringConstant(springConstant);
        counterSpring.setSpringConstant(springConstant);

        spring.setDamping(1.5);
        counterSpring.setDamping(1.5f);

        previousBody.addForceToForceRegistry(spring);
        previousBody.addForceToForceRegistry(new Gravity(previousBody));

        body.addForceToForceRegistry(new Gravity(body));
        body.addForceToForceRegistry(counterSpring);
    }
    if(i == 0) {
        Spring initialSpring = new Spring(body, new PVector(0,0), new PVector(0, 0));
        initialSpring.setSpringLength(2);
        initialSpring.setDamping(1.5f);
        initialSpring.setSpringConstant(100*24);

        body.addForceToForceRegistry(initialSpring);
    }
}

for(int i = 0; i < ropeBodies.size(); i++){
    AddBodyToBodyEntityList(ropeBodies.get(i));
    if(i == ropeBodies.size() - 1){
        Rigidbody lastRopeBody = ropeBodies.get(i);
        Rigidbody box = RigidbodyGenerator.CreateCircleBody(3f,
                                                     1f, 20f, false, true,
                                                     0.05, new PVector(0, 0, 0),
                                                     new PVector(255, 255, 255));
        box.SetInitialPosition(new PVector(lastRopeBody.getPosition().x, lastRopeBody.getPosition().y + 10));
        Rod rod = new Rod(lastRopeBody, box, new PVector(0,0), new PVector(0,0));
        Rod rod2 = new Rod(box, lastRopeBody, new PVector(0,0), new PVector(0,0));
        lastRopeBody.addForceToForceRegistry(rod);
        box.addForceToForceRegistry(rod2);
        box.addForceToForceRegistry(new Gravity(box));
        AddBodyToBodyEntityList(box);

    }
}
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



