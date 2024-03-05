public class UI_SettingsWindow extends UI_Window {

    public UI_QualitySettings qualitySettings = new UI_QualitySettings(false);
    private String currentSimulationQuality = qualitySettings.settings.getString("SimulationQuality");
    private String currentVisualQuality = qualitySettings.settings.getString("VisualQuality");
    private String currentScrollSensitivity = qualitySettings.settings.getString("ScrollSensitivity");
    private String currentTextQuality = qualitySettings.settings.getString("TextQuality");

    private boolean currentShowFrameStats = qualitySettings.settings.getBoolean("Show Frame Stats");
    private boolean currentShowAABBs = qualitySettings.settings.getBoolean("Show AABBs");
    private boolean currentShowCollisionPoints = qualitySettings.settings.getBoolean("Show Collision Points");

    private UI_TickSlider Simulation_Quality;
    private UI_TickSlider Visual_Quality;
    private UI_TickSlider Scroll_Sensitivity;
    private UI_TickSlider Text_Quality;

    private UI_Toggle Show_Frame_Stats;
    private UI_Toggle Show_AABBs;
    private UI_Toggle Show_Collision_Points;

    private UI_Button Reset_To_Defaults;

    private String prvSimulationQuality = currentSimulationQuality;
    private String prvVisualQuality = currentVisualQuality;
    private String prvScrollSensitivity = currentScrollSensitivity;
    private String prvTextQuality = currentTextQuality;

    private boolean prvShowFrameStats = currentShowFrameStats;
    private boolean prvShowAABBs = currentShowAABBs;
    private boolean prvShowCollisionPoints = currentShowCollisionPoints;




    public UI_SettingsWindow() {
        super("Settings", 4, new PVector(713, 700), new PVector(713, 47), new PVector(713, 653), false);
        this.setWindowPosition(new PVector(displayWidth/2, displayHeight/2));
        textFont(UI_Constants.INTER_BOLD);
        textSize(25);
        textAlign(CENTER, CENTER);
        this.Window_Text_Width = textWidth(this.Window_Name);
        this.Window_Text_Position.set(0, -(this.Window_Form_Container_Size.y + this.Window_Text_Container_Size.y) / 2 + (textAscent() - textDescent()) * UI_Constants.GLOBAL_TEXT_ALIGN_FACTOR_Y);

        this.initializeSettingsWindow();
    }

    public void initializeSettingsWindow() {
        /*
        Text
        */
        this.addElement(new UI_Text("Simulation Quality", (UI_Window)this, -this.Window_Form_Container_Size.x / 4, -this.Window_Form_Container_Size.y / 2 + 50, 0, 25, UI_Constants.GRAY_25, true, UI_Constants.INTER_BOLD));
        this.addElement(new UI_Text("Visual Quality", (UI_Window)this, this.Window_Form_Container_Size.x / 4, -this.Window_Form_Container_Size.y / 2 + 50, 0, 25, UI_Constants.GRAY_25, true, UI_Constants.INTER_BOLD));
        this.addElement(new UI_Text("Scroll Sensitivity", (UI_Window)this, -this.Window_Form_Container_Size.x / 4, -this.Window_Form_Container_Size.y / 2 + 200, 0, 25, UI_Constants.GRAY_25, true, UI_Constants.INTER_BOLD));
        this.addElement(new UI_Text("Text Quality", (UI_Window)this, this.Window_Form_Container_Size.x / 4, -this.Window_Form_Container_Size.y / 2 + 200, 0, 25, UI_Constants.GRAY_25, true, UI_Constants.INTER_BOLD));
        this.addElement(new UI_Text("Debugging", (UI_Window)this, 0, -this.Window_Form_Container_Size.y / 2 + 350, 0, 25, UI_Constants.GRAY_25, true, UI_Constants.INTER_BOLD));
        /*
        Toggles
        */

        this.Show_Frame_Stats = new UI_Toggle("Show Frame Stats", (UI_Window)this, 0, -this.Window_Form_Container_Size.y / 2 + 390, this.currentShowFrameStats, 1.22);
        this.Show_AABBs = new UI_Toggle("Show AABB's", (UI_Window)this, 0, -this.Window_Form_Container_Size.y / 2 + 440, this.currentShowAABBs, 1.22);
        this.Show_Collision_Points = new UI_Toggle("Show Collision Points", (UI_Window)this, 0, -this.Window_Form_Container_Size.y / 2 + 490, this.currentShowCollisionPoints, 1.22);
        this.addElement(this.Show_Frame_Stats);
        this.addElement(this.Show_AABBs);
        this.addElement(this.Show_Collision_Points);

        /*
        Sliders
        */
        this.Simulation_Quality = new UI_TickSlider(new String[]{"Low", "Medium", "High"}, (UI_Window)this, this.currentSimulationQuality, -this.Window_Form_Container_Size.x / 4,  -this.Window_Form_Container_Size.y / 2 + 125, 3);
        this.Visual_Quality = new UI_TickSlider(new String[]{"Low", "Medium", "High"}, (UI_Window)this, this.currentVisualQuality, this.Window_Form_Container_Size.x / 4,  -this.Window_Form_Container_Size.y / 2 + 125, 3);
        this.Scroll_Sensitivity = new UI_TickSlider(new String[]{"Low", "Medium", "High"}, (UI_Window)this, this.currentScrollSensitivity, -this.Window_Form_Container_Size.x / 4,  -this.Window_Form_Container_Size.y / 2 + 275, 3);
        this.Text_Quality = new UI_TickSlider(new String[]{"Low", "High"}, (UI_Window)this, this.currentTextQuality, this.Window_Form_Container_Size.x / 4,  -this.Window_Form_Container_Size.y / 2 + 275, 3);
        this.addElement(this.Simulation_Quality);
        this.addElement(this.Visual_Quality);
        this.addElement(this.Scroll_Sensitivity);
        this.addElement(this.Text_Quality);

        /*
        Button
        */
        this.Reset_To_Defaults = new UI_Button("Reset to defaults", this, false);
        this.addElement(this.Reset_To_Defaults);
    }

    public void checkWindowElements() {
        if(this.Simulation_Quality.getElementName() != this.prvSimulationQuality) {
            this.qualitySettings.saveSettings(this.Visual_Quality.getElementName(), this.Simulation_Quality.getElementName(), this.Text_Quality.getElementName(), this.Scroll_Sensitivity.getElementName(), this.Show_Frame_Stats.getState(), this.Show_AABBs.getState(), this.Show_Collision_Points.getState());
            this.qualitySettings.updateSettings(this.Simulation_Quality.getElementName(), this.Scroll_Sensitivity.getElementName(), this.Show_Frame_Stats.getState(), this.Show_AABBs.getState(), this.Show_Collision_Points.getState());
            this.prvSimulationQuality = this.Simulation_Quality.getElementName();
        } else if(this.Visual_Quality.getElementName() != this.prvVisualQuality) {
            this.qualitySettings.saveSettings(this.Visual_Quality.getElementName(), this.Simulation_Quality.getElementName(), this.Text_Quality.getElementName(), this.Scroll_Sensitivity.getElementName(), this.Show_Frame_Stats.getState(), this.Show_AABBs.getState(), this.Show_Collision_Points.getState());
            this.qualitySettings.updateSettings(this.Simulation_Quality.getElementName(), this.Scroll_Sensitivity.getElementName(), this.Show_Frame_Stats.getState(), this.Show_AABBs.getState(), this.Show_Collision_Points.getState());
            this.prvVisualQuality = this.Visual_Quality.getElementName();
        } else if(this.Text_Quality.getElementName() != this.prvVisualQuality) {
            this.qualitySettings.saveSettings(this.Visual_Quality.getElementName(), this.Simulation_Quality.getElementName(), this.Text_Quality.getElementName(), this.Scroll_Sensitivity.getElementName(), this.Show_Frame_Stats.getState(), this.Show_AABBs.getState(), this.Show_Collision_Points.getState());
            this.qualitySettings.updateSettings(this.Simulation_Quality.getElementName(), this.Scroll_Sensitivity.getElementName(), this.Show_Frame_Stats.getState(), this.Show_AABBs.getState(), this.Show_Collision_Points.getState());
            this.prvTextQuality = this.Text_Quality.getElementName();
        } else if(this.Scroll_Sensitivity.getElementName() != this.prvScrollSensitivity) {
            this.qualitySettings.saveSettings(this.Visual_Quality.getElementName(), this.Simulation_Quality.getElementName(), this.Text_Quality.getElementName(), this.Scroll_Sensitivity.getElementName(), this.Show_Frame_Stats.getState(), this.Show_AABBs.getState(), this.Show_Collision_Points.getState());
            this.qualitySettings.updateSettings(this.Simulation_Quality.getElementName(), this.Scroll_Sensitivity.getElementName(), this.Show_Frame_Stats.getState(), this.Show_AABBs.getState(), this.Show_Collision_Points.getState());
            this.prvScrollSensitivity = this.Scroll_Sensitivity.getElementName();
        } else if(this.Show_Frame_Stats.getState() != this.prvShowFrameStats) {
            this.qualitySettings.saveSettings(this.Visual_Quality.getElementName(), this.Simulation_Quality.getElementName(), this.Text_Quality.getElementName(), this.Scroll_Sensitivity.getElementName(), this.Show_Frame_Stats.getState(), this.Show_AABBs.getState(), this.Show_Collision_Points.getState());
            this.qualitySettings.updateSettings(this.Simulation_Quality.getElementName(), this.Scroll_Sensitivity.getElementName(), this.Show_Frame_Stats.getState(), this.Show_AABBs.getState(), this.Show_Collision_Points.getState());
            this.prvShowFrameStats = this.Show_Frame_Stats.getState();
        } else if(this.Show_AABBs.getState() != this.prvShowAABBs) {
            this.qualitySettings.saveSettings(this.Visual_Quality.getElementName(), this.Simulation_Quality.getElementName(), this.Text_Quality.getElementName(), this.Scroll_Sensitivity.getElementName(), this.Show_Frame_Stats.getState(), this.Show_AABBs.getState(), this.Show_Collision_Points.getState());
            this.qualitySettings.updateSettings(this.Simulation_Quality.getElementName(), this.Scroll_Sensitivity.getElementName(), this.Show_Frame_Stats.getState(), this.Show_AABBs.getState(), this.Show_Collision_Points.getState());
            this.prvShowAABBs = this.Show_AABBs.getState();
        } else if(this.Show_Collision_Points.getState() != this.prvShowCollisionPoints) {
            this.qualitySettings.saveSettings(this.Visual_Quality.getElementName(), this.Simulation_Quality.getElementName(), this.Text_Quality.getElementName(), this.Scroll_Sensitivity.getElementName(), this.Show_Frame_Stats.getState(), this.Show_AABBs.getState(), this.Show_Collision_Points.getState());
            this.qualitySettings.updateSettings(this.Simulation_Quality.getElementName(), this.Scroll_Sensitivity.getElementName(), this.Show_Frame_Stats.getState(), this.Show_AABBs.getState(), this.Show_Collision_Points.getState());
            this.prvShowCollisionPoints = this.Show_Collision_Points.getState();
        }
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

        text(this.Window_Name, this.Window_Text_Position.x, this.Window_Text_Position.y);
    }




    public void open() {
        this.deselectAllWindows();
        this.isActiveWindow = true;
        this.Window_Visibility = true;
        UI_Manager.bringToFront(this);
        this.Window_Container.getChild("Window_Container_Stroke").setStroke(UI_Constants.BLUE_SELECTED);
        this.Window_Container.getChild("Window_Text_Container").setFill(UI_Constants.BLUE_UNSELECTED);
        // this.initializeCreationsWindow();
    }



    @Override
    public void interactionDraw() {
        if(UI_Manager.getTabBar().getActiveTabID() == 0) {
            this.lockSelected();
            this.checkWindowElements();
        }   
    }


    public void lockSelected() {
        this.isActiveWindow = true;
        this.Window_Visibility = true;
        UI_Manager.getHotBar().setActiveSlotID(-1);
        this.Window_Container.getChild("Window_Container_Stroke").setStroke(UI_Constants.BLUE_SELECTED);
        this.Window_Container.getChild("Window_Text_Container").setFill(UI_Constants.BLUE_UNSELECTED);
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

}
  
