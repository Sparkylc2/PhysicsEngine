
public class Shape {


  private int opacity = 166;


  private PVector fill = new PVector();
  private PVector stroke = new PVector();

  public Shape() {
  }
  
  public void draw() {
    background(16, 18, 19);
    pushMatrix();
    translate(-1920/12.5, -1080/12.5);
    scale(0.05f);
    shape(background, 0, 0);
    popMatrix();
    
    drawRigidbodies();
  /*---------------------------------Collision Point Debugging--------------------------------------*/
    if(DRAW_AABBS) {
      drawAABB();
    }
    
    if(DRAW_CONTACT_POINTS) {
      drawCollisionPoints();
    }
  /*-----------------------------------------------------------------------------------------------*/
    drawForces();
  }

/*
====================================================================================================
==================================-=== Drawing Methods =============================================
====================================================================================================
*/
  public void drawRigidbodies() {
    boolean inEditMode = true;//editor.getInEditMode();
    Rigidbody selectedRigidbody = null; //editor.getSelectedRigidbody();

    for(int body = 0; body < rigidbodyList.size(); body++) {

      Rigidbody rigidbody = rigidbodyList.get(body);
        if(rigidbody.getIsVisible()) {
          if (rigidbody.getShapeType() == ShapeType.CIRCLE) {
            drawCircle(rigidbody.getPosition(), rigidbody.getRadius(),
                      rigidbody.getAngle(), rigidbody.getStrokeWeight(), rigidbody.getFillColour(),
                       rigidbody.getStrokeColour(), inEditMode);
          }

          if (rigidbody.getShapeType() == ShapeType.BOX) {
            if(rigidbody == selectedRigidbody && inEditMode) {
              drawPolygon(rigidbody.getPosition(), rigidbody.GetTransformedVertices(),
                          rigidbody.getStrokeWeight(), rigidbody.getFillColour(),
                          rigidbody.getStrokeColour(), false);
            } else {
              drawPolygon(rigidbody.getPosition(), rigidbody.GetTransformedVertices(),
                          rigidbody.getStrokeWeight(), rigidbody.getFillColour(),
                          rigidbody.getStrokeColour(), inEditMode);
            }
          }
        }
      }
  }

  public void drawCircle(PVector position, float radius, float angle, float strokeWeight, PVector fillColour,
    PVector strokeColour, boolean inEditMode) {

    float diameter = radius * 2.0f;

    this.stroke.set(strokeColour);
    this.fill.set(fillColour);


    if(inEditMode) {
      fill(this.fill.x, this.fill.y, this.fill.z, this.opacity);
      stroke(this.stroke.x, this.stroke.y, this.stroke.z, this.opacity);
    } else {
      fill(this.fill.x, this.fill.y, this.fill.z);
      stroke(this.stroke.x, this.stroke.y, this.stroke.z);
    }

    strokeWeight(strokeWeight);
    ellipseMode(CENTER);
    ellipse(position.x, position.y,  diameter,  diameter);

    PVector va = new PVector();
    PVector vb = new PVector(radius, 0);
    va = PhysEngMath.Transform(va, position, angle);
    vb = PhysEngMath.Transform(vb, position, angle);
    line(va.x, va.y, vb.x, vb.y);
    }

  public void drawCircle(PVector position, float radius, float angle, float strokeWeight, PVector fillColour,
    PVector strokeColour, float opacity) {

    float diameter = radius * 2.0f;

    this.stroke.set(strokeColour);
    this.fill.set(fillColour);

    fill(this.fill.x, this.fill.y, this.fill.z, opacity);
    stroke(this.stroke.x, this.stroke.y, this.stroke.z, opacity);

    strokeWeight(strokeWeight);
    ellipseMode(CENTER);
    ellipse(position.x, position.y,  diameter,  diameter);

    PVector va = new PVector();
    PVector vb = new PVector(radius, 0);
    va = PhysEngMath.Transform(va, position, angle);
    vb = PhysEngMath.Transform(vb, position, angle);
    line(va.x, va.y, vb.x, vb.y);
  }
  
  public void drawBox(PVector position, float width, float height, float angle, float strokeWeight,
    PVector fillColour, PVector strokeColour, boolean inEditMode) {

    this.stroke.set(strokeColour);
    this.fill.set(fillColour);


    if(inEditMode) {
      fill(this.fill.x, this.fill.y, this.fill.z, this.opacity);
      stroke(this.stroke.x, this.stroke.y, this.stroke.z, this.opacity);
    } else {
      fill(this.fill.x, this.fill.y, this.fill.z);
      stroke(this.stroke.x, this.stroke.y, this.stroke.z);
    }
    strokeWeight(strokeWeight);
    rectMode(CENTER);
    pushMatrix();
    rect(position.x, position.y, width, height);
    popMatrix();
  }

  public void drawBox(PVector position, float width, float height, float angle, float strokeWeight,
    PVector fillColour, PVector strokeColour, int opacity) {

    this.stroke.set(strokeColour);
    this.fill.set(fillColour);


    fill(this.fill.x, this.fill.y, this.fill.z, opacity);
    stroke(this.stroke.x, this.stroke.y, this.stroke.z, opacity);

    strokeWeight(strokeWeight);
    rectMode(CENTER);

    pushMatrix();
    rotate(angle);
    rect(position.x, position.y, width, height);
    popMatrix();
  }
  
  public void drawPolygon(PVector position, PVector[] transformedVertices, float strokeWeight,
    PVector fillColour, PVector strokeColour, boolean inEditMode) {
    
    this.stroke.set(strokeColour);
    this.fill.set(fillColour);

    if(inEditMode) {
      fill(this.fill.x, this.fill.y, this.fill.z, this.opacity);
      stroke(this.stroke.x, this.stroke.y, this.stroke.z, this.opacity);
    } else {
      fill(this.fill.x, this.fill.y, this.fill.z);
      stroke(this.stroke.x, this.stroke.y, this.stroke.z);
    }

    strokeWeight(strokeWeight);

    beginShape();
    for (PVector transformedVertex : transformedVertices) {
      vertex(transformedVertex.x, transformedVertex.y);
    }
    endShape(CLOSE);
  }


public void drawPolygon(PVector position, PVector[] transformedVertices, float strokeWeight,
    PVector fillColour, PVector strokeColour, int opacity) {
    
    this.stroke.set(strokeColour);
    this.fill.set(fillColour);

    fill(this.fill.x, this.fill.y, this.fill.z, opacity);
    stroke(this.stroke.x, this.stroke.y, this.stroke.z, opacity);

    strokeWeight(strokeWeight);

    beginShape();
    for (PVector transformedVertex : transformedVertices) {
      vertex(transformedVertex.x, transformedVertex.y);
    }
    endShape(CLOSE);
  }

  public void drawAABB() {
    for(Rigidbody rigidbody : rigidbodyList) {
        AABB aabb = rigidbody.GetAABB();
        rectMode(CORNERS);
        stroke(255, 0, 0);
        noFill();
        rect(aabb.getMin().x, aabb.getMin().y, aabb.getMax().x, aabb.getMax().y);
    }
  }

/*-----------------------------------------------------------------------------------------------*/
public void drawForces() {
    for(Rigidbody rigidbody : rigidbodyList) {
        for(ForceRegistry force : rigidbody.getForceRegistry()) {
            force.draw();
        }
    }
}
/*---------------------------------Collision Point Debugging--------------------------------------*/
  public void drawCollisionPoints() {
      for(PVector point : pointsOfContactList) {
        stroke(0, 0, 0);
        strokeWeight(0.1f);
        noFill();
        rectMode(CENTER);
        rect(point.x, point.y, 1, 1);
      }
        pointsOfContactList.clear();
    }

  
/*-----------------------------------------------------------------------------------------------*/

}