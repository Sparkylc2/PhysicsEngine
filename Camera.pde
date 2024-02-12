

public class Camera {

  public PVector position;
  public float zoom;
  

  public Camera() {
    position = new PVector(-50, -50);
    zoom = 10f;
  }

  public void zoom(float amount, float mouseX, float mouseY) {
        PVector mouseBeforeZoom = screenToWorld(mouseX, mouseY);
        zoom *= amount;
        PVector mouseAfterZoom = screenToWorld(mouseX, mouseY);
        PVector shift = PVector.sub(mouseBeforeZoom, mouseAfterZoom);
        position.add(shift);
    }


    public void applyTransform() {
        translate(width/2, height/2);
        scale(zoom);
        translate(-position.x, -position.y);
    }

    public void resetTransform() {
        translate(position.x, position.y);
        scale(1/zoom);
        translate(-width/2, -height/2);
    }
  
    public PVector screenToWorld(float x, float y) {
        float worldX = (x - width/2) / zoom + position.x;
        float worldY = (y - height/2) / zoom + position.y;

        return new PVector(worldX, worldY);
    }

    public PVector screenToWorld(){
        return new PVector((mouseX - width / 2) / zoom + position.x, (mouseY - height / 2) / zoom + position.y);
    }

    public void zoom(float amount) {
        zoom *= amount;
    }

    public void move(float dx, float dy) {
        position.x += dx / zoom;
        position.y += dy / zoom;
    }

    public float[] getCameraExtents(float padding) {
        float left = screenToWorld(padding, padding).x;
        float right = screenToWorld(width - padding, padding).x;
        float top = screenToWorld(padding, padding).y;
        float bottom = screenToWorld(width - padding, height - padding).y;  

        return new float[] {left, right, top, bottom};
    }

    public PVector[] getWorldBoundsWithPadding(float padding) {
        PVector topLeft = screenToWorld(padding, padding);
        PVector topRight = screenToWorld(width - padding, padding);
        PVector bottomLeft = screenToWorld(padding, height - padding);
        PVector bottomRight = screenToWorld(width - padding, height - padding);

        return new PVector[] {topLeft, topRight, bottomLeft, bottomRight};
    }

}