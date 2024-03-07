
public void settings() {
    String os = System.getProperty("os.name").toLowerCase();
    UI_QualitySettings qualitySettings = new UI_QualitySettings(false);
    if(os.contains("mac")) {
        size(displayWidth, displayHeight - 125);
        pixelDensity(qualitySettings.getPixelDensity());
    } else if(os.contains("windows")) {
        fullScreen(FX2D);
        pixelDensity(qualitySettings.getPixelDensity());
    } else {
        throw new RuntimeException("OS not supported");
    }
}
    