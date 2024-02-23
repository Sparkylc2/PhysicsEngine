public class UI_Window {
    
    public final String Window_Name;
    public PVector Window_Position = new PVector(500, 400);
    public final int Window_ID;

    public boolean Window_Visibility = true;
    public float Window_Scale = displayWidth / 1512;

    public PShape Window_Container;

    /*
    Visuals
    */
    public final PVector Window_Container_Size = new PVector(285, 407);
    public final PVector Window_Text_Container_Size = new PVector(285, 35);
    public final PVector Window_Form_Container_Size = new PVector(285, 407-35);
    public final PVector Window_Text_Position = new PVector();
    public float Window_Text_Width;
    public final float Window_Rounding = 7;

    /*
    Elements
    */
    public ArrayList<UI_Element> Window_Elements = new ArrayList<UI_Element>();



    /*
    Interaction
    */
    public PVector initialMouseDragPosition = new PVector();
    

    public boolean isActiveWindow = false;
    public boolean isMouseOverWindow = false;
    public boolean isMouseOverWindowTextContainer = false;
    public boolean isMouseOverWindowFormContainer = false;

    public boolean isDragging = false;
    public boolean wasMousePressedOverWindow = false;
    /*
    For Testing
    */
    public UI_Window(String Window_Name, int Window_ID) {
        this.Window_Name = Window_Name;
        this.Window_ID = Window_ID;
        this.initializeWindow();
    }


/*
============================================= Initialization =======================================
*/
    public void initializeWindow() {
        textFont(UI_Constants.FONT[0]);
        textSize(UI_Constants.WINDOW_TITLE_TEXT_SIZE);
        textAlign(CENTER, CENTER);

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
        
        PShape Window_Container_TickMark = createShape(GROUP);
            Window_Container_TickMark.setName("Window_Container_TickMark");

            PShape TickMark_LineOne = createShape();
                TickMark_LineOne.beginShape();
                    TickMark_LineOne.vertex(this.Window_Text_Container_Size.x / 2 - 17, Window_Text_Container.getParam(1) - 6);
                    TickMark_LineOne.vertex(this.Window_Text_Container_Size.x / 2 - 29, Window_Text_Container.getParam(1) + 6);
                TickMark_LineOne.endShape();
                TickMark_LineOne.setFill(false);
                TickMark_LineOne.setStrokeWeight(2);
                TickMark_LineOne.setStroke(UI_Constants.GRAY_UNSELECTED_TEXT);

            PShape TickMark_LineTwo = createShape();
                TickMark_LineTwo.beginShape();
                    TickMark_LineTwo.vertex(this.Window_Text_Container_Size.x / 2 - 29, Window_Text_Container.getParam(1) - 6);
                    TickMark_LineTwo.vertex(this.Window_Text_Container_Size.x / 2 - 17, Window_Text_Container.getParam(1) + 6);
                TickMark_LineTwo.endShape();
                TickMark_LineTwo.setFill(false);
                TickMark_LineTwo.setStrokeWeight(2);
                TickMark_LineTwo.setStroke(UI_Constants.GRAY_UNSELECTED_TEXT);
            
            Window_Container_TickMark.addChild(TickMark_LineOne);
            Window_Container_TickMark.addChild(TickMark_LineTwo);

        PShape Window_Container_Listener = UI_Constants.createElementListener(Window_Container_Stroke);
                Window_Container_Listener.setName("Window_Container_Listener");
        PShape Window_Form_Container_Listener = UI_Constants.createElementListener(Window_Form_Container);
                Window_Form_Container_Listener.setName("Window_Form_Container_Listener");
        PShape Window_Text_Container_Listener = UI_Constants.createElementListener(Window_Text_Container);
                Window_Text_Container_Listener.setName("Window_Text_Container_Listener");
        PShape Window_Container_TickMark_Listener = createShape();
                Window_Container_TickMark_Listener.beginShape();
                    Window_Container_TickMark_Listener.vertex(this.Window_Text_Container_Size.x / 2 - 29, Window_Text_Container.getParam(1) - 6);
                    Window_Container_TickMark_Listener.vertex(this.Window_Text_Container_Size.x / 2 - 17, Window_Text_Container.getParam(1) - 6);
                    Window_Container_TickMark_Listener.vertex(this.Window_Text_Container_Size.x / 2 - 17, Window_Text_Container.getParam(1) + 6);
                    Window_Container_TickMark_Listener.vertex(this.Window_Text_Container_Size.x / 2 - 29, Window_Text_Container.getParam(1) + 6);
                Window_Container_TickMark_Listener.endShape(CLOSE);
                Window_Container_TickMark_Listener.setName("Window_Container_TickMark_Listener");
                Window_Container_TickMark_Listener.setFill(false);
                Window_Container_TickMark_Listener.setStroke(false);
            
        this.Window_Container.addChild(Window_Form_Container);
        this.Window_Container.addChild(Window_Text_Container);
        this.Window_Container.addChild(Window_Container_Stroke);
        this.Window_Container.addChild(Window_Container_TickMark);

        this.Window_Container.addChild(Window_Container_Listener);
        this.Window_Container.addChild(Window_Form_Container_Listener);
        this.Window_Container.addChild(Window_Text_Container_Listener);
        this.Window_Container.addChild(Window_Container_TickMark_Listener);

        this.Window_Container.resetMatrix();
        this.Window_Container.translate(this.Window_Position.x, this.Window_Position.y);
        this.Window_Container.scale(this.Window_Scale);


        this.Window_Text_Width = textWidth(this.Window_Name);
        this.Window_Text_Position.set(-this.Window_Text_Container_Size.x / 2 + textWidth(this.Window_Name) / 2 + 15, -(this.Window_Form_Container_Size.y + this.Window_Text_Container_Size.y) / 2);
    }

/*
============================================= Draw =================================================
*/  
    public void draw() {
        if(!this.Window_Visibility) {
            return;
        }

        this.drawShape();
        pushMatrix();
        translate(this.Window_Position.x, this.Window_Position.y);
        scale(this.Window_Scale);
            this.drawText();
            this.drawElementText();
        popMatrix();

        this.updateIsMouseOverWindow();
    }

    public void drawElementText() {
        for(UI_Element element : this.Window_Elements) {
            element.drawText();
        }
    }

    public void drawText() {
        fill(UI_Constants.WINDOW_TITLE_TEXT_COLOR);
        textFont(UI_Constants.FONT[0]);
        textSize(UI_Constants.WINDOW_TITLE_TEXT_SIZE);
        textAlign(CENTER, CENTER);

        text(this.Window_Name, this.Window_Text_Position.x, this.Window_Text_Position.y);
    }

    public void drawShape() {
        shape(this.Window_Container, 0, 0);
    }

/*
============================================= Interaction ==========================================
*/
    public void onMouseRelease() {
        if(!this.Window_Visibility) {
            return;
        }
        this.onElementMouseRelease();
        this.isDragging = false;
        this.wasMousePressedOverWindow = false;
    }

    public boolean onMouseDrag() {
        if(!this.Window_Visibility) {
            return false;
        }

        if(mousePressed && this.isMouseOverWindowFormContainer) {
            this.onElementMouseDrag();
            return true;
        }
        
        if (mousePressed && this.isMouseOverWindowTextContainer && this.wasMousePressedOverWindow) {
            if (!this.isDragging) {
                this.initialMouseDragPosition.set(mouseX, mouseY);
                this.isDragging = true;
            } else {
                PVector mouseDragDifference = PVector.sub(new PVector(mouseX, mouseY), this.initialMouseDragPosition);
                this.Window_Position.add(mouseDragDifference);
                this.Window_Container.resetMatrix();
                this.Window_Container.translate(this.Window_Position.x, this.Window_Position.y);
                this.initialMouseDragPosition.set(mouseX, mouseY);
            }
            return true;
        } else {
            this.isDragging = false;
            return false;
        }
    }

    public boolean onMousePress() {
        if(!this.Window_Visibility) {
            return false;
        }

        if(mouseButton == LEFT) {
            if(this.isMouseOverWindow) {
                this.wasMousePressedOverWindow = true;
                this.checkWindowClose();
                this.deselectAllWindows();
                this.onWindowSelect();
                this.onElementMousePress();
                return true;
            } else {
                this.onWindowDeselect();
                return false;
            }
        } else {
            return false;
        }
    }

    public void onElementMousePress() {
        for(UI_Element element : this.Window_Elements) {
            if(!element.onMousePress()) {
                continue;
            }

            if(element instanceof UI_Toggle) {
                handleToggleElement((UI_Toggle)element);
            } else if(element instanceof UI_Slider) {
                element.onSelect();
            }
        }
    }

    private void handleToggleElement(UI_Toggle toggleElement) {
        if(toggleElement.getState()) {
            toggleElement.onDeselect();
        } else {
            deselectGroupElements(toggleElement.getGroupName(), toggleElement);
            toggleElement.onSelect();
        }
    }

    private void deselectGroupElements(String groupName, UI_Element selectedElement) {
        if(groupName == null) {
            return;
        }

        for(UI_Element element : this.Window_Elements) {
            if(element != selectedElement && groupName.equals(element.getGroupName())) {
                element.onDeselect();
            }
        }
    }
    public void onElementMouseDrag() {
        for(UI_Element element : this.Window_Elements) {
            element.onMouseDrag();
        }
    }

    public void onElementMouseRelease() {
        for(UI_Element element : this.Window_Elements) {
            element.onMouseRelease();
        }
    }

    public void onWindowSelect() {
        this.isActiveWindow = true;
        this.Window_Container.getChild("Window_Container_Stroke").setStroke(UI_Constants.BLUE_SELECTED);
        this.Window_Container.getChild("Window_Text_Container").setFill(UI_Constants.BLUE_UNSELECTED);
    }

    public void onWindowDeselect() {
        this.isActiveWindow = false;
        this.Window_Container.getChild("Window_Container_Stroke").setStroke(UI_Constants.GRAY_400);
        this.Window_Container.getChild("Window_Text_Container").setFill(UI_Constants.GRAY_500);
    }

    public void onWindowClose() {
        this.Window_Visibility = false;
    }

    public void updateIsMouseOverWindow() {
        float x = mouseX - this.Window_Position.x;
        float y = mouseY - this.Window_Position.y;

        if(this.Window_Container.getChild("Window_Container_Listener").contains(x, y)) {
            if(this.Window_Container.getChild("Window_Text_Container_Listener").contains(x, y)) {
                this.isMouseOverWindowTextContainer = true;
                this.isMouseOverWindowFormContainer = false;
            } else {
                this.isMouseOverWindowTextContainer = false;
                this.isMouseOverWindowFormContainer = true;
            }
            this.isMouseOverWindow = true;
        } else {
            this.isMouseOverWindow = false;
            this.isMouseOverWindowTextContainer = false;
            this.isMouseOverWindowFormContainer = false;
        }
    }

    public void deselectAllWindows() {
        for (int i = 0; i < UI_Manager.WINDOWS.size(); i++) {
            UI_Manager.WINDOWS.get(i).onWindowDeselect();
        }
    }

    public void checkWindowClose() {
        if(this.Window_Container.getChild("Window_Container_TickMark_Listener").contains(mouseX - this.Window_Position.x, mouseY - this.Window_Position.y)) {
            this.onWindowClose();
        } else {
        }
    }


/*
============================================= Methods ==============================================
*/

    public void addElement(UI_Element element) {
        this.Window_Elements.add(element);
        this.Window_Container.addChild(element.getShape());
    }
/*
======================================== Getters & Setters =========================================
*/

    public float getWindowContainerWidth() {
        return this.Window_Container_Size.x;
    }
    public float getWindowContainerHeight() {
        return this.Window_Container_Size.y;
    }
    public PVector getWindowContainerDimensions() {
        return this.Window_Container_Size;
    }
    public float getWindowTextContainerWidth() {
        return this.Window_Text_Container_Size.x;
    }
    public float getWindowTextContainerHeight() {
        return this.Window_Text_Container_Size.y;
    }
    public PVector getWindowTextContainerDimensions() {
        return this.Window_Text_Container_Size;
    }
    public float getWindowFormContainerWidth() {
        return this.Window_Form_Container_Size.x;
    }
    public float getWindowFormContainerHeight() {
        return this.Window_Form_Container_Size.y;
    }
    public PVector getWindowFormContainerDimensions() {
        return this.Window_Form_Container_Size;
    }
    public float getWindowContainerCenterPositionX () {
        return this.Window_Position.x;
    }
    public float getWindowContainerCenterPositionY() {
        return this.Window_Position.y;
    }
    public float getWindowPositionX() {
        return this.Window_Position.x;
    }
    public float getWindowPositionY() {
        return this.Window_Position.y;
    }
    public PVector getWindowPosition() {
        return this.Window_Position;
    }
    public int getWindowElementArrayListSize() {
        return this.Window_Elements.size();
    }
    public int getWindowID() {
        return this.Window_ID;
    }
}
