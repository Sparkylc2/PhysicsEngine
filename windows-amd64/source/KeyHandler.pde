public class KeyHandler {

    private boolean[] keyDownCache = new boolean[256];




/*-------------------------------------- Rigidbody Tab -------------------------------------------*/

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
}
