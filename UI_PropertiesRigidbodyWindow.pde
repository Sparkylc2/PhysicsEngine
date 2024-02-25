public class UI_PropertiesRigidbodyWindow extends UI_Window {

    private boolean hasInit = false;

    private float prvBdyDnsty = 1;
    private float prvBdyRsttn = 0.5f;
    private float prvBdyRds = 1;
    private float prvBdyWdth = 2;
    private float prvBdyHght = 2;
    private float prvBdyAngl = 0;

    private boolean prvSttc = false;
    private boolean prvFxRttn = false;
    private boolean prvFxPstn = false;



    public UI_PropertiesRigidbodyWindow() {
        super("Properties (rigidbody)", 0);
        this.initialize();
    }

/*
========================================= UI Elements  =============================================
*/
    public void initialize() {

    }

    @Override
    public void onSlotChange(int previousSlotID) { 
        UI_Manager.bringToFront(this);
        this.onWindowSelect();
        
        if(!hasInit) {
            switch(UI_Manager.HOT_BAR.getActiveSlotID()) {
                case 2:
                    this.onCircleActive();
                    break;
                case 3:
                    this.onRectangleActive();
                    break;
            }
        }

        switch(previousSlotID) {
            case 2:
                this.prvBdyRds = this.getElementByName("Radius").getValue();
                this.prvBdyDnsty = this.getElementByName("Density").getValue();
                this.prvBdyRsttn = this.getElementByName("Restitution").getValue();
                this.prvSttc = this.getElementByName("Static").getState();
                this.prvFxRttn = this.getElementByName("Fixed Rotation").getState();
                this.prvFxPstn = this.getElementByName("Fixed Position").getState();
                this.prvBdyAngl = this.getElementByName("Angle").getValue();
                break;
            case 3:
                this.prvBdyWdth = this.getElementByName("Width").getValue();
                this.prvBdyHght = this.getElementByName("Height").getValue();
                this.prvBdyDnsty = this.getElementByName("Density").getValue();
                this.prvBdyRsttn = this.getElementByName("Restitution").getValue();
                this.prvSttc = this.getElementByName("Static").getState();
                this.prvFxRttn = this.getElementByName("Fixed Rotation").getState();
                this.prvFxPstn = this.getElementByName("Fixed Position").getState();
                this.prvBdyAngl = this.getElementByName("Angle").getValue();
                break;
            }

            switch(UI_Manager.HOT_BAR.getActiveSlotID()) {
                case 2:
                    this.clearAllElements();
                    this.onCircleActive();
                    break;
                case 3:
                    this.clearAllElements();
                    this.onRectangleActive();
                    break;
            }

        this.Window_Visibility = true;
        
    }

    public void onCircleActive() {
        this.HotBarSlotRepresentation = "Circle";
        this.addElement(new UI_Slider("Density", (UI_Window)this, MIN_BODY_DENSITY, MAX_BODY_DENSITY, prvBdyDnsty));
        this.addElement(new UI_Slider("Restitution", (UI_Window)this, 0, 1, prvBdyRsttn));
        this.addElement(new UI_Slider("Radius", (UI_Window)this, MIN_BODY_RADIUS, MAX_BODY_RADIUS, prvBdyRds));
        this.addElement(new UI_Toggle("Static", (UI_Window)this, "Staticity", prvSttc));
        this.addElement(new UI_Toggle("Fixed Rotation", (UI_Window)this, "Staticity", prvFxRttn));
        this.addElement(new UI_Toggle("Fixed Position", (UI_Window)this, "Staticity", prvFxPstn));
        this.addElement(new UI_Slider("Angle", (UI_Window)this, -360, 360, prvBdyAngl));
    } 

    public void onRectangleActive() {
        this.HotBarSlotRepresentation = "Rectangle";
        this.addElement(new UI_Slider("Density", (UI_Window)this, MIN_BODY_DENSITY, MAX_BODY_DENSITY, prvBdyDnsty));
        this.addElement(new UI_Slider("Restitution", (UI_Window)this, 0, 1, prvBdyRsttn));
        this.addElement(new UI_Slider("Width", (UI_Window)this, MIN_BODY_WIDTH, MAX_BODY_WIDTH, prvBdyWdth));
        this.addElement(new UI_Slider("Height", (UI_Window)this, MIN_BODY_HEIGHT, MAX_BODY_HEIGHT, prvBdyHght));
        this.addElement(new UI_Toggle("Static", (UI_Window)this, "Staticity", prvSttc));
        this.addElement(new UI_Toggle("Fixed Rotation", (UI_Window)this, "Staticity", prvFxRttn));
        this.addElement(new UI_Toggle("Fixed Position", (UI_Window)this, "Staticity", prvFxPstn));
        this.addElement(new UI_Slider("Angle", (UI_Window)this, -360, 360, prvBdyAngl));
    }
/*
========================================= Rigidbody Drawing ========================================
*/ 
    @Override
    public void interactionDraw() {
        if(UI_Manager.getIsOverOrPressedWindows()) {
            return;
        }
        
        if(mouseButton == LEFT) {
            this.drawVelocityLine();
        }
        
        this.drawRigidbody();
    }





    public void drawRigidbody() {
        /*--------------------------------- Checks ---------------------------------*/
        int activeSlotID = UI_Manager.HOT_BAR.getActiveSlotID();
        if(activeSlotID != 2 && activeSlotID != 3) {
            return;
        }
        /*---------------------------------------------------------------------------*/

        float angle = radians(this.getElementByName("Angle").getValue());
        PVector position = new PVector();
            if(Mouse.getIsMouseDownLeft() == true) {
                position.set(PhysEngMath.MouseVelocityCalculationAndClamp(Mouse.getMouseDownCoordinates(), 
                                                                          Mouse.getMouseCoordinates(), 
                                                                          MIN_MOUSE_VELOCITY_MAG, 
                                                                          MAX_MOUSE_VELOCITY_MAG));
                position.add(Mouse.getMouseDownCoordinates());
            } else {
                position.set(Mouse.getMouseCoordinates());
            }

        if(activeSlotID == 2) {
            this.drawCircle(position, angle);
        } else if(activeSlotID == 3) {
            this.drawRectangle(position, angle);
        }
    }

    public void drawCircle(PVector position, float angle) {
        pushMatrix();
        translate(position.x, position.y);
        rotate(angle);
            float radius = this.getElementByName("Radius").getValue();
            float diameter = radius * 2.0f;

            fill(255, 255, 255, 166);
            stroke(0, 0, 0, 166);
            strokeWeight(0.1);
            ellipseMode(CENTER);
            ellipse(0, 0, diameter,  diameter);

            PVector va = new PVector();
            PVector vb = new  PVector(radius, 0);
            va = PhysEngMath.Transform(va, new PVector(), angle);
            vb = PhysEngMath.Transform(vb, new PVector(), angle);

            line(va.x, va.y, vb.x, vb.y);
        popMatrix();
    }

    public void drawRectangle(PVector position, float angle) {
        pushMatrix();
        translate(position.x, position.y);
        rotate(angle);
            fill(255, 255, 255, 166);
            stroke(0, 0, 0, 166);
            strokeWeight(0.1);
            rectMode(CENTER);
            rect(0, 0, this.getElementByName("Width").getValue(), this.getElementByName("Height").getValue());
        popMatrix();
    }


/*
========================================= Rigidbody Creation =======================================
*/
    @Override
    public void interactionMouseRelease() {
        if(UI_Manager.getIsOverOrPressedWindows()) {
            return;
        }
        
        if(mouseButton == LEFT) {
            this.createRigidbody();
        }
    }







    public void createRigidbody() {
        /*--------------------------------- Checks ---------------------------------*/
        int activeSlotID = UI_Manager.HOT_BAR.getActiveSlotID();
        if(activeSlotID != 2 && activeSlotID != 3) {
            return;
        }

        if(Mouse.getRigidbodyUnderMouse() != null) {
            return;
        }
        /*---------------------------------------------------------------------------*/

        if(activeSlotID == 2) {
            this.createCircle();
        } else if(activeSlotID == 3) {
            this.createRectangle();
        }


    }

    public void createCircle() {
        Rigidbody rigidbody = RigidbodyGenerator.CreateCircleBody(this.getElementByName("Radius").getValue(),
                                                                  this.getElementByName("Density").getValue(),
                                                                  this.getElementByName("Restitution").getValue(),
                                                                  this.getElementByName("Static").getState(),
                                                                  true,
                                                                  0.1,
                                                                  new PVector(0, 0, 0),
                                                                  new PVector(255, 255, 255));

            if(!UI_Manager.getIsOverOrPressedWindows()) {
                PVector velocity = PhysEngMath.MouseVelocityCalculationAndClamp(Mouse.getMouseDownCoordinates(), 
                                                                                Mouse.getMouseCoordinates(), 
                                                                                MIN_MOUSE_VELOCITY_MAG, 
                                                                                MAX_MOUSE_VELOCITY_MAG);
                rigidbody.SetInitialPosition(PVector.add(Mouse.getMouseDownCoordinates(), velocity));
                rigidbody.setVelocity(PhysEngMath.SquareVelocity(velocity).mult(-1));
            } else {
                rigidbody.SetInitialPosition(Mouse.getMouseCoordinates());
            }

            rigidbody.setIsTranslationallyStatic(this.getElementByName("Fixed Position").getState());
            rigidbody.setIsRotationallyStatic(this.getElementByName("Fixed Rotation").getState());
            rigidbody.setCollidability(true);
            rigidbody.RotateTo(radians(this.getElementByName("Angle").getValue()));
            rigidbody.addForceToForceRegistry(new Gravity(rigidbody));

            AddBodyToBodyEntityList(rigidbody);
            return;
    }


    public void createRectangle() {
        Rigidbody rigidbody = RigidbodyGenerator.CreateBoxBody(this.getElementByName("Width").getValue(),
                                                              this.getElementByName("Height").getValue(),
                                                              this.getElementByName("Density").getValue(),
                                                              this.getElementByName("Restitution").getValue(),
                                                              this.getElementByName("Static").getState(),
                                                              true,
                                                              0.1,
                                                              new PVector(0, 0, 0),
                                                              new PVector(255, 255, 255));
        if(!UI_Manager.getIsOverOrPressedWindows()){
            PVector velocity = PhysEngMath.MouseVelocityCalculationAndClamp(Mouse.getMouseDownCoordinates(), 
                                                                            Mouse.getMouseCoordinates(), 
                                                                            MIN_MOUSE_VELOCITY_MAG, 
                                                                            MAX_MOUSE_VELOCITY_MAG);
            rigidbody.SetInitialPosition(PVector.add(Mouse.getMouseDownCoordinates(), velocity));
            rigidbody.setVelocity(PhysEngMath.SquareVelocity(velocity).mult(-1));
        } else {
            rigidbody.SetInitialPosition(Mouse.getMouseCoordinates());
        }
        
        rigidbody.setIsTranslationallyStatic(this.getElementByName("Fixed Position").getState());
        rigidbody.setIsRotationallyStatic(this.getElementByName("Fixed Rotation").getState());
        rigidbody.setCollidability(true);
        rigidbody.RotateTo(radians(this.getElementByName("Angle").getValue()));
        rigidbody.addForceToForceRegistry(new Gravity(rigidbody));

        AddBodyToBodyEntityList(rigidbody);
        return;
    }


    
/*
========================================= Rigidbody Drawing ========================================
*/
    public void drawVelocityLine() {
        int activeSlotID = UI_Manager.HOT_BAR.getActiveSlotID();
        if(activeSlotID != 2 && activeSlotID != 3) {
            return;
        }

        PVector mouseDownCoordinates = Mouse.getMouseDownCoordinates();
        PVector clamped = PhysEngMath.MouseVelocityCalculationAndClamp(mouseDownCoordinates, Mouse.getMouseCoordinates(), 
                                                                        MIN_MOUSE_VELOCITY_MAG, MAX_MOUSE_VELOCITY_MAG);
        PVector endPoint = PVector.add(mouseDownCoordinates, clamped);

        if(PVector.sub(mouseDownCoordinates, endPoint).magSq() > 0.1f){
            stroke(lerpColor(color(0, 255, 0), color(255, 0, 0), sq(map(clamped.mag(), MIN_MOUSE_VELOCITY_MAG, MAX_MOUSE_VELOCITY_MAG, 0, 1))));
            line(mouseDownCoordinates.x, mouseDownCoordinates.y, endPoint.x, endPoint.y);
        }
    }



    @Override
    public void onKeyPress(int keyCode) {
        int activeSlotID = UI_Manager.HOT_BAR.getActiveSlotID();
        boolean shiftDown = KeyHandler.isKeyDown(KeyEvent.VK_SHIFT);

        switch(keyCode) {
            case KeyEvent.VK_A:
                if(activeSlotID == 2) {
                    if(shiftDown) {
                        this.getElementByName("Radius").incrementValue(-1f);
                    } else {
                        this.getElementByName("Radius").incrementValue(-0.25f);
                    }
                } else if(activeSlotID == 3) {
                    if(shiftDown) {
                        this.getElementByName("Width").incrementValue(-5f);
                    } else {
                        this.getElementByName("Width").incrementValue(-1f);
                    }
                }
                break;
            case KeyEvent.VK_D:
                if(activeSlotID == 2) {
                    if(shiftDown) {
                        this.getElementByName("Radius").incrementValue(1f);
                    } else {
                        this.getElementByName("Radius").incrementValue(0.25f);
                    }
                } else if(activeSlotID == 3) {
                    if(shiftDown) {
                        this.getElementByName("Width").incrementValue(5f);
                    } else {
                        this.getElementByName("Width").incrementValue(1f);
                    }
                }
                break;
            case KeyEvent.VK_W:
                if(activeSlotID == 2) {
                    if(shiftDown) {
                        this.getElementByName("Radius").incrementValue(1f);
                    } else {
                        this.getElementByName("Radius").incrementValue(0.25f);
                    }
                } else if(activeSlotID == 3) {
                    if(shiftDown) {
                        this.getElementByName("Height").incrementValue(5f);
                    } else {
                        this.getElementByName("Height").incrementValue(1f);
                    }
                }
                break;

            case KeyEvent.VK_S:
                if(activeSlotID == 2) {
                    if(shiftDown) {
                        this.getElementByName("Radius").incrementValue(-1f);
                    } else {
                        this.getElementByName("Radius").incrementValue(-0.25f);
                    }
                } else if(activeSlotID == 3) {
                    if(shiftDown) {
                        this.getElementByName("Height").incrementValue(-5f);
                    } else {
                        this.getElementByName("Height").incrementValue(-1f);
                    }
                }
                break;
        }

    }

}
