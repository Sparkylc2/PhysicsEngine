
public int qCount = 0;
public boolean switchTab = true;

public boolean onePressed = false;
public boolean twoPressed = false;
public boolean threePressed = false;
public boolean fourPressed = false;
public boolean fivePressed = false;
public boolean sixPressed = false;

public boolean dPressed = false;
public boolean shiftPressed = false;
public boolean tabPressed = false;
public boolean wPressed = false;
public boolean sPressed = false;
public boolean aPressed = false;
public boolean qPressed = false;
public boolean cPressed = false;
public boolean rPressed = false;
public boolean ePressed = false;

public void keyPressed() {
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

    if(key == ' ') {
        isPaused = !isPaused;
    }
    if(key == 'r') {
        rigidbodyList.clear();
        softbodyList.clear();
    }
    if(key == BACKSPACE || key == DELETE) {

        Rigidbody rigidbody = interactivityListener.getClickedRigidbody();
        if(rigidbody != null) {
            rigidbodyList.remove(rigidbody);
        }
    }
    if(key == 'c') {
        interactivityListener.position = new PVector(-50, -50);
        interactivityListener.zoom = 10f;
    }
    if((key == 'b' || key == 'B') && (userInterface.getController("Box").getValue() == 1)) {
        Softbody softbody = new Softbody(interactivityListener.screenToWorld(mouseX, mouseY), 0, interactivityListener.getWidth(), interactivityListener.getHeight());
        softbody.CreateBoxSoftbody();
    }

    if(key == 'q' || key == 'Q') {
        if(userInterface.getTab("Forces").isActive()){
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
    }

    if(qPressed) {
        if(shiftPressed) {
            if(userInterface.getTab("Rigidbodies").isActive()) {
                userInterface.getController("Angle").setValue(userInterface.getController("Angle").getValue() - 10);
            }
        } else {
            if(userInterface.getTab("Rigidbodies").isActive()) {
                userInterface.getController("Angle").setValue(userInterface.getController("Angle").getValue() - 1);
            }
        }
    }

    if(ePressed) {
        if(shiftPressed){
            if(userInterface.getTab("Rigidbodies").isActive()) {
                userInterface.getController("Angle").setValue(userInterface.getController("Angle").getValue() + 10);
            }
        } else {
            if(userInterface.getTab("Rigidbodies").isActive()) {
                userInterface.getController("Angle").setValue(userInterface.getController("Angle").getValue() + 1);
            }
        }
    }

 

    if(key == '1') {
        if(userInterface.getTab("Forces").isActive()) {
            userInterface.getController("AddSpring").setValue(1);
            userInterface.getController("AddRod").setValue(0);
            userInterface.getController("AddMotor").setValue(0);

        } else if(userInterface.getTab("Rigidbodies").isActive()) {
            userInterface.getController("Circle").setValue(1);
            userInterface.getController("Box").setValue(0);
        }
    }
    if(key == '2') {
        if(userInterface.getTab("Forces").isActive()) {
            userInterface.getController("AddSpring").setValue(0);
            userInterface.getController("AddRod").setValue(1);
            userInterface.getController("AddMotor").setValue(0);

        } else if(userInterface.getTab("Rigidbodies").isActive()) {
            userInterface.getController("Circle").setValue(0);
            userInterface.getController("Box").setValue(1);
        }
    }
    if(key == '3') {
        if(userInterface.getTab("Forces").isActive()) {
            userInterface.getController("AddSpring").setValue(0);
            userInterface.getController("AddRod").setValue(0);
            userInterface.getController("AddMotor").setValue(1);
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
}

void keyReleased() {
    if (key == 'd' || key == 'D') {
        dPressed = false;
    }
    if (keyCode == SHIFT) {
        shiftPressed = false;
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
}
public void mouseClicked() {
    System.out.println(interactivityListener.screenToWorld(mouseX, mouseY));
    //Checks if the mouse is over the user in terface, if it isnt, continues
    if(!userInterface.isMouseOver()) {
        //If the user has selected a shape, generate a rigidbody
        if(interactivityListener.getGenerateRigidbodies() && !interactivityListener.getGenerateForces()) {
            interactivityListener.GenerateRigidbody();
        }
        if(interactivityListener.getGenerateForces() && !interactivityListener.getGenerateRigidbodies()) {
            interactivityListener.addSelectedRigidbody();
            interactivityListener.updateSelectedRigidbodies();
            interactivityListener.createForces();
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
