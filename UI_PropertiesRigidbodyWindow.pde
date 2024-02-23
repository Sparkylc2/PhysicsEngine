public class UI_PropertiesRigidbodyWindow extends UI_Window {




    public UI_PropertiesRigidbodyWindow() {
        super("Properties (rigidbody)", 0);
        initialize();
    }


    public void initialize() {
        this.addElement(new UI_Slider("Density", (UI_Window)this, MIN_BODY_DENSITY, MAX_BODY_DENSITY, DEFAULT_BODY_DENSITY));
        this.addElement(new UI_Slider("Restitution", (UI_Window)this, 0, 1, 0.5));
        this.addElement(new UI_Slider("Width", (UI_Window)this, MIN_BODY_WIDTH, MAX_BODY_WIDTH, DEFAULT_BODY_WIDTH));
        this.addElement(new UI_Slider("Height", (UI_Window)this, MIN_BODY_HEIGHT, MAX_BODY_HEIGHT, DEFAULT_BODY_HEIGHT));
        this.addElement(new UI_Toggle("Static", (UI_Window)this, "Staticity"));
        this.addElement(new UI_Toggle("Fixed Rotation", (UI_Window)this, "Staticity"));
        this.addElement(new UI_Toggle("Fixed Position", (UI_Window)this, "Staticity"));
        this.addElement(new UI_Slider("Angle", (UI_Window)this, -360, 360, 0));
    }





}
