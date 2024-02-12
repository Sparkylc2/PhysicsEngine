public interface TabInteractionHandler {

    public void ToggleListener(ControlEvent ToggleEvent);
    public void ToggleResponseHandler(boolean ToggleEventValue, int ToggleEventID);
    public void SliderListener(ControlEvent SliderEvent);
    public void SliderResponseHandler(float SliderEventValue, int SliderEventID);
    public void HandleToggle(Toggle ToggleController, int ToggleID, boolean ToggleValue, boolean[] ToggleArray);
    public void HandleToggles(int ToggleIndex, boolean ToggleValue, Toggle[] ToggleGroupArray, int[] ToggleGroupIDArray, boolean[] ToggleArray);
    public void VisibilityResponse();
    public void onMousePressed();
    public void onMouseReleased();
    public void onMouseMoved();
    public void onMouseDragged();
    public void onMouseClicked();
    public void keyPressedResponse();
    public void passiveResponse();
    public boolean isKeyDown(int keyCode);
}