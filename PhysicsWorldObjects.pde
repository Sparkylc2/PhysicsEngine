

public KeyAndTabHandler KeyAndTabHandler = new KeyAndTabHandler();
    public RT_InteractionHandler RT_InteractionHandler = new RT_InteractionHandler();
    public FT_InteractionHandler FT_InteractionHandler = new FT_InteractionHandler();
    public BT_InteractionHandler BT_InteractionHandler = new BT_InteractionHandler();
public TabInteractionHandler currentTabInteractionHandler = BT_InteractionHandler;


public Camera Camera = new Camera();
public MouseObject Mouse = new MouseObject();
public ControlP5 userInterface;

public Rigidbody RigidbodyGenerator = new Rigidbody();
public Shape render = new Shape();

public Level levelEditor = new Level();
//public Editor editor = new Editor();