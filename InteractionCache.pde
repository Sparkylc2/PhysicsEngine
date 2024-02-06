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
        if(isKeyDown(KeyEvent.VK_A)) {
            aPressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_B)) {
            bPressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_C)) {
            cPressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_D)) {
            dPressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_E)) {
            ePressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_F)) {
            fPressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_G)) {
            gPressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_H)) {
            hPressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_I)) {
            iPressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_J)) {
            jPressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_K)) {
            kPressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_L)) {
            lPressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_M)) {
            mPressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_N)) {
            nPressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_O)) {
            oPressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_P)) {
            pPressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_Q)) {
            qPressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_R)) {
            rPressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_S)) {
            sPressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_T)) {
            tPressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_U)) {
            uPressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_V)) {
            vPressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_W)) {
            wPressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_X)) {
            xPressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_Y)) {
            yPressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_Z)) {
            zPressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_0)) {
            zeroPressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_1)) {
            onePressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_2)) {
            twoPressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_3)) {
            threePressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_4)) {
            fourPressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_5)) {
            fivePressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_6)) {
            sixPressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_7)) {
            sevenPressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_8)) {
            eightPressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_9)) {
            ninePressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_SPACE)) {
            spacePressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_SHIFT)) {
            shiftPressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_CONTROL)) {
            ctrlPressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_ALT)) {
            altPressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_TAB)) {
            tabPressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_ESCAPE)) {
            escPressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_DELETE)) {
            deletePressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_BACK_SPACE)) {
            backspacePressedResponse();
        }
        if(isKeyDown(KeyEvent.VK_ENTER)) {
            enterPressedResponse();
        }
    }


    private void aPressedResponse() {

    }

    private void bPressedResponse() {

    }

    private void cPressedResponse() {

    }

    private void dPressedResponse() {

    }

    private void ePressedResponse() {

    }

    private void fPressedResponse() {

    }

    private void gPressedResponse() {

    }

    private void hPressedResponse() {

    }

    private void iPressedResponse() {

    }

    private void jPressedResponse() {

    }

    private void kPressedResponse() {

    }

    private void lPressedResponse() {

    }

    private void mPressedResponse() {

    }

    private void nPressedResponse() {

    }

    private void oPressedResponse() {

    }

    private void pPressedResponse() {

    }

    private void qPressedResponse() {

    }

    private void rPressedResponse() {

    }

    private void sPressedResponse() {

    }

    private void tPressedResponse() {

    }

    private void uPressedResponse() {

    }

    private void vPressedResponse() {

    }

    private void wPressedResponse() {

    }

    private void xPressedResponse() {

    }

    private void yPressedResponse() {

    }

    private void zPressedResponse() {

    }




    private void zeroPressedResponse() {

    }

    private void onePressedResponse() {

    }

    private void twoPressedResponse() {

    }

    private void threePressedResponse() {

    }

    private void fourPressedResponse() {

    }

    private void fivePressedResponse() {

    }

    private void sixPressedResponse() {

    }

    private void sevenPressedResponse() {

    }

    private void eightPressedResponse() {

    }

    private void ninePressedResponse() {

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