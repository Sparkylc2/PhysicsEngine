public class KeyAndTabHandler {

    private boolean[] keyDownCache = new boolean[256];



    /*
    ID 0: RigidbodyTab
    ID 1: ForceTab
    ID 2: EditorTab
    ID 3: CreationTab
    ID 4: SettingsTab
    ID 5: HelpTab
    */

    private int activeTabID = -1;


/*-------------------------------------- Rigidbody Tab -------------------------------------------*/

    public void onTabChange(int activeTabID) {
        this.activeTabID = activeTabID;
    }

/*
====================================================================================================
====================================== Key & Mouse Listeners =======================================
====================================================================================================
*/
    public void onKeyPressed(int keyCode) {
        if(keyCode < keyDownCache.length) {
            keyDownCache[keyCode] = true;
        }
    }

    public void onKeyReleased(int keyCode) {
        if(keyCode < keyDownCache.length) {
            keyDownCache[keyCode] = false;
        }
    }

    public boolean isKeyDown(int keyCode) {
        if(keyCode < keyDownCache.length) {
            return keyDownCache[keyCode];
        }
        return false;
    }

    public boolean isKeyUp(int keyCode) {
        if(keyCode < keyDownCache.length) {
            return !keyDownCache[keyCode];
        }
        return false;
    }

/*
====================================================================================================
====================================== Getters and Setters =========================================
====================================================================================================
*/
    public void setActiveTabElement(int activeTabID) {
        switch(activeTabID) {
            case 0:
                userInterface.getTab("RigidbodyTab").bringToFront();
                break;
            case 1:
                userInterface.getTab("ForceTab").bringToFront();
                break;
            case 2:
                userInterface.getTab("EditorTab").bringToFront();
                break;
            case 3:
                userInterface.getTab("CreationTab").bringToFront();
                break;
            case 4:
                userInterface.getTab("SettingsTab").bringToFront();
                break;
            case 5:
                userInterface.getTab("HelpTab").bringToFront();
                break;
            case 6:
                userInterface.getTab("DebugTab").bringToFront();
                break;
            default:
                System.out.println("Invalid Tab ID");
                break;
        }
    }
    
    public void setActiveTabID(int activeTabID) {
        this.activeTabID = activeTabID;
        Mouse.clearMouseObjectResults();
        switch(activeTabID) {
            case 0:
                CurrentTabInteractionHandler = RT_InteractionHandler;
                break;
            case 1:
                CurrentTabInteractionHandler = FT_InteractionHandler;
                break;
            case 2:
                System.out.println("Editor Tab");
                break;
            case 3:
                System.out.println("Creation Tab");
                break;
            case 4:
                System.out.println("Settings Tab");
                break;
            case 5:
                System.out.println("Help Tab");
                break;
            case 6:
                System.out.println("Debug Tab");
                break;
            default:
                System.out.println("Invalid Tab ID");
                break;
        }
    }

    public int getActiveTabID() {
        return activeTabID;
    }
    
}
