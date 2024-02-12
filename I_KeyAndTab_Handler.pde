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

    private int activeTabID = 0;


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
            System.out.println("Key " + keyCode + " pressed");
        }
    }

    public void onKeyReleased(int keyCode) {
        if(keyCode < keyDownCache.length) {
            keyDownCache[keyCode] = false;
            System.out.println("Key " + keyCode + " released");
        }
    }

    public boolean isKeyDown(int keyCode) {
        if(keyCode < keyDownCache.length) {
            return keyDownCache[keyCode];
        }
        return false;
    }

/*
====================================================================================================
====================================== Getters and Setters =========================================
====================================================================================================
*/

    public int getActiveTabID() {
        return activeTabID;
    }
    
}