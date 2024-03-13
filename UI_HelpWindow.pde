public class UI_HelpWindow extends UI_Window {



    private int activeSelectionID = -1;
    private String[] WindowTitles = new String[] {"Navigation & Controls", 
                                                  "Pen tool & Properties editor",
                                                  "Rigidbody tools",
                                                  "Force tools",
                                                  "Settings",
                                                  "Creations"
                                                  };


    private String[] NavigationAndControlsTexts = new String[] {
        "-To navigate between tabs, you can either press on an individual tab, or press Q or E to switch to the next or previous tab",
        "-To navigate between different hotbar slots, you can press the number keys between 1 & 7, each corresponding to a different slot",
        "-Pressing WASD or ZX keys while having a properties window open increments and decrements the dimensional sliders and angle sliders. Hold shift to increase the increment or decrement",
        "-Press CTRL-C while in edit mode and having a selection active to copy the selection, and press CTRL-V to paste the selection",
        "-Press RIGHT-CLICK and drag to pan the camera, and scroll to zoom in and out",
        "-Pressing the SPACEBAR will pause or unpause the simulation",
        "-Pressing TAB disables or enables cursor snapping"
    };


    private String[] PenToolAndPropertiesEditorTexts = new String[] {
        "-While having the pen tool selected, and having no shapes selected, click on a shape to edit its properties. You can add vertices by clicking on empty space, move vertices by dragging them, and delete vertices by pressing BACKSPACE while hovering over a vertex. To finish editing the body, press ENTER to exit edit mode",
        "-While having shapes selected and having your mouse over the selection box, drag to move the shapes around, and click again to deselect the shapes",
        "-While having the pen tool selected, drag to select a number of shapes. Once you have selected shapes, you are able to copy your selection with CTRL-C & paste your selection with CTRL-V"
    };

    private String[] RigidbodyToolsTexts = new String[] {
        "-To add a rigidbody simply click while having either the circle or the square selected",
        "-To increase the weight of a body, increase its density",
        "-To increase the bounciness of a body, increase its restitution",
        "-To increase the size or dimensions of a body, use the width and height sliders, or the radius slider. You can alternatively press WASD to increment or decrement the sliders dimensional sliders. Pressing SHIFT while using any of these keys will increase the increment and decrement",
        "-By setting the body as static, you make it immovable, both rotationally and positionally",
        "-By setting the body as having a fixed position or a fixed rotation, you either lock the position of the body but allow it to rotate, or you lock the rotation of the body, but allow its position to change, respectively"
    };

    private String[] ForceToolsTexts = new String[] {
        "-Changing the spring constant of a spring makes the spring stiffer or looser",
        "-Changing the equilibrium length of a spring changes the springs resting position",
        "-Changing the spring damping increases or decreases how quickly the springs oscillation slows down. Enabling the perfect spring option will make it oscillate indefinitely with no energy loss",
        "-Locking the translation of a spring to a specific axis makes the spring affect the acceleration of the parent body on only that axis",
        "-To correctly create a rod with the joint option enabled, first pause the simulation. Align the parts of the bodies you wish to connect, placing them directly on top of each other. After positioning, add the rod by clicking once",
        "-Changing the target angular velocity of a motor will increase its speed"
    };


    private String[] SettingsTexts = new String[] {
        "-Changing the simulation quality changes the sub-step count for each frame. Low corresponds to a sub-step count of 64, Medium to a sub-step count of 256, and High to a sub-step count of 1024",
        "-Changing the visual quality to Low disables smoothing and pure strokes. Changing it to medium enables bilinear smoothing while keeping pure strokes disabled. Changing it to High enables bicubic smoothing, enables pure strokes, and if your computer screen or monitor is an Apple Retina display, or a Windows HiDPI display, it enables 2x pixel density",
        "-Changing the text quality to Low disables text smoothing and pure glyphs. Changing the text quality to High enables text smoothing and glyphs"
    };

    private String[] CreationsTexts = new String[] {
        "-To save a level, press \"Save Level\", enter the level name, and press ENTER. Once a level has been saved, it's name cannot be used again. Level names can only contain letters and numbers, with no special characters",
        "-To load a creation, select it from the window and press \"Load Level\". To delete a level, select it and press \"Delete Level\"",
        "-Once more than 5 levels have been saved, a new page will be added. Press the \"Prev Page\" and \"Next Page\" buttons to alternate between level pages",
    };


    private float initialYPadding = 40;
    private float padding = 15;


    public UI_HelpWindow() {
        super("Help", 4, new PVector(713, 700), new PVector(713, 47), new PVector(713, 653), false);
        this.setWindowPosition(new PVector(displayWidth/2, displayHeight/2 - 35));
        textFont(UI_Constants.INTER_BOLD);
        textSize(25);
        textAlign(CENTER, CENTER);
        this.Window_Text_Width = textWidth(this.Window_Name);
        this.Window_Text_Position.set(0, -(this.Window_Form_Container_Size.y + this.Window_Text_Container_Size.y) / 2 - (textAscent() - textDescent()) * UI_Constants.GLOBAL_TEXT_ALIGN_FACTOR_Y);
    }   


    @Override
    public void drawText() {
        if(this.isActiveWindow) {
            fill(UI_Constants.WHITE);
        } else {
            fill(UI_Constants.GRAY_25);
        }

        textFont(UI_Constants.INTER_BOLD);
        textSize(25);
        textAlign(CENTER, CENTER);
        
        if(this.activeSelectionID == -1) {
            text(this.Window_Name, this.Window_Text_Position.x, this.Window_Text_Position.y);
        } else {
            text(this.WindowTitles[this.activeSelectionID], this.Window_Text_Position.x, this.Window_Text_Position.y);
        }
    }

    public void switchToSelectionScene() {
        this.clearAllElements();
        this.addElement(new UI_Button("Navigation & Controls", this, false));
        this.addElement(new UI_Button("Pen tool & Properties editor", this, false));
        this.addElement(new UI_Button("Rigidbody tools", this, false));
        this.addElement(new UI_Button("Force tools", this, false));
        this.addElement(new UI_Button("Settings", this, false));
        this.addElement(new UI_Button("Creations", this, false));
    }


    public void switchToNavigationAndControlsScene() {
        this.clearAllElements();
        //30px required per new row of text
        // public UI_Text(String Text_Name, UI_Window Text_ParentWindow, PVector Text_Position, PVector Text_BoxDimensions, int Text_AlignMode, int Text_Size, int Text_Color, boolean Text_ShowName, PFont Text_Font) {
        float[] textBoxHeights = {this.calculateTextBoxHeight(this.NavigationAndControlsTexts[0], 2, 1.2), this.calculateTextBoxHeight(this.NavigationAndControlsTexts[1], 2, 1.2), this.calculateTextBoxHeight(this.NavigationAndControlsTexts[2], 3, 1.2), this.calculateTextBoxHeight(this.NavigationAndControlsTexts[3], 2, 1.2), this.calculateTextBoxHeight(this.NavigationAndControlsTexts[4], 2, 1.2), this.calculateTextBoxHeight(this.NavigationAndControlsTexts[5], 1, 1.2), this.calculateTextBoxHeight(this.NavigationAndControlsTexts[6], 1, 1.2)};

        for(int i = 0; i < this.NavigationAndControlsTexts.length; i++) {
            this.addElement(new UI_Text(this.NavigationAndControlsTexts[i], this, this.calculateTextBoxPosition(i, textBoxHeights, padding), new PVector(633, textBoxHeights[i]), 3, 20, UI_Constants.WHITE, true, UI_Constants.INTER_REGULAR));
        }

        this.addElement(new UI_Button("Back", this, false));
    }

    public void switchToPenAndPropertiesScene() {
        this.clearAllElements();

        float[] textBoxHeights = {this.calculateTextBoxHeight(this.PenToolAndPropertiesEditorTexts[0], 6, 1.2), this.calculateTextBoxHeight(this.PenToolAndPropertiesEditorTexts[1], 3, 1.2), this.calculateTextBoxHeight(this.PenToolAndPropertiesEditorTexts[2], 3, 1.2)};

        for(int i = 0; i < this.PenToolAndPropertiesEditorTexts.length; i++) {
            this.addElement(new UI_Text(this.PenToolAndPropertiesEditorTexts[i], this, this.calculateTextBoxPosition(i, textBoxHeights, padding), new PVector(633, textBoxHeights[i]), 3, 20, UI_Constants.WHITE, true, UI_Constants.INTER_REGULAR));
        }
        this.addElement(new UI_Button("Back", this, false));
    }

    public void switchToRigidbodyToolsScene() {
        this.clearAllElements();

        float[] textBoxHeights = {this.calculateTextBoxHeight(this.RigidbodyToolsTexts[0], 2, 1.2), this.calculateTextBoxHeight(this.RigidbodyToolsTexts[1], 1, 1.2), this.calculateTextBoxHeight(this.RigidbodyToolsTexts[2], 1, 1.2), this.calculateTextBoxHeight(this.RigidbodyToolsTexts[3], 5, 1.2), this.calculateTextBoxHeight(this.RigidbodyToolsTexts[4], 2, 1.2), this.calculateTextBoxHeight(this.RigidbodyToolsTexts[5], 4, 1.2)};
        for(int i = 0; i < this.RigidbodyToolsTexts.length; i++) {
            this.addElement(new UI_Text(this.RigidbodyToolsTexts[i], this, this.calculateTextBoxPosition(i, textBoxHeights, padding), new PVector(633, textBoxHeights[i]), 3, 20, UI_Constants.WHITE, true, UI_Constants.INTER_REGULAR));
        }
        this.addElement(new UI_Button("Back", this, false));
    }

    public void switchToForcesToolsScene() {
        this.clearAllElements();

        float[] textBoxHeights = {this.calculateTextBoxHeight(this.ForceToolsTexts[0], 2, 1.2), this.calculateTextBoxHeight(this.ForceToolsTexts[1], 2, 1.2), this.calculateTextBoxHeight(this.ForceToolsTexts[2], 3, 1.2), this.calculateTextBoxHeight(this.ForceToolsTexts[3], 2, 1.2), this.calculateTextBoxHeight(this.ForceToolsTexts[4], 4, 1.2), this.calculateTextBoxHeight(this.ForceToolsTexts[5], 3, 1.2)};
        for(int i = 0; i < this.ForceToolsTexts.length; i++) {
            this.addElement(new UI_Text(this.ForceToolsTexts[i], this, this.calculateTextBoxPosition(i, textBoxHeights, padding), new PVector(633, textBoxHeights[i]), 3, 20, UI_Constants.WHITE, true, UI_Constants.INTER_REGULAR));
        }
        this.addElement(new UI_Button("Back", this, false));
    }

    public void switchToSettingsScene() {
        this.clearAllElements();

        float[] textBoxHeights = {this.calculateTextBoxHeight(this.SettingsTexts[0], 3, 1.2), this.calculateTextBoxHeight(this.SettingsTexts[1], 6, 1.2), this.calculateTextBoxHeight(this.SettingsTexts[2], 3, 1.2)};
        for(int i = 0; i < this.SettingsTexts.length; i++) {
            this.addElement(new UI_Text(this.SettingsTexts[i], this, this.calculateTextBoxPosition(i, textBoxHeights, padding), new PVector(633, textBoxHeights[i]), 3, 20, UI_Constants.WHITE, true, UI_Constants.INTER_REGULAR));
        }
        this.addElement(new UI_Button("Back", this, false));
    }

    public void switchToCreationsScene() {
        this.clearAllElements();

        float[] textBoxHeights = {this.calculateTextBoxHeight(this.CreationsTexts[0], 4, 1.2), this.calculateTextBoxHeight(this.CreationsTexts[1], 2, 1.2), this.calculateTextBoxHeight(this.CreationsTexts[2], 3, 1.2)};

        for(int i = 0; i < this.CreationsTexts.length; i++) {
            this.addElement(new UI_Text(this.CreationsTexts[i], this, this.calculateTextBoxPosition(i, textBoxHeights, padding), new PVector(633, textBoxHeights[i]), 3, 20, UI_Constants.WHITE, true, UI_Constants.INTER_REGULAR));
        }
        this.addElement(new UI_Button("Back", this, false));
    }


    public void onButtonPress(String name) {
        switch (name) {
            case "Navigation & Controls":
                this.activeSelectionID = 0;
                this.switchToNavigationAndControlsScene();
                break;
            case "Pen tool & Properties editor":
                this.activeSelectionID = 1;
                this.switchToPenAndPropertiesScene();
                break;
            case "Rigidbody tools":
                this.activeSelectionID = 2;
                this.switchToRigidbodyToolsScene();
                break;
            case "Force tools":
                this.activeSelectionID = 3;
                this.switchToForcesToolsScene();
                break;
            case "Settings":
                this.activeSelectionID = 4;
                this.switchToSettingsScene();
                break;
            case "Creations":
                this.activeSelectionID = 5;
                this.switchToCreationsScene();
                break;
            case "Back":
                this.activeSelectionID = -1;
                this.switchToSelectionScene();
                break;
        }
    }
    public void open() {
        this.deselectAllWindows();
        this.isActiveWindow = true;
        this.Window_Visibility = true;
        UI_Manager.bringToFront(this);
        this.Window_Container.getChild("Window_Container_Stroke").setStroke(UI_Constants.BLUE_SELECTED);
        this.Window_Container.getChild("Window_Text_Container").setFill(UI_Constants.BLUE_UNSELECTED);
        this.switchToSelectionScene();

    }



    @Override
    public void interactionDraw() {
        if(UI_Manager.getTabBar().getActiveTabID() == 3) {
            this.lockSelected();
            UI_Manager.closeAllWindows(this);
        }   
    }

    @Override
    public boolean onMouseDrag() {
        if(!this.Window_Visibility) {
            return false;
        }
        if(mousePressed && this.isMouseOverWindowFormContainer) {
            this.onElementMouseDrag();
            return true;
        }
        return false;
    }



    public void lockSelected() {
        this.isActiveWindow = true;
        this.Window_Visibility = true;
        UI_Manager.getHotBar().setActiveSlotID(-1);
        this.Window_Container.getChild("Window_Container_Stroke").setStroke(UI_Constants.BLUE_SELECTED);
        this.Window_Container.getChild("Window_Text_Container").setFill(UI_Constants.BLUE_UNSELECTED);
    }


    public float calculateTextBoxHeight(String text, int numLines, float lineSpacing) {
        textFont(UI_Constants.INTER_REGULAR);
        textSize(20);
        float lineHeight = textAscent() + textDescent();
        float textBoxHeight = (lineHeight * lineSpacing) * numLines; //+ 2 * padding;
        return textBoxHeight;

        // return 20*lineSpacing*numLines;
    }

    public float calculateTextBoxWidth(String text, int padding, int numTextBoxes) {
        float textBoxWidth = (width - 2 * padding) / numTextBoxes;
        return textBoxWidth;
    }

    public PVector calculateTextBoxPosition(int index, float[] textBoxHeights, float padding) {
        float yPosition = -this.Window_Form_Container_Size.y / 2 + initialYPadding;
        for (int i = 0; i < index; i++) {
            yPosition += textBoxHeights[i] + padding;
        }
        return new PVector(-this.Window_Form_Container_Size.x / 2 + 40, yPosition);
    }
}
  
