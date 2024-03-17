public class Softbody {

    private PVector initialPosition;

    private float radius;
    private float rectWidth;
    private float rectHeight;

    private float stiffness = 1000;
    private float damping = 1f;

    private int numRowParticles;
    private int numColumnParticles;

    private float particleRadius = 0.5f;

    private ArrayList<Rigidbody> softbodyEntityList = new ArrayList<Rigidbody>();
    private ArrayList<Rigidbody> edgeParticles = new ArrayList<Rigidbody>();
    private Rigidbody[][] softBodyParticles;

    

    public Softbody(PVector initialPosition, float radius, float RectWidth, float RectHeight) {
        this.initialPosition = initialPosition;
        this.radius = radius;

        this.rectWidth = (int)round(RectWidth);
        this.rectHeight = (int)round(RectHeight);

        //Create a way to calculate this later
        this.numRowParticles = (int)round(this.rectWidth/this.particleRadius);
        this.numColumnParticles = (int)round(this.rectHeight/this.particleRadius);
        softBodyParticles = new Rigidbody[numRowParticles][numColumnParticles];

        softbodyList.add(this);
    }


    public void CreateBoxSoftbody() {
        float spacingX = 2f;
        float spacingY = 2f;

        float initialParticlePositionX = this.initialPosition.x - this.rectWidth/2;
        float initialParticlePositionY = this.initialPosition.y - this.rectHeight/2;

        for(int row = 0; row < numRowParticles; row++) {
            for(int column = 0; column < numColumnParticles; column++) {

                PVector currentParticlePosition = new PVector(initialParticlePositionX + row*spacingX, initialParticlePositionY + column*spacingY);

                Rigidbody currentParticle = RigidbodyGenerator.CreateCircleBody(particleRadius, 0.5, 0.1, false, true, 0.1f, new PVector(0,0,0), new PVector(255,255,255));
                currentParticle.setPosition(currentParticlePosition);

                softBodyParticles[row][column] = currentParticle;
                //currentParticle.setCollidability(false);
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
    
    spring.setSpringConstant(this.stiffness);
    spring.setDamping(this.damping);
    spring.drawSpring = false;

    particleA.addForceToForceRegistry(spring);
    particleB.addForceToForceRegistry(spring);

    ALL_FORCES_ARRAYLIST.add(spring);
}

    public void updateSoftbody() {
      draw();
    }

    public void draw() {
        fill(255);
        stroke(0);
        beginShape();
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


/*

public void draw() {

    beginShape();
    PVector center = calculateCenter();
    // Top edge
    for (int column = 0; column < numColumnParticles; column++) {
        PVector pos = softBodyParticles[0][column].getPosition();
        PVector offset = pos.copy().sub(center).normalize().mult(particleRadius);
        vertex(pos.x + offset.x, pos.y + offset.y);
    }
    // Right edge
    for (int row = 0; row < numRowParticles; row++) {
        PVector pos = softBodyParticles[row][numColumnParticles - 1].getPosition();
        PVector offset = pos.copy().sub(center).normalize().mult(particleRadius);
        vertex(pos.x + offset.x, pos.y + offset.y);
    }
    // Bottom edge
    for (int column = numColumnParticles - 1; column >= 0; column--) {
        PVector pos = softBodyParticles[numRowParticles - 1][column].getPosition();
        PVector offset = pos.copy().sub(center).normalize().mult(particleRadius);
        vertex(pos.x + offset.x, pos.y + offset.y);
    }
    // Left edge
    for (int row = numRowParticles - 1; row >= 0; row--) {
        PVector pos = softBodyParticles[row][0].getPosition();
        PVector offset = pos.copy().sub(center).normalize().mult(radius);
        vertex(pos.x + offset.x, pos.y + offset.y);
    }

    endShape(CLOSE);
}

private PVector calculateCenter() {
    float totalX = 0;
    float totalY = 0;
    int count = 0;

    for (int row = 0; row < numRowParticles; row++) {
        for (int col = 0; col < numColumnParticles; col++) {
            PVector pos = softBodyParticles[row][col].getPosition();
            totalX += pos.x;
            totalY += pos.y;
            count++;
        }
    }

    if (count == 0) {
        return new PVector(0, 0); // or some default value in case there are no particles
    }

    float centerX = totalX / count;
    float centerY = totalY / count;

    return new PVector(centerX, centerY);
}
*/
}
