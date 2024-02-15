public abstract class TabInteractionHandlerAbstract implements TabInteractionHandler {

    @Override   
    public void ToggleListener(ControlEvent ToggleEvent) {
        // do nothing
    }
    @Override
    public void ToggleResponseHandler(boolean ToggleEventValue, int ToggleEventID) {
        // do nothing
    }
    @Override
    public void SliderListener(ControlEvent SliderEvent) {
        // do nothing
    }
    @Override
    public void SliderResponseHandler(float SliderEventValue, int SliderEventID) {
        // do nothing
    }
    @Override
    public void HandleToggle(Toggle ToggleController, int ToggleID, boolean ToggleValue, boolean[] ToggleArray) {
        ToggleController.setBroadcast(false);
        ToggleController.setValue(ToggleValue ? 1 : 0);
        ToggleArray[ToggleID] = ToggleValue;
        ToggleController.setBroadcast(true);
    }


    @Override
    public void HandleSlider(Slider SliderController, int SliderID, float SliderValue, float[] SliderArray) {
        SliderController.setBroadcast(false);
        SliderController.setValue(SliderValue);
        SliderArray[SliderID] = SliderValue;
        SliderController.setBroadcast(true);
    }
    
    @Override
    public void DefaultValueInitialization() {
        // do nothing
    }
    
    @Override
    public void VisibilityResponse() {
        // do nothing
    }
    @Override
    public void onMousePressed() {
        // do nothing
    }
    @Override
    public void onMouseReleased() {
        // do nothing
    }
    @Override
    public void onMouseMoved() {
        // do nothing
    }
    @Override
    public void onMouseDragged() {
        // do nothing
    }
    @Override
    public void onMouseClicked() {
        // do nothing
    }
    @Override
    public void onKeyPressed() {
        // do nothing
    }
    @Override
    public void passiveResponse() {
        // do nothing
    }
    @Override
    public boolean isKeyDown(int keyCode) {
        return KeyAndTabHandler.isKeyDown(keyCode);
    }
}