public class UI_QualitySettings {

    public JSONObject settings;
    public JSONObject timePlayed;

    private long startTime;

    private Timer playtimeTimer = new Timer();


    public UI_QualitySettings() {
        this.loadJSON("settings");
        this.loadJSON("timePlayed");
    }

    public UI_QualitySettings(boolean init) {
        this.loadJSON("settings");
        this.loadJSON("timePlayed");
        if(init) {
            this.init();
        } 
    }


/*
====================================== Timing ===============================
*/
    public void startPlaytimeTracking() {
        this.startTime = System.currentTimeMillis();
        
        this.playtimeTimer.scheduleAtFixedRate(new TimerTask() {
            @Override
            public void run() {
                updatePlaytime();
            }
        }, 60000, 60000); 
    }


    public void updatePlaytime() {
        int totalPlayTimeMinutes = this.timePlayed.getInt("TimePlayedMinutes") + 1;
        int totalPlayTimeHours = this.timePlayed.getInt("TimePlayedHours");

        if(totalPlayTimeMinutes >= 60) {
            totalPlayTimeHours += 1;
            totalPlayTimeMinutes = 0;
        }

        String timePlayed = "Time Played: " + totalPlayTimeHours + "h " + totalPlayTimeMinutes + "m";
        
        this.timePlayed.setInt("TimePlayedMinutes", totalPlayTimeMinutes);
        this.timePlayed.setInt("TimePlayedHours", totalPlayTimeHours);
        this.timePlayed.setString("TimePlayed", timePlayed);

        if(UI_Manager.getSettingsWindow() != null) {
            UI_Manager.getSettingsWindow().currentTimePlayed = timePlayed;
        }

        saveJSONObject(this.timePlayed, sketchPath() + "/data/settings/timePlayed.json");
        this.timePlayed = loadJSONObject(sketchPath() + "/data/settings/timePlayed.json");
    }

/*
======================================== File Loading ==============================================
*/  
    public void createDefaultSettingsFile() {
        JSONObject settings = new JSONObject();
            settings.setString("VisualQuality", "High");
            settings.setString("SimulationQuality", "Medium");
            settings.setString("TextQuality", "High");
            settings.setString("ScrollSensitivity", "Medium");
            settings.setBoolean("Show Frame Stats", false);
            settings.setBoolean("Show AABBs", false);
            settings.setBoolean("Show Collision Points", false);
            settings.setFloat("CoefficientOfStaticFriction", 0.8f);
            settings.setFloat("CoefficientOfKineticFriction", 0.3f);
            settings.setFloat("Gravity", 9.81f);

        saveJSONObject(settings, sketchPath() + "/data/settings/settings.json");
        this.settings = settings;
    }


    public void createDefaultTimePlayedFile() {
        JSONObject timePlayed = new JSONObject();
            timePlayed.setInt("TimePlayedMinutes", 0);
            timePlayed.setInt("TimePlayedHours", 0);
            timePlayed.setString("TimePlayed", "Time Played: 0h 0m");

        saveJSONObject(timePlayed, sketchPath() + "/data/settings/timePlayed.json");
        this.timePlayed = timePlayed;
    }

    public void init() {
        try {
            String VisualQuality = settings.getString("VisualQuality");
            String SimulationQuality = settings.getString("SimulationQuality");
            String TextQuality = settings.getString("TextQuality");
            String ScrollSensitivity = settings.getString("ScrollSensitivity");

            boolean Show_Frame_Stats = settings.getBoolean("Show Frame Stats");
            boolean Show_AABBs = settings.getBoolean("Show AABBs");
            boolean Show_Collision_Points = settings.getBoolean("Show Collision Points");

            float CoefficientOfStaticFriction = settings.getFloat("CoefficientOfStaticFriction");
            float CoefficientOfKineticFriction = settings.getFloat("CoefficientOfKineticFriction");
            float Gravity = settings.getFloat("Gravity");

            switch (VisualQuality) {
                case "Low":
                    this.setLowVisualQuality();
                    break;
                case "Medium":
                    this.setMediumVisualQuality();
                    break;
                case "High":
                    this.setHighVisualQuality();
                    break;
            }

            switch (SimulationQuality) {
                case "Low":
                    this.setLowSimulationQuality();
                    break;
                case "Medium":
                    this.setMediumSimulationQuality();
                    break;
                case "High":
                    this.setHighSimulationQuality();
                    break;
            }

            switch(ScrollSensitivity) {
                case "Low":
                    this.setLowScrollSensitivity();
                    break;
                case "Medium":
                    this.setMediumScrollSensitivity();
                    break;
                case "High":
                    this.setHighScrollSensitivity();
                    break;
            }

            switch(TextQuality) {
                case "Low":
                    this.setLowTextQuality();
                    break;
                case "High":
                    this.setHighTextQuality();
            }

            DRAW_CONTACT_POINTS = Show_Collision_Points;;
            DRAW_AABBS = Show_AABBs;
            DRAW_STATS = Show_Frame_Stats;
            COEFFICIENT_OF_STATIC_FRICTION = CoefficientOfStaticFriction;
            COEFFICIENT_OF_KINETIC_FRICTION = CoefficientOfKineticFriction;
            GRAVITY_MAG = Gravity;
            GRAVITY_VECTOR.set(0, GRAVITY_MAG);
        } catch (Exception e) {
            this.createDefaultSettingsFile();
            this.init();
        }
    }

    public void saveSetting(String entry, String value) {
        this.settings.setString(entry, value);
        this.updateSettings();
        saveJSONObject(this.settings, sketchPath() + "/data/settings/settings.json");
    }

    public void saveSetting(String entry, boolean value) {
        this.settings.setBoolean(entry, value);
        this.updateSettings();
        saveJSONObject(this.settings, sketchPath() + "/data/settings/settings.json");
    }

    public void saveSetting(String entry, float value) {
        this.settings.setFloat(entry, value);
        this.updateSettings();
        saveJSONObject(this.settings, sketchPath() + "/data/settings/settings.json");
    }

    public void updateSettings() {
        switch(this.settings.getString("SimulationQuality")) {
            case "Low":
                setLowSimulationQuality();
                break;
            case "Medium":
                setMediumSimulationQuality();
                break;
            case "High":
                setHighSimulationQuality();
                break;
        }
        switch(this.settings.getString("ScrollSensitivity")) {
            case "Low":
                setLowScrollSensitivity();
                break;
            case "Medium":
                setMediumScrollSensitivity();
                break;
            case "High":
                setHighScrollSensitivity();
                break;
        }

        DRAW_CONTACT_POINTS = this.settings.getBoolean("Show Collision Points");
        DRAW_AABBS = this.settings.getBoolean("Show AABBs");
        DRAW_STATS = this.settings.getBoolean("Show Frame Stats");

        COEFFICIENT_OF_KINETIC_FRICTION = this.settings.getFloat("CoefficientOfKineticFriction");
        COEFFICIENT_OF_STATIC_FRICTION = this.settings.getFloat("CoefficientOfStaticFriction");
        GRAVITY_MAG = this.settings.getFloat("Gravity");
        GRAVITY_VECTOR.set(0, GRAVITY_MAG);
    }



/*
======================================= Specific Settings ==========================================
*/
    private void setLowSimulationQuality() {
        SUB_STEP_COUNT = 64;
    }

    private void setMediumSimulationQuality() {
        SUB_STEP_COUNT = 256;
    }

    private void setHighSimulationQuality() {
        SUB_STEP_COUNT = 1024;
    }

    private void setLowVisualQuality() {
        noSmooth();
    }

    private void setMediumVisualQuality() {
        smooth(2);
    }

    private void setHighVisualQuality() {
        smooth(3);
    }

    private void setLowScrollSensitivity() {
        SCROLL_SENSITIVITY = 1.05f;
    }

    private void setMediumScrollSensitivity() {
        SCROLL_SENSITIVITY = 1.1f;
    }

    private void setHighScrollSensitivity() {
        SCROLL_SENSITIVITY = 1.5f;
    }

    private void setLowTextQuality() {
        hint(DISABLE_STROKE_PURE);
        TEXT_SMOOTHING = false;
    }

    private void setHighTextQuality() {
        TEXT_SMOOTHING = true;
    }

    private void loadJSON(String name) {
        String directoryPath = dataPath("settings");
        createPath(directoryPath);

        if(name.equals("settings")) {
            loadSettingsJSON();
        } else if(name.equals("timePlayed")) {
            loadTimePlayedJSON();
        } else {
            throw new IllegalArgumentException("Invalid JSON file name");
        }
    }

    private void loadSettingsJSON() {
        String filePath = sketchPath() + "/data/settings/settings.json";

        JSONObject settings;

        try {
            settings = loadJSONObject(filePath);
            this.settings = settings;
        } catch(Exception e) {
            this.createDefaultSettingsFile();
            settings = loadJSONObject(filePath);
            this.settings = settings;
        }
    }

    private void loadTimePlayedJSON() {
        String filePath = sketchPath() + "/data/settings/timePlayed.json";
        JSONObject timePlayed;
        try {
            timePlayed = loadJSONObject(filePath);
            this.timePlayed = timePlayed;
        } catch(Exception e) {
            this.createDefaultTimePlayedFile();
            timePlayed = loadJSONObject(filePath);
            this.timePlayed = timePlayed;
        }
    }



    public int getPixelDensity() {
        if(this.settings.getString("VisualQuality").equals("Low")) {
            return 1;
        } else if(this.settings.getString("VisualQuality").equals("Medium")) {
            return 1;
        } else if(this.settings.getString("VisualQuality").equals("High")) {
            return displayDensity();
        } else {
            throw new IllegalArgumentException("Invalid visual quality setting");
        }
    }
    
}
