public void settings() {
    smooth(8);
    String os = System.getProperty("os.name").toLowerCase();
    if(os.contains("mac")) {
        size(displayWidth, displayHeight - 125);
    } else if(os.contains("windows")) {
        fullScreen(FX2D);
    } else {
        throw new RuntimeException("OS not supported");
    }
}
