public class UI_TextField extends UI_Element {


    private UI_Window TextField_ParentWindow;
    private float TextField_Position_X;
    private float TextField_Position_Y;

    private float TextField_Width = 304f;
    private float TextField_Height = 31f;
   
    private boolean TextField_Stroke_Enabled = false;

    private String TextField_Name = "";
    public String TextField_Text = "";

    public boolean TextField_ShowName = true;

    public boolean TextField_CenterX = false;

    private float TextField_Text_Position_X;
    private float TextField_Text_Position_Y;

    private int TextField_TextLength = 0;

    private boolean selected = false;

    private PShape TextField_Shape_Group = createShape(GROUP);
   

    public UI_TextField(String TextField_Name, UI_Window TextField_ParentWindow, float TextField_Position_X, float TextField_Position_Y, float TextField_Width, float TextField_Height) {
        this.TextField_Name = TextField_Name;
        this.TextField_ParentWindow = TextField_ParentWindow;
        this.TextField_Position_X = TextField_Position_X;
        this.TextField_Position_Y = TextField_Position_Y;

        this.Element_Width = (int)TextField_Width;
        this.Element_Height = (int)TextField_Height;
        this.TextField_Width = TextField_Width;
        this.TextField_Height = TextField_Height;

        this.TextField_Shape_Group.setName(this.TextField_Name + "Group");

        this.initializeTextField();
      
   }

   public UI_TextField(String TextField_Name, UI_Window TextField_ParentWindow, float TextField_Position_X, float TextField_Position_Y, float TextField_Width, float TextField_Height, boolean TextField_CenterX) {
        this.TextField_Name = TextField_Name;
        this.TextField_ParentWindow = TextField_ParentWindow;
        this.TextField_Position_X = TextField_Position_X;
        this.TextField_Position_Y = TextField_Position_Y;

        this.TextField_CenterX = TextField_CenterX;

        this.Element_Width = (int)TextField_Width;
        this.Element_Height = (int)TextField_Height;
        this.TextField_Width = TextField_Width;
        this.TextField_Height = TextField_Height;

        this.TextField_Shape_Group.setName(this.TextField_Name + "Group");

        this.initializeTextField();
      
   }

    public UI_TextField(String TextField_Name, UI_Window TextField_ParentWindow, float TextField_Position_X, float TextField_Position_Y) {
        this.TextField_Name = TextField_Name;   

        this.TextField_ParentWindow = TextField_ParentWindow;

        this.TextField_Position_X = TextField_Position_X;
        this.TextField_Position_Y = TextField_Position_Y;

        this.Element_Width = 290;
        this.Element_Height = 31;

        this.TextField_Width = this.Element_Width;
        this.TextField_Height = this.Element_Height;

        this.initializeTextField();
    }


    public void initializeTextField() {
        rectMode(CENTER);
        this.createElementBaseShape();
        this.createElementText();

        if(!this.TextField_Name.equals("Level Name")) {
            this.onSelect();
        }
    }
    @Override
    public void createElementBaseShape() {
        PShape TextField_Shape_Base = createShape(RECT, TextField_Position_X, TextField_Position_Y, TextField_Width, TextField_Height, this.Element_Rounding);
            TextField_Shape_Base.setName("Base");
            TextField_Shape_Base.setFill(false);
            TextField_Shape_Base.setStroke(this.Element_Base_Unselected_Stroke_Color);

        PShape TextField_Shape_Base_Listener = UI_Constants.createElementListener(TextField_Shape_Base);
            TextField_Shape_Base_Listener.setName("Listener");

        this.TextField_Shape_Group.addChild(TextField_Shape_Base);
        this.TextField_Shape_Group.addChild(TextField_Shape_Base_Listener);
    }

    @Override
    public void createElementText() {
        textFont(this.Element_Font);
        textSize(this.Element_Text_Size);
        if(this.TextField_CenterX) {
            textAlign(CENTER, CENTER);
            this.TextField_Text_Position_X = this.TextField_Position_X;
            this.TextField_Text_Position_Y = this.TextField_Position_Y - (textAscent() - textDescent()) * UI_Constants.GLOBAL_TEXT_ALIGN_FACTOR_Y;
        } else {
            textAlign(LEFT, CENTER);
            this.TextField_Text_Position_X = this.TextField_Position_X - (this.TextField_Width/2) + 17;
            this.TextField_Text_Position_Y = this.TextField_Position_Y - (textAscent() - textDescent()) * UI_Constants.GLOBAL_TEXT_ALIGN_FACTOR_Y;
        }
    }


    @Override
    public void drawText() {
        textFont(this.Element_Font);
        textSize(this.Element_Text_Size);
        if(this.TextField_CenterX) {
            textAlign(CENTER, CENTER);
        } else {
            textAlign(LEFT, CENTER);
        }

        if(!this.selected && this.TextField_Text.equals("") && this.TextField_ShowName) {
            fill(color(255, 255, 255, 166));
            text(this.TextField_Name, this.TextField_Text_Position_X, this.TextField_Text_Position_Y);
        } else {
            fill(color(255, 255, 255, 255));
            text(this.TextField_Text, this.TextField_Text_Position_X, this.TextField_Text_Position_Y);
        }
    }
   
   // IF THE KEYCODE IS ENTER RETURN 1
   // ELSE RETURN 0

    public boolean keyPress(char Key, int KeyCode) {
        if(this.selected) {
            if(KeyCode == BACKSPACE) {
                this.Backspace();
            } else if(KeyCode == 32) {
                this.addText(' ');
            } else if(KeyCode == ENTER) {
                if(this.TextField_Name.equals("Level Name")) {
                    UI_CreationWindow creationWindow = (UI_CreationWindow)this.TextField_ParentWindow;
                    creationWindow.onLevelSaved();
                    this.onDeselect();
                    return true;
                } else if(this.TextField_Name.equals("Rename Level TextField")){
                    UI_CreationWindow creationWindow = (UI_CreationWindow)this.TextField_ParentWindow;
                    creationWindow.onLevelRenamed();
                    this.onDeselect();
                    return true;
                }
            } else {
                boolean isKeyLetter = (Character.toLowerCase(Key) >= 'a' && Character.toLowerCase(Key) <= 'z');
                boolean isKeyNumber = (Key >= '0' && Key <= '9');


                if(isKeyLetter || isKeyNumber) {
                    if(KeyHandler.isKeyDown(KeyEvent.VK_SHIFT)) {
                        this.addText(Character.toUpperCase(Key));
                    } else {
                        this.addText(Character.toLowerCase(Key));
                    }
                }
            }
        }
        return false;
    }

   
   private void addText(char text) {
      if (textWidth(this.TextField_Text + text) < this.TextField_Width - 20) {
         this.TextField_Text += text;
         this.TextField_TextLength++;
      }
   }
   
   private void Backspace() {
      if (this.TextField_TextLength - 1 >= 0) {
         this.TextField_Text = this.TextField_Text.substring(0, this.TextField_TextLength - 1);
         this.TextField_TextLength--;
      }
   }
    
    @Override
    public boolean onMousePress() {
        float x = mouseX - this.TextField_ParentWindow.getWindowPosition().x;
        float y = mouseY - this.TextField_ParentWindow.getWindowPosition().y;

        if(this.TextField_Shape_Group.getChild("Listener").contains(x, y)) {
            this.onSelect();
            return true;
        } else {
            this.onDeselect();
            return false;
        }
    }

    @Override
    public void onMouseRelease() {

    }

    @Override
    public void onMouseDrag() {

    }

    @Override
    public void onSelect() {
        this.selected = true;
        IS_TEXTFIELD_ACTIVE = true;

        this.TextField_Shape_Group.getChild("Base").setStroke(UI_Constants.GRAY_300);
    }

    @Override
    public void onDeselect() {
        this.TextField_Text = "";
        this.TextField_TextLength = 0;
        this.selected = false;
        IS_TEXTFIELD_ACTIVE = false;
        this.TextField_Shape_Group.getChild("Base").setStroke(UI_Constants.GRAY_500);
        
        if(this.TextField_Name.equals("Rename Level TextField")) {
            UI_CreationWindow creationWindow = (UI_CreationWindow)this.TextField_ParentWindow;
            creationWindow.state = UI_State.DEFAULT;
            creationWindow.previousState = UI_State.DEFAULT;
            creationWindow.redrawState();
        } else if (this.TextField_Name.equals("Level Name")) {
            UI_CreationWindow creationWindow = (UI_CreationWindow)this.TextField_ParentWindow;
            creationWindow.previousState = UI_State.DEFAULT;
            creationWindow.state = UI_State.DEFAULT;
            creationWindow.redrawState();
        }
    }

    
    private void onHover() {
        this.TextField_Shape_Group.getChild("Base").setStroke(UI_Constants.GRAY_400);
    }

    @Override
    public boolean getState() {
        return this.selected;
    }

    @Override
    public void setState(boolean state) {
        this.selected = state;
    }

    @Override
    public float getValue() {
        return 0;
    }

    @Override
    public void setValue(float value) {

    }

    @Override
    public void incrementValue(float amount) {

    }

    @Override
    public String getElementName() {
        return this.TextField_Name;
    }

    @Override
    public String getGroupName() {
        return null;
    }

    @Override
    public PShape getShape() {
        return this.TextField_Shape_Group;
    }
}
