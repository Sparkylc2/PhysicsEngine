public class GUI {

/*
====================================================================================================
========================================= GUI Tab Elements =========================================
====================================================================================================
*/  
    /*----- Tabs -----*/
    public Tab RigidbodyTab;
    public Tab ForceTab;
    public Toggle ForcesTabToggle;
    public Tab EditorTab;
    public Tab CreationTab;
    public Tab SettingsTab;
    public Tab HelpTab;
    public Tab DebugTab;

    public int TabCount = 6;

/*
====================================================================================================
========================================= Group Elements ===========================================
====================================================================================================
*/
    /*----- Groups -----*/
    public Group RigidbodyGroup;
    public Group ForceGroup;
    public Group EditorGroup;
    public Group CreationGroup;
    public Group SettingsGroup;
    public Group HelpGroup;
    public Group DebugGroup;

/*
====================================================================================================
==================================== Rigidbody Tab Elements ========================================
====================================================================================================
*/
    /*----- Toggle Buttons -----*/
    public Toggle RT_Circle_Toggle;
    public Toggle RT_Rectangle_Toggle;
    public Toggle RT_FillColour_Toggle;
    public Toggle RT_StrokeColour_Toggle;
    public Toggle RT_IsStatic_Toggle;
    public Toggle RT_IsTranslationallyStatic_Toggle;
    public Toggle RT_IsRotationallyStatic_Toggle;
    public Toggle RT_AddGravity_Toggle;
    public Toggle RT_Collidability_Toggle;

    /*----- Sliders -----*/
    public Slider RT_Density_Slider;
    public Slider RT_Restitution_Slider;
    public Slider RT_Rectangle_Width_Slider;
    public Slider RT_Rectangle_Height_Slider;
    public Slider RT_Circle_Radius_Slider;
    public Slider RT_StrokeWeight_Slider;
    public Slider RT_RedFill_Slider;
    public Slider RT_GreenFill_Slider;
    public Slider RT_BlueFill_Slider;
    public Slider RT_RedStroke_Slider;
    public Slider RT_GreenStroke_Slider;
    public Slider RT_BlueStroke_Slider;
    public Slider RT_Angle_Slider;
    public Slider RT_AngularVelocity_Slider;

    /*----- Bangs -----*/
    public Bang RT_Color_Bang;


/*
====================================================================================================
========================================= Forces Tab Elements =======================================
====================================================================================================
*/
    /*----- Toggle Buttons -----*/
    public Toggle FT_Spring_Toggle;
    public Toggle FT_Rod_Toggle;
    public Toggle FT_Motor_Toggle;
    public Toggle FT_Spring_LockToX_Toggle;
    public Toggle FT_Spring_LockToY_Toggle;
    public Toggle FT_Spring_PerfectSpring_Toggle;
    public Toggle FT_Rod_IsJoint_Toggle;
    public Toggle FT_Motor_DrawMotor_Toggle;
    public Toggle FT_Motor_DrawMotorForce_Toggle;



    /*----- Sliders -----*/
    public Slider FT_Spring_SpringConstant_Slider;
    public Slider FT_Spring_EquilibriumLength_Slider;
    public Slider FT_Spring_Damping_Slider;
    public Slider FT_Motor_TargetAngularVelocity_Slider;


/*
====================================================================================================
========================================= Formatting ===============================================
====================================================================================================
*/
    //The size of the group
    public int globalGroupHeight = 225;
    public int globalGroupWidth = 230;
    private int globalGroupBarHeight = 20;

    //The padding of the group from the edges of the screen
    public int globalScreenGroupPaddingX = 40;
    public int globalScreenGroupPaddingY = 40;

    //The padding for elements from the edge of the group
    private int globalGroupPaddingX = 10;
    private int globalGroupPaddingY = 10;
    
    //The padding between elements in the group
    private int globalInterElementPaddingX = 10;
    private int globalInterElementPaddingY = 10;

    //the group background color
    private int globalGroupColor = color(60, 60, 60);
    private int rowCount = 10;

/*
====================================================================================================
=================================== Default Value Initialization ===================================
====================================================================================================
*/
/*---------------------------- Default Values Initialization ------------------------*/
    //private Tab defaultTab = userInterface.getTab("RigidbodyTab");
    private Tab defaultTab = userInterface.getTab("SettingsTab");

    /*---------------------------- Forces Tab -------------------------------------*/
        private boolean defaultSpringSelector = false;
        private boolean defaultRodSelector = false;
        private boolean defaultMotorSelector = false;

        private float defaultSpringConstant = 50f;
        private float defaultSpringDamping = 0.5f;
        private float defaultSpringEquilibriumLength = 1f;

        private boolean defaultLockToXAxis = false;
        private boolean defaultLockToYAxis = false;

        private boolean defaultSpringIsPerfect = false;
        private boolean defaultSpringIsHingeable = true;

        private boolean defaultRodIsHingeable = true;
        private boolean defaultRodIsJoint = false;

        private boolean defaultSnapToCenter = true;
        private boolean defaultSnapToEdge = false;

        private float defaultMotorTargetAngularVelocity = 0f;
        private boolean defaultMotorDrawMotor = false;
        private boolean defaultMotorDrawMotorForce = true;

    /*---------------------------- Editor Tab ----------------------- */


/*
====================================================================================================
========================================= User Interface ===========================================
====================================================================================================
*/
        public GUI(ControlP5 userInterface) {
                    /*
                    RigidbodyTab = userInterface.addTab("RigidbodyTab")
                                .setLabel("Rigidbody")
                                .setId(0)
                                .activateEvent(true)
                                ;

                    ForceTab = userInterface.addTab("ForceTab")
                                .setLabel("Forces")
                                .setId(1)
                                .activateEvent(true)
                                ;

                    EditorTab = userInterface.addTab("EditorTab")
                                .setLabel("Editor")
                                .setId(2)
                                .activateEvent(true)
                                ;

                    CreationTab = userInterface.addTab("CreationTab")
                                .setLabel("Creations")
                                .setId(3)
                                .activateEvent(true)
                                ;

                    SettingsTab = userInterface.addTab("SettingsTab")
                                .setLabel("Settings")
                                .setId(4)
                                .activateEvent(true)
                                ;

                    HelpTab = userInterface.addTab("HelpTab")
                                .setLabel("Help")
                                .setId(5)
                                .activateEvent(true)
                                ;
                                
                    DebugTab = userInterface.addTab("DebugTab")
                                .setLabel("Debug")
                                .setId(6)
                                .activateEvent(true)
                                ;
                            
                    */
                    SettingsTab = userInterface.addTab("SettingsTab")
                                .setLabel("Settings")
                                .setId(4)
                                .hide()
                                ;
                    EditorTab = userInterface.addTab("EditorTab")
                                .setLabel("Editor")
                                .setId(2)
                                .hide()
                                ;
                    CreationTab = userInterface.addTab("CreationTab")
                                .setLabel("Creations")
                                .setId(3)
                                .hide()
                                ;
                    ForceTab = userInterface.addTab("ForceTab")
                                .setLabel("Forces")
                                .setId(1)
                                .hide()
                                ;
                    RigidbodyTab = userInterface.addTab("RigidbodyTab")
                                .setLabel("Rigidbody")
                                .setId(0)
                                .hide()
                                ;
                    HelpTab = userInterface.addTab("HelpTab")
                                .setLabel("Help")
                                .setId(5)
                                .hide()
                                ;
                    DebugTab = userInterface.addTab("DebugTab")
                                .setLabel("Debug")
                                .setId(6)
                                .hide()
                                ;
                    
                                

/*----------------------------------- Rigidbodies Tab ------------------------------------------*/
                    RigidbodyGroup = userInterface.addGroup("RigidbodyGroup")
                                .setPosition(calculateGroupPositionX(), calculateGroupPositionY())
                                .setBackgroundHeight(globalGroupHeight)
                                .setBarHeight(globalGroupBarHeight)
                                .setBackgroundColor(globalGroupColor)
                                .setWidth(globalGroupWidth)
                                .setTab("RigidbodyTab")
                                ;
                        RT_Circle_Toggle = userInterface.addToggle("RT_Circle_Toggle")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(2)), calculateButtonPositionY(1, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(2),calculateButtonHeight(rowCount))
                                        .setLabel("Circle")
                                        .setVisible(true)
                                        .setGroup(RigidbodyGroup)
                                        .setValue(false)
                                        .plugTo(RT_InteractionHandler, "ToggleListener")
                                        ;
                                    
                        RT_Rectangle_Toggle = userInterface.addToggle("RT_Rectangle_Toggle")
                                        .setPosition(calculateButtonPositionX(2, calculateButtonWidth(2)), calculateButtonPositionY(1, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(2),calculateButtonHeight(rowCount))
                                        .setLabel("Rectangle")
                                        .setVisible(true)
                                        .setGroup(RigidbodyGroup)
                                        .setValue(false)
                                        .plugTo(RT_InteractionHandler, "ToggleListener")
                                        ;


                        RT_Density_Slider = userInterface.addSlider("RT_Density_Slider")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(2)), calculateButtonPositionY(2, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(2),calculateButtonHeight(rowCount))
                                        .setLabel("Density")
                                        .setVisible(false)
                                        .setRange(MIN_BODY_DENSITY, MAX_BODY_DENSITY)
                                        .setValue(5)
                                        .setGroup(RigidbodyGroup)
                                        .plugTo(RT_InteractionHandler, "SliderListener")
                                        ;

                        RT_Restitution_Slider = userInterface.addSlider("RT_Restitution_Slider")
                                        .setPosition(calculateButtonPositionX(2, calculateButtonWidth(2)), calculateButtonPositionY(2, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(2),calculateButtonHeight(rowCount))
                                        .setLabel("Restitution")
                                        .setVisible(false)
                                        .setRange(0.01, 1)
                                        .setValue(0.5)
                                        .setGroup(RigidbodyGroup)
                                        .plugTo(RT_InteractionHandler, "SliderListener")
                                        ;

                        RT_Rectangle_Width_Slider = userInterface.addSlider("RT_Rectangle_Width_Slider")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(2)), calculateButtonPositionY(3, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(2),calculateButtonHeight(rowCount))
                                        .setLabel("Width")
                                        .setVisible(false)
                                        .setRange(MIN_BODY_WIDTH, MAX_BODY_WIDTH)
                                        .setValue(2f)
                                        .setGroup(RigidbodyGroup)
                                        .plugTo(RT_InteractionHandler, "SliderListener")
                                        ;

                        RT_Rectangle_Height_Slider = userInterface.addSlider("RT_Rectangle_Height_Slider")
                                        .setPosition(calculateButtonPositionX(2, calculateButtonWidth(2)), calculateButtonPositionY(3, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(2),calculateButtonHeight(rowCount))
                                        .setLabel("Height")
                                        .setVisible(false)
                                        .setRange(MIN_BODY_HEIGHT, MAX_BODY_HEIGHT)
                                        .setValue(2f)
                                        .setGroup(RigidbodyGroup)
                                        .plugTo(RT_InteractionHandler, "SliderListener")
                                        ;

                        RT_Circle_Radius_Slider = userInterface.addSlider("RT_Circle_Radius_Slider")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(1)), calculateButtonPositionY(3, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(1),calculateButtonHeight(rowCount))
                                        .setLabel("Radius")
                                        .setVisible(false)
                                        .setRange(MIN_BODY_RADIUS, MAX_BODY_RADIUS)
                                        .setValue(1)
                                        .setGroup(RigidbodyGroup)
                                        .plugTo(RT_InteractionHandler, "SliderListener")
                                        ;


                        RT_FillColour_Toggle = userInterface.addToggle("RT_FillColour_Toggle")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(3)), calculateButtonPositionY(4, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(3),calculateButtonHeight(rowCount))
                                        .setLabel("Fill Colour")
                                        .setVisible(false)
                                        .setGroup(RigidbodyGroup)
                                        .setValue(true)
                                        .plugTo(RT_InteractionHandler, "ToggleListener")
                                        ;

                        RT_StrokeColour_Toggle = userInterface.addToggle("RT_StrokeColour_Toggle")
                                        .setPosition(calculateButtonPositionX(2, calculateButtonWidth(3)), calculateButtonPositionY(4, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(3),calculateButtonHeight(rowCount))
                                        .setLabel("Stroke Colour")
                                        .setVisible(false)
                                        .setGroup(RigidbodyGroup)
                                        .setValue(false)
                                        .plugTo(RT_InteractionHandler, "ToggleListener")
                                        ;

                        RT_StrokeWeight_Slider = userInterface.addSlider("RT_StrokeWeight_Slider")
                                        .setPosition(calculateButtonPositionX(3, calculateButtonWidth(3)), calculateButtonPositionY(4, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(3),calculateButtonHeight(rowCount))
                                        .setLabel("Stroke")
                                        .setVisible(false)
                                        .setRange(0, 0.5f)
                                        .setValue(0.05f)
                                        .setGroup(RigidbodyGroup)
                                        .plugTo(RT_InteractionHandler, "SliderListener")
                                        ;

                        RT_RedFill_Slider = userInterface.addSlider("RT_RedFill_Slider")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(3)), calculateButtonPositionY(5, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(3),calculateButtonHeight(rowCount))
                                        .setLabel("Red")
                                        .setVisible(false)
                                        .setRange(0, 255)
                                        .setValue(255)
                                        .setGroup(RigidbodyGroup)
                                        .plugTo(RT_InteractionHandler, "SliderListener")
                                        ;

                        RT_GreenFill_Slider = userInterface.addSlider("RT_GreenFill_Slider")
                                        .setPosition(calculateButtonPositionX(2, calculateButtonWidth(3)), calculateButtonPositionY(5, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(3),calculateButtonHeight(rowCount))
                                        .setLabel("Green")
                                        .setVisible(false)
                                        .setRange(0, 255)
                                        .setValue(255)
                                        .setGroup(RigidbodyGroup)
                                        .plugTo(RT_InteractionHandler, "SliderListener")
                                        ;

                        RT_BlueFill_Slider = userInterface.addSlider("RT_BlueFill_Slider")
                                        .setPosition(calculateButtonPositionX(3, calculateButtonWidth(3)), calculateButtonPositionY(5, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(3),calculateButtonHeight(rowCount))
                                        .setLabel("Blue")
                                        .setVisible(false)
                                        .setRange(0, 255)
                                        .setValue(255)
                                        .setGroup(RigidbodyGroup)
                                        .plugTo(RT_InteractionHandler, "SliderListener")
                                        ;

                        RT_RedStroke_Slider = userInterface.addSlider("RT_RedStroke_Slider")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(3)), calculateButtonPositionY(5, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(3),calculateButtonHeight(rowCount))
                                        .setLabel("Red")
                                        .setVisible(false)
                                        .setRange(0, 255)
                                        .setValue(0)
                                        .setGroup(RigidbodyGroup)
                                        .plugTo(RT_InteractionHandler, "SliderListener")
                                        ;

                        RT_GreenStroke_Slider = userInterface.addSlider("RT_GreenStroke_Slider")
                                        .setPosition(calculateButtonPositionX(2, calculateButtonWidth(3)), calculateButtonPositionY(5, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(3),calculateButtonHeight(rowCount))
                                        .setLabel("Green")
                                        .setVisible(false)
                                        .setRange(0, 255)
                                        .setValue(0)
                                        .setGroup(RigidbodyGroup)
                                        .plugTo(RT_InteractionHandler, "SliderListener")
                                        ;

                        RT_BlueStroke_Slider = userInterface.addSlider("RT_BlueStroke_Slider")
                                        .setPosition(calculateButtonPositionX(3, calculateButtonWidth(3)), calculateButtonPositionY(5, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(3),calculateButtonHeight(rowCount))
                                        .setLabel("Blue")
                                        .setVisible(false)
                                        .setRange(0, 255)
                                        .setValue(0)
                                        .setGroup(RigidbodyGroup)
                                        .plugTo(RT_InteractionHandler, "SliderListener")
                                        ;

                        RT_Color_Bang = userInterface.addBang("RT_Color_Bang")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(1)), calculateButtonPositionY(6, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(1),calculateButtonHeight(rowCount))
                                        .setLabel("Color")
                                        .setColorForeground(color(255, 255, 255))
                                        .setColorActive(color(255, 255, 255))
                                        .setVisible(false)
                                        .setLabelVisible(false)
                                        .setGroup(RigidbodyGroup)
                                        ;

                        RT_IsStatic_Toggle = userInterface.addToggle("RT_IsStatic_Toggle")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(3)), calculateButtonPositionY(7, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(3),calculateButtonHeight(rowCount))
                                        .setLabel("Static")
                                        .setVisible(false)
                                        .setGroup(RigidbodyGroup)
                                        .setValue(false)
                                        .plugTo(RT_InteractionHandler, "ToggleListener")
                                        ;

                        RT_IsTranslationallyStatic_Toggle = userInterface.addToggle("RT_IsTranslationallyStatic_Toggle")
                                        .setPosition(calculateButtonPositionX(2, calculateButtonWidth(3)), calculateButtonPositionY(7, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(3),calculateButtonHeight(rowCount))
                                        .setLabel("TransStatic")
                                        .setVisible(false)
                                        .setGroup(RigidbodyGroup)
                                        .setValue(false)
                                        .plugTo(RT_InteractionHandler, "ToggleListener")
                                        ;

                        RT_IsRotationallyStatic_Toggle = userInterface.addToggle("RT_IsRotationallyStatic_Toggle")
                                        .setPosition(calculateButtonPositionX(3, calculateButtonWidth(3)), calculateButtonPositionY(7, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(3),calculateButtonHeight(rowCount))
                                        .setLabel("RotStatic")
                                        .setVisible(false)
                                        .setGroup(RigidbodyGroup)
                                        .setValue(false)
                                        .plugTo(RT_InteractionHandler, "ToggleListener")
                                        ;

                        RT_Angle_Slider = userInterface.addSlider("RT_Angle_Slider")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(2)), calculateButtonPositionY(8, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(2),calculateButtonHeight(rowCount))
                                        .setLabel("Angle")
                                        .setVisible(false)
                                        .setRange(-360, 360)
                                        .setValue(0)
                                        .setGroup(RigidbodyGroup)
                                        .plugTo(RT_InteractionHandler, "SliderListener")
                                        ;

                        RT_AngularVelocity_Slider = userInterface.addSlider("RT_AngularVelocity_Slider")
                                        .setPosition(calculateButtonPositionX(2, calculateButtonWidth(2)), calculateButtonPositionY(8, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(2),calculateButtonHeight(rowCount))
                                        .setLabel("Angular Vel")
                                        .setVisible(false)
                                        .setRange(-10, 10)
                                        .setValue(0)
                                        .setGroup(RigidbodyGroup)
                                        .plugTo(RT_InteractionHandler, "SliderListener")
                                        ;

                        RT_AddGravity_Toggle = userInterface.addToggle("RT_AddGravity_Toggle")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(2)), calculateButtonPositionY(9, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(2),calculateButtonHeight(rowCount))
                                        .setLabel("Add Gravity")
                                        .setVisible(false)
                                        .setValue(true)
                                        .setGroup(RigidbodyGroup)
                                        .plugTo(RT_InteractionHandler, "ToggleListener")
                                        ;

                        RT_Collidability_Toggle = userInterface.addToggle("RT_Collidability_Toggle") 
                                        .setPosition(calculateButtonPositionX(2, calculateButtonWidth(2)), calculateButtonPositionY(9, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(2),calculateButtonHeight(rowCount))
                                        .setLabel("Collidable")
                                        .setVisible(false)
                                        .setValue(true)
                                        .setGroup(RigidbodyGroup)
                                        .plugTo(RT_InteractionHandler, "ToggleListener")
                                        ;
                        

/*----------------------------------- Forces Tab ------------------------------------------*/
                ForceGroup = userInterface.addGroup("ForceGroup")
                            .setPosition(calculateGroupPositionX(), calculateGroupPositionY())
                            .setBackgroundHeight(globalGroupHeight)
                            .setBarHeight(globalGroupBarHeight)
                            .setBackgroundColor(globalGroupColor)
                            .setWidth(globalGroupWidth)
                             //.disableCollapse()
                            .setTab("ForceTab")
                            ;
                        FT_Spring_Toggle = userInterface.addToggle("FT_Spring_Toggle")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(3)), calculateButtonPositionY(1, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(3),calculateButtonHeight(rowCount))
                                        .setLabel("Spring")
                                        .setValue(false)
                                        .setVisible(true)
                                        .setGroup(ForceGroup)
                                        .plugTo(FT_InteractionHandler, "ToggleListener")
                                        ;

                        FT_Rod_Toggle = userInterface.addToggle("FT_Rod_Toggle")
                                        .setPosition(calculateButtonPositionX(2, calculateButtonWidth(3)), calculateButtonPositionY(1, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(3),calculateButtonHeight(rowCount))
                                        .setLabel("Rod")
                                        .setValue(false)
                                        .setVisible(true)
                                        .setGroup(ForceGroup)
                                        .plugTo(FT_InteractionHandler, "ToggleListener")
                                        ;

                        FT_Motor_Toggle = userInterface.addToggle("FT_Motor_Toggle")
                                        .setPosition(calculateButtonPositionX(3, calculateButtonWidth(3)), calculateButtonPositionY(1, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(3),calculateButtonHeight(rowCount))
                                        .setLabel("Motor")
                                        .setValue(false)
                                        .setVisible(true)
                                        .setGroup(ForceGroup)
                                        .plugTo(FT_InteractionHandler, "ToggleListener")
                                        ;

                        FT_Spring_SpringConstant_Slider = userInterface.addSlider("FT_Spring_SpringConstant_Slider")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(1)), calculateButtonPositionY(2, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(1),calculateButtonHeight(rowCount))
                                        .setLabel("Spring Constant")
                                        .setVisible(false)
                                        .setRange(0, 300)
                                        .setValue(50f)
                                        .setGroup(ForceGroup)
                                        .plugTo(FT_InteractionHandler, "SliderListener")
                                        ;

                        FT_Spring_EquilibriumLength_Slider = userInterface.addSlider("FT_Spring_EquilibriumLength_Slider")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(1)), calculateButtonPositionY(3, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(1),calculateButtonHeight(rowCount))
                                        .setLabel("Equilibrium Length")
                                        .setVisible(false)
                                        .setRange(0, 5)
                                        .setValue(1f)
                                        .setGroup(ForceGroup)
                                        .plugTo(FT_InteractionHandler, "SliderListener")
                                        ;

                        FT_Spring_Damping_Slider = userInterface.addSlider("FT_Spring_Damping_Slider")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(1)), calculateButtonPositionY(4, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(1),calculateButtonHeight(rowCount))
                                        .setLabel("Damping")
                                        .setVisible(false)
                                        .setRange(0, 1)
                                        .setValue(0.5f)
                                        .setGroup(ForceGroup)
                                        .plugTo(FT_InteractionHandler, "SliderListener")
                                        ;

                        FT_Spring_LockToX_Toggle = userInterface.addToggle("FT_Spring_LockToX_Toggle")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(1)), calculateButtonPositionY(5, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(1),calculateButtonHeight(rowCount))
                                        .setLabel("Lock translation to x-axis")
                                        .setVisible(false)
                                        .setValue(false)
                                        .setGroup(ForceGroup)
                                        .plugTo(FT_InteractionHandler, "ToggleListener")
                                        ;
                        FT_Spring_LockToY_Toggle = userInterface.addToggle("FT_Spring_LockToY_Toggle")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(1)), calculateButtonPositionY(6, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(1),calculateButtonHeight(rowCount))
                                        .setLabel("Lock translation to y-axis")
                                        .setVisible(false)
                                        .setValue(false)
                                        .setGroup(ForceGroup)
                                        .plugTo(FT_InteractionHandler, "ToggleListener")
                                        ;

                        FT_Spring_PerfectSpring_Toggle = userInterface.addToggle("FT_Spring_PerfectSpring_Toggle")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(1)), calculateButtonPositionY(7, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(1),calculateButtonHeight(rowCount))
                                        .setLabel("Perfect Spring")
                                        .setVisible(false)
                                        .setValue(false)
                                        .setGroup(ForceGroup)
                                        .plugTo(FT_InteractionHandler, "ToggleListener")
                                        ;

                        FT_Rod_IsJoint_Toggle = userInterface.addToggle("FT_Rod_IsJoint_Toggle")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(1)), calculateButtonPositionY(2, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(1),calculateButtonHeight(rowCount))
                                        .setLabel("Joint")
                                        .setVisible(false)
                                        .setValue(false)
                                        .setGroup(ForceGroup)
                                        .plugTo(FT_InteractionHandler, "ToggleListener")
                                        ;

                        FT_Motor_TargetAngularVelocity_Slider = userInterface.addSlider("FT_Motor_TargetAngularVelocity_Slider")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(1)), calculateButtonPositionY(2, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(1),calculateButtonHeight(rowCount))
                                        .setLabel("Target Angular Velocity")
                                        .setVisible(false)
                                        .setRange(-10, 10)
                                        .setValue(5f)
                                        .setGroup(ForceGroup)
                                        .plugTo(FT_InteractionHandler, "SliderListener")
                                        ;

                        FT_Motor_DrawMotor_Toggle = userInterface.addToggle("FT_Motor_DrawMotor_Toggle")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(2)), calculateButtonPositionY(3, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(2),calculateButtonHeight(rowCount))
                                        .setLabel("Draw Motor")
                                        .setVisible(false)
                                        .setValue(false)
                                        .setGroup(ForceGroup)
                                        .plugTo(FT_InteractionHandler, "ToggleListener")
                                        ;

                        FT_Motor_DrawMotorForce_Toggle = userInterface.addToggle("FT_Motor_DrawMotorForce_Toggle")
                                        .setPosition(calculateButtonPositionX(2, calculateButtonWidth(2)), calculateButtonPositionY(3, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(2),calculateButtonHeight(rowCount))
                                        .setLabel("Draw Motor Force")
                                        .setVisible(false)
                                        .setValue(true)
                                        .setGroup(ForceGroup)
                                        .plugTo(FT_InteractionHandler, "ToggleListener")
                                        ;
/*------------------------------------ Debug Tab ----------------------------------------------- */
                    DebugGroup = userInterface.addGroup("DebugGroup")
                        .setPosition(calculateGroupPositionX(), calculateGroupPositionY())
                        .setBackgroundHeight(globalGroupHeight)
                        .setBarHeight(globalGroupBarHeight)
                        .setBackgroundColor(globalGroupColor)
                        .setWidth(globalGroupWidth)
                        .setLabel("Debug")
                         //.disableCollapse()
                        .setTab("DebugTab")
                        ;

                        Slider subStepCount = userInterface.addSlider("SubStepCount")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(1)), calculateButtonPositionY(1, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(1), calculateButtonHeight(rowCount))
                                        .setLabel("Substep Count")
                                        .setVisible(true)
                                        .setRange(0, 1024)
                                        .setValue(128)
                                        .setNumberOfTickMarks(17)
                                        .setSliderMode(Slider.FLEXIBLE)
                                        .setGroup(DebugGroup)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                        SUB_STEP_COUNT = (int) userInterface.getController("SubStepCount").getValue();
                                                    }
                                                })
                                            ;
                        Toggle drawContactPoints = userInterface.addToggle("drawContactPoints")
                                        .setPosition(calculateButtonPositionX(1, calculateButtonWidth(2)), calculateButtonPositionY(2, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(2), calculateButtonHeight(rowCount))
                                        .setLabel("Draw Contact Points")
                                        .setVisible(true)
                                        .setValue(false)
                                        .setGroup(DebugGroup)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                       DRAW_CONTACT_POINTS = !DRAW_CONTACT_POINTS;
                                                    }
                                                })
                                            ;

                        Toggle drawABBs = userInterface.addToggle("drawAABBs")
                                        .setPosition(calculateButtonPositionX(2, calculateButtonWidth(2)), calculateButtonPositionY(2, calculateButtonHeight(rowCount)))
                                        .setSize(calculateButtonWidth(2), calculateButtonHeight(rowCount))
                                        .setLabel("Draw AABB's")
                                        .setVisible(true)
                                        .setValue(false)
                                        .setGroup(DebugGroup)
                                        .onChange(new CallbackListener() {
                                                void controlEvent(CallbackEvent theEvent) {
                                                       DRAW_AABBS = !DRAW_AABBS;
                                                    }
                                                })
                                            ;



/*
====================================================================================================
======================================== Formatting ================================================
====================================================================================================
*/
    userInterface.getController("RT_Circle_Toggle").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    userInterface.getController("RT_Rectangle_Toggle").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);

    userInterface.getController("RT_Density_Slider").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
    userInterface.getController("RT_Restitution_Slider").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
    userInterface.getController("RT_Rectangle_Width_Slider").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
    userInterface.getController("RT_Rectangle_Height_Slider").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
    userInterface.getController("RT_Circle_Radius_Slider").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
    userInterface.getController("RT_StrokeWeight_Slider").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
    userInterface.getController("RT_RedFill_Slider").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
    userInterface.getController("RT_GreenFill_Slider").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
    userInterface.getController("RT_BlueFill_Slider").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
    userInterface.getController("RT_RedStroke_Slider").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
    userInterface.getController("RT_GreenStroke_Slider").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
    userInterface.getController("RT_BlueStroke_Slider").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
    userInterface.getController("RT_Angle_Slider").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
    userInterface.getController("RT_AngularVelocity_Slider").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

    userInterface.getController("RT_FillColour_Toggle").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    userInterface.getController("RT_StrokeColour_Toggle").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    userInterface.getController("RT_Color_Bang").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    userInterface.getController("RT_IsStatic_Toggle").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    userInterface.getController("RT_IsTranslationallyStatic_Toggle").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    userInterface.getController("RT_IsRotationallyStatic_Toggle").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    userInterface.getController("RT_AddGravity_Toggle").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    userInterface.getController("RT_Collidability_Toggle").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);

    userInterface.getController("FT_Spring_Toggle").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    userInterface.getController("FT_Rod_Toggle").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    userInterface.getController("FT_Motor_Toggle").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    userInterface.getController("FT_Spring_SpringConstant_Slider").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
    userInterface.getController("FT_Spring_EquilibriumLength_Slider").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
    userInterface.getController("FT_Spring_Damping_Slider").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
    userInterface.getController("FT_Spring_LockToX_Toggle").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    userInterface.getController("FT_Spring_LockToY_Toggle").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    userInterface.getController("FT_Spring_PerfectSpring_Toggle").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    userInterface.getController("FT_Rod_IsJoint_Toggle").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    userInterface.getController("FT_Motor_TargetAngularVelocity_Slider").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
    userInterface.getController("FT_Motor_DrawMotor_Toggle").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    userInterface.getController("FT_Motor_DrawMotorForce_Toggle").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);



//userInterface.getController("SubStepCount").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
//userInterface.getController("drawContactPoints").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
//userInterface.getController("drawAABBs").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);






    userInterface.getTab("default").hide();
    CurrentTabInteractionHandler.VisibilityResponse();

    this.updateControllerColors();

}

/*
====================================================================================================
======================================== Helper Methods ============================================
====================================================================================================
*/
   public int calculateButtonWidth(int buttonCount) {
        return (globalGroupWidth - 2 * globalGroupPaddingX - (buttonCount - 1) * globalInterElementPaddingX) / buttonCount;
     }

    public int calculateButtonHeight(int rowCount) {
     rowCount--;
    return (globalGroupHeight - 2 * globalGroupPaddingY - (rowCount - 1) * globalInterElementPaddingY) / rowCount;
    }

    public int calculateButtonPositionX(int buttonNumber, int buttonWidth) {
     buttonNumber--;
     return  globalGroupPaddingX + buttonNumber * (buttonWidth + globalInterElementPaddingX);
    }
    public int calculateButtonPositionY(int rowNumber, int buttonHeight) {
     rowNumber--;
     return globalGroupPaddingX + rowNumber * (buttonHeight + globalInterElementPaddingY);
    }

    public int calculateGroupPositionX() {
     return width - globalGroupWidth - globalScreenGroupPaddingX;
    }
    public int calculateGroupPositionY() {
     return globalScreenGroupPaddingY;
    }

    public void checkGUIRepositioning() {
        if(PREVIOUS_WIDTH != width || PREVIOUS_HEIGHT != height) {

            PREVIOUS_WIDTH = width;
            PREVIOUS_HEIGHT = height;
            GUI_GROUP_POSITION_X = calculateGroupPositionX();
            GUI_GROUP_POSITION_Y = calculateGroupPositionY();
            updateGUIPositioning();
        }
    }

    private void updateGUIPositioning() {
        RigidbodyGroup.setPosition(GUI_GROUP_POSITION_X, GUI_GROUP_POSITION_Y);
        ForceGroup.setPosition(GUI_GROUP_POSITION_X, GUI_GROUP_POSITION_Y);
        //EditorGroup.setPosition(GUI_GROUP_POSITION_X, GUI_GROUP_POSITION_Y);
        //CreationGroup.setPosition(GUI_GROUP_POSITION_X, GUI_GROUP_POSITION_Y);
        //SettingsGroup.setPosition(GUI_GROUP_POSITION_X, GUI_GROUP_POSITION_Y);
        //HelpGroup.setPosition(GUI_GROUP_POSITION_X, GUI_GROUP_POSITION_Y);
        //DebugGroup.setPosition(GUI_GROUP_POSITION_X, GUI_GROUP_POSITION_Y);
    }

    public void initialize() {

        GUI_GROUP_POSITION_X = this.calculateGroupPositionX();
        GUI_GROUP_POSITION_Y = this.calculateGroupPositionY();
        GUI_GLOBAL_GROUP_WIDTH = this.globalGroupWidth;
        GUI_GLOBAL_GROUP_HEIGHT = this.globalGroupHeight;
        //userInterface.setFont(new ControlFont(pFont, 10));
    }

    public void updateControllerColors() {
        for(ControllerInterface<?> controller : userInterface.getAll()) {
            controller.setColorForeground(color(82, 82, 82));
            controller.setColorBackground(color(34, 35, 36));
            controller.setColorActive(color(21, 121, 170));
        }

        userInterface.getTab("RigidbodyTab").setColorBackground(color(34, 35, 36));
        userInterface.getTab("RigidbodyTab").setColorActive(color(21, 121, 170));
        userInterface.getTab("RigidbodyTab").setColorLabel(color(255, 255, 255));

        userInterface.getTab("ForceTab").setColorBackground(color(34, 35, 36));
        userInterface.getTab("ForceTab").setColorActive(color(21, 121, 170));
        userInterface.getTab("ForceTab").setColorLabel(color(255, 255, 255));

        userInterface.getTab("EditorTab").setColorBackground(color(34, 35, 36));
        userInterface.getTab("EditorTab").setColorActive(color(21, 121, 170));
        userInterface.getTab("EditorTab").setColorLabel(color(255, 255, 255));

        userInterface.getTab("CreationTab").setColorBackground(color(34, 35, 36));
        userInterface.getTab("CreationTab").setColorActive(color(21, 121, 170));
        userInterface.getTab("CreationTab").setColorLabel(color(255, 255, 255));

        userInterface.getTab("SettingsTab").setColorBackground(color(34, 35, 36));
        userInterface.getTab("SettingsTab").setColorActive(color(21, 121, 170));
        userInterface.getTab("SettingsTab").setColorLabel(color(255, 255, 255));

        userInterface.getTab("HelpTab").setColorBackground(color(34, 35, 36));
        userInterface.getTab("HelpTab").setColorActive(color(21, 121, 170));
        userInterface.getTab("HelpTab").setColorLabel(color(255, 255, 255));

        userInterface.getTab("DebugTab").setColorBackground(color(34, 35, 36));
        userInterface.getTab("DebugTab").setColorActive(color(21, 121, 170));
        userInterface.getTab("DebugTab").setColorLabel(color(255, 255, 255));

    }

    public void customTab(ControlEvent theEvent) {
        if(theEvent.getController().getName().equals("ForcesTabToggle") && theEvent.getController().getValue() == 1) {
            ForceTab.show();
        } else {
            ForceTab.hide();
        }
    }
/*
====================================================================================================
======================================== Getters and Setters =======================================
====================================================================================================
*/

public int getGroupHeight() {
    return this.globalGroupHeight;
}
public int getGroupWidth() {
    return this.globalGroupWidth;
}
}
