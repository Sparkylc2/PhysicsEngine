
public void settings() {
    String os = System.getProperty("os.name").toLowerCase();

    if(os.contains("mac")) {
        size(displayWidth, displayHeight - 125);
        // pixelDensity(displayDensity());
        UI_QualitySettings qualitySettings = new UI_QualitySettings(false);
    } else if(os.contains("windows")) {
        fullScreen(FX2D);
        UI_QualitySettings qualitySettings = new UI_QualitySettings(false);
    } else {
        throw new RuntimeException("OS not supported");
    }
}
    