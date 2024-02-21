public class UI_Window {
    
    private final String Window_Name;
    private PVector Window_Position = new PVector(500, 400);
    private final int Window_ID;

    private boolean Window_Visibility = true;
    private float Window_Scale = displayWidth / 1512;

    private PShape Window_Container;


    //private UI_Form UI_Form;

    /*
    Visuals
    */
    private final PVector Window_Container_Size = new PVector(285, 400);
    private final PVector Window_Text_Container_Size = new PVector(285, 35);
    private final PVector Window_Form_Container_Size = new PVector(285, 365);
    private final PVector Window_Text_Position = new PVector();
    private float Window_Text_Width;
    private final float Window_Rounding = 7;



    /*
    Interaction
    */
    private PVector initialMouseDragPosition = new PVector();
    private boolean wasMousePressed = false;

    private boolean isMouseOverWindow = false;
    private boolean isDragging = false;
    private boolean hasDragged = false;
    private boolean isSelected = false;
    /*
    For Testing
    */
    public UI_Window(String Window_Name, int Window_ID) {
        this.Window_Name = Window_Name;
        this.Window_ID = Window_ID;
        this.initializeWindow();
    }



    private void initializeWindow() {
        textFont(UI_Constants.FONT[0]);
        textAlign(CENTER, CENTER);
        textSize(18);
        rectMode(CENTER);
        this.Window_Container = createShape(GROUP);

        PShape Window_Text_Container = createShape(RECT, 0, -this.Window_Form_Container_Size.y / 2 - this.Window_Text_Container_Size.y / 2 + 0.5, 
                                                             this.Window_Text_Container_Size.x, 
                                                             this.Window_Text_Container_Size.y, 
                                                             this.Window_Rounding, 
                                                             this.Window_Rounding, 
                                                             0, 0);
            Window_Text_Container.setName("Window_Text_Container");
            Window_Text_Container.setStroke(false);
            Window_Text_Container.setFill(UI_Constants.GRAY_500);

        PShape Window_Form_Container = createShape(RECT, 0, 0, this.Window_Form_Container_Size.x,
                                                               this.Window_Form_Container_Size.y, 
                                                               0, 0, 
                                                               this.Window_Rounding,
                                                               this.Window_Rounding);
            Window_Form_Container.setName("Window_Form_Container");
            Window_Form_Container.setStroke(false);
            Window_Form_Container.setFill(UI_Constants.GRAY_600);
        
        PShape Window_Container_Stroke = createShape(RECT, 0, -this.Window_Text_Container_Size.y / 2, this.Window_Container_Size.x, this.Window_Container_Size.y, this.Window_Rounding);
            Window_Container_Stroke.setName("Window_Container_Stroke");
            Window_Container_Stroke.setStroke(UI_Constants.GRAY_400);
            Window_Container_Stroke.setStrokeWeight(2);
            Window_Container_Stroke.setFill(false);

        this.Window_Container.addChild(Window_Form_Container);
        this.Window_Container.addChild(Window_Text_Container);
        this.Window_Container.addChild(Window_Container_Stroke);

        this.Window_Container.resetMatrix();
        this.Window_Container.translate(this.Window_Position.x, this.Window_Position.y);
        this.Window_Container.scale(this.Window_Scale);


        this.Window_Text_Width = textWidth(this.Window_Name);
        this.Window_Text_Position.set(-this.Window_Text_Container_Size.x / 2 + textWidth(this.Window_Name) / 2 + 15, -(this.Window_Form_Container_Size.y + this.Window_Text_Container_Size.y) / 2);
    }

    public void draw() {
        fill(255);
        textFont(UI_Constants.FONT[0]);
        textAlign(CENTER, CENTER);
        textSize(18);


        shape(this.Window_Container, 0, 0);

        pushMatrix();
        translate(this.Window_Position.x, this.Window_Position.y);
        scale(this.Window_Scale);
        text(this.Window_Name, this.Window_Text_Position.x, this.Window_Text_Position.y);
        popMatrix();

        this.updateIsMouseOverWindow();
        this.onMouseDrag();
    }

    public void onMouseRelease() {
        this.isDragging = false;
    }
    public void onMouseDrag() {
        if (mousePressed && mouseButton == LEFT && !this.wasMousePressed) {
            if (this.isMouseOverWindow) {
                this.onWindowSelect();
                this.initialMouseDragPosition.set(mouseX, mouseY);
                this.isDragging = true;
            }
        } else if(mousePressed && mouseButton == LEFT && this.isDragging) { 
            PVector mouseDragDifference = PVector.sub(new PVector(mouseX, mouseY), this.initialMouseDragPosition);

            this.Window_Position.add(mouseDragDifference);
            this.Window_Container.resetMatrix();
            this.Window_Container.translate(this.Window_Position.x, this.Window_Position.y);
            this.Window_Container.scale(this.Window_Scale);

            this.initialMouseDragPosition.set(mouseX, mouseY);
        } 
        this.wasMousePressed = mousePressed;
    }

    public void onMousePress() {
        if(mouseButton == LEFT) {
            if(this.isMouseOverWindow) {
                this.onWindowSelect();
            } else {
                this.onWindowDeselect();
            }
        }
    }


    public void onWindowSelect() {
        this.isSelected = true;
        this.Window_Container.getChild("Window_Container_Stroke").setStroke(UI_Constants.BLUE_SELECTED);
        this.Window_Container.getChild("Window_Text_Container").setFill(UI_Constants.BLUE_UNSELECTED);
    }

    public void onWindowDeselect() {
        this.isSelected = false;
        this.Window_Container.getChild("Window_Container_Stroke").setStroke(UI_Constants.GRAY_400);
        this.Window_Container.getChild("Window_Text_Container").setFill(UI_Constants.GRAY_500);
    }

    public void updateIsMouseOverWindow() {
        if (mouseX > this.Window_Position.x - this.Window_Container_Size.x / 2 * this.Window_Scale && 
            mouseX < this.Window_Position.x + this.Window_Container_Size.x / 2 * this.Window_Scale && 
            mouseY > this.Window_Position.y - this.Window_Container_Size.y / 2 * this.Window_Scale && 
            mouseY < this.Window_Position.y + this.Window_Container_Size.y / 2 * this.Window_Scale) {
            this.isMouseOverWindow = true;
        } else {
            this.isMouseOverWindow = false;
        }
    }
}
