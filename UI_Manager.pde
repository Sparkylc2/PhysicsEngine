public class UI_Manager {
    
    private UI_TabBar TAB_BAR;
    private UI_HotBar HOT_BAR;

    private UI_PropertiesRigidbodyWindow propertiesRigidbodyWindow;
    private UI_PropertiesForceWindow propertiesForceWindow;
    private UI_PropertiesEditorWindow propertiesEditorWindow;
    private UI_CreationWindow creationWindow;
    private UI_SettingsWindow settingsWindow;

    private ArrayList<UI_Window> WINDOWS;



    public boolean dragging = false;

    public boolean hasWindowBeenInteractedWith = false;
    public float timeWindowBeenInteractedWith;

    public boolean isMouseOverWindow = false;
    public boolean wasMousePressedOverWindow = false;

    public void init() {
        UI_Constants = new UI_Constants();
        this.TAB_BAR = new UI_TabBar();
        this.HOT_BAR = new UI_HotBar();
        this.WINDOWS = new ArrayList<UI_Window>();

        this.propertiesRigidbodyWindow = new UI_PropertiesRigidbodyWindow();
        this.propertiesForceWindow = new UI_PropertiesForceWindow();
        this.propertiesEditorWindow = new UI_PropertiesEditorWindow();
        this.creationWindow = new UI_CreationWindow();
        this.settingsWindow = new UI_SettingsWindow();

        this.WINDOWS.add((UI_Window)this.propertiesRigidbodyWindow);
        this.WINDOWS.add((UI_Window)this.propertiesForceWindow);
        this.WINDOWS.add((UI_Window)this.propertiesEditorWindow);
        this.WINDOWS.add((UI_Window)this.creationWindow);
        this.WINDOWS.add((UI_Window)this.settingsWindow);

        for(UI_Window window : WINDOWS) {
            window.setWindowVisibility(false);
        }
    }


    public void draw() {
        if(hasWindowBeenInteractedWith) {
            if(millis() - timeWindowBeenInteractedWith > 100) {
                this.hasWindowBeenInteractedWith = false;
                this.timeWindowBeenInteractedWith = 0;
            }
        }   

        this.TAB_BAR.draw();
        this.HOT_BAR.draw();

        for(UI_Window window : this.WINDOWS) {
                window.draw();
        }

        for(UI_Window window : this.WINDOWS) {
            if(window.isMouseOverWindow) {
                this.isMouseOverWindow = true;
                return;
            } else {
                this.isMouseOverWindow = false;
            }

            if(window.wasMousePressedOverWindow) {
                this.wasMousePressedOverWindow = true;
                return;
            } else {
                this.wasMousePressedOverWindow = false;
            }
        }
    }

    public void interactionDraw() {
        for(UI_Window window : this.WINDOWS) {
            window.interactionDraw();
        }
    }



/*
======================================= Mouse Interaction =======================================
*/
    public void onMousePress() {
        if(this.HOT_BAR.onMousePress()) {
            this.timeWindowBeenInteractedWith = millis();
            this.hasWindowBeenInteractedWith = true;
        }

        if(this.TAB_BAR.onMousePress()) {
            this.timeWindowBeenInteractedWith = millis();
            this.hasWindowBeenInteractedWith = true;
        }

        boolean windowVisibilityChange = false;
        boolean isVisibilityChangeActiveWindow = false;
        UI_Window activeWindow = this.getActiveWindow();

        for(int i = this.WINDOWS.size() - 1; i >= 0; i--) {
            this.WINDOWS.get(i).interactionMousePress();

            boolean isWindowVisibleBefore = this.WINDOWS.get(i).Window_Visibility;
            boolean isWindowVisibleAfter;

            if(this.WINDOWS.get(i).onMousePress()) {
                isWindowVisibleAfter = this.WINDOWS.get(i).Window_Visibility;

                if(activeWindow != null) {
                    if(isWindowVisibleBefore != isWindowVisibleAfter) {
                        if(this.WINDOWS.get(i) == activeWindow) {
                            isVisibilityChangeActiveWindow = true;
                        }
                    windowVisibilityChange = true;
                    }
                }
                
                this.timeWindowBeenInteractedWith = millis();
                this.hasWindowBeenInteractedWith = true;

                if(!windowVisibilityChange) {
                    return;
                }
            } 
        }

        if(windowVisibilityChange && !isVisibilityChangeActiveWindow && activeWindow != null) {
            activeWindow.onWindowSelectHotbarCaller();
        }
    }

    public void onMouseDrag() {
        for(int i = this.WINDOWS.size() - 1; i >= 0; i--) {

            this.WINDOWS.get(i).interactionMouseDrag();
            
            if(this.WINDOWS.get(i).onMouseDrag()) {
                this.timeWindowBeenInteractedWith = millis();
                this.hasWindowBeenInteractedWith = true;
                return;
            }
        }
    }

    public void onMouseRelease() {
        ArrayList<UI_Window> windowsCopy = new ArrayList<>(this.WINDOWS);
        for(UI_Window window : windowsCopy) {
            window.onMouseRelease();
            window.interactionMouseRelease();
        }
    }

    public void onMouseClick() {
        ArrayList<UI_Window> windowsCopy = new ArrayList<>(this.WINDOWS);
        for(UI_Window window : windowsCopy) {
            window.interactionMouseClick();
        }
    }
/*
================================================================================================
*/
    public void bringToFront(UI_Window window) {
        this.WINDOWS.add(this.WINDOWS.remove(this.WINDOWS.indexOf(window)));
    }



    public void onKeyPress(int keyCode) {
        UI_Window window = getActiveWindow();

        if(window != null) {
            window.onKeyPress(keyCode);
        }
    }
    

    public void repositionWindow(UI_Window window) {
        for(UI_Window win : UI_Manager.WINDOWS) {
            if(window == win) {
                continue;
            }

            if(win.getWindowPosition().x < displayWidth / 2) {
                window.setWindowPosition(new PVector(displayWidth * (3/4), displayHeight/3));
            } else {
                window.setWindowPosition(new PVector(displayWidth * (1/4), displayHeight/3));
            }
        }
    }


    public void closeAllWindows() {
        for(UI_Window window : this.WINDOWS) {
            window.onWindowClose();
        }
    }

/*
====================================== Getters and Setters =========================================
*/

    
    public UI_Window getActiveWindow() {
        for(UI_Window window : this.WINDOWS) {
            if(window.isActiveWindow) {
                return window;
            }
        }
        return null;
    }
    public UI_HotBar getHotBar() {
        return this.HOT_BAR;
    }
    public UI_TabBar getTabBar() {
        return this.TAB_BAR;
    }
    public UI_Window getWindow(int id) {
        return this.WINDOWS.get(id);
    }

    // public UI_Window getWindowByName(String name) {
    //     for(UI_Window window : this.WINDOWS) {
    //         if(window.getWindowName().equals(name)) {
    //             return window;
    //         }
    //     }
    //     throw new IllegalArgumentException("No window with name: " + name);
    // }


    public UI_PropertiesRigidbodyWindow getPropertiesRigidbodyWindow() {
        return this.propertiesRigidbodyWindow;
    }

    public UI_PropertiesForceWindow getPropertiesForceWindow() {
        return this.propertiesForceWindow;
    }

    public UI_PropertiesEditorWindow getPropertiesEditorWindow() {
        return this.propertiesEditorWindow;
    }

    public UI_CreationWindow getCreationWindow() {
        return this.creationWindow;
    }

    public UI_SettingsWindow getSettingsWindow() {
        return this.settingsWindow;
    }

    public ArrayList<UI_Window> getWindows() {
        return this.WINDOWS;
    }

    public boolean getIsOverWindows() {
        return this.isMouseOverWindow;
    }

    public boolean getIsOverOrPressedWindows() {
        return this.isMouseOverWindow || this.wasMousePressedOverWindow;
    }

    public boolean getIsPressedOverWindow() {
        return this.wasMousePressedOverWindow;
    }

    public int getActiveTabID() {
        return this.TAB_BAR.getActiveTabID();
    }
    public void setActiveTabID(int id) {
        this.TAB_BAR.setActiveTabID(id);
    }
}
