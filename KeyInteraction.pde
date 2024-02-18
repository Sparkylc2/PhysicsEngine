

public void keyPressed() {
    KeyAndTabHandler.onKeyPressed(keyCode);
    CurrentTabInteractionHandler.onKeyPressed();


    if(KeyAndTabHandler.isKeyDown(KeyEvent.VK_Q)) {
        PShape TabShape = UserInterface.TabObject.getTabShape();
        PShape Q = TabShape.getChild(1);
        Q.setFill(color(82, 82, 82));
        int newTabID = UserInterface.getActiveTabID() - 1;
        if (newTabID < 0) {
            newTabID = 3; // Wrap around to the highest tab id
        }
        UserInterface.setActiveTabID(newTabID);
    }
    
    if(KeyAndTabHandler.isKeyDown(KeyEvent.VK_E)) {
        PShape TabShape = UserInterface.TabObject.getTabShape();
        PShape E = TabShape.getChild(2);
        E.setFill(color(82, 82, 82));
        UserInterface.setActiveTabID((UserInterface.getActiveTabID() + 1) % 4);
    }

    if(keyCode == LEFT) {
        KeyAndTabHandler.setActiveTabID((KeyAndTabHandler.getActiveTabID() - 1) < 0 ? gui.TabCount : (KeyAndTabHandler.getActiveTabID() - 1));
        KeyAndTabHandler.setActiveTabElement(KeyAndTabHandler.getActiveTabID());
    }
    if(keyCode == RIGHT) {
        KeyAndTabHandler.setActiveTabID((KeyAndTabHandler.getActiveTabID() + 1) > gui.TabCount ? 0 : (KeyAndTabHandler.getActiveTabID() + 1));
        KeyAndTabHandler.setActiveTabElement(KeyAndTabHandler.getActiveTabID());
    }
    if(keyCode == ENTER) {
        Mouse.getMouseObjectResults().clear();
    }

    if(keyCode == TAB) {
        Mouse.setSnappingEnabled(!Mouse.getSnappingEnabled());
    }

    if(key == ' ') {
        IS_PAUSED = !IS_PAUSED;
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

}

public void keyReleased() {  
    KeyAndTabHandler.onKeyReleased(keyCode);

    if(!KeyAndTabHandler.isKeyDown(KeyEvent.VK_Q)) {
        PShape TabShape = UserInterface.TabObject.getTabShape();
        PShape Q = TabShape.getChild(1);
        Q.setFill(color(22, 23, 23));

    }

    if(!KeyAndTabHandler.isKeyDown(KeyEvent.VK_E)) {
        PShape TabShape = UserInterface.TabObject.getTabShape();
        PShape E = TabShape.getChild(2);
        E.setFill(color(22, 23, 23));
    }
}

