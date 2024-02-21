
public void settings() {
    smooth(8);
    if(System.getProperty("os.name").toLowerCase().contains("mac")) {
        size(displayWidth, displayHeight - 125);
    } else if(System.getProperty("os.name").toLowerCase().contains("windows")) {
        size(displayWidth, displayHeight, FX2D);
        fullScreen();
    } else {
        throw new RuntimeException("OS not supported");
    }
}
