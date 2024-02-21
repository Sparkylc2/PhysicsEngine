public class UI_Window {
    
    private final String Window_Name;
    private final PVector Window_Size;
    private final int Window_ID;

    private PVector Window_Position;
    private PVector Window_Name_Position;
    private int Window_Z_Index;
    private boolean Window_Visibility;

    private PShape Window_Container;

    //private UI_Form UI_Form;

    /*
    Visuals
    */

    /*
    For Testing
    */
    public UI_Window() {
        this.Window_Name = "Window";
        this.Window_Size = new PVector(300, 400);
        this.Window_ID = 0;

        this.Window_Position = new PVector();
        this.Window_Z_Index = 0;
        this.Window_Visibility = false;

        this.initializeWindow();
    }

    public UI_Window(String Window_Name, PVector Window_Size, int Window_ID) {
        this.Window_Name = Window_Name;
        this.Window_Size = Window_Size;
        this.Window_ID = Window_ID;

        this.Window_Position = new PVector();
        this.Window_Z_Index = 0;
        this.Window_Visibility = false;

        this.initializeWindow();
    }


    private void initializeWindow() {
        rectMode(CENTER);
        this.Window_Container = createShape(GROUP);

        PShape Window_Text_Container = createShape(RECT, 0, 0, 285, 35, 7, 7, 0, 0);
            Window_Text_Container.setFill(UI_Constants.GRAY_500);
            Window_Text_Container.setStroke(UI_Constants.GRAY_400);
            Window_Text_Container.setStrokeWeight(1.5);
        

        PShape Window_Form_Container = createShape(RECT, 0, 17.5, 285, 365, 0, 0, 7, 7);
            Window_Form_Container.setFill(UI_Constants.GRAY_600);
            Window_Form_Container.setStroke(UI_Constants.GRAY_400);
            Window_Form_Container.setStrokeWeight(1.5);

        this.Window_Container.addChild(Window_Form_Container);
        this.Window_Container.addChild(Window_Text_Container);

        this.Window_Container.resetMatrix();
        this.Window_Container.translate(500, 300);
    }

    public void draw() {
        shape(this.Window_Container, this.Window_Position.x, this.Window_Position.y);
    }
}
