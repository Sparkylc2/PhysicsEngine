
public void mousePressed(){
    if(mouseButton == LEFT){
        Mouse.updateMouseDownCoordinates();
        currentTabInteractionHandler.onMousePressed();
        return;
    }
}

public void mouseReleased() {
    if(mouseButton == LEFT) {
        Mouse.updateMouseUpCoordinates();
        currentTabInteractionHandler.onMouseReleased();
        return;
    }
}

public void mouseClicked() {
    currentTabInteractionHandler.onMouseClicked();
} 

public void mouseWheel(MouseEvent event) {
    if(Mouse.getIsMouseOverUI()) {
        return;
    }

    float e = -event.getCount();
    Camera.zoom(pow(1.1f, e), mouseX, mouseY);
}

public void mouseDragged() {
    if(!Mouse.getIsMouseOverUI() && mouseButton == RIGHT){
        Camera.move(pmouseX - mouseX, pmouseY - mouseY);
        return;
    }
    if(mouseButton == LEFT) {
        currentTabInteractionHandler.onMouseDragged();
    }
}

public void mouseMoved() {
    //editor.dragSnap();
}

