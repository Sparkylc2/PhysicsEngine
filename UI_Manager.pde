public class UI_Manager {
    
    public UI_TabBar TAB_BAR;
    public UI_HotBar HOT_BAR;
    public UI_Window WINDOW;

    public void init() {
        UI_Constants = new UI_Constants();
        this.TAB_BAR = new UI_TabBar();
        this.HOT_BAR = new UI_HotBar();
        this.WINDOW = new UI_Window();
    }

    public void draw() {
        this.TAB_BAR.draw();
        this.HOT_BAR.draw();
        this.WINDOW.draw();
    }



/*
====================================== Getters and Setters =========================================
*/

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
