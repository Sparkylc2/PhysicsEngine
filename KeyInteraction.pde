@Override
public void exit() {
    java.lang.System.exit(0);
}

public void keyPressed() {
    KeyHandler.onKeyPressed(keyCode);


    UI_Manager.onKeyPress(keyCode);
    UI_Manager.getPropertiesEditorWindow().onKeyPress(keyCode);
    
    if(UI_Manager.getTabBar().getActiveTabID() == 2) {
        if(IS_TEXTFIELD_ACTIVE && UI_Manager.getCreationWindow().getTextField() != null) {
            UI_Manager.getCreationWindow().getTextField().keyPress(key, keyCode);
            return;
        } else if (IS_TEXTFIELD_ACTIVE && UI_Manager.getCreationWindow().getFileButtonToRenameTextField() != null) {
            UI_Manager.getCreationWindow().getFileButtonToRenameTextField().keyPress(key, keyCode);
            return;
        }
    }

    if(KeyHandler.isKeyDown(KeyEvent.VK_Q)) {
        UI_Manager.getTabBar().onQPressed();
        return;
    }
    
    if(KeyHandler.isKeyDown(KeyEvent.VK_E)) {
        UI_Manager.getTabBar().onEPressed();
        return;
    }

    if(KeyHandler.isKeyDown(KeyEvent.VK_1)) {
        UI_Manager.getHotBar().setActiveSlotID(0);
        UI_Manager.getTabBar().setActiveTabID(1);
        return;
    }

    if(KeyHandler.isKeyDown(KeyEvent.VK_2)) {
        UI_Manager.getHotBar().setActiveSlotID(1);
        UI_Manager.getTabBar().setActiveTabID(1);
        return;
    }

    if(KeyHandler.isKeyDown(KeyEvent.VK_3)) {
        UI_Manager.getHotBar().setActiveSlotID(2);
        UI_Manager.getTabBar().setActiveTabID(1);
        return;
    }

    if(KeyHandler.isKeyDown(KeyEvent.VK_4)) {
        UI_Manager.getHotBar().setActiveSlotID(3);
        UI_Manager.getTabBar().setActiveTabID(1);
        return;
    }

    if(KeyHandler.isKeyDown(KeyEvent.VK_5)) {
        UI_Manager.getHotBar().setActiveSlotID(4);
        UI_Manager.getTabBar().setActiveTabID(1);
        return;
    }


    if(KeyHandler.isKeyDown(KeyEvent.VK_6)) {
        UI_Manager.getHotBar().setActiveSlotID(5);
        UI_Manager.getTabBar().setActiveTabID(1);
        return;
    }

    if(KeyHandler.isKeyDown(KeyEvent.VK_7)) {
        UI_Manager.getHotBar().setActiveSlotID(6);
        UI_Manager.getTabBar().setActiveTabID(1);
        return;
    }

    if(keyCode == ESC) {
        exit();
        return;
    }
    
    if(keyCode == ENTER) {
        Mouse.getMouseObjectResults().clear();
        return;
    }

    if(keyCode == TAB) {
        Mouse.setSnappingEnabled(!Mouse.getSnappingEnabled());
        return;
    }

    if(key == ' ') {
        if(!IS_PAUSED_LOCK) {
            IS_PAUSED = !IS_PAUSED;
        }
                UI_Manager.getPropertiesEditorWindow().PAUSE_STATE_ON_OPEN = IS_PAUSED;
        return;
    }

    if(key == 'r' || key == 'R') {
        Camera.resetCamera();
        return;
    }

    if(key == 'c' || key == 'C') {
        rigidbodyList.clear();
        ALL_FORCES_ARRAYLIST.clear();
        softbodyList.clear();
        return;
    }
}

public void keyReleased() {  
    KeyHandler.onKeyReleased(keyCode);

    if(!KeyHandler.isKeyDown(KeyEvent.VK_Q)) {
        UI_Manager.getTabBar().onQReleased();
    }

    if(!KeyHandler.isKeyDown(KeyEvent.VK_E)) {
        UI_Manager.getTabBar().onEReleased();
    }
}

