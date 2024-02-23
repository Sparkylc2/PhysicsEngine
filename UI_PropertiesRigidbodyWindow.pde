public class UI_PropertiesRigidbodyWindow extends UI_Window {




    public UI_PropertiesRigidbodyWindow() {
        super("Properties (rigidbody)", 0);
        initialize();
    }


    public void initialize() {
        this.addElement(new UI_Toggle("rigidbody1", (UI_Window)this));
        this.addElement(new UI_Toggle("rigidbody2", (UI_Window)this));
    }





}
