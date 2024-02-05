
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
        Rigidbody rigidbody = interactivityListener.getClickedRigidbody();

        if(rigidbody != null) {
            ArrayList<ForceRegistry> forceRegistry = rigidbody.getForceRegistry();
            
            for(ForceRegistry force : forceRegistry) {
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
            if(userInterface.getTab("Rigidbodies").isActive()) {
                if(userInterface.getController("Angle").getValue() == -360) {
                    userInterface.getController("Angle").setValue(360);
                } else {
                    userInterface.getController("Angle").setValue(userInterface.getController("Angle").getValue() - 10);
                }
            }
        } else {
            if(userInterface.getTab("Rigidbodies").isActive()) {
                if(userInterface.getController("Angle").getValue() == -360) {
                    userInterface.getController("Angle").setValue(360);
                } else {
                    userInterface.getController("Angle").setValue(userInterface.getController("Angle").getValue() - 1);
                }
            }
        }
    }

    /*

      if(ctrlEPressed) {
        Rigidbody newClickedRigidbody = interactivityListener.getClickedRigidbody();
        if(newClickedRigidbody != null){
            interactivityListener.updateGUIValues(clickedRigidbody);
            interactivityListener.editRigidbody = true;
        }
    } else
*/
    /* ------------ FIX THIS ---------------- */

   if(ePressed) {
        if(shiftPressed){
            if(userInterface.getTab("Rigidbodies").isActive()) {
                if(userInterface.getController("Angle").getValue() == 360) {
                    userInterface.getController("Angle").setValue(-360);
                } else {
                    userInterface.getController("Angle").setValue(userInterface.getController("Angle").getValue() + 10);
                }
            }
        } else {
            if(userInterface.getTab("Rigidbodies").isActive()) {
                if(userInterface.getController("Angle").getValue() == 360) {
                    userInterface.getController("Angle").setValue(-360);
                } else {
                    userInterface.getController("Angle").setValue(userInterface.getController("Angle").getValue() + 1);
                }
            }
        }
    } 
/*----------------------------------------------------------------------------------- */

    

    if(key == '1') {
        if(userInterface.getTab("Forces").isActive()) {
            if(userInterface.getController("AddSpring").getValue() == 0){
                userInterface.getController("AddSpring").setValue(1);
                userInterface.getController("AddRod").setValue(0);
                userInterface.getController("AddMotor").setValue(0);
            } else {
                userInterface.getController("AddSpring").setValue(0);
                userInterface.getController("AddRod").setValue(0);
                userInterface.getController("AddMotor").setValue(0);
            }

        } else if(userInterface.getTab("Rigidbodies").isActive()) {
            if(userInterface.getController("Circle").getValue() == 0){
                userInterface.getController("Circle").setValue(1);
                userInterface.getController("Box").setValue(0);
            } else {
                userInterface.getController("Circle").setValue(0);
                userInterface.getController("Box").setValue(0);               
            }
        }
    }
    if(key == '2') {
        if(userInterface.getTab("Forces").isActive()) {
            if(userInterface.getController("AddRod").getValue() == 0){
                userInterface.getController("AddSpring").setValue(0);
                userInterface.getController("AddRod").setValue(1);
                userInterface.getController("AddMotor").setValue(0);
            } else {
                userInterface.getController("AddSpring").setValue(0);
                userInterface.getController("AddRod").setValue(0);
                userInterface.getController("AddMotor").setValue(0);
            }

        } else if(userInterface.getTab("Rigidbodies").isActive()) {
            if(userInterface.getController("Box").getValue() == 0){
                userInterface.getController("Circle").setValue(0);
                userInterface.getController("Box").setValue(1);
            } else {
                userInterface.getController("Circle").setValue(0);
                userInterface.getController("Box").setValue(0);               
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
        if(userInterface.getTab("Rigidbodies").isActive()) {
            if(userInterface.getController("isStatic").getValue() == 1) {
                userInterface.getController("isStatic").setValue(0);
            } else {
                userInterface.getController("isStatic").setValue(1);
            }

            userInterface.getController("transStatic").setValue(0);
            userInterface.getController("rotStatic").setValue(0);

        } else if(userInterface.getTab("Forces").isActive()) {
            if(userInterface.getController("AddSpring").getValue() == 1) {
                if(userInterface.getController("SpringLockToX").getValue() == 1) {
                    userInterface.getController("SpringLockToX").setValue(0);
                } else {
                    userInterface.getController("SpringLockToX").setValue(1);
                }
            } else if(userInterface.getController("AddRod").getValue() == 1) {
                if(userInterface.getController("RodIsHingeable").getValue() == 0){
                    userInterface.getController("RodIsHingeable").setValue(1);
                } else {
                    userInterface.getController("RodIsHingeable").setValue(0);
                }
            }
        }
    }

    if(key == '5') {
        if(userInterface.getTab("Rigidbodies").isActive()) {
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

    if(key == TAB) {
        if(switchTab) {
            userInterface.getTab("Rigidbodies").bringToFront();

        } else {
            userInterface.getTab("Forces").bringToFront();
        }   
        switchTab = !switchTab;
    }

    if(aPressed) {
        if(shiftPressed) {
            if(userInterface.getTab("Rigidbodies").isActive()) {
                if(userInterface.getController("Circle").getValue() == 1) {
                    userInterface.getController("CircleRadius").setValue(userInterface.getController("CircleRadius").getValue() - 0.5f);
                }
                if(userInterface.getController("Box").getValue() == 1) {
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
                if(userInterface.getController("Circle").getValue() == 1) {
                    userInterface.getController("CircleRadius").setValue(userInterface.getController("CircleRadius").getValue() - 0.05f);
                }
                if(userInterface.getController("Box").getValue() == 1) {
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
                if(userInterface.getController("Circle").getValue() == 1) {
                    userInterface.getController("CircleRadius").setValue(userInterface.getController("CircleRadius").getValue() + 0.5f);
                }
                if(userInterface.getController("Box").getValue() == 1) {
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
                if(userInterface.getController("Circle").getValue() == 1) {
                    userInterface.getController("CircleRadius").setValue(userInterface.getController("CircleRadius").getValue() + 0.05f);
                }
                if(userInterface.getController("Box").getValue() == 1) {
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

   
    if(wPressed) {
        if(shiftPressed){
            if(userInterface.getTab("Rigidbodies").isActive()) {
                if(userInterface.getController("Circle").getValue() == 1) {
                    userInterface.getController("CircleRadius").setValue(userInterface.getController("CircleRadius").getValue() + 0.5f);
                }
                if(userInterface.getController("Box").getValue() == 1) {
                    userInterface.getController("RectangleHeight").setValue(userInterface.getController("RectangleHeight").getValue() + 1f);
                }
            }
        } else {
            if(userInterface.getTab("Rigidbodies").isActive()) {
                if(userInterface.getController("Circle").getValue() == 1) {
                    userInterface.getController("CircleRadius").setValue(userInterface.getController("CircleRadius").getValue() + 0.05f);
                }
                if(userInterface.getController("Box").getValue() == 1) {
                    userInterface.getController("RectangleHeight").setValue(userInterface.getController("RectangleHeight").getValue() + 0.1f);
                }
            }
        }
    }

    if(sPressed) {
        if(shiftPressed){
            if(userInterface.getTab("Rigidbodies").isActive()) {
                if(userInterface.getController("Circle").getValue() == 1) {
                    userInterface.getController("CircleRadius").setValue(userInterface.getController("CircleRadius").getValue() - 0.5f);
                }
                if(userInterface.getController("Box").getValue() == 1) {
                    userInterface.getController("RectangleHeight").setValue(userInterface.getController("RectangleHeight").getValue() - 1f);
                }
            }
        } else {
            if(userInterface.getTab("Rigidbodies").isActive()) {
                if(userInterface.getController("Circle").getValue() == 1) {
                    userInterface.getController("CircleRadius").setValue(userInterface.getController("CircleRadius").getValue() - 0.05f);
                }
                if(userInterface.getController("Box").getValue() == 1) {
                    userInterface.getController("RectangleHeight").setValue(userInterface.getController("RectangleHeight").getValue() - 0.1f);
                }
            }
        }
    }




    if(ctrlCPressed) {
        interactivityListener.updateGUIValues(interactivityListener.getClickedRigidbody());
    }

    if(ctrlVPressed) {
        //interactivityListener.GenerateRigidbody();
    }

    if(deletePressed) {
        if(isInEditMode) {
            editor.whileEditorSelect(2);
        }
    }

}

void keyReleased() {

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
        if(shiftPressed) {
            clickedRigidbody = interactivityListener.getClickedRigidbody();

            if(clickedRigidbody != null){
                if(firstTime){
                    mouseSpringAdded = true;
                    PVector mouseCoordinates = interactivityListener.screenToWorld();
                    PVector localAnchorA = PhysEngMath.Transform(PhysEngMath.SnapController(interactivityListener, this.clickedRigidbody, mouseCoordinates), -this.clickedRigidbody.getAngle());
                    //PVector localAnchorA = PhysEngMath.Transform(PVector.sub(mouseCoordinates, clickedRigidbody.getPosition()), -clickedRigidbody.getAngle());

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
            interactivityListener.mouseDown = true;
            interactivityListener.initialMousePosition.set(interactivityListener.screenToWorld());
            /* Velocity Calculation Stuff */
        } 
    }
}

public void mouseReleased(){
    if(mouseButton == LEFT){

        interactivityListener.mouseDown = false;

        if(mouseSpringAdded && clickedRigidbody != null){
            mouseSpringAdded = false;
            clickedRigidbody.removeForceFromForceRegistry(mouseSpring);
        } else {
            if(userInterface.getTab("Rigidbodies").isActive() && !userInterface.getTab("Forces").isActive()) {
                interactivityListener.GenerateRigidbody();
            } else if(userInterface.getTab("Forces").isActive() && !userInterface.getTab("Rigidbodies").isActive()) {
                interactivityListener.addSelectedRigidbody();
                interactivityListener.updateSelectedRigidbodies();
                interactivityListener.createForces();
            }
        }
    }
}

public void mouseClicked() {
    if(mouseButton == LEFT) {
        if(ctrlVPressed) {
            Rigidbody rigidbody = interactivityListener.getClickedRigidbody();
            if(!isInEditMode && rigidbody != null) {
                isInEditMode = true;
                editor.onEditorSelect(rigidbody);
                System.out.println("In Edit mode");
                return;
            } else if(isInEditMode) {
                isInEditMode = false;
                editor.onEditorDeselect();
                System.out.println("Out of Edit mode");
                return;
            }
        }

        editor.whileEditorSelect(0);
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
            PVector mousePos = interactivityListener.screenToWorld();
            mouseSpring.setAnchorPoint(mousePos.x, mousePos.y);
        } else if(isInEditMode) {
            editor.whileEditorSelect(1);
        }
    }
}


public boolean IsMouseOverUI() {
  if(userInterface.isMouseOver() || gui.calculateGroupPositionX() < mouseX && mouseX < gui.calculateGroupPositionX() + gui.globalGroupWidth &&  gui.calculateGroupPositionY() < mouseY && mouseY <  gui.calculateGroupPositionY() +  gui.globalGroupHeight) {
    return true;
    } else {
    return false;
    }
}
