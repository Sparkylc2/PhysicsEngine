public KeyHandler KeyHandler = new KeyHandler();
public PThreadManager DrawThreadManager = new PThreadManager(this);
public ArrayList<PThread> UI_DrawThreads = new ArrayList<PThread>();


public DashedLines dash;
public Camera Camera = new Camera();
public MouseObject Mouse = new MouseObject();
public FrameTimeUtility FrameTimeUtility = new FrameTimeUtility();
public UI_QualitySettings playTimeTracker;


public Rigidbody RigidbodyGenerator = new Rigidbody();
public Shape Render = new Shape();
	
public UI_Constants UI_Constants;
public UI_Manager UI_Manager = new UI_Manager();




