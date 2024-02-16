

public class Camera {

    public PVector position;
    public PVector targetPosition;
    public float zoom;
    public float targetZoom;
    float easing = 0.05f;
  

    public Camera() {
        position = new PVector(-50, -50);
        targetPosition = new PVector(-50, -50);
        zoom = 10f;
        targetZoom = 10f;

    }

    public void update() {
        position.x = lerp(position.x, targetPosition.x, easing);
        position.y = lerp(position.y, targetPosition.y, easing);

        // Smoothly change the zoom level towards the target zoom level
        zoom = lerp(zoom, targetZoom, easing);
    }
    
    public void zoom(float amount, float mouseX, float mouseY) {
        PVector mouseBeforeZoom = screenToWorld(mouseX, mouseY);
        targetZoom *= amount;
        PVector mouseAfterZoom = screenToWorld(mouseX, mouseY);
        PVector shift = PVector.sub(mouseBeforeZoom, mouseAfterZoom);
        targetPosition.add(shift);
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

    public void move(float dx, float dy) {
        targetPosition.x += dx / zoom;
        targetPosition.y += dy / zoom;
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