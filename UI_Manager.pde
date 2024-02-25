public class UI_Manager {
    
    public UI_TabBar TAB_BAR;
    public UI_HotBar HOT_BAR;
    public ArrayList<UI_Window> WINDOWS;

    public boolean dragging = false;

    public void init() {
        UI_Constants = new UI_Constants();
        this.TAB_BAR = new UI_TabBar();
        this.HOT_BAR = new UI_HotBar();
        this.WINDOWS = new ArrayList<UI_Window>();
        this.WINDOWS.add((UI_Window) new UI_PropertiesRigidbodyWindow());
        this.WINDOWS.add((UI_Window) new UI_PropertiesForceWindow());

        this.WINDOWS.get(0).Window_Visibility = false;
        this.WINDOWS.get(1).Window_Visibility = false;
    }

    public void draw() {
        this.TAB_BAR.draw();
        this.HOT_BAR.draw();
        for(UI_Window window : this.WINDOWS) {
                window.draw();
        }
    }

    public void interactionDraw() {
        for(UI_Window window : this.WINDOWS) {
            window.interactionDraw();
        }
    }

    public void onMousePress() {
        for(int i = this.WINDOWS.size() - 1; i >= 0; i--) {
            this.WINDOWS.get(i).interactionMousePress();

            if(this.WINDOWS.get(i).onMousePress()) {
                this.WINDOWS.add(this.WINDOWS.remove(i));
                return;
            }
        }
    }

    public void onMouseDrag() {
        for(int i = this.WINDOWS.size() - 1; i >= 0; i--) {
        
            this.WINDOWS.get(i).interactionMouseDrag();

            if(this.WINDOWS.get(i).onMouseDrag()) {
                this.WINDOWS.add(this.WINDOWS.remove(i));
                return;
            }
        }
    }

    public void onMouseRelease() {
        for(UI_Window window : this.WINDOWS) {
            window.interactionMouseRelease();
            
            window.onMouseRelease();
        }
    }

    public void bringToFront(UI_Window window) {
        this.WINDOWS.add(this.WINDOWS.remove(this.WINDOWS.indexOf(window)));
    }



    public void onKeyPress(int keyCode) {
        UI_Window window = getActiveWindow();

        if(window != null) {
            window.onKeyPress(keyCode);
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

    public UI_Window getWindowByName(String name) {
        for(UI_Window window : this.WINDOWS) {
            if(window.getWindowName().equals(name)) {
                return window;
            }
        }
        throw new IllegalArgumentException("No window with name: " + name);
    }

    public boolean getIsOverWindows() {
        for(UI_Window window : this.WINDOWS) {
            if(window.isMouseOverWindow) {
                return true;
            }
        }
        return false;
    }

    public boolean getIsOverOrPressedWindows() {
        for(UI_Window window : this.WINDOWS) {
            if(window.isMouseOverWindow || window.wasMousePressedOverWindow) {
                return true;
            }
        }
        return false;
    }
    public ArrayList<UI_Window> getWindows() {
        return this.WINDOWS;
    }
    public int getActiveTabID() {
        return this.TAB_BAR.getActiveTabID();
    }
    public void setActiveTabID(int id) {
        this.TAB_BAR.setActiveTabID(id);
    }
}
