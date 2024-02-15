public class FT_InteractionHandler extends TabInteractionHandlerAbstract{

    /*
    ID 0: FT_Spring_Toggle => Default: false
    ID 1: FT_Rod_Toggle => Default: false
    ID 2: FT_Motor_Toggle => Default: false
    ID 3: FT_Spring_LockToX_Toggle => Default: false
    ID 4: FT_Spring_LockToY_Toggle => Default: false
    ID 5: FT_Spring_PerfectSpring_Toggle => Default: false
    ID 6: FT_Rod_IsJoint_Toggle => Default: false
    ID 7: FT_Motor_DrawMotor => Default: false
    ID 8: FT_Motor_DrawMotorForce => Default: true
    */
    private boolean MOUSE_LEFT_DOWN = false;
    private boolean MOUSE_SPRING_ADDED = false;

    private boolean[] TOGGLE_STATES = {false, false, false, false, false, false, false, false, true};


    /*
    ID 0: FT_Spring_SpringConstant_Slider => Default: 50
    ID 1: FT_Spring_EquilibriumLength_Slider => Default: 1
    ID 2: FT_Spring_Damping_Slider => Default: 0.5
    ID 3: FT_Motor_TargetAngularVelocity_Slider => Default: 5
    */

    private float[] SLIDER_VALUES = {50f, 1f, 0.5f, 5f};


    private Spring mouseSpring = new Spring();




/*
====================================================================================================
======================================= Main Methods ===============================================
====================================================================================================
*/


    public void drawForces() {
        PVector worldAnchorA;
        PVector worldAnchorB;
        Rigidbody rigidbodyToDrawFrom;

        ArrayList<MouseObjectResult> mouseObjectResults = Mouse.getMouseObjectResults();

        if(mouseObjectResults.size() == 0 || mouseObjectResults.size() > 1) {
            return;
        }

        int toggleState = -1;
        for(int i = 0; i < this.TOGGLE_STATES.length; i++) {
            if(this.TOGGLE_STATES[i]) {
                toggleState = i;
                break;
            }
        }  

        if(toggleState == -1) {
            return;
        } 

        rigidbodyToDrawFrom = mouseObjectResults.get(0).getSelectedRigidbody();
        
        if(rigidbodyToDrawFrom != null) {
            worldAnchorA = PhysEngMath.Transform(mouseObjectResults.get(0).getTransformedLocalCoordinate(), rigidbodyToDrawFrom.getPosition(), rigidbodyToDrawFrom.getAngle());
            worldAnchorB = Mouse.getMouseCoordinates();
        } else {
            worldAnchorA = mouseObjectResults.get(0).getWorldCoordinate();
            worldAnchorB = Mouse.getMouseCoordinates();
        }



        switch(toggleState) {
            case 0:
                this.drawSpring(worldAnchorA, worldAnchorB, rigidbodyToDrawFrom);
                break;
            case 1:
                this.drawRod(worldAnchorA, worldAnchorB, rigidbodyToDrawFrom);
                break;
            case 2:
                this.drawMotor(worldAnchorA, worldAnchorB, rigidbodyToDrawFrom);
                break;
        }
    }   



    public void drawSpring(PVector worldAnchorA, PVector worldAnchorB, Rigidbody rigidbodyToDrawFrom) {

        PVector direction = PVector.sub(worldAnchorA, worldAnchorB);
        fill(255, 255, 255, OPACITY);
        float length = direction.mag();
        direction.normalize();

        float segments = 10;
        float segmentLength = length / segments;
        float offsetMagnitude = 0.5f;
        
        strokeWeight(0.3f);
        stroke(0, 0, 0, OPACITY); 
        line(worldAnchorA.x, worldAnchorA.y, worldAnchorB.x, worldAnchorB.y);
        stroke(255, 255, 255, OPACITY); 
        strokeWeight(0.1f);
        line(worldAnchorA.x, worldAnchorA.y, worldAnchorB.x, worldAnchorB.y);
            
        for(int i = 0; i < segments; i++) {
            PVector segmentStart = PVector.add(worldAnchorB, PVector.mult(direction, segmentLength * i));
            PVector segmentEnd = PVector.add(worldAnchorB, PVector.mult(direction, segmentLength * (i + 1)));

            PVector midPoint = PVector.lerp(segmentStart, segmentEnd, 0.5f);

            PVector offset1, offset2;
            if(i % 2 == 0) {
                offset1 = PVector.mult(new PVector(-direction.y, direction.x), offsetMagnitude);
                offset2 = PVector.mult(new PVector(direction.y, -direction.x), offsetMagnitude);
            } else {
                offset1 = PVector.mult(new PVector(direction.y, -direction.x), offsetMagnitude);
                offset2 = PVector.mult(new PVector(-direction.y, direction.x), offsetMagnitude);
            }

            PVector midPoint1 = PVector.add(midPoint, offset1);
            PVector midPoint2 = PVector.add(midPoint, offset2);

            // Draw the lines
            strokeWeight(0.2f);
            stroke(0, 0, 0, OPACITY);
            line(segmentStart.x, segmentStart.y, midPoint1.x, midPoint1.y);
            line(midPoint1.x, midPoint1.y, segmentEnd.x, segmentEnd.y);
            line(segmentStart.x, segmentStart.y, midPoint2.x, midPoint2.y);
            line(midPoint2.x, midPoint2.y, segmentEnd.x, segmentEnd.y);
            strokeWeight(0.1f);
            stroke(255, 255, 255, OPACITY);
            line(segmentStart.x, segmentStart.y, midPoint1.x, midPoint1.y);
            line(midPoint1.x, midPoint1.y, segmentEnd.x, segmentEnd.y);
            line(segmentStart.x, segmentStart.y, midPoint2.x, midPoint2.y);
            line(midPoint2.x, midPoint2.y, segmentEnd.x, segmentEnd.y);
        }
    }



    public void drawRod(PVector worldAnchorA, PVector worldAnchorB, Rigidbody rigidbodyToDrawFrom) {

        strokeWeight(0.15);
        stroke(0, 0, 0, OPACITY);
        line(worldAnchorA.x, worldAnchorA.y, worldAnchorB.x, worldAnchorB.y);
        strokeWeight(0.1);
        stroke(255, 255, 255, OPACITY);
        line(worldAnchorA.x, worldAnchorA.y, worldAnchorB.x, worldAnchorB.y);
    }


    public void drawMotor(PVector worldAnchorA, PVector worldAnchorB, Rigidbody rigidbodyToDrawFrom) {
        if(rigidbodyToDrawFrom == null) {
                return;
        }

        PVector position = rigidbodyToDrawFrom.getPosition();
        boolean isClockwise = this.SLIDER_VALUES[3] > 0;

        float size = rigidbodyToDrawFrom.getRadius() * 0.5f;
        float arrowSize = size * 0.15f;
        float startAngle = 0;
        float endAngle = 3 * PI/2;
            
        pushMatrix();
        translate(position.x, position.y);
        rotate(rigidbodyToDrawFrom.getAngle() + PI/6);

        noFill();
        strokeWeight(0.1f);
        stroke(255, 0, 0, OPACITY);
        arc(0, 0, size, size, startAngle, endAngle);

        // Calculate the start and end of the arc
        float startX =  size * cos(startAngle)/2;
        float startY = size * sin(startAngle)/2;
        float endX = size * cos(endAngle)/2;
        float endY = size * sin(endAngle)/2;
            
        if(isClockwise) {
            strokeWeight(0.1f);
            stroke(255, 0, 0, OPACITY);
            triangle(endX, endY-arrowSize, endX, endY+arrowSize, endX+arrowSize*2, endY);
        } else {
            strokeWeight(0.1f);
            stroke(255, 0, 0, OPACITY);
            triangle(startX-arrowSize, startY, startX + arrowSize, startY, startX, startY - 2 * arrowSize);
        }
        popMatrix();

    }

    public void createForces() {

        if(!(this.TOGGLE_STATES[0] || this.TOGGLE_STATES[1] || this.TOGGLE_STATES[2]) || !this.MOUSE_LEFT_DOWN) {
            return;
        }


        ArrayList<MouseObjectResult> mouseObjectResults = Mouse.getMouseObjectResults();
        if(mouseObjectResults.size() == 0 || mouseObjectResults.size() == 1){
            return;
        }

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

        if(this.TOGGLE_STATES[0]) {
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

                spring.setEquilibriumLength(this.SLIDER_VALUES[1]);
                spring.setSpringConstant(this.SLIDER_VALUES[0]);
                spring.setDamping(this.SLIDER_VALUES[2]);

                spring.setLockTranslationToXAxis(this.TOGGLE_STATES[3]);
                spring.setLockTranslationToYAxis(this.TOGGLE_STATES[4]);
                spring.setPerfectSpring(this.TOGGLE_STATES[5]);

        } else if(this.TOGGLE_STATES[1]){

            Rod rod;
            if(rigidbodyArray.length == 1) {

                rod = new Rod(rigidbodyArray[0], anchorArray[0], anchorArray[1]);
                System.out.println(anchorArray[0]);
                System.out.println(mouseCoordinates);
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

            rod.setIsJoint(this.TOGGLE_STATES[6]);

        } else if(this.TOGGLE_STATES[2]) {

            Motor motor = new Motor(rigidbodyArray[0], this.SLIDER_VALUES[3]);

            motor.setDrawMotor(this.TOGGLE_STATES[7]);
            motor.setDrawMotorForce(this.TOGGLE_STATES[8]);

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
    }


    public void addMouseSpring() {
        if(this.isKeyDown(KeyEvent.VK_SHIFT) && this.MOUSE_LEFT_DOWN) {
            Rigidbody rigidbody = Mouse.getCurrentRigidbodyUnderMouse();

            if(rigidbody != null){
                PVector mouseCoordinates = Mouse.getMouseCoordinates();
                PVector localAnchorA = PhysEngMath.Transform(PhysEngMath.SnapController(rigidbody, mouseCoordinates), -rigidbody.getAngle());

                mouseSpring.setRigidbodyA(rigidbody);
                mouseSpring.setLocalAnchorA(localAnchorA);
                mouseSpring.setAnchorPoint(mouseCoordinates);
                rigidbody.addForceToForceRegistry(mouseSpring);
                mouseSpring.setSpringConstant(200);
                mouseSpring.setDamping(0.8f); 
                mouseSpring.setEquilibriumLength(0.2);  
                this.MOUSE_SPRING_ADDED = true;
            } 
        }
    }

    public void removeMouseSpring() {
        if(mouseSpring.getRigidbodyA() != null && this.MOUSE_SPRING_ADDED) {
            mouseSpring.getRigidbodyA().removeForceFromForceRegistry(mouseSpring);
            mouseSpring.setRigidbodyA(null);
            this.MOUSE_SPRING_ADDED = false;
        }
    }



/*
====================================================================================================
======================================= Mouse Response  ============================================
====================================================================================================
*/
    @Override
    public void passiveResponse() {
        this.drawForces();
    } 

    @Override
    public void onMousePressed() {
        if(mouseButton == LEFT) {
            this.MOUSE_LEFT_DOWN = true;
            this.addMouseSpring();
        }
    }
    @Override
    public void onMouseDragged() {
        if(this.MOUSE_SPRING_ADDED && this.MOUSE_LEFT_DOWN) {
            PVector mouseCoordinates = Mouse.getMouseCoordinates();
            mouseSpring.setAnchorPoint(mouseCoordinates);
        }
    }
    
    @Override
    public void onMouseReleased() {

        if(this.MOUSE_SPRING_ADDED) {
            this.removeMouseSpring();
            Mouse.clearMouseObjectResults();
        } else if(this.MOUSE_LEFT_DOWN){
            this.createForces();
        }
        this.MOUSE_LEFT_DOWN = false;

    }

/*
====================================================================================================
======================================= GUI Response  ==============================================
====================================================================================================
*/
    @Override
    public void ToggleListener(ControlEvent ToggleEvent) {
        Controller ToggleEvent_Controller = ToggleEvent.getController();
            int ToggleEvent_Value = (int)ToggleEvent_Controller.getValue();
            String ToggleEvent_Controller_Name = ToggleEvent_Controller.getName();

        switch(ToggleEvent_Controller_Name) {
            case "FT_Spring_Toggle":
                this.ToggleResponseHandler(ToggleEvent_Value == 1, 0);
                break;
            case "FT_Rod_Toggle":
                this.ToggleResponseHandler(ToggleEvent_Value == 1, 1);
                break;
            case "FT_Motor_Toggle":
                this.ToggleResponseHandler(ToggleEvent_Value == 1, 2);
                break;
            case "FT_Spring_LockToX_Toggle":
                this.ToggleResponseHandler(ToggleEvent_Value == 1, 3);
                break;
            case "FT_Spring_LockToY_Toggle":
                this.ToggleResponseHandler(ToggleEvent_Value == 1, 4);
                break;
            case "FT_Spring_PerfectSpring_Toggle":
                this.ToggleResponseHandler(ToggleEvent_Value == 1, 5);
                break;
            case "FT_Rod_IsJoint_Toggle":
                this.ToggleResponseHandler(ToggleEvent_Value == 1, 6);
                break;
            case "FT_Motor_DrawMotor":
                this.ToggleResponseHandler(ToggleEvent_Value == 1, 7);
                break;
            case "FT_Motor_DrawMotorForce":
                this.ToggleResponseHandler(ToggleEvent_Value == 1, 8);
                break;
            default:
                throw new IllegalArgumentException("Invalid toggle event controller name: " + ToggleEvent_Controller_Name);
        }
    }

    @Override
    public void ToggleResponseHandler(boolean ToggleEventValue, int ToggleEventID) {
        this.TOGGLE_STATES[ToggleEventID] = ToggleEventValue;

        switch(ToggleEventID) {
            case 0:
                if(ToggleEventValue) {
                    this.HandleToggle(gui.FT_Spring_Toggle, 0, true, this.TOGGLE_STATES);
                    this.HandleToggle(gui.FT_Rod_Toggle, 1, false, this.TOGGLE_STATES);
                    this.HandleToggle(gui.FT_Motor_Toggle, 2, false, this.TOGGLE_STATES);
                } else {
                    this.HandleToggle(gui.FT_Spring_Toggle, 0, false, this.TOGGLE_STATES);
                }
                this.VisibilityResponse();
                break;
            case 1:
                if(ToggleEventValue) {
                    this.HandleToggle(gui.FT_Spring_Toggle, 0, false, this.TOGGLE_STATES);
                    this.HandleToggle(gui.FT_Rod_Toggle, 1, true, this.TOGGLE_STATES);
                    this.HandleToggle(gui.FT_Motor_Toggle, 2, false, this.TOGGLE_STATES);
                } else {
                    this.HandleToggle(gui.FT_Rod_Toggle, 1, false, this.TOGGLE_STATES);
                }
                this.VisibilityResponse();
                break;
            case 2:
                if(ToggleEventValue) {
                    this.HandleToggle(gui.FT_Spring_Toggle, 0, false, this.TOGGLE_STATES);
                    this.HandleToggle(gui.FT_Rod_Toggle, 1, false, this.TOGGLE_STATES);
                    this.HandleToggle(gui.FT_Motor_Toggle, 2, true, this.TOGGLE_STATES);
                } else {
                    this.HandleToggle(gui.FT_Motor_Toggle, 2, false, this.TOGGLE_STATES);
                }
                this.VisibilityResponse();
                break;
            case 3:
                if(ToggleEventValue) {
                    this.HandleToggle(gui.FT_Spring_LockToX_Toggle, 3, true, this.TOGGLE_STATES);
                    this.HandleToggle(gui.FT_Spring_LockToY_Toggle, 4, false, this.TOGGLE_STATES);
                } else {
                    this.HandleToggle(gui.FT_Spring_LockToX_Toggle, 3, false, this.TOGGLE_STATES);
                }
                break;
            case 4:
                if(ToggleEventValue) {
                    this.HandleToggle(gui.FT_Spring_LockToX_Toggle, 3, false, this.TOGGLE_STATES);
                    this.HandleToggle(gui.FT_Spring_LockToY_Toggle, 4, true, this.TOGGLE_STATES);
                } else {
                    this.HandleToggle(gui.FT_Spring_LockToY_Toggle, 4, false, this.TOGGLE_STATES);
                }
                break;
            case 5:
                this.HandleToggle(gui.FT_Spring_PerfectSpring_Toggle, 5, ToggleEventValue, this.TOGGLE_STATES);
                break;
            case 6:
                this.HandleToggle(gui.FT_Rod_IsJoint_Toggle, 6, ToggleEventValue, this.TOGGLE_STATES);
                break;
            case 7:
                this.HandleToggle(gui.FT_Motor_DrawMotor_Toggle, 7, ToggleEventValue, this.TOGGLE_STATES);
                break;
            case 8:
                this.HandleToggle(gui.FT_Motor_DrawMotorForce_Toggle, 8, ToggleEventValue, this.TOGGLE_STATES);
                break;
        }
    }

    @Override
    public void SliderListener(ControlEvent SliderEvent) {
        Controller SliderEvent_Controller = SliderEvent.getController();
            float SliderEvent_value = SliderEvent_Controller.getValue();
            String SliderEvent_Controller_Name = SliderEvent_Controller.getName();
        
        switch(SliderEvent_Controller_Name) {
            case "FT_Spring_SpringConstant_Slider":
                this.SliderResponseHandler(SliderEvent_value, 0);
                break;
            case "FT_Spring_EquilibriumLength_Slider":
                this.SliderResponseHandler(SliderEvent_value, 1);
                break;
            case "FT_Spring_Damping_Slider":
                this.SliderResponseHandler(SliderEvent_value, 2);
                break;
            case "FT_Motor_TargetAngularVelocity_Slider":
                this.SliderResponseHandler(SliderEvent_value, 3);
                break;
        }
    }

    @Override
    public void SliderResponseHandler(float SliderEventValue, int SliderEventID) {
        this.SLIDER_VALUES[SliderEventID] = SliderEventValue;

        switch(SliderEventID) {
            case 0:
                this.HandleSlider(gui.FT_Spring_SpringConstant_Slider, 0, SliderEventValue, this.SLIDER_VALUES);
                break;
            case 1:
                this.HandleSlider(gui.FT_Spring_EquilibriumLength_Slider, 1, SliderEventValue, this.SLIDER_VALUES);
                break;
            case 2:
                this.HandleSlider(gui.FT_Spring_Damping_Slider, 2, SliderEventValue, this.SLIDER_VALUES);
                break;
            case 3:
                this.HandleSlider(gui.FT_Motor_TargetAngularVelocity_Slider, 3, SliderEventValue, this.SLIDER_VALUES);
                break;
        }
    }
         

    @Override
    public void VisibilityResponse() {
        gui.FT_Spring_SpringConstant_Slider.setVisible(this.TOGGLE_STATES[0]);
        gui.FT_Spring_EquilibriumLength_Slider.setVisible(this.TOGGLE_STATES[0]);
        gui.FT_Spring_Damping_Slider.setVisible(this.TOGGLE_STATES[0]);
        gui.FT_Spring_LockToX_Toggle.setVisible(this.TOGGLE_STATES[0]);
        gui.FT_Spring_LockToY_Toggle.setVisible(this.TOGGLE_STATES[0]);
        gui.FT_Spring_PerfectSpring_Toggle.setVisible(this.TOGGLE_STATES[0]);

        gui.FT_Rod_IsJoint_Toggle.setVisible(this.TOGGLE_STATES[1]);

        gui.FT_Motor_DrawMotor_Toggle.setVisible(this.TOGGLE_STATES[2]);
        gui.FT_Motor_DrawMotorForce_Toggle.setVisible(this.TOGGLE_STATES[2]);
        gui.FT_Motor_TargetAngularVelocity_Slider.setVisible(this.TOGGLE_STATES[2]);
    }

        
/*
====================================================================================================
======================================= Key Response  ==============================================
====================================================================================================
*/

    @Override
    public void onKeyPressed() {
        if(this.isKeyDown(KeyEvent.VK_SHIFT)) {
            if(this.isKeyDown(KeyEvent.VK_W)) {
                if(this.TOGGLE_STATES[0]) {
                    this.HandleSlider(gui.FT_Spring_SpringConstant_Slider, 0, this.SLIDER_VALUES[0] + 10, this.SLIDER_VALUES);
                } else if(this.TOGGLE_STATES[2]) {
                    this.HandleSlider(gui.FT_Motor_TargetAngularVelocity_Slider, 3, this.SLIDER_VALUES[3] + 1, this.SLIDER_VALUES);
                }
            } else if(this.isKeyDown(KeyEvent.VK_S)) {
                if(this.TOGGLE_STATES[0]) {
                    this.HandleSlider(gui.FT_Spring_SpringConstant_Slider, 0, this.SLIDER_VALUES[0] - 10, this.SLIDER_VALUES);
                } else if(this.TOGGLE_STATES[2]) {
                    this.HandleSlider(gui.FT_Motor_TargetAngularVelocity_Slider, 3, this.SLIDER_VALUES[3] - 1, this.SLIDER_VALUES);
                }
            } else if(this.isKeyDown(KeyEvent.VK_A)) {
                if(this.TOGGLE_STATES[0]) {
                    this.HandleSlider(gui.FT_Spring_EquilibriumLength_Slider, 1, this.SLIDER_VALUES[1] - 1, this.SLIDER_VALUES);
                } else if(this.TOGGLE_STATES[2]) {
                    this.HandleSlider(gui.FT_Motor_TargetAngularVelocity_Slider, 3, this.SLIDER_VALUES[3] - 1, this.SLIDER_VALUES);
                }
            } else if(this.isKeyDown(KeyEvent.VK_D)) {
                if(this.TOGGLE_STATES[0]) {
                    this.HandleSlider(gui.FT_Spring_EquilibriumLength_Slider, 1, this.SLIDER_VALUES[1] + 1, this.SLIDER_VALUES);
                } else if(this.TOGGLE_STATES[2]) {
                    this.HandleSlider(gui.FT_Motor_TargetAngularVelocity_Slider, 3, this.SLIDER_VALUES[3] + 1, this.SLIDER_VALUES);
                }
            } else if(this.isKeyDown(KeyEvent.VK_Q)) {
                if(this.TOGGLE_STATES[0]) {
                    this.HandleSlider(gui.FT_Spring_Damping_Slider, 2, this.SLIDER_VALUES[2] - 0.1f, this.SLIDER_VALUES);
                } else if(this.TOGGLE_STATES[2]) {
                    this.HandleSlider(gui.FT_Motor_TargetAngularVelocity_Slider, 3, this.SLIDER_VALUES[3] - 1, this.SLIDER_VALUES);
                }
            } else if(this.isKeyDown(KeyEvent.VK_E)) {
                if(this.TOGGLE_STATES[0]) {
                    this.HandleSlider(gui.FT_Spring_Damping_Slider, 2, this.SLIDER_VALUES[2] + 0.1f, this.SLIDER_VALUES);
                } else if(this.TOGGLE_STATES[2]) {
                    this.HandleSlider(gui.FT_Motor_TargetAngularVelocity_Slider, 3, this.SLIDER_VALUES[3] + 1, this.SLIDER_VALUES);
                }
            }
        } else {
            if(this.isKeyDown(KeyEvent.VK_1)) {
                if(!this.TOGGLE_STATES[0]) {
                    this.HandleToggle(gui.FT_Spring_Toggle, 0, true, this.TOGGLE_STATES);
                    this.HandleToggle(gui.FT_Rod_Toggle, 1, false, this.TOGGLE_STATES);
                    this.HandleToggle(gui.FT_Motor_Toggle, 2, false, this.TOGGLE_STATES);
                } else {
                    this.HandleToggle(gui.FT_Spring_Toggle, 0, false, this.TOGGLE_STATES);
                }
                this.VisibilityResponse();
            } else if(this.isKeyDown(KeyEvent.VK_2)) {
                if(!this.TOGGLE_STATES[1]) {
                    this.HandleToggle(gui.FT_Spring_Toggle, 0, false, this.TOGGLE_STATES);
                    this.HandleToggle(gui.FT_Rod_Toggle, 1, true, this.TOGGLE_STATES);
                    this.HandleToggle(gui.FT_Motor_Toggle, 2, false, this.TOGGLE_STATES);
                } else {
                    this.HandleToggle(gui.FT_Rod_Toggle, 1, false, this.TOGGLE_STATES);
                }
                this.VisibilityResponse();
            } else if(this.isKeyDown(KeyEvent.VK_3)) {
                if(!this.TOGGLE_STATES[2]) {
                    this.HandleToggle(gui.FT_Spring_Toggle, 0, false, this.TOGGLE_STATES);
                    this.HandleToggle(gui.FT_Rod_Toggle, 1, false, this.TOGGLE_STATES);
                    this.HandleToggle(gui.FT_Motor_Toggle, 2, true, this.TOGGLE_STATES);
                } else {
                    this.HandleToggle(gui.FT_Motor_Toggle, 2, false, this.TOGGLE_STATES);
                }
                this.VisibilityResponse();
            } else if(this.isKeyDown(KeyEvent.VK_4)) {
                if(this.TOGGLE_STATES[0]) {
                    if(!this.TOGGLE_STATES[3]) {
                        this.HandleToggle(gui.FT_Spring_LockToX_Toggle, 3, true, this.TOGGLE_STATES);
                        this.HandleToggle(gui.FT_Spring_LockToY_Toggle, 4, false, this.TOGGLE_STATES);
                    } else {
                        this.HandleToggle(gui.FT_Spring_LockToX_Toggle, 3, false, this.TOGGLE_STATES);
                    }
                } else if(this.TOGGLE_STATES[1]) {
                        this.HandleToggle(gui.FT_Rod_IsJoint_Toggle, 6, !this.TOGGLE_STATES[6], this.TOGGLE_STATES);
                } else if(this.TOGGLE_STATES[2]) {
                    if(!this.TOGGLE_STATES[7]) {
                        this.HandleToggle(gui.FT_Motor_DrawMotor_Toggle, 7, true, this.TOGGLE_STATES);
                        this.HandleToggle(gui.FT_Motor_DrawMotorForce_Toggle, 8, false, this.TOGGLE_STATES);
                    } else {
                        this.HandleToggle(gui.FT_Motor_DrawMotor_Toggle, 7, false, this.TOGGLE_STATES);
                    }
                }
            } else if(this.isKeyDown(KeyEvent.VK_5)) {
                if(this.TOGGLE_STATES[0]) {
                    if(!this.TOGGLE_STATES[4]) {
                        this.HandleToggle(gui.FT_Spring_LockToX_Toggle, 3, false, this.TOGGLE_STATES);
                        this.HandleToggle(gui.FT_Spring_LockToY_Toggle, 4, true, this.TOGGLE_STATES);
                    } else {
                        this.HandleToggle(gui.FT_Spring_LockToY_Toggle, 4, false, this.TOGGLE_STATES);
                    }
                } else if(this.TOGGLE_STATES[2]) {
                    if(!this.TOGGLE_STATES[8]) {
                        this.HandleToggle(gui.FT_Motor_DrawMotor_Toggle, 7, false, this.TOGGLE_STATES);
                        this.HandleToggle(gui.FT_Motor_DrawMotorForce_Toggle, 8, true, this.TOGGLE_STATES);
                    } else {
                        this.HandleToggle(gui.FT_Motor_DrawMotorForce_Toggle, 8, false, this.TOGGLE_STATES);
                    }
                }
            } else if(this.isKeyDown(KeyEvent.VK_6)) {
                if(this.TOGGLE_STATES[0]) {
                    this.HandleToggle(gui.FT_Spring_PerfectSpring_Toggle, 5, !this.TOGGLE_STATES[5], this.TOGGLE_STATES);
                }
            }
        }
    }

/*
====================================================================================================
======================================= Getters and Setters ========================================
====================================================================================================
*/  
    public void setToggleState(int index, boolean state) {
        this.TOGGLE_STATES[index] = state;
    }

    public void setSliderValue(int index, float value) {
        this.SLIDER_VALUES[index] = value;
    }
}
