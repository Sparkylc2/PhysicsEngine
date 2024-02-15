public interface TabInteractionHandler {
    public final int OPACITY = 166;
    public void ToggleListener(ControlEvent ToggleEvent);
    public void ToggleResponseHandler(boolean ToggleEventValue, int ToggleEventID);
    public void SliderListener(ControlEvent SliderEvent);
    public void SliderResponseHandler(float SliderEventValue, int SliderEventID);
    public void HandleToggle(Toggle ToggleController, int ToggleID, boolean ToggleValue, boolean[] ToggleArray);
    public void HandleSlider(Slider SliderController, int SliderID, float SliderValue, float[] SliderArray);
    public void DefaultValueInitialization();
    public void VisibilityResponse();
    public void onMousePressed();
    public void onMouseReleased();
    public void onMouseMoved();
    public void onMouseDragged();
    public void onMouseClicked();
    public void onKeyPressed();
    public void passiveResponse();
    public boolean isKeyDown(int keyCode);
}