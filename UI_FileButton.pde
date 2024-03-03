public class UI_FileButton extends UI_Element {
    

    public UI_Window FileButton_ParentWindow;

    public String FileButton_Name;
    public float FileButton_Name_Position_X;
    public float FileButton_Name_Position_Y;

    public String FileButton_Group;
    public boolean FileButton_State;
    public String FilePath;

    public boolean FileButton_ShowName = true;
    public File FileButton_File;

    public PShape FileButton_Shape_Group = createShape(GROUP);



    public UI_FileButton (File FileButton_File, String FileButton_Name, UI_Window FileButton_ParentWindow, String FileButton_Group, boolean FileButton_State, String FilePath) {
        this.FileButton_Name = FileButton_Name;
        this.FileButton_State = FileButton_State;
        this.FileButton_Group = FileButton_Group;
        this.FilePath = FilePath;
        this.FileButton_File = FileButton_File;


        this.FileButton_Shape_Group.setName(this.FileButton_Name + "Group");
        this.FileButton_ParentWindow = FileButton_ParentWindow;

        this.initializeFileButton();
    }

    public void initializeFileButton() {
        rectMode(CENTER);
        this.createElementBaseShape();
        this.createElementText();
    }




/*
======================================= Button Creation ============================================
*/  
    @Override
    public void createElementBaseShape() {

        this.Element_Height = 34;
        this.Element_Width = 272;

        rectMode(CENTER);
        int numElements = this.FileButton_ParentWindow.getWindowElementArrayListSize();

        float fileButtonShapeX;
        float fileButtonShapeY;
        float fileButtonShapeWidth;
        float fileButtonShapeHeight;

        if(numElements == 0) {
            fileButtonShapeX = 0;
            fileButtonShapeY = -this.FileButton_ParentWindow.getWindowFormContainerHeight() / 2 + this.Element_Container_Top_Padding_Y + this.Element_Height / 2;
            fileButtonShapeWidth = this.Element_Width;
            fileButtonShapeHeight = this.Element_Height;
            
        } else {
            fileButtonShapeX = 0;
            fileButtonShapeY = (this.Element_Height - this.FileButton_ParentWindow.getWindowFormContainerHeight()) /2 + (this.Element_Height + this.Element_Element_Padding_Y) * numElements + this.Element_Container_Top_Padding_Y;
            fileButtonShapeWidth = this.Element_Width;
            fileButtonShapeHeight = this.Element_Height;
        }

        PShape FileButton_Shape_Base = createShape(RECT, fileButtonShapeX, fileButtonShapeY, fileButtonShapeWidth, fileButtonShapeHeight, this.Element_Rounding);
            FileButton_Shape_Base.setName("FileButton_Shape_Base");
            FileButton_Shape_Base.setStrokeWeight(this.Element_Stroke_Weight);
            FileButton_Shape_Base.setFill(this.Element_Base_Unselected_Color);
            FileButton_Shape_Base.setStroke(this.Element_Base_Unselected_Stroke_Color);

        PShape FileButton_Shape_Base_Listener = UI_Constants.createElementListener(FileButton_Shape_Base);
            FileButton_Shape_Base_Listener.setName("FileButton_Shape_Base_Listener");

        this.FileButton_Shape_Group.addChild(FileButton_Shape_Base);
        this.FileButton_Shape_Group.addChild(FileButton_Shape_Base_Listener);
    }

    @Override 
    public void createElementText() {
        textFont(this.Element_Font);
        textSize(this.Element_Text_Size);
        textAlign(CENTER, CENTER);

        this.FileButton_Name_Position_X = this.FileButton_Shape_Group.getChild("FileButton_Shape_Base").getParam(0);
        this.FileButton_Name_Position_Y = this.FileButton_Shape_Group.getChild("FileButton_Shape_Base").getParam(1) - (textAscent() - textDescent()) * UI_Constants.GLOBAL_TEXT_ALIGN_FACTOR_Y;
    }


    public void onFileButtonSelect() {
        
    }

    public void onFileButtonDeselect() {


    }

    

/*
======================================= Button Interaction =========================================
*/  
    @Override
    public boolean onMousePress() {
        float x = mouseX - this.FileButton_ParentWindow.getWindowPosition().x;
        float y = mouseY - this.FileButton_ParentWindow.getWindowPosition().y;

        return this.FileButton_Shape_Group.getChild("FileButton_Shape_Base_Listener").contains(x, y);
    }

    @Override 
    public void onMouseRelease() {

    }

    @Override
    public void onMouseDrag() {
        
    }
    

    @Override
    public void onSelect() {
        this.FileButton_State = true;
        this.FileButton_Shape_Group.getChild("FileButton_Shape_Base").setStroke(this.Element_Base_Selected_Stroke_Color);
        this.FileButton_Shape_Group.getChild("FileButton_Shape_Base").setFill(this.Element_Base_Selected_Color);
    }


    @Override
    public void onDeselect() {
        this.FileButton_State = false;
        this.FileButton_Shape_Group.getChild("FileButton_Shape_Base").setStroke(this.Element_Base_Unselected_Stroke_Color);
        this.FileButton_Shape_Group.getChild("FileButton_Shape_Base").setFill(this.Element_Base_Unselected_Color);
    }

/*
=====================================  Button Draw ==================================================
*/

    @Override
    public void drawText() {
        fill(this.Element_Text_Color);
        textFont(this.Element_Font);
        textSize(this.Element_Text_Size);
        textAlign(CENTER, CENTER);

        if(this.FileButton_ShowName) {
            text(this.FileButton_Name, this.FileButton_Name_Position_X, this.FileButton_Name_Position_Y);
        }

    }




/*
======================================= Button Getters and Setters =================================
*/  

    public void deleteFile() {
        if(!this.FileButton_File.delete()) {
            System.out.println("Failed to delete file: " + this.FileButton_File.getName());
        }
    }

    public void renameFile(String newName) {

    if (newName == null || newName.trim().isEmpty()) {
        System.out.println("Invalid new name: " + newName);
        return;
    }

    String oldName = this.FileButton_File.getName().substring(0, this.FileButton_File.getName().indexOf(".json"));

    if(oldName.equals(newName)) {
        return;
    }

    File newFile = new File(sketchPath() + "/data/levelSaves/" + newName + ".json");

    if (newFile.exists()) {
        System.out.println("A file with the name " + newName + " already exists.");
        return;
    }

    if(!this.FileButton_File.renameTo(newFile)) {
        System.out.println("Failed to rename file: " + this.FileButton_File.getName() + " to " + newName);
    }

    }

    public boolean equals(UI_FileButton fileButton) {
        if(this.FileButton_Name.equals(fileButton.getElementName())) {
            this.onSelect();
            return true;
        }
        return false;
    }

    
    @Override   
    public String getElementName() {
        return this.FileButton_Name;
    }

    @Override
    public PShape getShape() {
        return this.FileButton_Shape_Group;
    }

    @Override
    public boolean getState() {
        return this.FileButton_State;
    }
    @Override
    public String getGroupName() {
        return this.FileButton_Group;
    }

    @Override 
    public float getValue() {
        return 0;
    }

    @Override
    public void setValue(float value) {
        return;
    }

    @Override
    public void incrementValue(float amount) {

    }

    @Override
    public void setState(boolean state) {
        if(state) {
            this.onSelect();
        } else {
            this.onDeselect();
        }
    }

}   
