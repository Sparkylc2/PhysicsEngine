

public void keyPressed() {
    KeyAndTabHandler.onKeyPressed(keyCode);
    CurrentTabInteractionHandler.onKeyPressed();

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
}

