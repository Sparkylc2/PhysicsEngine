public class FrameTimeUtility {

    private int simulationStartTime;
    private int currentFrameTime;
    private int lastFrameTime;


    private long totalWorldStepTimeStart;
    private long subWorldStepTimeStart;

    private long totalWorldStepTime;
    private long subWorldStepTime;

    private int totalBodyCount;
    private double systemTime;

    private int totalSampleCount;
    private int subSampleCount;

    private String totalStepTime;
    private String subStepTime;
    private int bodyCount;

    private String totalStepTimeUnit;
    private String subStepTimeUnit;

    public float DT = 0.0f;
    private float fps;
    private float displayTimeStep;



    public void displayTimings() {
        if(!DRAW_STATS) {
            return;
        }
        
        if(millis() - systemTime >= 200) {
            this.totalStepTime = calculateAverageTime(this.totalWorldStepTime, this.totalSampleCount);
            this.subStepTime = calculateAverageTime(this.subWorldStepTime, this.subSampleCount);
            this.bodyCount = rigidbodyList.size();

            //updates the counter and resets values
            this.totalWorldStepTime = 0;
            this.subWorldStepTime = 0;
            this.totalSampleCount = 0;
            this.subSampleCount = 0;
            this.systemTime = millis();

            this.fps = frameRate;
            this.displayTimeStep = this.DT;
        }

        textFont(UI_Constants.INTER_REGULAR);
        textSize(15);
        textAlign(LEFT, CENTER);
        stroke(255);
        fill(255);
        text("Total Step Time: " + totalStepTime, 10, 40);
        text("Sub Step Time: " + subStepTime, 10, 60);
        text("Body Count: " + bodyCount, 10, 80);
        text("FPS: " + fps, 10, 100);
        text("dt: " + displayTimeStep, 10, 120);
        text("Simulation Length: " + (float)(millis() - this.simulationStartTime) / 1000, 10, 140);
    }


    public void startTotalWorldStepTime() {
        if(!DRAW_STATS) {
            return;
        }
        this.totalWorldStepTimeStart = System.nanoTime();
    }
    public void updateTotalWorldStepTime() {
        if(!DRAW_STATS) {
            return;
        }
        this.totalSampleCount++;
        this.totalWorldStepTime += System.nanoTime() - totalWorldStepTimeStart;
    }
    
    public void startSubWorldStepTime() {
        if(!DRAW_STATS) {
            return;
        }
        this.subWorldStepTimeStart = System.nanoTime();
    }

    public void updateSubWorldStepTime() {
        if(!DRAW_STATS) {
            return;
        }
        this.subSampleCount++;
        this.subWorldStepTime += System.nanoTime() - subWorldStepTimeStart;
    }

    private String calculateAverageTime(long totalTime, int sampleCount) {
        double averageTime = ((double)totalTime) / sampleCount;
        String timeUnit = "ns";

        if(averageTime > 1000) {
            averageTime /= 1000;
            timeUnit = "μs";
        }
        if (averageTime > 1000) {
            averageTime /= 1000;
            timeUnit = "ms";
        }

        averageTime = new BigDecimal(averageTime).setScale(3, RoundingMode.HALF_UP).doubleValue();
        return averageTime + timeUnit;
    }

    public void init() {
        this.simulationStartTime = millis();
        this.lastFrameTime = millis();
    }

    public void calculateFrameTime() {
        this.currentFrameTime = millis();
        this.DT = (float)(this.currentFrameTime - this.lastFrameTime) / 1000.0F;
    }

    public void updateFrameTime() {
        this.lastFrameTime = this.currentFrameTime;
    }
}
