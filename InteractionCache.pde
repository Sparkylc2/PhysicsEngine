public class InteractionCache {

    /*
    How this is going to work:
    Basically what your doing at the moment is trying to update the gui using a much neater, more modular,
    and efficient system. Your using the plugTo in conjunction with the eventListener to get which
    button is being pressed etc, and you want to have this all update in here. You want to only
    rely on this class to update values for everything, that includes mouse down,
    key down, and the gui. You want to have a method for each type of input, and then you want to
    update stuff like the editor, interactivity listener, etc, using these values. This should be
    the central hub for basically every interaction the user makes with the system, and this should
    be more effective.

    On your list of other things your doing, you need to implement drag and dropping of multi shape
    selections, including being able to copy and paste a selection. you want to maybe implement the rod
    gravity idea, and you also want to add convex polygon decomposition. you are also going to make
    a seperate editor tab, settings tab, help tab, etc. and importing custom creations. remember the id
    system, and how you are coordinating that. Also review how you treat keydown inputs, and remember to use
    switch cases when possible. Also remember to use the keylistener and mouselistener classes to
    update the interaction cache, and then use the interaction cache to update the gui and the editor.
    */

    
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
    ID 0: Fill Colour
    ID 1: Stroke Colour
    */
    private int activeColourCustomizationSelectedID = -1;

    /*
    ID 0: Force Spring
    ID 1: Force Rod
    ID 2: Force Motor
    */
    private int activeForceSelectedID = -1;



    public void onTabChange(int activeTabID) {
        this.activeTabID = activeTabID;
    }




/*
====================================================================================================
====================================== Rigidbody Generation ========================================
====================================================================================================
*/
    public void shapeSelectorListener() {
        if(gui.ShapeSelector.getState(0)) {
            this.activeShapeSelectedID = 0;
        } else if(gui.ShapeSelector.getState(1)) {
            this.activeShapeSelectedID = 1;
        } else {
            this.activeShapeSelectedID = -1;
        }
        onShapeSelectorChange();
    }

    public void onShapeSelectorChange() {
        gui.RectangleWidth.setVisible(this.activeShapeSelectedID == 1);
        gui.RectangleHeight.setVisible(this.activeShapeSelectedID == 1);

        gui.CircleRadius.setVisible(this.activeShapeSelectedID == 0);

        gui.Density.setVisible(this.activeShapeSelectedID == 0 || this.activeShapeSelectedID == 1);
        gui.Restitution.setVisible(this.activeShapeSelectedID == 0 || this.activeShapeSelectedID == 1);

        //gui.ColourSelector.setVisible(this.activeShapeSelectedID == 0 || this.activeShapeSelectedID == 1);
        gui.fillColour.setVisible(this.activeShapeSelectedID == 0 || this.activeShapeSelectedID == 1);
        gui.strokeColour.setVisible(this.activeShapeSelectedID == 0 || this.activeShapeSelectedID == 1);
        gui.strokeWeight.setVisible(this.activeShapeSelectedID == 0 || this.activeShapeSelectedID == 1);
                                        
        gui.isStatic.setVisible(this.activeShapeSelectedID == 0 || this.activeShapeSelectedID == 1);
        gui.isTranslationallyStatic.setVisible(this.activeShapeSelectedID == 0 || this.activeShapeSelectedID == 1);
        gui.isRotationallyStatic.setVisible(this.activeShapeSelectedID == 0 || this.activeShapeSelectedID == 1);

        gui.angle.setVisible(this.activeShapeSelectedID == 0 || this.activeShapeSelectedID == 1);
        gui.angularVelocity.setVisible(this.activeShapeSelectedID == 0 || this.activeShapeSelectedID == 1);

        gui.addGravity.setVisible(this.activeShapeSelectedID == 0 || this.activeShapeSelectedID == 1);
        gui.isCollidable.setVisible(this.activeShapeSelectedID == 0 || this.activeShapeSelectedID == 1);
    }   

    public void colourCustomizationSelectorListener(ControlEvent theEvent) {
        if (theEvent.getController().getName().equals("FillColour") && theEvent.getController().getValue() == 1){
            gui.strokeColour.setValue(false);
            this.activeColourCustomizationSelectedID = 0;
        } else if (theEvent.getController().getName().equals("StrokeColour") && theEvent.getController().getValue() == 1) {
            gui.fillColour.setValue(false);
            this.activeColourCustomizationSelectedID = 1;
        } else {
            this.activeColourCustomizationSelectedID = -1;
        }
}




    public void onColourCustomizationSelectorChange() {

    }
/*
====================================================================================================
====================================== Key & Mouse Listeners =======================================
====================================================================================================
*/
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


/*
====================================================================================================
====================================== Key Pressed Responses =======================================
====================================================================================================
*/
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
        if(isKeyDown(KeyEvent.VK_SHIFT)) {
                        if(isKeyDown(KeyEvent.VK_W)) {
                            switch(this.activeShapeSelectedID) {
                                case 0:
                                    gui.CircleRadius.setValue(gui.CircleRadius.getValue() + 0.5f);
                                    return;
                                case 1:
                                    gui.RectangleHeight.setValue(gui.RectangleHeight.getValue() + 1f);
                                    return;
                            }
                        }

                        if(isKeyDown(KeyEvent.VK_S)) {
                            switch(this.activeShapeSelectedID) {
                                case 0:
                                    gui.CircleRadius.setValue(gui.CircleRadius.getValue() - 0.5f);
                                    return;
                                case 1:
                                    gui.RectangleHeight.setValue(gui.RectangleHeight.getValue() - 1f);
                                    return;
                            }
                        }

                        if(isKeyDown(KeyEvent.VK_A)) {
                            switch(this.activeShapeSelectedID) {
                                case 0:
                                    gui.CircleRadius.setValue(gui.CircleRadius.getValue() - 0.5f);
                                    return;
                                case 1:
                                    gui.RectangleWidth.setValue(gui.RectangleWidth.getValue() - 1f);
                                    return;
                            }
                        }

                        if(isKeyDown(KeyEvent.VK_D)) {
                            switch(this.activeShapeSelectedID) {
                                case 0:
                                    gui.CircleRadius.setValue(gui.CircleRadius.getValue() + 0.5f);
                                    return;
                                case 1:
                                    gui.RectangleWidth.setValue(gui.RectangleWidth.getValue() + 1f);
                                    return;
                            }
                        }


        } else {


                        if(isKeyDown(KeyEvent.VK_W)) {
                            switch(this.activeShapeSelectedID) {
                                case 0:
                                    gui.CircleRadius.setValue(gui.CircleRadius.getValue() + 0.05f);
                                    return;
                                case 1:
                                    gui.RectangleHeight.setValue(gui.RectangleHeight.getValue() + 0.1f);
                                    return;
                            }
                        }

                        if(isKeyDown(KeyEvent.VK_S)) {
                            switch(this.activeShapeSelectedID) {
                                case 0:
                                    gui.CircleRadius.setValue(gui.CircleRadius.getValue() - 0.05f);
                                    return;
                                case 1:
                                    gui.RectangleHeight.setValue(gui.RectangleHeight.getValue() - 0.1f);
                                    return;
                            }
                        }

                        if(isKeyDown(KeyEvent.VK_A)) {
                            switch(this.activeShapeSelectedID) {
                                case 0:
                                    gui.CircleRadius.setValue(gui.CircleRadius.getValue() - 0.05f);
                                    return;
                                case 1:
                                    gui.RectangleWidth.setValue(gui.RectangleWidth.getValue() - 0.1f);
                                    return;
                            }
                        }

                        if(isKeyDown(KeyEvent.VK_D)) {
                            switch(this.activeShapeSelectedID) {
                                case 0:
                                    gui.CircleRadius.setValue(gui.CircleRadius.getValue() + 0.05f);
                                    return;
                                case 1:
                                    gui.RectangleWidth.setValue(gui.RectangleWidth.getValue() + 0.1f);
                                    return;
                            }
                        }

                        if(isKeyDown(KeyEvent.VK_1)) {
                            switch(this.activeShapeSelectedID) {
                                case -1:
                                    gui.ShapeSelector.activate(0);
                                    this.shapeSelectorListener();
                                    return;
                                case 0:
                                    gui.ShapeSelector.deactivateAll();
                                    this.shapeSelectorListener();
                                    return;
                                case 1:
                                    gui.ShapeSelector.activate(0);
                                    this.shapeSelectorListener();
                                    return;
                            }
                        }

                        if(isKeyDown(KeyEvent.VK_2)) {
                            switch(this.activeShapeSelectedID) {
                                case -1:
                                    gui.ShapeSelector.activate(1);
                                    this.shapeSelectorListener();
                                    return;
                                case 0:
                                    gui.ShapeSelector.activate(1);
                                    this.shapeSelectorListener();
                                    return;
                                case 1:
                                    gui.ShapeSelector.deactivateAll();
                                    this.shapeSelectorListener();
                                    return;
                            }
                        }
            } 
    }  


   public void forceTabPressedResponse() {

   }

   public void editorTabPressedResponse() {
   }

    public void creationsTabPressedResponse() {
    }

    public void settingsTabPressedResponse() {
    }

    public void helpTabPressedResponse() {
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