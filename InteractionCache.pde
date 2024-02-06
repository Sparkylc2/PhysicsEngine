public class InteractionCache {


    private boolean[] keyDownCache = new boolean[256];


    /*
    Index 1: Mouse button left
    Index 2: Mouse button middle
    Index 3: Mouse button right
    */
    private boolean[] mouseDownCache = new boolean[3];


    /*
    ID 0: RigidbodyTab
    ID 1: ForceTab
    ID 2: EditorTab
    ID 3: CreationsTab
    ID 4: SettingsTab
    ID 5: HelpTab
    */
    private int activeTabID = 0;


    /*
    ID 0: Shape Circle
    ID 1: Shape Rectangle
    */
    private int activeShapeSelectedID= -1;


    /*
    ID 0: Force Spring
    ID 1: Force Rod
    ID 2: Force Motor
    */
    private int activeForceSelectedID = -1;



    public void onTabChange(int activeTabID) {
        this.activeTabID = activeTabID;
    }

    public void onShapeChange(int activeShapeSelectedID) {
        this.activeShapeSelectedID = activeShapeSelectedID;

        switch(this.activeShapeSelectedID) {
            case 0:
                interactivityListener.setShapeType(ShapeType.CIRCLE);
                return;
            case 1:
                interactivityListener.setShapeType(ShapeType.BOX);
                return;
        }

        this.activeShapeSelectedID = -1;
    }

    public void onForceChange(int activeForceSelectedID) {
        this.activeForceSelectedID = activeForceSelectedID;

        switch(this.activeForceSelectedID) {
            case 0:
                interactivityListener.setForceType(ForceType.SPRING);
                return;
            case 1:
                interactivityListener.setForceType(ForceType.ROD);
                return;
            case 2:
                interactivityListener.setForceType(ForceType.MOTOR);
                return;
        }

        this.activeForceSelectedID = -1;
    }

    public void onMousePressed(int button) {
        if(button < mouseDownCache.length) {
            mouseDownCache[button] = true;
            System.out.println("Mouse button " + button + " pressed");
        }
    }

    public void onMouseReleased(int button) {
        if(button < mouseDownCache.length) {
            mouseDownCache[button] = false;
            System.out.println("Mouse button " + button + " released");
        }
    }

    public boolean isMouseDown(int button) {
        if(button < mouseDownCache.length) {
            return mouseDownCache[button];
        }
        return false;
    }

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



    public void keyPressedResponse() {
        switch(activeTabID) {
            case 0:
                rigidbodyTabPressedResponse();
                return;
            case 1:
                forceTabPressedResponse();
                return;
            case 2:
                editorTabPressedResponse();
                return;
            case 3:
                creationsTabPressedResponse();
                return;
            case 4:
                settingsTabPressedResponse();
                return;
            case 5:
                helpTabPressedResponse();
                return;
        }
    }


    public void rigidbodyTabPressedResponse() {
        switch(isKeyDown(VK_SHIFT)) {
            case true:
                switch()
        }
        switch(activeShapeSelectedID) {
            case 0:
                circlePressedResponse();
                return;
            case 1:
                rectanglePressedResponse();
                return;
        }
    }


    private void spacePressedResponse() {

    }

    public void enterPressedResponse(){
        Mouse.getMouseObjectResults().clear();
    }

    public void deletePressedResponse(){
        Rigidbody rigidbody = Mouse.getRigidbodyUnderMouse();
        System.out.println("rigidbody: " + rigidbody);
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

    public void backspacePressedResponse(){
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

    public void shiftPressedResponse(){

    }

    public void ctrlPressedResponse(){

    }

    public void altPressedResponse(){

    }

    public void tabPressedResponse(){

    }

    public void escPressedResponse(){

    }





/*
====================================================================================================
====================================== Getters and Setters =========================================
====================================================================================================
*/

    public int getActiveTabID() {
        return activeTabID;
    }

    public int getActiveShapeSelectedID() {
        return activeShapeSelectedID;
    }

    public int getActiveForceSelectedID() {
        return activeForceSelectedID;
    }
}