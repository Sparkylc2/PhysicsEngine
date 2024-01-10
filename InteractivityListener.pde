

public class InteractivityListener {

  public PVector position;
  public float zoom;

/*
====================================================================================================
======================================= GUI Variables ==============================================
====================================================================================================
*/
  private float width = 2f;
  private float height = 2f;

  private float radius = 2f;

  private float density = 1f;
  private float restitution = 1f;

  private boolean generateRigidbodies = true;
  private boolean generateForces = false;

  private boolean isStatic = false;
  private boolean isTranslationallyStatic = false;
  private boolean isRotationallyStatic = false;
  private boolean isCollidable = false;

  private float strokeWeight = 0.05f;
  private PVector strokeColour = new PVector(0,0,0);
  private PVector fillColour = new PVector(255, 255, 255);

  private ShapeType shapeType;

  public InteractivityListener() {
    position = new PVector(0, -50);
    zoom = 10f;
  }

/*
====================================================================================================
======================================= GUI Methods ================================================
====================================================================================================
*/

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

  public void zoom(float amount) {
    zoom *= amount;
  }

  void move(float dx, float dy) {
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
//Overloaded method that returns the camera extents as PVector coordinates
public PVector[] getWorldBoundsWithPadding(float padding) {
  PVector topLeft = screenToWorld(padding, padding);
  PVector topRight = screenToWorld(width - padding, padding);
  PVector bottomLeft = screenToWorld(padding, height - padding);
  PVector bottomRight = screenToWorld(width - padding, height - padding);

  return new PVector[] {topLeft, topRight, bottomLeft, bottomRight};
}
/*
====================================================================================================
======================================= Getters & Setters ==========================================
====================================================================================================
*/


public void setWidth(float width) {
  this.width = width;
}

public void setHeight(float height) {
  this.height = height;
}

public void setRadius(float radius) {
  this.radius = radius;
}

public void setDensity(float density) {
  this.density = density;
}

public void setRestitution(float restitution) {
  this.restitution = restitution;
}

public void setIsStatic(boolean isStatic) {
  this.isStatic = isStatic;
}

public void setCollidable(boolean isCollidable) {
  this.isCollidable = isCollidable;
}

public void setStrokeWeight(float strokeWeight) {
  this.strokeWeight = strokeWeight;
}

public void setStrokeColour(PVector strokeColour) {
  this.strokeColour = strokeColour;
}

public void setFillColour(PVector fillColour) {
  this.fillColour = fillColour;
}

public void setShapeType(ShapeType shapeType) {
  this.shapeType = shapeType;
}

public void setIsTranslationallyStatic(boolean isTranslationallyStatic) {
  this.isTranslationallyStatic = isTranslationallyStatic;
}

public void setIsRotationallyStatic(boolean isRotationallyStatic) {
  this.isRotationallyStatic = isRotationallyStatic;
}

public void setGenerateRigidbodies(boolean generateRigidbodies) {
  this.generateRigidbodies = generateRigidbodies;
}

public void setGenerateForces(boolean generateForces) {
  this.generateForces = generateForces;
}


public float getWidth() {
  return this.width;
}

public float getHeight() {
  return this.height;
}

public float getRadius() {
  return this.radius;
}

public float getDensity() {
  return this.density;
}

public float getRestitution() {
  return this.restitution;
}

public boolean getIsStatic() {
  return this.isStatic;
}

public boolean getCollidable() {
  return this.isCollidable;
}

public float getStrokeWeight() {
  return this.strokeWeight;
}

public PVector getStrokeColour() {
  return this.strokeColour;
}

public PVector getFillColour() {
  return this.fillColour;
}

public ShapeType getShapeType() {
  return this.shapeType;
}

public boolean getIsTranslationallyStatic() {
  return this.isTranslationallyStatic;
}

public boolean getIsRotationallyStatic() {
  return this.isRotationallyStatic;
}

public boolean getGenerateRigidbodies() {
  return this.generateRigidbodies;
}

public boolean getGenerateForces() {
  return this.generateForces;
}


}



public void mouseWheel(MouseEvent event) {
    if(!userInterface.isMouseOver()) {
        float e = -event.getCount();
        interactivityListener.zoom(pow(1.1f, e), mouseX, mouseY);
    }
}

public void mouseDragged() {
  if(!userInterface.isMouseOver()){
    interactivityListener.move(pmouseX - mouseX, pmouseY - mouseY);
  }
}

public void mouseClicked() {
    if(!userInterface.isMouseOver()) {
    if(interactivityListener.getShapeType() == ShapeType.BOX) {
        Rigidbody rigidbody = RigidbodyGenerator.CreateBoxBody( interactivityListener.getWidth(),
                                                                interactivityListener.getHeight(),
                                                                interactivityListener.getDensity(),
                                                                interactivityListener.getRestitution(),
                                                                interactivityListener.getIsStatic(),
                                                                interactivityListener.getCollidable(),
                                                                interactivityListener.getStrokeWeight(),
                                                                interactivityListener.getStrokeColour(),
                                                                interactivityListener.getFillColour());

        rigidbody.SetInitialPosition(interactivityListener.screenToWorld(mouseX, mouseY));
        rigidbody.setIsTranslationallyStatic(interactivityListener.getIsTranslationallyStatic());
        rigidbody.setIsRotationallyStatic(interactivityListener.getIsRotationallyStatic());
        
        rigidbody.addForceToForceRegistry(new Gravity());
        AddBodyToBodyEntityList(rigidbody);
  
  }
  if(interactivityListener.getShapeType() == ShapeType.CIRCLE) {
    Rigidbody rigidbody = RigidbodyGenerator.CreateCircleBody(interactivityListener.getRadius(),
                                                                interactivityListener.getDensity(),
                                                                interactivityListener.getRestitution(),
                                                                interactivityListener.getIsStatic(),
                                                                interactivityListener.getCollidable(),
                                                                interactivityListener.getStrokeWeight(),
                                                                interactivityListener.getStrokeColour(),
                                                                interactivityListener.getFillColour());
    
    rigidbody.SetInitialPosition(interactivityListener.screenToWorld(mouseX, mouseY));
    rigidbody.setIsTranslationallyStatic(interactivityListener.getIsTranslationallyStatic());
    rigidbody.setIsRotationallyStatic(interactivityListener.getIsRotationallyStatic());

    rigidbody.addForceToForceRegistry(new Gravity());
    AddBodyToBodyEntityList(rigidbody);

  }
    }
}





