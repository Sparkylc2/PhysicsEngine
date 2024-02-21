@Override
void exit() {
 java.lang.System.exit(0);
}

public void keyPressed() {
    KeyAndTabHandler.onKeyPressed(keyCode);
    CurrentTabInteractionHandler.onKeyPressed();


    if(KeyAndTabHandler.isKeyDown(KeyEvent.VK_Q)) {
        UI_Manager.getTabBar().onQPressed();
    }
    
    if(KeyAndTabHandler.isKeyDown(KeyEvent.VK_E)) {
        UI_Manager.getTabBar().onEPressed();
    }

    if(KeyAndTabHandler.isKeyDown(KeyEvent.VK_1)) {
        UI_Manager.getHotBar().setActiveSlotID(0);
        UI_Manager.getTabBar().setActiveTabID(1);
    }

    if(KeyAndTabHandler.isKeyDown(KeyEvent.VK_2)) {
        UI_Manager.getHotBar().setActiveSlotID(1);
        UI_Manager.getTabBar().setActiveTabID(1);
    }

    if(KeyAndTabHandler.isKeyDown(KeyEvent.VK_3)) {
        UI_Manager.getHotBar().setActiveSlotID(2);
        UI_Manager.getTabBar().setActiveTabID(1);
    }

    if(KeyAndTabHandler.isKeyDown(KeyEvent.VK_4)) {
        UI_Manager.getHotBar().setActiveSlotID(3);
        UI_Manager.getTabBar().setActiveTabID(1);
    }

    if(KeyAndTabHandler.isKeyDown(KeyEvent.VK_5)) {
        UI_Manager.getHotBar().setActiveSlotID(4);
        UI_Manager.getTabBar().setActiveTabID(1);
    }

    if(KeyAndTabHandler.isKeyDown(KeyEvent.VK_6)) {
        UI_Manager.getHotBar().setActiveSlotID(5);
        UI_Manager.getTabBar().setActiveTabID(1);
    }

    if(KeyAndTabHandler.isKeyDown(KeyEvent.VK_7)) {
        UI_Manager.getHotBar().setActiveSlotID(6);
        UI_Manager.getTabBar().setActiveTabID(1);
    }

    if(keyCode == ESC) {
        exit();
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
        UI_Manager.getTabBar().onQReleased();
    }

    if(!KeyAndTabHandler.isKeyDown(KeyEvent.VK_E)) {
        UI_Manager.getTabBar().onEReleased();
    }
}

