public class UI_Text extends UI_Element {


    private UI_Window Text_ParentWindow;

    private String Text_Name = "";
    private float Text_Position_X;
    private float Text_Position_Y;

    private PFont Text_Font = UI_Constants.INTER_BOLD;
    private int Text_AlignMode = 0;
    private int Text_Size = 12;
    private int Text_Color = color(255, 255, 255);

    private boolean Text_ShowName = true;
    
    public UI_Text(String Text_Name, UI_Window Text_ParentWindow, float Text_Position_X, float Text_Position_Y, int Text_AlignMode, int Text_Size, int Text_Color, boolean Text_ShowName, PFont Text_Font) {
        this.Text_Name = Text_Name;
        this.Text_Font = Text_Font;
        this.Text_ParentWindow = Text_ParentWindow;
        this.Text_Position_X = Text_Position_X;
        this.Text_Position_Y = Text_Position_Y;
        this.Text_AlignMode = Text_AlignMode;
        this.Text_Size = Text_Size;
        this.Text_Color = Text_Color;
        this.Text_ShowName = Text_ShowName;

        this.createElementText();
    }

    @Override
    public void createElementBaseShape() {

    }

    @Override
    public void createElementText() {
        textFont(this.Text_Font);
        textSize(this.Text_Size);
        if(this.Text_AlignMode == 0) {
            textAlign(CENTER, CENTER);
        } else if(this.Text_AlignMode == 1) {
            textAlign(LEFT, CENTER);
        } else if(this.Text_AlignMode == 2) {
            textAlign(RIGHT, CENTER);
        } else {
            throw new IllegalArgumentException("Invalid Text Alignment Mode");
        }

        this.Text_Position_Y -= (textAscent() - textDescent()) * UI_Constants.GLOBAL_TEXT_ALIGN_FACTOR_Y;
    }


    @Override
    public void drawText() {
        textFont(this.Text_Font);
        textSize(this.Text_Size);
        fill(this.Text_Color);

        if(this.Text_AlignMode == 0) {
            textAlign(CENTER, CENTER);
        } else if(this.Text_AlignMode == 1) {
            textAlign(LEFT, CENTER);
        } else if(this.Text_AlignMode == 2) {
            textAlign(RIGHT, CENTER);
        } else {
            throw new IllegalArgumentException("Invalid Text Alignment Mode");
        }

        if(this.Text_ShowName) {
            text(this.Text_Name, this.Text_Position_X, this.Text_Position_Y);
        }
    }
   
   
    
    @Override
    public boolean onMousePress() {
        return false;

    }

    @Override
    public void onMouseRelease() {

    }

    @Override
    public void onMouseDrag() {

    }

    @Override
    public void onSelect() {

    }

    @Override
    public void onDeselect() {
    
    }

    @Override
    public boolean getState() {
        return false;
    }

    @Override
    public void setState(boolean state) {

    }

    @Override
    public float getValue() {
        return -1;
    }

    @Override
    public void setValue(float value) {

    }

    @Override
    public void incrementValue(float amount) {

    }

    @Override
    public String getElementName() {
        return this.Text_Name;
    }

    @Override
    public String getGroupName() {
        return null;
    }

    @Override
    public PShape getShape() {
        return null;
    }
}
