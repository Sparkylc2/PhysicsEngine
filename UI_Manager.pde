public class UI_Manager {
    
    public UI_TabBar TAB_BAR;
    public UI_HotBar HOT_BAR;
    public UI_Window WINDOW;
    public UI_Window WINDOW2;

    public void init() {
        UI_Constants = new UI_Constants();
        this.TAB_BAR = new UI_TabBar();
        this.HOT_BAR = new UI_HotBar();
        this.WINDOW = new UI_Window("Properties (rigidbody)", 0);
        this.WINDOW2 = new UI_Window("Properties (forces)", 1);
    }

    public void draw() {
        this.TAB_BAR.draw();
        this.HOT_BAR.draw();
        this.WINDOW.draw();
        this.WINDOW2.draw();
    }



/*
====================================== Getters and Setters =========================================
*/

    public UI_Window getWindow() {
        return this.WINDOW;
    }

    public UI_HotBar getHotBar() {
        return this.HOT_BAR;
    }

    public UI_TabBar getTabBar() {
        return this.TAB_BAR;
    }

    public int getActiveTabID() {
        return this.TAB_BAR.getActiveTabID();
    }
    
    public void setActiveTabID(int id) {
        this.TAB_BAR.setActiveTabID(id);
    }
}
