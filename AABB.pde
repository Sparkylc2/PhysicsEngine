public class AABB {

  private final PVector Min;
  private final PVector Max;

/*
====================================================================================================
========================================== Constructors ============================================
====================================================================================================
*/

  public AABB(PVector min, PVector max) {
      this.Min = min;
      this.Max = max;
  }
  
  
/*-------------------------------------Overloaded Constructor-------------------------------------*/
  public AABB(float minX, float minY, float maxX, float maxY) {
      this.Min = new PVector(minX, maxY);
      this.Max = new PVector(maxX, maxY);
  }
  
  public AABB(PVector vec1, PVector vec2, boolean autoFix) {
      this.Min = new PVector(min(vec1.x, vec2.x), min(vec1.y, vec2.y));
      this.Max = new PVector(max(vec1.x, vec2.x), max(vec1.y, vec2.y));
  
  }
  
  public void drawAABB() {
    rectMode(CORNERS);
    dash.rect(Min.x, Min.y, Max.x, Max.y);
  }
  
  
    public void shiftAABB(PVector amount) {
      this.Min.add(amount);
      this.Max.add(amount);
    }
/*
====================================================================================================
==============================================GETTERS & SETTERS=====================================
====================================================================================================
*/
    public PVector getMin() {
      return Min;
    }
  
    public PVector getMax() {
      return Max;
    }
  
}