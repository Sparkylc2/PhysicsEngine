public class UI_PropertiesForceWindow extends UI_Window {




    public UI_PropertiesForceWindow() {
        super("Properties (forces)", 1);
        initialize();
    }


    public void initialize() {
        this.addElement(new UI_Toggle("forces1", (UI_Window)this));
        this.addElement(new UI_Toggle("forces2", (UI_Window)this));
        this.addElement(new UI_Slider("forcesSlider1", (UI_Window)this, 0, 100, 50));

    }




}
