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
            JSONObject def = new JSONObject();
                def.setString("VisualQuality", "High");
                def.setString("SimulationQuality", "Medium");
                def.setString("TextQuality", "High");
                def.setString("ScrollSensitivity", "Medium");
                def.setBoolean("Show Frame Stats", false);
                def.setBoolean("Show AABBs", false);
                def.setBoolean("Show Collision Points", false);

            settings.setString("VisualQuality", "High");
            settings.setString("SimulationQuality", "Medium");
            settings.setString("TextQuality", "High");
            settings.setString("ScrollSensitivity", "Medium");
            settings.setBoolean("Show Frame Stats", false);
            settings.setBoolean("Show AABBs", false);
            settings.setBoolean("Show Collision Points", false);

        settings.setJSONObject("Default", def);

        saveJSONObject(settings, sketchPath() + "/data/settings/settings.json");
        this.settings = loadJSONObject(sketchPath() + "/data/settings/settings.json");
    }

    public void createDefaultTimePlayedFile() {
        JSONObject timePlayed = new JSONObject();
            timePlayed.setInt("TimePlayedMinutes", 0);
            timePlayed.setInt("TimePlayedHours", 0);
            timePlayed.setString("TimePlayed", "Time Played: 0h 0m");

        saveJSONObject(timePlayed, sketchPath() + "/data/settings/timePlayed.json");
        this.timePlayed = loadJSONObject(sketchPath() + "/data/settings/timePlayed.json");
    }

    public void init() {
        String VisualQuality = settings.getString("VisualQuality");
        String SimulationQuality = settings.getString("SimulationQuality");
        String TextQuality = settings.getString("TextQuality");
        String ScrollSensitivity = settings.getString("ScrollSensitivity");

        boolean Show_Frame_Stats = settings.getBoolean("Show Frame Stats");
        boolean Show_AABBs = settings.getBoolean("Show AABBs");
        boolean Show_Collision_Points = settings.getBoolean("Show Collision Points");

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
    }

    public void resetSettings() {
        JSONObject settings = loadJSONObject(sketchPath() + "/data/settings/settings.json");
        JSONObject defaultSettings = settings.getJSONObject("Default");

        String VisualQuality = defaultSettings.getString("VisualQuality");
        String SimulationQuality = defaultSettings.getString("SimulationQuality");
        String TextQuality = defaultSettings.getString("TextQuality");
        String ScrollSensitivity = defaultSettings.getString("ScrollSensitivity");

        boolean Show_Frame_Stats = defaultSettings.getBoolean("Show Frame Stats");
        boolean Show_AABBs = defaultSettings.getBoolean("Show AABBs");
        boolean Show_Collision_Points = defaultSettings.getBoolean("Show Collision Points");

        saveSettings(VisualQuality, SimulationQuality, TextQuality, ScrollSensitivity, Show_Frame_Stats, Show_AABBs, Show_Collision_Points);
        this.settings = loadJSONObject(sketchPath() + "/data/settings/settings.json");

    }

    public void saveSettings(String VisualQuality, String SimulationQuality, String TextQuality, String ScrollSensitivity, boolean Show_Frame_Stats, boolean Show_AABBs, boolean Show_Collision_Points) {
        JSONObject settings = new JSONObject();
        JSONObject def = new JSONObject();
            def.setString("VisualQuality", "High");
            def.setString("SimulationQuality", "Medium");
            def.setString("TextQuality", "High");
            def.setString("ScrollSensitivity", "Medium");
            def.setBoolean("Show Frame Stats", false);
            def.setBoolean("Show AABBs", false);
            def.setBoolean("Show Collision Points", false);

        settings.setString("VisualQuality", VisualQuality);
        settings.setString("SimulationQuality", SimulationQuality);
        settings.setString("TextQuality", TextQuality);
        settings.setString("ScrollSensitivity", ScrollSensitivity);
        settings.setBoolean("Show Frame Stats", Show_Frame_Stats);
        settings.setBoolean("Show AABBs", Show_AABBs);
        settings.setBoolean("Show Collision Points", Show_Collision_Points);

        settings.setJSONObject("Default", def);

        saveJSONObject(settings, sketchPath() + "/data/settings/settings.json");

        this.settings = loadJSONObject(sketchPath() + "/data/settings/settings.json");
    }


    public void updateSettings(String SimulationQuality, String ScrollSensitivity, boolean Show_Frame_Stats, boolean Show_AABBs, boolean Show_Collision_Points) {
        switch(SimulationQuality) {
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
        switch(ScrollSensitivity) {
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

        DRAW_CONTACT_POINTS = Show_Collision_Points;;
        DRAW_AABBS = Show_AABBs;
        DRAW_STATS = Show_Frame_Stats;
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
        SCROLL_SENSITIVITY = 0.8f;
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
        hint(ENABLE_STROKE_PURE);
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
            createDefaultSettingsFile();
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
            createDefaultTimePlayedFile();
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
