
public void keyPressed() {
    if(key == ' ') {
        isPaused = !isPaused;
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
    
    //Checks if the mouse is over the user interface, if it isnt, continues
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
