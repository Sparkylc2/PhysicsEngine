public class UserInterface {
    
    public UserInterfaceTabObject TabObject = new UserInterfaceTabObject();

    public void setup() {
        TabObject.createTabGraphics();
    }

    public void draw() {
        TabObject.drawTabGraphics();
    }

    public int getActiveTabID() {
        return TabObject.getActiveTabID();
    }
    public void setActiveTabID(int id) {
        TabObject.setActiveTabID(id);
    }
}
