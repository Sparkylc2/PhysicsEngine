public class UI_SettingsWindow extends UI_Window {

    public UI_QualitySettings qualitySettings = new UI_QualitySettings(false);
    public String currentTimePlayed;

    private UI_TickSlider Simulation_Quality;
    private UI_TickSlider Visual_Quality;
    private UI_TickSlider Scroll_Sensitivity;
    private UI_TickSlider Text_Quality;

    private UI_Toggle Show_Frame_Stats;
    private UI_Toggle Show_AABBs;
    private UI_Toggle Show_Collision_Points;

    private UI_Slider Coeff_Static_Friction;
    private UI_Slider Coeff_Kinetic_Friction;
    private UI_Slider Gravity;

    private UI_Button Reset_To_Defaults;

    private String prvSimulationQuality;
    private String prvVisualQuality;
    private String prvScrollSensitivity;
    private String prvTextQuality;

    private boolean prvShowFrameStats;
    private boolean prvShowAABBs;
    private boolean prvShowCollisionPoints;

    private float prvCoeffStaticFriction;
    private float prvCoeffKineticFriction;
    private float prvGravity;




    public UI_SettingsWindow() {
        super("Settings", 4, new PVector(713, 700), new PVector(713, 47), new PVector(713, 653), false);
        this.setWindowPosition(new PVector(displayWidth/2, displayHeight/2 - 35));
        textFont(UI_Constants.INTER_BOLD);
        textSize(25);
        textAlign(CENTER, CENTER);
        this.Window_Text_Width = textWidth(this.Window_Name);
        this.Window_Text_Position.set(0, -(this.Window_Form_Container_Size.y + this.Window_Text_Container_Size.y) / 2 - (textAscent() - textDescent()) * UI_Constants.GLOBAL_TEXT_ALIGN_FACTOR_Y);

        this.initializeSettingsWindow();
    }

    public void initializeSettingsWindow() {
        this.currentTimePlayed = qualitySettings.timePlayed.getString("TimePlayed");
        try {
            String currentSimulationQuality = qualitySettings.settings.getString("SimulationQuality");
            String currentVisualQuality = qualitySettings.settings.getString("VisualQuality");
            String currentScrollSensitivity = qualitySettings.settings.getString("ScrollSensitivity");
            String currentTextQuality = qualitySettings.settings.getString("TextQuality");   
            boolean currentShowFrameStats = qualitySettings.settings.getBoolean("Show Frame Stats");
            boolean currentShowAABBs = qualitySettings.settings.getBoolean("Show AABBs");
            boolean currentShowCollisionPoints = qualitySettings.settings.getBoolean("Show Collision Points");
            float currentCoeffStaticFriction = qualitySettings.settings.getFloat("CoefficientOfStaticFriction");
            float currentCoeffKineticFriction = qualitySettings.settings.getFloat("CoefficientOfKineticFriction");
            float currentGravity = qualitySettings.settings.getFloat("Gravity");

            this.prvSimulationQuality = currentSimulationQuality;
            this.prvVisualQuality = currentVisualQuality;
            this.prvScrollSensitivity = currentScrollSensitivity;
            this.prvTextQuality = currentTextQuality;
            this.prvShowFrameStats = !currentShowFrameStats;
            this.prvShowAABBs = !currentShowAABBs;
            this.prvShowCollisionPoints = currentShowCollisionPoints;
            this.prvCoeffStaticFriction = currentCoeffStaticFriction;
            this.prvCoeffKineticFriction = currentCoeffKineticFriction;
            this.prvGravity = currentGravity;

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

            float scale = 1.1f;

            float showFrameStatsPosX = this.Window_Form_Container_Size.x / 4f + (280f / 2f) - (265f * scale / 2f);
            float showFrameStatsPosY = -this.Window_Form_Container_Size.y / 2f + 390;
            float showAABBsPosX = this.Window_Form_Container_Size.x / 4f + 280f / 2f - (265f * scale / 2f);
            float showAABBsPosY = -this.Window_Form_Container_Size.y / 2f + 440;
            float showCollisionPointsPosX = this.Window_Form_Container_Size.x / 4f +  280f / 2 - (265f * scale / 2f);
            float showCollisionPointsPosY = -this.Window_Form_Container_Size.y / 2f + 490;


            this.Show_Frame_Stats = new UI_Toggle("Show Frame Stats", (UI_Window)this, showFrameStatsPosX, showFrameStatsPosY, currentShowFrameStats, scale);
            this.Show_AABBs = new UI_Toggle("Show AABB's", (UI_Window)this, showAABBsPosX, showAABBsPosY, currentShowAABBs, scale);
            this.Show_Collision_Points = new UI_Toggle("Show Collision Points", (UI_Window)this, showCollisionPointsPosX, showCollisionPointsPosY, currentShowCollisionPoints, scale);
            this.addElement(this.Show_Frame_Stats);
            this.addElement(this.Show_AABBs);
            this.addElement(this.Show_Collision_Points);

            /*
            Sliders
            */
            this.Simulation_Quality = new UI_TickSlider(new String[]{"Low", "Medium", "High"}, (UI_Window)this, currentSimulationQuality, -this.Window_Form_Container_Size.x / 4,  -this.Window_Form_Container_Size.y / 2 + 125, 3);
            this.Visual_Quality = new UI_TickSlider(new String[]{"Low", "Medium", "High"}, (UI_Window)this, currentVisualQuality, this.Window_Form_Container_Size.x / 4,  -this.Window_Form_Container_Size.y / 2 + 125, 3);
            this.Scroll_Sensitivity = new UI_TickSlider(new String[]{"Low", "Medium", "High"}, (UI_Window)this, currentScrollSensitivity, -this.Window_Form_Container_Size.x / 4,  -this.Window_Form_Container_Size.y / 2 + 275, 3);
            this.Text_Quality = new UI_TickSlider(new String[]{"Low", "High"}, (UI_Window)this, currentTextQuality, this.Window_Form_Container_Size.x / 4,  -this.Window_Form_Container_Size.y / 2 + 275, 3);
            
            this.Simulation_Quality.TickSlider_Name = "Simulation Quality";
            this.Visual_Quality.TickSlider_Name = "Visual Quality";
            this.Scroll_Sensitivity.TickSlider_Name = "Scroll Sensitivity";

            this.addElement(this.Simulation_Quality);
            this.addElement(this.Visual_Quality);
            this.addElement(this.Scroll_Sensitivity);
            this.addElement(this.Text_Quality);


            this.Coeff_Static_Friction = new UI_Slider("Coeff. of static friction", this, 0, 1, currentCoeffStaticFriction);
            this.Coeff_Kinetic_Friction = new UI_Slider("Coeff. of kinetic friction", this, 0, 1, currentCoeffKineticFriction);
            this.Gravity = new UI_Slider("Gravity", this, 0, 100, currentGravity);

            this.addElement(this.Coeff_Static_Friction);
            this.addElement(this.Coeff_Kinetic_Friction);
            this.addElement(this.Gravity);

            /*
            Button
            */
            this.Reset_To_Defaults = new UI_Button("Reset to defaults", this, false);
            this.addElement(this.Reset_To_Defaults);
        } catch (Exception e) {
            this.qualitySettings.createDefaultSettingsFile();
            this.initializeSettingsWindow();
        }

    }

    public void checkWindowElements() {
        if(this.Simulation_Quality.getElementName() != this.prvSimulationQuality) {
            this.qualitySettings.saveSetting("SimulationQuality", this.Simulation_Quality.getElementName());
            this.prvSimulationQuality = this.Simulation_Quality.getElementName();
        } else if(this.Visual_Quality.getElementName() != this.prvVisualQuality) {
            this.qualitySettings.saveSetting("VisualQuality", this.Visual_Quality.getElementName());
            this.prvVisualQuality = this.Visual_Quality.getElementName();
        } else if(this.Text_Quality.getElementName() != this.prvVisualQuality) {
            this.qualitySettings.saveSetting("TextQuality", this.Text_Quality.getElementName());
            this.prvTextQuality = this.Text_Quality.getElementName();
        } else if(this.Scroll_Sensitivity.getElementName() != this.prvScrollSensitivity) {
            this.qualitySettings.saveSetting("ScrollSensitivity", this.Scroll_Sensitivity.getElementName());
            this.prvScrollSensitivity = this.Scroll_Sensitivity.getElementName();
        }

        this.qualitySettings.saveSetting("Show Frame Stats", this.Show_Frame_Stats.getState());
        this.qualitySettings.saveSetting("Show AABBs", this.Show_AABBs.getState());
        this.qualitySettings.saveSetting("Show Collision Points", this.Show_Collision_Points.getState());
        this.qualitySettings.saveSetting("CoefficientOfStaticFriction", this.Coeff_Static_Friction.getValue());
        this.qualitySettings.saveSetting("CoefficientOfKineticFriction", this.Coeff_Kinetic_Friction.getValue());
        this.qualitySettings.saveSetting("Gravity", this.Gravity.getValue());
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
        textFont(UI_Constants.INTER_REGULAR);
        textSize(13);
        textLeading(13* 1.286f);
        textAlign(CENTER, CENTER);
        fill(UI_Constants.GRAY_25);
        text(this.currentTimePlayed, 0, this.Window_Form_Container_Size.y / 2 - 17.5);
    }




    public void open() {
        this.deselectAllWindows();
        this.isActiveWindow = true;
        this.Window_Visibility = true;
        UI_Manager.bringToFront(this);
        this.Window_Container.getChild("Window_Container_Stroke").setStroke(UI_Constants.BLUE_SELECTED);
        this.Window_Container.getChild("Window_Text_Container").setFill(UI_Constants.BLUE_UNSELECTED);
    }



    @Override
    public void interactionDraw() {
        if(UI_Manager.getTabBar().getActiveTabID() == 0) {
            this.lockSelected();
            this.checkWindowElements();
            UI_Manager.closeAllWindows(this);
        }   
    }


    public void lockSelected() {
        this.isActiveWindow = true;
        this.Window_Visibility = true;
        UI_Manager.getHotBar().setActiveSlotID(-1);
        this.Window_Container.getChild("Window_Container_Stroke").setStroke(UI_Constants.BLUE_SELECTED);
        this.Window_Container.getChild("Window_Text_Container").setFill(UI_Constants.BLUE_UNSELECTED);
    }
    
    public void onResetButtonPressed() {
        this.Simulation_Quality.setValue(0.5f);
        this.Visual_Quality.setValue(0.5f);
        this.Scroll_Sensitivity.setValue(0.5f);
        this.Text_Quality.setValue(0.9f);
        this.Show_Frame_Stats.setState(false);
        this.Show_AABBs.setState(false);
        this.Show_Collision_Points.setState(false);
        this.Coeff_Static_Friction.setValue(0.8f);
        this.Coeff_Kinetic_Friction.setValue(0.3f);
        this.Gravity.setValue(9.81f);
        this.qualitySettings.createDefaultSettingsFile();
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
  
