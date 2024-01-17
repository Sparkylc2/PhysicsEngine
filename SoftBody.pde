public class Softbody {

    private PVector initialPosition;

    private float radius;
    private float width;
    private float height;

    private float stiffness = 300;
    private float damping = 0.5f;

    private int numRowParticles;
    private int numColumnParticles;

    private float particleRadius = 0.25f;

    private Rigidbody[][] softBodyParticles;
    

    public Softbody(PVector initialPosition, float radius, float width, float height) {

        this.initialPosition = initialPosition;
        this.radius = radius;

        this.width = Math.round(width);
        this.height = Math.round(height);

        //Create a way to calculate this later
        this.numRowParticles = Math.round(this.width/this.particleRadius);
        this.numColumnParticles = Math.round(this.height/this.particleRadius);

        softBodyParticles = new Rigidbody[numRowParticles][numColumnParticles];
    }


    public void CreateBoxSoftbody() {
        float spacingX = 1;
        float spacingY = 1f;

        float initialParticlePositionX = this.initialPosition.x - this.width/2;
        float initialParticlePositionY = this.initialPosition.y - this.height/2;

        for(int row = 0; row < numRowParticles; row++) {
            for(int column = 0; column < numColumnParticles; column++) {

                PVector currentParticlePosition = new PVector(initialParticlePositionX + row*spacingX, initialParticlePositionY + column*spacingY);

                Rigidbody currentParticle = RigidbodyGenerator.CreateCircleBody(particleRadius, 0.5, 0.1, false, true, 0.1f, new PVector(0,0,0), new PVector(255,255,255));
                currentParticle.setPosition(currentParticlePosition);

                softBodyParticles[row][column] = currentParticle;

                currentParticle.addForceToForceRegistry(new Gravity(currentParticle));
                currentParticle.setIsVisible(false);

                AddBodyToBodyEntityList(currentParticle);
            }
        }


for(int row = 0; row < numRowParticles; row++) {
    for(int column = 0; column < numColumnParticles; column++) {

        Rigidbody currentParticle = softBodyParticles[row][column];

        // Link to particle below if it exists
        if(row < numRowParticles - 1) {
            Rigidbody particleToLinkTo = softBodyParticles[row+1][column];
            addSpringBetweenParticles(currentParticle, particleToLinkTo);
        }

        // Link to particle to the right if it exists
        if(column < numColumnParticles - 1) {
            Rigidbody particleToLinkTo = softBodyParticles[row][column+1];
            addSpringBetweenParticles(currentParticle, particleToLinkTo);
        }

        // Link to bottom-right diagonal if it exists
        if(row < numRowParticles - 1 && column < numColumnParticles - 1) {
            Rigidbody particleToLinkTo = softBodyParticles[row+1][column+1];
            addSpringBetweenParticles(currentParticle, particleToLinkTo);
        }

        // Link to top-right diagonal if it exists
        if(row > 0 && column < numColumnParticles - 1) {
            Rigidbody particleToLinkTo = softBodyParticles[row-1][column+1];
            addSpringBetweenParticles(currentParticle, particleToLinkTo);
        }
    }
}
    }

private void addSpringBetweenParticles(Rigidbody particleA, Rigidbody particleB) {
    Spring spring = new Spring(particleA, particleB, new PVector(), new PVector());
    spring.setSpringLength(PVector.dist(particleA.getPosition(), particleB.getPosition()));
    spring.setSpringConstant(this.stiffness);
    spring.setDamping(this.damping);
    spring.drawSpring = false;

    particleA.addForceToForceRegistry(spring);
    particleB.addForceToForceRegistry(spring);
}

 public void draw() {
    
  beginShape();
  // Top edge
  for (int column = 0; column < numColumnParticles; column++) {
    PVector pos = softBodyParticles[0][column].getPosition();
    vertex(pos.x, pos.y);
  }
  // Right edge
  for (int row = 0; row < numRowParticles; row++) {
    PVector pos = softBodyParticles[row][numColumnParticles - 1].getPosition();
    vertex(pos.x, pos.y);
  }
  // Bottom edge
  for (int column = numColumnParticles - 1; column >= 0; column--) {
    PVector pos = softBodyParticles[numRowParticles - 1][column].getPosition();
    vertex(pos.x, pos.y);
  }
  // Left edge
  for (int row = numRowParticles - 1; row >= 0; row--) {
    PVector pos = softBodyParticles[row][0].getPosition();
    vertex(pos.x, pos.y);
  }
  endShape(CLOSE);
  
  
}


}

