
public int qCount = 0;
public boolean switchTab = true;


public boolean firstTime = true;
public Spring mouseSpring;
public boolean mouseSpringAdded = false;
public boolean rigidbodySelected = false;
public boolean isInEditMode = false;

public Rigidbody clickedRigidbody;

public boolean mouseDown = false;

public boolean shiftPressed = false;
public boolean tabPressed = false;
public boolean deletePressed = false;
public boolean ctrlEPressed = false;
public boolean ctrlCPressed = false;
public boolean ctrlVPressed = false;

public boolean onePressed = false;
public boolean twoPressed = false;
public boolean threePressed = false;
public boolean fourPressed = false;
public boolean fivePressed = false;
public boolean sixPressed = false;


public boolean dPressed = false;
public boolean wPressed = false;
public boolean sPressed = false;
public boolean aPressed = false;
public boolean qPressed = false;
public boolean cPressed = false;
public boolean rPressed = false;
public boolean ePressed = false;
public boolean vPressed = false;

public void keyPressed() {
    InteractionCache.onKeyPressed(keyCode);
    InteractionCache.keyPressedResponse();
    
    if(keyCode == ENTER) {
        Mouse.getMouseObjectResults().clear();
    }
    if(keyCode == BACKSPACE) {
        deletePressed = true;
    }
    if(key == 'c' || key == 'C') {

        cPressed = true;
    }
    
    if (key == 'd' || key == 'D') {
        dPressed = true;
    }

    if (key == 'w' || key == 'W') {
        wPressed = true;
    }
    if (key == 's' || key == 'S') {
        sPressed = true;
    }

    if (key == 'a' || key == 'A') {
        aPressed = true;
    }

    if(key == 'q' || key == 'Q') {
        qPressed = true;
    }

    if(key == 'e' || key == 'E') {
        ePressed = true;
    }
    if (keyCode == SHIFT) {
        shiftPressed = true;
    }

    if(key == 'v' || key == 'V') {
        vPressed = true;
    }

    if(key == ' ') {
        isPaused = !isPaused;
    }
    if(key == 'r') {
        rigidbodyList.clear();
        ALL_FORCES_ARRAYLIST.clear();
        softbodyList.clear();
    }
    if(keyCode == BACKSPACE || keyCode == DELETE) {

        Rigidbody rigidbody = Mouse.getRigidbodyUnderMouse();
        if(rigidbody != null) {
            ArrayList<ForceRegistry> forceRegistry = rigidbody.getForceRegistry();
            for(ForceRegistry force : forceRegistry) {
                Rigidbody rigidbodyA = force.getRigidbodyA();
                Rigidbody rigidbodyB = force.getRigidbodyB();

                if((rigidbodyA == null && rigidbodyB != null) || (rigidbodyA != null && rigidbodyB == null)) {
                    ALL_FORCES_ARRAYLIST.remove(force);
                } else if(rigidbodyA != rigidbody && rigidbodyA != null) {
                    rigidbodyA.removeForceFromForceRegistry(force);
                } else if(rigidbodyB != rigidbody && rigidbodyB != null) {
                    rigidbodyB.removeForceFromForceRegistry(force);
                }

                ALL_FORCES_ARRAYLIST.remove(force);
            }
            rigidbodyList.remove(rigidbody);
        }
    }
    if(key == 69 || key == 101) {
        ctrlEPressed = true;
    }
    if(key == 67 || key == 99) {
        ctrlCPressed = true;
    }
    if(key == 86 || key == 118) {
        ctrlVPressed = true;
    }


    if(key == 'f') {
        levelEditor.saveLevelState();
    }
    if(key == 'g') {
        loadLevel = true;
    }

    if(key == 'm') {
        interactivityListener.position = new PVector(-50, -50);
        interactivityListener.zoom = 10f;
    }

    /*
    if(key == 'z' || key == 'Z') {
            qCount++;
            if(qCount == 1) {
                interactivityListener.setSnapToCenter(true);
                interactivityListener.setSnapToEdge(false);
    
                if(userInterface.getController("AddSpring").getValue() == 1) {
                    userInterface.getController("SpringSnapToCenter").setValue(1);
                    userInterface.getController("SpringSnapToEdge").setValue(0);
                } else if(userInterface.getController("AddRod").getValue() == 1) {
                    userInterface.getController("RodSnapToCenter").setValue(1);
                    userInterface.getController("RodSnapToEdge").setValue(0);
                }
            } else if(qCount == 2) {
                interactivityListener.setSnapToCenter(false);
                interactivityListener.setSnapToEdge(true);
    
                if(userInterface.getController("AddSpring").getValue() == 1) {
                    userInterface.getController("SpringSnapToCenter").setValue(0);
                    userInterface.getController("SpringSnapToEdge").setValue(1);
                } else if(userInterface.getController("AddRod").getValue() == 1) {
                    userInterface.getController("RodSnapToCenter").setValue(0);
                    userInterface.getController("RodSnapToEdge").setValue(1);
                }
            } else if(qCount == 3) {
                interactivityListener.setSnapToCenter(false);
                interactivityListener.setSnapToEdge(false);
    
                if(userInterface.getController("AddSpring").getValue() == 1) {
                    userInterface.getController("SpringSnapToCenter").setValue(0);
                    userInterface.getController("SpringSnapToEdge").setValue(0);
                } else if(userInterface.getController("AddRod").getValue() == 1) {
                    userInterface.getController("RodSnapToCenter").setValue(0);
                    userInterface.getController("RodSnapToEdge").setValue(0);
                }
                qCount = 0;
            }
    }

    if(qPressed) {
        if(shiftPressed) {
            if(InteractionCache.getActiveTabID() == 0) {
                if(userInterface.getController("Angle").getValue() == -360) {
                    userInterface.getController("Angle").setValue(360);
                } else {
                    userInterface.getController("Angle").setValue(userInterface.getController("Angle").getValue() - 10);
                }
            }
        } else {
            if(InteractionCache.getActiveTabID() == 0) {
                if(userInterface.getController("Angle").getValue() == -360) {
                    userInterface.getController("Angle").setValue(360);
                } else {
                    userInterface.getController("Angle").setValue(userInterface.getController("Angle").getValue() - 1);
                }
            }
        }
    }

    

      if(ctrlEPressed) {
        Rigidbody newClickedRigidbody = interactivityListener.getClickedRigidbody();
        if(newClickedRigidbody != null){
            interactivityListener.updateGUIValues(clickedRigidbody);
            interactivityListener.editRigidbody = true;
        }
    } else


   if(ePressed) {
        if(shiftPressed){
            if(InteractionCache.getActiveTabID() == 0) {
                if(userInterface.getController("Angle").getValue() == 360) {
                    userInterface.getController("Angle").setValue(-360);
                } else {
                    userInterface.getController("Angle").setValue(userInterface.getController("Angle").getValue() + 10);
                }
            }
        } else {
            if(InteractionCache.getActiveTabID() == 0){
                if(userInterface.getController("Angle").getValue() == 360) {
                    userInterface.getController("Angle").setValue(-360);
                } else {
                    userInterface.getController("Angle").setValue(userInterface.getController("Angle").getValue() + 1);
                }
            }
        }
    } 


    

    if(key == '1') {
        if(InteractionCache.getActiveTabID() == 1){
            if(userInterface.getController("AddSpring").getValue() == 0){
                userInterface.getController("AddSpring").setValue(1);
                userInterface.getController("AddRod").setValue(0);
                userInterface.getController("AddMotor").setValue(0);
            } else {
                userInterface.getController("AddSpring").setValue(0);
                userInterface.getController("AddRod").setValue(0);
                userInterface.getController("AddMotor").setValue(0);
            }

        } else if(InteractionCache.getActiveTabID() == 0){
            if(InteractionCache.getActiveShapeSelectedID() != 0){
                gui.ShapeSelector.activate(0);
            } else {
                gui.ShapeSelector.deactivateAll();
            }
        }
    }
    if(key == '2') {
        if(InteractionCache.getActiveTabID() == 1) {
            if(userInterface.getController("AddRod").getValue() == 0){
                userInterface.getController("AddSpring").setValue(0);
                userInterface.getController("AddRod").setValue(1);
                userInterface.getController("AddMotor").setValue(0);
            } else {
                userInterface.getController("AddSpring").setValue(0);
                userInterface.getController("AddRod").setValue(0);
                userInterface.getController("AddMotor").setValue(0);
            }

        } else if(InteractionCache.getActiveTabID()==0) {
            if(InteractionCache.getActiveShapeSelectedID() != 1){
               gui.ShapeSelector.activate(1);
            } else {
                gui.ShapeSelector.deactivateAll();
            }
        }
    }
    if(key == '3') {
        if(userInterface.getTab("Forces").isActive()) {
            if(userInterface.getController("AddMotor").getValue() == 0){
                userInterface.getController("AddSpring").setValue(0);
                userInterface.getController("AddRod").setValue(0);
                userInterface.getController("AddMotor").setValue(1);
            } else {
                userInterface.getController("AddSpring").setValue(0);
                userInterface.getController("AddRod").setValue(0);
                userInterface.getController("AddMotor").setValue(0);
            }
        }
    }

    if(key == '4') {
        if(InteractionCache.getActiveTabID() == 0){
            if(userInterface.getController("isStatic").getValue() == 1) {
                userInterface.getController("isStatic").setValue(0);
            } else {
                userInterface.getController("isStatic").setValue(1);
            }

            userInterface.getController("transStatic").setValue(0);
            userInterface.getController("rotStatic").setValue(0);

        } else if(InteractionCache.getActiveTabID() == 1){
            if(userInterface.getController("AddSpring").getValue() == 1) {
                if(userInterface.getController("SpringLockToX").getValue() == 1) {
                    userInterface.getController("SpringLockToX").setValue(0);
                } else {
                    userInterface.getController("SpringLockToX").setValue(1);
                }
            }
        }
    }

    if(key == '5') {
        if(InteractionCache.getActiveTabID() == 0){
            if(userInterface.getController("transStatic").getValue() == 1) {
                userInterface.getController("transStatic").setValue(0);
            } else {
                userInterface.getController("transStatic").setValue(1);
            }

            userInterface.getController("isStatic").setValue(0);
            userInterface.getController("rotStatic").setValue(0);
        } else if(userInterface.getTab("Forces").isActive()) {
            if(userInterface.getController("AddSpring").getValue() == 1){
                if(userInterface.getController("SpringLockToY").getValue() == 1) {
                    userInterface.getController("SpringLockToY").setValue(0);
                } else {
                    userInterface.getController("SpringLockToY").setValue(1);
                }
            } else if(userInterface.getController("AddRod").getValue() == 1) {
                if(userInterface.getController("RodIsJoint").getValue() == 0) {
                    userInterface.getController("RodIsJoint").setValue(1);
                } else {
                    userInterface.getController("RodIsJoint").setValue(0);
                }
            }
        }
    }

    if(key == '6') {
        if(userInterface.getTab("Rigidbodies").isActive()) {
            if(userInterface.getController("rotStatic").getValue() == 1) {
                userInterface.getController("rotStatic").setValue(0);
            } else {
                userInterface.getController("rotStatic").setValue(1);
            }

            userInterface.getController("isStatic").setValue(0);
            userInterface.getController("transStatic").setValue(0);
        }
    }
*/
    if(key == TAB) {
        if(switchTab) {
            userInterface.getTab("Rigidbodies").bringToFront();

        } else {
            userInterface.getTab("Forces").bringToFront();
        }   
        switchTab = !switchTab;
    }
/*
    if(aPressed) {
        if(shiftPressed) {
            if(userInterface.getTab("Rigidbodies").isActive()) {
                if(InteractionCache.getActiveShapeSelectedID() == 0) {
                    userInterface.getController("CircleRadius").setValue(userInterface.getController("CircleRadius").getValue() - 0.5f);
                }
                if(InteractionCache.getActiveShapeSelectedID() == 1) {
                    userInterface.getController("RectangleWidth").setValue(userInterface.getController("RectangleWidth").getValue() - 1f);
                }
            } else if(userInterface.getTab("Forces").isActive()) {
                if(userInterface.getController("AddSpring").getValue() == 1) {
                    userInterface.getController("SpringConstant").setValue(userInterface.getController("SpringConstant").getValue() - 20f);
                }
                if(userInterface.getController("AddMotor").getValue() == 1) {
                    userInterface.getController("MotorTargetAngularVelocity").setValue(userInterface.getController("MotorTargetAngularVelocity").getValue() - 1f);
                }
            }
        } else {
            if(userInterface.getTab("Rigidbodies").isActive()) {
                if(InteractionCache.getActiveShapeSelectedID() == 0) {
                    userInterface.getController("CircleRadius").setValue(userInterface.getController("CircleRadius").getValue() - 0.05f);
                }
                if(InteractionCache.getActiveShapeSelectedID() == 1){
                    userInterface.getController("RectangleWidth").setValue(userInterface.getController("RectangleWidth").getValue() - 0.1f);
                }
            } else if(userInterface.getTab("Forces").isActive()) {
                if(userInterface.getController("AddSpring").getValue() == 1) {
                    userInterface.getController("SpringConstant").setValue(userInterface.getController("SpringConstant").getValue() - 1f);
                }
                if(userInterface.getController("AddMotor").getValue() == 1) {
                    userInterface.getController("MotorTargetAngularVelocity").setValue(userInterface.getController("MotorTargetAngularVelocity").getValue() - 0.1f);
                }
            }
        }
    }

    if(dPressed) {
        if(shiftPressed){
            if(userInterface.getTab("Rigidbodies").isActive()) {
                if(InteractionCache.getActiveShapeSelectedID() == 0){
                    userInterface.getController("CircleRadius").setValue(userInterface.getController("CircleRadius").getValue() + 0.5f);
                }
                if(InteractionCache.getActiveShapeSelectedID() == 1){
                    userInterface.getController("RectangleWidth").setValue(userInterface.getController("RectangleWidth").getValue() + 1f);
                }
            } else if(userInterface.getTab("Forces").isActive()) {
                if(userInterface.getController("AddSpring").getValue() == 1) {
                    userInterface.getController("SpringConstant").setValue(userInterface.getController("SpringConstant").getValue() + 20f);
                }
                if(userInterface.getController("AddMotor").getValue() == 1) {
                    userInterface.getController("MotorTargetAngularVelocity").setValue(userInterface.getController("MotorTargetAngularVelocity").getValue() + 1f);
                }
            }
        } else {
            if(userInterface.getTab("Rigidbodies").isActive()) {
                if(InteractionCache.getActiveShapeSelectedID() == 0){
                    userInterface.getController("CircleRadius").setValue(userInterface.getController("CircleRadius").getValue() + 0.05f);
                }
                if(InteractionCache.getActiveShapeSelectedID() == 1) {
                    userInterface.getController("RectangleWidth").setValue(userInterface.getController("RectangleWidth").getValue() + 0.1f);
                }
            } else if(userInterface.getTab("Forces").isActive()) {
                if(userInterface.getController("AddSpring").getValue() == 1) {
                    userInterface.getController("SpringConstant").setValue(userInterface.getController("SpringConstant").getValue() + 1f);
                }
                if(userInterface.getController("AddMotor").getValue() == 1) {
                    userInterface.getController("MotorTargetAngularVelocity").setValue(userInterface.getController("MotorTargetAngularVelocity").getValue() + 0.1f);
                }
            }
        }
    }

   






    if(ctrlCPressed) {
        //interactivityListener.updateGUIValues(Mouse.getRigidbodyUnderMouse());
    }

    if(ctrlVPressed) {
        //interactivityListener.GenerateRigidbody();
    }

    if(deletePressed) {
        if(isInEditMode) {
            editor.whileEditorSelect(2);
        }
    }
    */

}

void keyReleased() {  
    InteractionCache.onKeyReleased(keyCode);
    if(keyCode == BACKSPACE) {
        deletePressed = false;
    }
    if (key == 'd' || key == 'D') {
        dPressed = false;
    }

    if (keyCode == SHIFT) {
        shiftPressed = false;
    }

    if(key == 'c' || key == 'C') {
        cPressed = false;
    }

    if(key == 67 || key == 99) {
        ctrlCPressed = false;
    }
    if(key == 86 || key == 118) {
        ctrlVPressed = false;
    }
    if(key == 69 || key == 101) {
        ctrlEPressed = false;
    }

    if (key == 'w' || key == 'W') {
        wPressed = false;
    }
    if (key == 's' || key == 'S') {
        sPressed = false;
    }
    if (key == 'a' || key == 'A') {
        aPressed = false;
    }
    if(key == 'q' || key == 'Q') {
        qPressed = false;
    }
    if(key == 'e' || key == 'E') {
        ePressed = false;
    }
    if(key == 'v' || key == 'V') {
        vPressed = false;
    }

}


public void mousePressed(){
    if(mouseButton == LEFT){
        Mouse.updateMouseDownCoordinates();
        if(shiftPressed) {
            clickedRigidbody = Mouse.getCurrentRigidbodyUnderMouse();

            if(clickedRigidbody != null){
                if(firstTime){
                    mouseSpringAdded = true;
                    PVector mouseCoordinates = interactivityListener.screenToWorld();
                    //PVector localAnchorA = PhysEngMath.Transform(PhysEngMath.SnapController(interactivityListener, this.clickedRigidbody, mouseCoordinates), -this.clickedRigidbody.getAngle());
                    PVector localAnchorA = PhysEngMath.Transform(PhysEngMath.SnapController(interactivityListener, this.clickedRigidbody, Mouse.getMouseCoordinates()), -clickedRigidbody.getAngle());

                    mouseSpring = new Spring(clickedRigidbody, localAnchorA, mouseCoordinates);
                    mouseSpring.setSpringConstant(200f);
                    mouseSpring.setSpringLength(0f);
                    clickedRigidbody.addForceToForceRegistry(mouseSpring);
                    firstTime = false;
                } else {
                    mouseSpringAdded = true;
                    PVector mouseCoordinates = interactivityListener.screenToWorld();
                    PVector localAnchorA = PhysEngMath.Transform(PhysEngMath.SnapController(interactivityListener, this.clickedRigidbody, mouseCoordinates), -clickedRigidbody.getAngle());

                    mouseSpring.setRigidbodyA(clickedRigidbody);
                    mouseSpring.setLocalAnchorA(localAnchorA.x, localAnchorA.y);
                    mouseSpring.setAnchorPoint(mouseCoordinates.x, mouseCoordinates.y);
                    clickedRigidbody.addForceToForceRegistry(mouseSpring);
                }
            }
        } else {
            /* Velocity Calculation Stuff */
            Mouse.updateMouseDownCoordinates();
            /* Velocity Calculation Stuff */
        } 
    }
}

public void mouseReleased(){
    if(mouseButton == LEFT){
        Mouse.updateMouseUpCoordinates();
        editor.onRelease();
        if(mouseSpringAdded && clickedRigidbody != null){
            mouseSpringAdded = false;
            clickedRigidbody.removeForceFromForceRegistry(mouseSpring);
        } else {
            if(InteractionCache.getActiveTabID() == 0) {
                interactivityListener.GenerateRigidbody();
            } else if(userInterface.getTab("Forces").isActive() && !userInterface.getTab("Rigidbodies").isActive()) {
                //interactivityListener.updateSelectedRigidbodies();
                interactivityListener.createForces();
            }
        }
    }
}

public void mouseClicked() {
    if(mouseButton == LEFT){
        if(ctrlVPressed) {
            Rigidbody rigidbody = Mouse.getCurrentRigidbodyUnderMouse();
            if(!isInEditMode && rigidbody != null) {
                isInEditMode = true;
                editor.onEditorSelect(rigidbody);
                return;
            } else if(isInEditMode) {
                isInEditMode = false;
                editor.onEditorDeselect();
                return;
            }
        }
        editor.whileEditorSelect(0);
        //editor.onClick();
    }
} 

public void mouseWheel(MouseEvent event) {
    if(!userInterface.isMouseOver()) {
        float e = -event.getCount();
        interactivityListener.zoom(pow(1.1f, e), mouseX, mouseY);
    }
}

public void mouseDragged() {
    if(!userInterface.isMouseOver() && mouseButton == RIGHT){
        interactivityListener.move(pmouseX - mouseX, pmouseY - mouseY);
    }
    if(!userInterface.isMouseOver() && mouseButton == LEFT) {
        if(mouseSpringAdded){
            PVector mousePos = Mouse.getMouseCoordinates();
            mouseSpring.setAnchorPoint(mousePos.x, mousePos.y);
        } else if(isInEditMode) {
            editor.whileEditorSelect(1);
        }
        
        //editor.onDrag();
    }
}

public void mouseMoved() {
    //editor.dragSnap();
}


public boolean IsMouseOverUI() {
  if(userInterface.isMouseOver() || gui.calculateGroupPositionX() < mouseX && mouseX < gui.calculateGroupPositionX() + gui.globalGroupWidth &&  gui.calculateGroupPositionY() < mouseY && mouseY <  gui.calculateGroupPositionY() +  gui.globalGroupHeight) {
    return true;
    } else {
    return false;
    }
}
