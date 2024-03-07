public class UI_PropertiesForceWindow extends UI_Window {



    private boolean hasInit = false;


    private boolean MOUSE_SPRING_ADDED;
    private Spring mouseSpring = new Spring();
/*
======================================= Element Values =============================================
*/  
    private float prvSprngConst = 100;
    private float prvEqlbrmLng = 1;
    private float prvDamping = 0.5f;
    private boolean prvLockYTrnsltn = false;
    private boolean prvLockXTrnsltn = false;
    private boolean prvPrfctSprng = false;

    private boolean prvJoint = false;

    private boolean prvDrawMotor = true;
    private float prvMotorSpeed = 0;

    public UI_PropertiesForceWindow() {
        super("Properties (forces)", 1);
        initialize();
    }

/*
======================================= UI ELEMENTS ================================================
*/

    public void initialize() {

    }

    @Override
    public void onSlotChange(int previousSlotID) {
        this.onWindowSelect();
        
        if(!hasInit) {
            switch(UI_Manager.HOT_BAR.getActiveSlotID()) {
                case 4:
                    this.onSpringActive();
                    this.hasInit = true;
                    break;
                case 5:
                    this.onRodActive();
                    this.hasInit = true;
                    break;
                case 6:
                    this.onMotorActive();
                    this.hasInit = true;
                    break;
            }

            this.Window_Visibility = true;

            return;
        }

        this.Window_Visibility = true;

        switch(UI_Manager.HOT_BAR.getActiveSlotID()) {
            case 4:
                this.onSpringActive();
                break;
            case 5:
                this.onRodActive();
                break;
            case 6:
                this.onMotorActive();
                break;
        }
    }

    public void onSpringActive() {
        this.savePrevElementStates();
        this.clearAllElements();
        this.HotBarSlotRepresentation = "Spring";
        this.addElement(new UI_Slider("Spring Constant", (UI_Window)this, 0, 300, prvSprngConst));
        this.addElement(new UI_Slider("Equilibrium Length", (UI_Window)this, 0, 10, prvEqlbrmLng));
        this.addElement(new UI_Slider("Damping", (UI_Window)this, 0, 1, prvDamping));
        this.addElement(new UI_Toggle("Lock Y Translation", (UI_Window)this, "Translation", prvLockYTrnsltn));
        this.addElement(new UI_Toggle("Lock X Translation", (UI_Window)this, "Translation", prvLockXTrnsltn));
        this.addElement(new UI_Toggle("Perfect Spring", (UI_Window)this, prvPrfctSprng));
    }

    public void onRodActive() {
        this.savePrevElementStates();
        this.clearAllElements();
        this.HotBarSlotRepresentation = "Rod";
        this.addElement(new UI_Toggle("Joint", (UI_Window)this, prvJoint));
    }

    public void onMotorActive() {
        this.savePrevElementStates();
        this.clearAllElements();
        this.HotBarSlotRepresentation = "Motor";
        this.addElement(new UI_Toggle("Draw Motor", (UI_Window)this, prvDrawMotor));
        this.addElement(new UI_Slider("Motor Speed", (UI_Window)this, -20, 20, prvMotorSpeed));
    }

    public void savePrevElementStates() {
        if(!this.hasInit) {
            return;
        }

        switch (this.HotBarSlotRepresentation) {
            case "Spring":
                this.prvSprngConst = this.getElementByName("Spring Constant").getValue();
                this.prvEqlbrmLng = this.getElementByName("Equilibrium Length").getValue();
                this.prvDamping = this.getElementByName("Damping").getValue();
                this.prvLockYTrnsltn = this.getElementByName("Lock Y Translation").getState();
                this.prvLockXTrnsltn = this.getElementByName("Lock X Translation").getState();
                this.prvPrfctSprng = this.getElementByName("Perfect Spring").getState();
                break;
            case "Rod":
                this.prvJoint = this.getElementByName("Joint").getState();
                break;
            case "Motor":
                this.prvDrawMotor = this.getElementByName("Draw Motor").getState();
                this.prvMotorSpeed = this.getElementByName("Motor Speed").getValue();
                break;
        }
    }
/*
========================================= Force Drawing ============================================
*/
    @Override
    public void interactionDraw() {
        if(UI_Manager.getIsOverOrPressedWindows()) {
            return;
        }
        this.drawForces();
    }







    public void drawForces() {

        /*---------------------------------- Checks --------------------------------------*/
        int activeSlotID = UI_Manager.HOT_BAR.getActiveSlotID();
        if(activeSlotID != 4 && activeSlotID != 5 && activeSlotID != 6) {
            return;
        }
        
        ArrayList<MouseObjectResult> mouseObjectResults = Mouse.getMouseObjectResults();
        if(mouseObjectResults.size() == 0 || mouseObjectResults.size() > 1) {
            return;
        } else if(mouseObjectResults.size() == 1 && (UI_Manager.getIsPressedOverWindow())) {
            mouseObjectResults.clear();
            return;
        }
        /*--------------------------------------------------------------------------------*/


        PVector worldAnchorA;
        PVector worldAnchorB;
        Rigidbody rigidbodyToDrawFrom;


        
        rigidbodyToDrawFrom = mouseObjectResults.get(0).getSelectedRigidbody();
        
        if(rigidbodyToDrawFrom != null) {
            worldAnchorA = PhysEngMath.Transform(mouseObjectResults.get(0).getTransformedLocalCoordinate(), rigidbodyToDrawFrom.getPosition(), rigidbodyToDrawFrom.getAngle());
            worldAnchorB = Mouse.getMouseCoordinates();
        } else {
            worldAnchorA = mouseObjectResults.get(0).getWorldCoordinate();
            worldAnchorB = Mouse.getMouseCoordinates();
        }

        switch(activeSlotID) {
            case 4:
                this.drawSpring(worldAnchorA, worldAnchorB, rigidbodyToDrawFrom);
                break;
            case 5:
                this.drawRod(worldAnchorA, worldAnchorB, rigidbodyToDrawFrom);
                break;
            case 6:
                this.drawMotor(worldAnchorA, worldAnchorB, rigidbodyToDrawFrom);
                break;
        }
    }   


    public void drawSpring(PVector worldAnchorA, PVector worldAnchorB, Rigidbody rigidbodyToDrawFrom) {
        PVector direction = PVector.sub(worldAnchorA, worldAnchorB);
        float length = direction.mag();
        direction.normalize();
    
        float segments = 5;
        float segmentLength = length / segments;
        float offsetMagnitude = 0.5f; // Adjust this value to change the size of the zigzags
    
        // Draw the rod
        strokeWeight(0.3f);
        stroke(0, 0, 0, 166); // Black
        line(worldAnchorA.x, worldAnchorA.y, worldAnchorB.x, worldAnchorB.y);
        stroke(255, 255, 255, 166); // White
        strokeWeight(0.1f);
        line(worldAnchorA.x, worldAnchorA.y, worldAnchorB.x, worldAnchorB.y);
    
        for(int i = 0; i < segments; i++) {
            PVector segmentStart = PVector.add(worldAnchorB, PVector.mult(direction, segmentLength * i));
            PVector segmentEnd = PVector.add(worldAnchorB, PVector.mult(direction, segmentLength * (i + 1)));
    
            // Calculate the midpoint of the segment
            PVector midPoint = PVector.lerp(segmentStart, segmentEnd, 0.5f);
    
            // Alternate the offset direction to give appearance of spring
            PVector offset;
            if(i % 2 == 0) {
                offset = PVector.mult(new PVector(-direction.y, direction.x), offsetMagnitude);
            } else {
                offset = PVector.mult(new PVector(direction.y, -direction.x), offsetMagnitude);
            }
    
            // Add the offset to the midpoint
            PVector midPointOffset = PVector.add(midPoint, offset);
    
            // Draw the lines
            strokeWeight(0.2f);
            stroke(0, 0, 0, 166);
            line(segmentStart.x, segmentStart.y, midPointOffset.x, midPointOffset.y);
            line(midPointOffset.x, midPointOffset.y, segmentEnd.x, segmentEnd.y);
            strokeWeight(0.1f);
            stroke(255, 255, 255, 166);
            line(segmentStart.x, segmentStart.y, midPointOffset.x, midPointOffset.y);
            line(midPointOffset.x, midPointOffset.y, segmentEnd.x, segmentEnd.y);
        }
    }


    public void drawRod(PVector worldAnchorA, PVector worldAnchorB, Rigidbody rigidbodyToDrawFrom) {
        strokeWeight(0.15);
        stroke(0, 0, 0, 166);
        line(worldAnchorA.x, worldAnchorA.y, worldAnchorB.x, worldAnchorB.y);
        strokeWeight(0.1);
        stroke(255, 255, 255, 166);
        line(worldAnchorA.x, worldAnchorA.y, worldAnchorB.x, worldAnchorB.y);
    }



    public void drawMotor(PVector worldAnchorA, PVector worldAnchorB, Rigidbody rigidbodyToDrawFrom) {
        if(rigidbodyToDrawFrom == null) {
                return;
        }

        PVector position = rigidbodyToDrawFrom.getPosition();
        boolean isClockwise = this.getElementByName("Motor Speed").getValue() > 0;

        float size = rigidbodyToDrawFrom.getRadius() * 0.5f;
        float arrowSize = size * 0.15f;
        float startAngle = 0;
        float endAngle = 3 * PI/2;
            
        pushMatrix();
        translate(position.x, position.y);
        rotate(rigidbodyToDrawFrom.getAngle() + PI/6);

        noFill();
        strokeWeight(0.1f);
        stroke(255, 0, 0, 166);
        arc(0, 0, size, size, startAngle, endAngle);

        // Calculate the start and end of the arc
        float startX =  size * cos(startAngle)/2;
        float startY = size * sin(startAngle)/2;
        float endX = size * cos(endAngle)/2;
        float endY = size * sin(endAngle)/2;
            
        if(isClockwise) {
            strokeWeight(0.1f);
            stroke(255, 0, 0, 166);
            triangle(endX, endY-arrowSize, endX, endY+arrowSize, endX+arrowSize*2, endY);
        } else {
            strokeWeight(0.1f);
            stroke(255, 0, 0, 166);
            triangle(startX-arrowSize, startY, startX + arrowSize, startY, startX, startY - 2 * arrowSize);
        }
        popMatrix();

    }


/*
========================================= Force Creation ==============================================
*/  
    @Override
    public void interactionMousePress() {
        if(UI_Manager.hasWindowBeenInteractedWith) {
            return;
        }

        if(UI_Manager.getIsOverOrPressedWindows()){
            return;
        }

        this.addMouseSpring();
    }

    @Override
    public void interactionMouseDrag() {
        if(this.MOUSE_SPRING_ADDED) {
            PVector mouseCoordinates = Mouse.getMouseCoordinates();
            mouseSpring.setAnchorPoint(mouseCoordinates);
        }
    }
    @Override
    public void interactionMouseRelease() {
        if(UI_Manager.getIsOverOrPressedWindows()) {
            return;
        }

        if(UI_Manager.hasWindowBeenInteractedWith) {
            Mouse.getMouseObjectResults().clear();
            return;
        }

        if(this.MOUSE_SPRING_ADDED) {
            this.removeMouseSpring();
            Mouse.clearMouseObjectResults();
            return;
        } 

        this.createForces();
        return;
    }







    public void createForces() {
        /*---------------------------------- Checks --------------------------------------*/
        int activeSlotID = UI_Manager.HOT_BAR.getActiveSlotID();
        if(activeSlotID != 4 && activeSlotID != 5 && activeSlotID != 6 && !Mouse.getIsMouseDownLeft()) {
            return;
        }

        ArrayList<MouseObjectResult> mouseObjectResults = Mouse.getMouseObjectResults();
        if(mouseObjectResults.size() == 0 || mouseObjectResults.size() == 1){
            return;
        }
        /*--------------------------------------------------------------------------------*/

        PVector mouseCoordinates = Mouse.getMouseCoordinates();

        Rigidbody rigidbody1 = mouseObjectResults.get(0).getSelectedRigidbody();
        Rigidbody rigidbody2 = mouseObjectResults.get(1).getSelectedRigidbody();
        PVector anchor1 = mouseObjectResults.get(0).getTransformedLocalCoordinate();
        PVector anchor2 = mouseObjectResults.get(1).getTransformedLocalCoordinate();

        Rigidbody[] rigidbodyArray = new Rigidbody[0];
        PVector[] anchorArray = new PVector[0];

        if(rigidbody1 != null && rigidbody2 == null) {
            rigidbodyArray = new Rigidbody[]{rigidbody1};
            anchorArray = new PVector[]{anchor1, anchor2};
        } else if(rigidbody1 == null && rigidbody2 != null){
            rigidbodyArray = new Rigidbody[]{rigidbody2};
            anchorArray = new PVector[]{anchor2, anchor1};
        } else if(rigidbody1 != null && rigidbody2 != null) {
            rigidbodyArray = new Rigidbody[]{rigidbody1, rigidbody2};
            anchorArray = new PVector[]{anchor1, anchor2};
        } else if(rigidbody1 == null && rigidbody2 == null) {
            return;
        }

        mouseObjectResults.clear();

        switch(activeSlotID) {
            case 4:
                this.createSpring(rigidbodyArray, anchorArray);
                break;
            case 5:
                this.createRod(rigidbodyArray, anchorArray);
                break;
            case 6:
                this.createMotor(rigidbodyArray, anchorArray);
                break;
        }
    }

    public void createSpring(Rigidbody[] rigidbodyArray, PVector[] anchorArray) {
        Spring spring;

        if(rigidbodyArray.length == 1) {
            spring = new Spring(rigidbodyArray[0], anchorArray[0], anchorArray[1]);
            ALL_FORCES_ARRAYLIST.add(spring);
            rigidbodyArray[0].addForceToForceRegistry(spring);

        } else if(rigidbodyArray.length == 2) {
            spring = new Spring(rigidbodyArray[0], rigidbodyArray[1], anchorArray[0], anchorArray[1]);
            ALL_FORCES_ARRAYLIST.add(spring);
            rigidbodyArray[0].addForceToForceRegistry(spring);
            rigidbodyArray[1].addForceToForceRegistry(spring);
        } else {
            throw new IllegalArgumentException("RigidbodyArray is 0");
        }

        spring.setSpringConstant(this.getElementByName("Spring Constant").getValue());
        spring.setEquilibriumLength(this.getElementByName("Equilibrium Length").getValue());
        spring.setDamping(this.getElementByName("Damping").getValue());
        spring.setLockTranslationToXAxis(this.getElementByName("Lock Y Translation").getState());
        spring.setLockTranslationToYAxis(this.getElementByName("Lock X Translation").getState());
        spring.setPerfectSpring(this.getElementByName("Perfect Spring").getState());
    }


    public void createRod(Rigidbody[] rigidbodyArray, PVector[] anchorArray) {
        Rod rod;

        if(rigidbodyArray.length == 1) {
            rod = new Rod(rigidbodyArray[0], anchorArray[0], anchorArray[1]);
            ALL_FORCES_ARRAYLIST.add(rod);
            rigidbodyArray[0].addForceToForceRegistry(rod);
        } else if(rigidbodyArray.length == 2) {
            rod = new Rod(rigidbodyArray[0], rigidbodyArray[1], anchorArray[0], anchorArray[1]);
            ALL_FORCES_ARRAYLIST.add(rod);
            rigidbodyArray[0].addForceToForceRegistry(rod);
            rigidbodyArray[1].addForceToForceRegistry(rod);
        } else {
            throw new IllegalArgumentException("RigidbodyArray is 0");
        }
        rod.setIsJoint(this.getElementByName("Joint").getState());
    }


    public void createMotor(Rigidbody[] rigidbodyArray, PVector[] anchorArray) {
        Motor motor = new Motor(rigidbodyArray[0], this.getElementByName("Motor Speed").getValue());

            ///motor.setDrawMotor(this.TOGGLE_STATES[7]);
            motor.setDrawMotorForce(this.getElementByName("Draw Motor").getState());
            Iterator<ForceRegistry> iterator = rigidbodyArray[0].getForceRegistry().iterator();

            while (iterator.hasNext()) {
                ForceRegistry force = iterator.next();
                if (force instanceof Motor) {
                    iterator.remove();
                    ALL_FORCES_ARRAYLIST.remove(force);
                }
            }

            ALL_FORCES_ARRAYLIST.add(motor);
            rigidbodyArray[0].addForceToForceRegistry(motor);
    }

/*
========================================= Mouse Spring ==============================================
*/
    public void addMouseSpring() {
        if(KeyHandler.isKeyDown(KeyEvent.VK_SHIFT) && !this.MOUSE_SPRING_ADDED) {
            Rigidbody rigidbody = Mouse.getCurrentRigidbodyUnderMouse();

            if(rigidbody != null){
                PVector mouseCoordinates = Mouse.getMouseCoordinates();
                PVector localAnchorA = PhysEngMath.Transform(PhysEngMath.SnapController(Mouse, rigidbody, mouseCoordinates), -rigidbody.getAngle());

                mouseSpring.setRigidbodyA(rigidbody);
                mouseSpring.setLocalAnchorA(localAnchorA);
                mouseSpring.setAnchorPoint(mouseCoordinates);
                mouseSpring.setSpringConstant(200);
                mouseSpring.setDamping(0.8f); 
                mouseSpring.setEquilibriumLength(0.2);  
                rigidbody.addForceToForceRegistry(mouseSpring);
                this.MOUSE_SPRING_ADDED = true;
                UI_Manager.getPropertiesRigidbodyWindow().setMouseSpringAdded(true);
                UI_Manager.getPropertiesEditorWindow().setMouseSpringAdded(true);
                
            } 
        }
    }

    public void removeMouseSpring() {
        if(mouseSpring.getRigidbodyA() != null && this.MOUSE_SPRING_ADDED) {
            mouseSpring.getRigidbodyA().removeForceFromForceRegistry(mouseSpring);
            mouseSpring.setRigidbodyA(null);
            this.MOUSE_SPRING_ADDED = false;
            UI_Manager.getPropertiesEditorWindow().setMouseSpringAdded(false);
        }
    }


/*
======================================= Key Interaction ========================================
*/
        
    /* Assumes input is a keyCode that has definitely been pressed */
    @Override
    public void onKeyPress(int keyCode) {
        int activeSlotID = UI_Manager.HOT_BAR.getActiveSlotID();
        boolean shiftDown = KeyHandler.isKeyDown(KeyEvent.VK_SHIFT);

        switch(keyCode) {
            case KeyEvent.VK_A:
                if(activeSlotID == 4) {
                    if(shiftDown) {
                        this.getElementByName("Spring Constant").incrementValue(-10f);
                    } else {
                        this.getElementByName("Spring Constant").incrementValue(-5f);
                    }
                } else if(activeSlotID == 6) {
                    if(shiftDown) {
                        this.getElementByName("Motor Speed").incrementValue(-2f);
                    } else {
                        this.getElementByName("Motor Speed").incrementValue(-1f);
                    }
                }
                break;
            case KeyEvent.VK_D:
                if(activeSlotID == 4) {
                    if(shiftDown) {
                        this.getElementByName("Spring Constant").incrementValue(10f);
                    } else {
                        this.getElementByName("Spring Constant").incrementValue(5f);
                    }
                } else if(activeSlotID == 6) {
                    if(shiftDown) {
                        this.getElementByName("Motor Speed").incrementValue(2f);
                    } else {
                        this.getElementByName("Motor Speed").incrementValue(1f);
                    }
                }
                break;
            case KeyEvent.VK_W:
                if(activeSlotID == 4) {
                    if(shiftDown) {
                        this.getElementByName("Equilibrium Length").incrementValue(1f);
                    } else {
                        this.getElementByName("Equilibrium Length").incrementValue(0.5f);
                    }
                }
                break;
            case KeyEvent.VK_S:
                if(activeSlotID == 4) {
                    if(shiftDown) {
                        this.getElementByName("Equilibrium Length").incrementValue(-1f);
                    } else {
                        this.getElementByName("Equilibrium Length").incrementValue(-0.5f);
                    }
                }
                break;
        }

    }


}
