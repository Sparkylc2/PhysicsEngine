public class Cloth {

    private PVector initialLeftCornerPosition;
    private PVector initialRightCornerPosition;

    private float clothWidth;
    private float clothHeight;

    private float stiffness = 300f;
    private float damping = 1f;

    private int numRowParticles;
    private int numColumnParticles;
    private int spacing = 2;
    private float particleRadius = 0.5f;

    private Rigidbody[][] clothBodyParticles;

    public Cloth(PVector initialLeftCornerPosition, PVector initialRightCornerPosition, float length) {

        this.initialLeftCornerPosition = initialLeftCornerPosition;
        this.initialRightCornerPosition = initialRightCornerPosition;
        this.clothWidth = (int)round(PVector.sub(initialLeftCornerPosition, initialRightCornerPosition).mag() / 5.0) * 5;
        this.clothHeight = (int)round(length / spacing) * spacing;

        this.numRowParticles = (int)clothWidth/spacing;
        this.numColumnParticles = (int)clothHeight/spacing;
        clothBodyParticles = new Rigidbody[numRowParticles][numColumnParticles];
    }


    public void CreateCloth() {
        float initialParticlePositionX = this.initialLeftCornerPosition.x;
        float initialParticlePositionY = this.initialLeftCornerPosition.y;

        for(int row = 0; row < numRowParticles; row++) {
            for(int column = 0; column < numColumnParticles; column++) {

                PVector currentParticlePosition = new PVector(initialParticlePositionX + row*spacing, initialParticlePositionY + column*spacing);

                Rigidbody currentParticle = RigidbodyGenerator.CreateCircleBody(particleRadius, 0.5, 0.02, false, true, 0.1f, new PVector(0,0,0), new PVector(255,255,255));
                currentParticle.setPosition(currentParticlePosition);
                currentParticle.previousPosition = currentParticlePosition.copy();

                clothBodyParticles[row][column] = currentParticle;

                currentParticle.addForceToForceRegistry(new Gravity(currentParticle));
                currentParticle.setIsVisible(false);
                AddBodyToBodyEntityList(currentParticle);
            }
        }

        clothBodyParticles[0][0].setIsVisible(true);
        clothBodyParticles[numRowParticles - 1][0].setIsVisible(true);

        clothBodyParticles[0][0].setIsStatic(true);
        clothBodyParticles[numRowParticles - 1][0].setIsStatic(true);


        for(int row = 0; row < numRowParticles; row++) {
            for(int column = 0; column < numColumnParticles; column++) {
            
                Rigidbody currentParticle = clothBodyParticles[row][column];

                // Link to particle below if it exists
                if(row < numRowParticles - 1) {
                    Rigidbody particleToLinkTo = clothBodyParticles[row+1][column];
                    addSpringBetweenParticles(currentParticle, particleToLinkTo);
                }

                // Link to particle to the right if it exists
                if(column < numColumnParticles - 1) {
                    Rigidbody particleToLinkTo = clothBodyParticles[row][column+1];
                    addSpringBetweenParticles(currentParticle, particleToLinkTo);
                }

                if (row == 0 || row == numRowParticles - 1 || column == 0 || column == numColumnParticles - 1) {
                    // If the particle is on the edge, set its collidability to true
                    currentParticle.setCollidability(true);
                } else {
                    // If the particle is not on the edge, set its collidability to false
                    currentParticle.setCollidability(false);
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

    public void updateCloth() {
      draw();
    }




    public void draw() {
beginShape(LINES);
for (int row = 0; row < numRowParticles; row++) {
    for (int column = 0; column < numColumnParticles - 1; column++) {
        PVector pos = clothBodyParticles[row][column].getPosition();
        PVector rightPos = clothBodyParticles[row][column + 1].getPosition();
        vertex(pos.x, pos.y);
        vertex(rightPos.x, rightPos.y);
    }
}
endShape();

// Draw vertical lines
beginShape(LINES);
for (int column = 0; column < numColumnParticles; column++) {
    for (int row = 0; row < numRowParticles - 1; row++) {
        PVector pos = clothBodyParticles[row][column].getPosition();
        PVector bottomPos = clothBodyParticles[row + 1][column].getPosition();
        vertex(pos.x, pos.y);
        vertex(bottomPos.x, bottomPos.y);
    }
}
endShape();


    }


}

