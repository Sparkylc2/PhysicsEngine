public class UI_CreationWindow extends UI_Window {



    public UI_State state = UI_State.DEFAULT;
    public UI_State previousState = UI_State.DEFAULT;


    private String currentlyLoadedLevel = "";
    private UI_FileButton activeFileButton = null;

    private int totalFiles = -1;

    private int currentPage = 0;


	public UI_CreationWindow() {
		super("Creations", 2, new PVector(338, 400), new PVector(338, 35), new PVector(338, 400 - 35), false);

        this.Window_Container.resetMatrix();
        float borderSizeX = 290;
        float borderSizeY = 242;
        float borderY = -this.Window_Form_Container_Size.y / 2 + 9 + borderSizeY / 2;

        PShape selectionBorder = createShape(RECT, 0, borderY, borderSizeX, borderSizeY, this.Window_Rounding);
            selectionBorder.setName("File_Selection_Border");
            selectionBorder.setFill(false);
            selectionBorder.setStroke(UI_Constants.GRAY_300);
            selectionBorder.setStrokeWeight(UI_Constants.GLOBAL_STROKE_WEIGHT);
        
        this.Window_Container.addChild(selectionBorder);
        
        this.Window_Container.translate(this.Window_Position.x, this.Window_Position.y);
        this.Window_Container.scale(this.Window_Scale);

        this.initializeCreationsWindow();
	}

	public void initializeCreationsWindow() {
        this.updateFileSelection(false, false, null);
        this.onFileDeselect();
    }

    public void updateFileSelection(boolean isIncrement, boolean isDecrement, UI_FileButton activeFileButton) {
        //5 elements per page
        String path = sketchPath() + "/data/LevelSaves/";
        File[] allFiles = new File(path).listFiles();
        
        //Sorts files to be most recent modified ontop 

        File[] saveFiles = Arrays.stream(allFiles)
            .filter(file -> file.getName().endsWith(".json"))
            .toArray(File[]::new);
        Arrays.sort(saveFiles, Comparator.comparingLong(File::lastModified).reversed());

        this.totalFiles = saveFiles.length;

        if(isIncrement) {
            if((this.currentPage + 1) * 5 < saveFiles.length) {
                this.currentPage++;
            }
        }

        if(isDecrement) {
            if(this.currentPage > 0) {
                this.currentPage--;
            }
        }

        int start = this.currentPage * 5;
        int end;

        if((currentPage + 1) * 5 > saveFiles.length) {
            end = saveFiles.length;
        } else {
            end = (currentPage + 1) * 5;
        }

        for(int i = start; i < end; i++) {

            UI_FileButton fileButton = new UI_FileButton(saveFiles[i], 
                                                        saveFiles[i].getName().substring(0, saveFiles[i].getName().indexOf(".json")), 
                                                        this, "FileGroup", false, saveFiles[i].getAbsolutePath());
            if(activeFileButton != null) {
                if(fileButton.equals(activeFileButton)) {

                }

                if(this.state == UI_State.RENAME_LEVEL) {
                    if(fileButton.equals(activeFileButton)) {
                        fileButton.FileButton_ShowName = false;
                    }
                }
            } 

            this.addElement(fileButton);
        }

    }   


    public void onFileSelect() {
        this.clearAllElements();
        this.updateFileSelection(false, false, this.activeFileButton);
        this.addElement(new UI_Button("Delete Level", this, false));
        this.addElement(new UI_Button("Load Level", this, false));
        this.addElement(new UI_Button("Rename Level", this, false));
    }

    public void onFileDeselect() {
        this.clearAllElements();
        this.updateFileSelection(false, false, null);

        if(this.totalFiles > 5) {
            if(this.currentPage > 0) {
                this.addElement(new UI_Button("Prev Page", this, false));
            }
            if((this.currentPage + 1) * 5 < this.totalFiles) {
                this.addElement(new UI_Button("Next Page", this, false));
            }
        }

        this.addElement(new UI_Button("Save Level", this, false));

    }

    public void onLevelSaved() {

        this.saveLevelState();
        this.state = UI_State.DEFAULT;

        this.clearAllElements();
        this.currentPage = 0;
        this.updateFileSelection(false, false, null);

        if(this.totalFiles > 5) {
            if(this.currentPage > 0) {
                this.addElement(new UI_Button("Prev Page", this, false));
            }
            if((this.currentPage + 1) * 5 < this.totalFiles) {
                this.addElement(new UI_Button("Next Page", this, false));
            }
        }

        this.addElement(new UI_Button("Save Level", this, false));
    }

    public void onLevelLoad() {
        this.loadLevelState();
        this.currentPage = 0;
        this.onFileDeselect();
    }

    public void onLevelDelete() {
        this.activeFileButton.deleteFile();
        this.onFileDeselect();
    }


    public void onFileDecrement() {
        this.clearAllElements();
        this.updateFileSelection(false, true, null);

        if(this.totalFiles > 5) {
            if(this.currentPage > 0) {
                this.addElement(new UI_Button("Prev Page", this, false));
            }
            if((this.currentPage + 1) * 5 < this.totalFiles) {
                this.addElement(new UI_Button("Next Page", this, false));
            }
        }

        this.addElement(new UI_Button("Save Level", this, false));
    }

    public void onFileIncrement() {
        this.clearAllElements();
        this.updateFileSelection(true, false, null);

        if(this.totalFiles > 5) {
            if(this.currentPage > 0) {
                this.addElement(new UI_Button("Prev Page", this, false));
            }
            if((this.currentPage + 1) * 5 < this.totalFiles) {
                this.addElement(new UI_Button("Next Page", this, false));
            }
        }

        this.addElement(new UI_Button("Save Level", this, false));
    }

    public void onRenameLevelSelect() {
        this.state = UI_State.RENAME_LEVEL;

        this.clearAllElements();
        this.updateFileSelection(false, false, this.activeFileButton);

        this.state = UI_State.FILE_SELECTED;

        this.addElement(new UI_Button("Rename Level", this, true));

        float[] params = this.activeFileButton.FileButton_Shape_Group.getChild("FileButton_Shape_Base").getParams();

        UI_TextField renameLevel = new UI_TextField("Rename Level TextField", this, params[0], params[1], params[2], params[3], true);
        renameLevel.TextField_Text = this.activeFileButton.FileButton_Name;
        renameLevel.TextField_TextLength = this.activeFileButton.FileButton_Name.length();
        renameLevel.TextField_ShowName = false;
        this.addElement(renameLevel);
    }

    public void onLevelRenamed() {
        this.activeFileButton.renameFile(this.getFileButtonToRenameTextField().TextField_Text);
        this.state = UI_State.DEFAULT;

        this.clearAllElements();
        this.updateFileSelection(false, false, null);

        if(this.totalFiles > 5) {
            if(this.currentPage > 0) {
                this.addElement(new UI_Button("Prev Page", this, false));
            }
            if((this.currentPage + 1) * 5 < this.totalFiles) {
                this.addElement(new UI_Button("Next Page", this, false));
            }
        }

        this.addElement(new UI_Button("Save Level", this, false));
    }

    public void onSaveLevelSelect() {
        this.clearAllElements();
        this.updateFileSelection(false, false, null);
        
        float params[] = this.Window_Container.getChild("File_Selection_Border").getParams();
        float TextField_Position_X = 0;
        float TextField_Position_Y = params[1] + params[3] / 2 + 16 + 31/2;

        this.addElement(new UI_TextField("Level Name", this, TextField_Position_X, TextField_Position_Y));
        this.addElement(new UI_Button("Save Level", this, true));
    }


    @Override
    public void interactionDraw() {
        if(UI_Manager.getTabBar().getActiveTabID() == 2) {
            this.lockSelected();
        }   
    }

    @Override
    public void interactionMousePress() {

    }

    @Override
    public void interactionMouseRelease() {
        if(UI_Manager.getTabBar().getActiveTabID() == 2) { 
            this.checkWindowElements();
            this.updateState();
        }
    }

    @Override
    public void interactionMouseClick() {

    }

    @Override
    public void onWindowSelect() {
        this.deselectAllWindows();
        this.isActiveWindow = true;
        this.Window_Visibility = true;
        UI_Manager.bringToFront(this);
        this.Window_Container.getChild("Window_Container_Stroke").setStroke(UI_Constants.BLUE_SELECTED);
        this.Window_Container.getChild("Window_Text_Container").setFill(UI_Constants.BLUE_UNSELECTED);
    }


    
    public void lockSelected() {
        this.isActiveWindow = true;
        this.Window_Visibility = true;
        UI_Manager.getHotBar().setActiveSlotID(-1);
        //this.updateFileSelection();
        this.Window_Container.getChild("Window_Container_Stroke").setStroke(UI_Constants.BLUE_SELECTED);
        this.Window_Container.getChild("Window_Text_Container").setFill(UI_Constants.BLUE_UNSELECTED);
    }

    public void open() {
        this.deselectAllWindows();
        this.isActiveWindow = true;
        this.Window_Visibility = true;
        UI_Manager.bringToFront(this);
        this.Window_Container.getChild("Window_Container_Stroke").setStroke(UI_Constants.BLUE_SELECTED);
        this.Window_Container.getChild("Window_Text_Container").setFill(UI_Constants.BLUE_UNSELECTED);
        this.initializeCreationsWindow();
    }


    private UI_TextField getTextField() {
        for(UI_Element element : this.Window_Elements) {
            if(element instanceof UI_TextField && element.getElementName().equals("Level Name")) {
                return (UI_TextField)element;
            }
        }
        return null;
    }

    private UI_TextField getFileButtonToRenameTextField() {
        for(UI_Element element : this.Window_Elements) {
            if(element instanceof UI_TextField && element.getElementName().equals("Rename Level TextField")) {
                return (UI_TextField)element;
            }
        }
        return null;
    }

	@Override
	public void onKeyPress(int keyCode) {
        // if(this.state == UI_State.SAVE_LEVEL) {
        //     UI_TextField textField = this.getTextField();
        //     if(textField != null && textField.keyPress(keyCode)) {
        //         //Returns true if enter is pressed, so once this returns true save the level with the name of the text inside
        //     }
        // }

		switch(keyCode) {
			case KeyEvent.VK_Z:
				this.saveLevelState();
                break;
			case KeyEvent.VK_X:
				this.loadLevelState();
                break;
            case KeyEvent.VK_LEFT:
                this.onFileDecrement();
                break;
            case KeyEvent.VK_RIGHT:
                this.onFileIncrement();
                break;
        }

	}


    public void updateState() {
        if(this.state == this.previousState) {
            return;
        }

        switch(this.state) {
            case DEFAULT:
                this.onFileDeselect();
                break;
            case FILE_SELECTED:
                this.onFileSelect();
                break;
            case SAVE_LEVEL:
                this.onSaveLevelSelect();
                break;
        }

        this.previousState = this.state;
    }

    public void redrawState() {
        switch(this.state) {
            case DEFAULT:
                this.onFileDeselect();
                break;
            case FILE_SELECTED:
                this.onFileSelect();
                break;
            case SAVE_LEVEL:
                this.onSaveLevelSelect();
                break;
        }
    }


   
    public void checkWindowElements() {
        for(UI_Element element : this.Window_Elements) {
            if(element instanceof UI_FileButton) {
                if(element.getState()) {
                    this.activeFileButton = (UI_FileButton)element;
                    this.state = UI_State.FILE_SELECTED;
                    return;
                }
            }

            if(element instanceof UI_Button) {
                if(element.getElementName().equals("Save Level") && element.getState()) {
                    this.state = UI_State.SAVE_LEVEL;
                    return;
                } else if(element.getElementName().equals("Save Level") && !element.getState()) {
                    this.state = UI_State.DEFAULT;
                    return;
                }
            }   
        }

        this.activeFileButton = null;
        this.state = UI_State.DEFAULT;
    }

/*
=========================================== Level Loading & Saving =============================================
*/
	public void loadLevelState() {
		IS_PAUSED = true;
		JSONArray rigidbodyArray = loadJSONArray(this.activeFileButton.FilePath);
        this.currentlyLoadedLevel = this.activeFileButton.FileButton_Name;

		ALL_FORCES_ARRAYLIST.clear();
		rigidbodyList.clear();

		for(int i = 0; i < rigidbodyArray.size()-1; i++) {
			JSONObject rigidbodyJSON = rigidbodyArray.getJSONObject(i);
			Rigidbody rigidbody = this.deserializeRigidbody(rigidbodyJSON);
			rigidbody.addForceToForceRegistry(new Gravity(rigidbody));
			rigidbodyList.add(rigidbody);

		}

		JSONArray forcesArray = rigidbodyArray.getJSONArray(rigidbodyArray.size() - 1);

		for(int i = 0; i < forcesArray.size(); i++) {
			Spring spring = null;
			Rod rod = null;
			Motor motor = null;
			Gravity gravity = null;

			JSONObject forceJSON = forcesArray.getJSONObject(i);

			if(forceJSON.getString("ForceType").equals("Spring")){
				spring = this.deserializeSpring(forceJSON);
			} else if (forceJSON.getString("ForceType").equals("Rod")) {
				rod = this.deserializeRod(forceJSON);
			} else if (forceJSON.getString("ForceType").equals("Motor")) {
				motor = this.deserializeMotor(forceJSON);
			} else if(forceJSON.getString("ForceType").equals("Gravity")) {
				gravity = this.deserializeGravity(forceJSON);
			}

			if(spring != null) {
				if(spring.getIsTwoBodySpring()) {
					spring.getRigidbodyA().addForceToForceRegistry(spring);
					spring.getRigidbodyB().addForceToForceRegistry(spring);
					ALL_FORCES_ARRAYLIST.add(spring);
				} else {
					spring.getRigidbodyA().addForceToForceRegistry(spring);
					ALL_FORCES_ARRAYLIST.add(spring);
				}
			} else if(rod != null) {
				if(rod.getTwoBodyRod()) {
					rod.getRigidbodyA().addForceToForceRegistry(rod);
					rod.getRigidbodyB().addForceToForceRegistry(rod);

					if(rod.getIsJoint()) {
						rod.getRigidbodyA().addBodyToCollisionExclusionList(rod.getRigidbodyB());
						rod.getRigidbodyB().addBodyToCollisionExclusionList(rod.getRigidbodyA());
					}
					ALL_FORCES_ARRAYLIST.add(rod);
				} else {
					rod.getRigidbodyA().addForceToForceRegistry(rod);
					ALL_FORCES_ARRAYLIST.add(rod);
				}
			} else if(motor != null) {
				motor.getRigidbodyA().addForceToForceRegistry(motor);
				ALL_FORCES_ARRAYLIST.add(spring);

			} else if(gravity != null) {
				gravity.getRigidbodyA().addForceToForceRegistry(gravity);
				ALL_FORCES_ARRAYLIST.add(gravity);
			}
		}
		IS_PAUSED = false;
	}

	public void saveLevelState() {
		JSONArray rigidbodyArray = new JSONArray();

		for(Rigidbody body : rigidbodyList) {

			String ID = body.getID();

			/*---------------- Main Rigidbody JSON Object --------------*/
			JSONObject rigidbodyJSON = new JSONObject();
			/*----------------------------------------------------------*/

			JSONObject IDJSON = new JSONObject();
					IDJSON.setString("ID", ID);
				rigidbodyJSON.setJSONObject("RigidbodyID", IDJSON);

			JSONObject positionAndVelocityJSON = new JSONObject();
					positionAndVelocityJSON.setJSONObject("position", this.serialize2DPVector(body.getPosition()));
					positionAndVelocityJSON.setJSONObject("velocity", this.serialize2DPVector(body.getVelocity()));
				rigidbodyJSON.setJSONObject("positionAndVelocity", positionAndVelocityJSON);


			JSONObject angleAndAngularVelocityJSON = new JSONObject();
					angleAndAngularVelocityJSON.setFloat("angle", body.getAngle());
					angleAndAngularVelocityJSON.setFloat("angularVelocity", body.getAngularVelocity());
				rigidbodyJSON.setJSONObject("angleAndAngularVelocity", angleAndAngularVelocityJSON);

			JSONObject shapeTypeJSON = new JSONObject();
					shapeTypeJSON.setString("shapeType", body.getShapeType().name());
				rigidbodyJSON.setJSONObject("shapeType", shapeTypeJSON);

			JSONObject densityAndRestitutionJSON = new JSONObject();
					densityAndRestitutionJSON.setFloat("density", body.getDensity());
					densityAndRestitutionJSON.setFloat("restitution", body.getRestitution());
				rigidbodyJSON.setJSONObject("densityAndRestitution", densityAndRestitutionJSON);

			JSONObject geometryJSON = new JSONObject();
					JSONArray verticesArray = serializePVectorArray(body.getVertices());
					geometryJSON.setJSONArray("vertices", verticesArray);
					geometryJSON.setFloat("radius", body.getRadius());
					geometryJSON.setFloat("width", body.getWidth());
					geometryJSON.setFloat("height", body.getHeight());
				rigidbodyJSON.setJSONObject("geometry", geometryJSON);

		JSONObject frictionJSON = new JSONObject();
				frictionJSON.setFloat("coeffOfStaticFriction", body.getCoefficientOfStaticFriction());
				frictionJSON.setFloat("coeffOfKineticFriction", body.getCoefficientOfKineticFriction());
			rigidbodyJSON.setJSONObject("friction", frictionJSON);

		JSONObject staticityJSON = new JSONObject();
				staticityJSON.setBoolean("isStatic", body.getIsStatic());
				staticityJSON.setBoolean("isTranslationallyStatic", body.getIsTranslationallyStatic());
				staticityJSON.setBoolean("isRotationallyStatic", body.getIsRotationallyStatic());
			rigidbodyJSON.setJSONObject("staticity", staticityJSON);

		JSONObject drawingPropertiesJSON = new JSONObject();
				drawingPropertiesJSON.setFloat("strokeWeight", body.getStrokeWeight());
				drawingPropertiesJSON.setJSONObject("strokeColour", serialize3DPVector(body.getStrokeColour()));
				drawingPropertiesJSON.setJSONObject("fillColour", serialize3DPVector(body.getFillColour()));
			rigidbodyJSON.setJSONObject("drawingProperties", drawingPropertiesJSON);

		JSONObject visibilityAndCollidabilityJSON = new JSONObject();
				visibilityAndCollidabilityJSON.setBoolean("visibility", body.getIsVisible());
				visibilityAndCollidabilityJSON.setBoolean("collidability", body.getCollidability());
			rigidbodyJSON.setJSONObject("visibilityAndCollidability", visibilityAndCollidabilityJSON);


			rigidbodyArray.append(rigidbodyJSON);
		}

		rigidbodyArray.append(this.serializeForces());

		saveJSONArray(rigidbodyArray, sketchPath() + "/data/LevelSaves/" + this.getTextField().TextField_Text + ".json");
	}

	private JSONArray serializeForces() {
			JSONArray forcesArray = new JSONArray();

			for(int i = 0; i < ALL_FORCES_ARRAYLIST.size(); i++) {
				JSONObject forceJSON = new JSONObject();
				ForceRegistry force = ALL_FORCES_ARRAYLIST.get(i);

				if(force instanceof Spring) {
					forceJSON = serializeSpring((Spring)force);
				} else if(force instanceof Rod) {
					forceJSON = serializeRod((Rod)force);
				} else if(force instanceof Motor) {
					forceJSON = serializeMotor((Motor)force);
				} else if(force instanceof Gravity) {
					forceJSON = serializeGravity((Gravity)force);
				}
				forcesArray.append(forceJSON);
			}
			return forcesArray;
	}


	private Rigidbody deserializeRigidbody(JSONObject rigidbodyJSON) {
		Rigidbody rigidbody;
		ShapeType shapeType = this.deserializeShapeType(rigidbodyJSON.getJSONObject("shapeType"));

		if(shapeType == ShapeType.CIRCLE) {
			rigidbody = RigidbodyGenerator.CreateCircleBody(rigidbodyJSON.getJSONObject("geometry").getFloat("radius"),
															rigidbodyJSON.getJSONObject("densityAndRestitution").getFloat("density"),
															rigidbodyJSON.getJSONObject("densityAndRestitution").getFloat("restitution"),
															rigidbodyJSON.getJSONObject("staticity").getBoolean("isStatic"),
															rigidbodyJSON.getJSONObject("visibilityAndCollidability").getBoolean("collidability"),
															rigidbodyJSON.getJSONObject("drawingProperties").getFloat("strokeWeight"),
															this.deserialize3DPVector(rigidbodyJSON.getJSONObject("drawingProperties").getJSONObject("strokeColour")),
															this.deserialize3DPVector(rigidbodyJSON.getJSONObject("drawingProperties").getJSONObject("fillColour")));

		} else {
			rigidbody = RigidbodyGenerator.CreatePolygon(this.deserializePVectorArray(rigidbodyJSON.getJSONObject("geometry").getJSONArray("vertices")),
															rigidbodyJSON.getJSONObject("densityAndRestitution").getFloat("density"),
															rigidbodyJSON.getJSONObject("densityAndRestitution").getFloat("restitution"),
															rigidbodyJSON.getJSONObject("staticity").getBoolean("isStatic"),
															rigidbodyJSON.getJSONObject("staticity").getBoolean("isTranslationallyStatic"),
															rigidbodyJSON.getJSONObject("staticity").getBoolean("isRotationallyStatic"),
															rigidbodyJSON.getJSONObject("visibilityAndCollidability").getBoolean("collidability"),
															rigidbodyJSON.getJSONObject("drawingProperties").getFloat("strokeWeight"),
															this.deserialize3DPVector(rigidbodyJSON.getJSONObject("drawingProperties").getJSONObject("strokeColour")),
															this.deserialize3DPVector(rigidbodyJSON.getJSONObject("drawingProperties").getJSONObject("fillColour")));
		}

			rigidbody.setID(rigidbodyJSON.getJSONObject("RigidbodyID").getString("ID"));
			rigidbody.setIsStatic(rigidbodyJSON.getJSONObject("staticity").getBoolean("isStatic"));
			rigidbody.setIsTranslationallyStatic(rigidbodyJSON.getJSONObject("staticity").getBoolean("isTranslationallyStatic"));
			rigidbody.setIsRotationallyStatic(rigidbodyJSON.getJSONObject("staticity").getBoolean("isRotationallyStatic"));

			rigidbody.SetInitialPosition(this.deserialize2DPVector(rigidbodyJSON.getJSONObject("positionAndVelocity").getJSONObject("position")));
			rigidbody.setVelocity(this.deserialize2DPVector(rigidbodyJSON.getJSONObject("positionAndVelocity").getJSONObject("velocity")));
			rigidbody.setAngle(rigidbodyJSON.getJSONObject("angleAndAngularVelocity").getFloat("angle"));
			rigidbody.setAngularVelocity(rigidbodyJSON.getJSONObject("angleAndAngularVelocity").getFloat("angularVelocity"));


			return rigidbody;
	}

	private Spring deserializeSpring(JSONObject springJSON) {

		boolean isTwoBodySpring = springJSON.getBoolean("isTwoBodySpring");
		if(isTwoBodySpring) {
			Rigidbody rigidbodyA = this.getRigidbodyByID(springJSON.getString("rigidbodyAID"));
			Rigidbody rigidbodyB = this.getRigidbodyByID(springJSON.getString("rigidbodyBID"));


			PVector localAnchorA = this.deserialize2DPVector(springJSON.getJSONObject("localAnchorA"));
			PVector localAnchorB = this.deserialize2DPVector(springJSON.getJSONObject("localAnchorB"));

			Spring spring = new Spring(rigidbodyA, rigidbodyB, localAnchorA, localAnchorB);

			spring.setSpringConstant(springJSON.getFloat("springConstant"));
			spring.setEquilibriumLength(springJSON.getFloat("equilibriumLength"));
			spring.setDamping(springJSON.getFloat("damping"));
			spring.setDrawSpring(springJSON.getBoolean("drawSpring"));
			spring.setLockTranslationToXAxis(springJSON.getBoolean("lockTranslationToXAxis"));
			spring.setLockTranslationToYAxis(springJSON.getBoolean("lockTranslationToYAxis"));
			spring.setPerfectSpring(springJSON.getBoolean("isPerfectSpring"));
			spring.setSpringLength(springJSON.getFloat("springLength"));

			return spring;
		} else {
			Rigidbody rigidbodyA = this.getRigidbodyByID(springJSON.getString("rigidbodyAID"));
			PVector localAnchorA = this.deserialize2DPVector(springJSON.getJSONObject("localAnchorA"));
			PVector anchorPoint = this.deserialize2DPVector(springJSON.getJSONObject("anchorPoint"));

			Spring spring = new Spring(rigidbodyA, localAnchorA, anchorPoint);
			spring.setSpringConstant(springJSON.getFloat("springConstant"));
			spring.setEquilibriumLength(springJSON.getFloat("equilibriumLength"));
			spring.setDamping(springJSON.getFloat("damping"));
			spring.setDrawSpring(springJSON.getBoolean("drawSpring"));
			spring.setLockTranslationToXAxis(springJSON.getBoolean("lockTranslationToXAxis"));
			spring.setLockTranslationToYAxis(springJSON.getBoolean("lockTranslationToYAxis"));
			spring.setPerfectSpring(springJSON.getBoolean("isPerfectSpring"));
			spring.setSpringLength(springJSON.getFloat("springLength"));

			return spring;
		}
	}

	private Rod deserializeRod(JSONObject rodJSON) {
			boolean isTwoBodyRod = rodJSON.getBoolean("isTwoBodyRod");
			if(isTwoBodyRod) {
					Rigidbody rigidbodyA = this.getRigidbodyByID(rodJSON.getString("rigidbodyAID"));
					Rigidbody rigidbodyB = this.getRigidbodyByID(rodJSON.getString("rigidbodyBID"));

					PVector localAnchorA = this.deserialize2DPVector(rodJSON.getJSONObject("localAnchorA"));
					PVector localAnchorB = this.deserialize2DPVector(rodJSON.getJSONObject("localAnchorB"));

					Rod rod = new Rod(rigidbodyA, rigidbodyB, localAnchorA, localAnchorB);
					rod.setLength(rodJSON.getFloat("length"));
					rod.setDamping(rodJSON.getFloat("damping"));
					rod.setIsJoint(rodJSON.getBoolean("isJoint"));

					return rod;
			} else {
					Rigidbody rigidbodyA = this.getRigidbodyByID(rodJSON.getString("rigidbodyAID"));
					PVector localAnchorA = this.deserialize2DPVector(rodJSON.getJSONObject("localAnchorA"));
					PVector anchorPoint = this.deserialize2DPVector(rodJSON.getJSONObject("anchorPoint"));

					Rod rod = new Rod(rigidbodyA, localAnchorA, anchorPoint);
					rod.setLength(rodJSON.getFloat("length"));
					rod.setDamping(rodJSON.getFloat("damping"));
					rod.setIsJoint(rodJSON.getBoolean("isJoint"));
					return rod;
			}
	}

	private Motor deserializeMotor(JSONObject motorJSON) {
			Rigidbody rigidbody = this.getRigidbodyByID(motorJSON.getString("rigidbodyID"));

			Motor motor = new Motor(rigidbody, motorJSON.getFloat("targetAngularVelocity"));
			motor.setLocalAnchor(this.deserialize2DPVector(motorJSON.getJSONObject("localAnchor")));
			motor.setDrawMotor(motorJSON.getBoolean("drawMotor"));
			motor.setDrawMotorForce(motorJSON.getBoolean("drawMotorForce"));
			return motor;

		}

	private Gravity deserializeGravity(JSONObject gravityJSON) {
			Rigidbody rigidbody = this.getRigidbodyByID(gravityJSON.getString("rigidbodyID"));
			return new Gravity(rigidbody);
	}


	private JSONObject serializeSpring(Spring spring) {
			JSONObject springJSON = new JSONObject();

			springJSON.setString("rigidbodyAID", spring.getRigidbodyA().getID());

			if(spring.getIsTwoBodySpring()) {
					springJSON.setString("rigidbodyBID", spring.getRigidbodyB().getID());
			}

			springJSON.setString("ForceType", "Spring");
			springJSON.setFloat("springConstant", spring.getSpringConstant());
			springJSON.setFloat("equilibriumLength", spring.getEquilibriumLength());
			springJSON.setFloat("damping", spring.getDamping());

			springJSON.setJSONObject("localAnchorA", serialize2DPVector(spring.getLocalAnchorA()));
			springJSON.setJSONObject("localAnchorB", serialize2DPVector(spring.getLocalAnchorB()));
			springJSON.setJSONObject("anchorPoint", serialize2DPVector(spring.getAnchorPoint()));

			springJSON.setBoolean("drawSpring", spring.getDrawSpring());
			springJSON.setBoolean("lockTranslationToXAxis", spring.getLockTranslationToXAxis());
			springJSON.setBoolean("lockTranslationToYAxis", spring.getLockTranslationToYAxis());

			springJSON.setBoolean("isPerfectSpring", spring.getPerfectSpring());
			springJSON.setBoolean("isTwoBodySpring", spring.getIsTwoBodySpring());
			springJSON.setFloat("springLength", spring.getSpringLength());

			return springJSON;
	}

	private JSONObject serializeRod(Rod rod) {
			JSONObject rodJSON = new JSONObject();

			rodJSON.setString("rigidbodyAID", rod.getRigidbodyA().getID());
			if(rod.getTwoBodyRod()) {
					rodJSON.setString("rigidbodyBID", rod.getRigidbodyB().getID());
			}
			rodJSON.setString("ForceType", "Rod");
			rodJSON.setFloat("length", rod.getLength());
			rodJSON.setFloat("damping", rod.getDamping());

			rodJSON.setJSONObject("localAnchorA", serialize2DPVector(rod.getLocalAnchorA()));
			rodJSON.setJSONObject("localAnchorB", serialize2DPVector(rod.getLocalAnchorB()));
			rodJSON.setJSONObject("anchorPoint", serialize2DPVector(rod.getAnchorPoint()));

			rodJSON.setBoolean("isTwoBodyRod", rod.getTwoBodyRod());
			rodJSON.setBoolean("isJoint", rod.getIsJoint());

			return rodJSON;
	}

	private JSONObject serializeMotor(Motor motor) {
			JSONObject motorJSON = new JSONObject();

			motorJSON.setString("ForceType", "Motor");
			motorJSON.setString("rigidbodyID", motor.getRigidbodyA().getID());
			motorJSON.setJSONObject("localAnchor", serialize2DPVector(motor.getLocalAnchor()));
			motorJSON.setFloat("targetAngularVelocity", motor.getTargetAngularVelocity());
			motorJSON.setBoolean("drawMotorForce", motor.getDrawMotorForce());
			motorJSON.setBoolean("drawMotor", motor.getDrawMotor());
			
			return motorJSON;
	}

	private JSONObject serializeGravity(Gravity gravity) {
			JSONObject gravityJSON = new JSONObject();

			gravityJSON.setString("ForceType", "Gravity");
			gravityJSON.setString("rigidbodyID", gravity.getRigidbodyA().getID());
			return gravityJSON;
	}


	private ShapeType deserializeShapeType(JSONObject shapeTypeJSON) {
			return ShapeType.valueOf(shapeTypeJSON.getString("shapeType"));
	}

	private JSONObject serialize2DPVector(PVector vector) {
			JSONObject vectorJSON = new JSONObject();

			vectorJSON.setFloat("x", vector.x);
			vectorJSON.setFloat("y", vector.y);
			return vectorJSON;
	}

	private PVector deserialize2DPVector(JSONObject vectorJSON) {
			return new PVector(vectorJSON.getFloat("x"), vectorJSON.getFloat("y"));
	}

	private JSONObject serialize3DPVector(PVector vector) {
			JSONObject vectorJSON = new JSONObject();

			vectorJSON.setFloat("x", vector.x);
			vectorJSON.setFloat("y", vector.y);
			vectorJSON.setFloat("z", vector.z);
			return vectorJSON;
	}

	private PVector deserialize3DPVector(JSONObject vectorJSON) {
			return new PVector(vectorJSON.getFloat("x"), vectorJSON.getFloat("y"), vectorJSON.getFloat("z"));
	}


	private JSONArray serializePVectorArray(PVector[] vectors) {
			JSONArray vectorArray = new JSONArray();
			if(vectors == null || vectors.length == 0) {
				return vectorArray;
			}
			for(PVector vector : vectors) {
				vectorArray.append(this.serialize2DPVector(vector));
			}
			return vectorArray;
	}

	private PVector[] deserializePVectorArray(JSONArray vectorArrayJSON) {
			PVector[] vectorArray = new PVector[vectorArrayJSON.size()];

			for(int i = 0; i < vectorArrayJSON.size(); i++) {
				vectorArray[i] = this.deserialize2DPVector(vectorArrayJSON.getJSONObject(i));
			}
			return vectorArray;
	}


	private Rigidbody getRigidbodyByID(String id) {
			for(Rigidbody body : rigidbodyList) {
					if(body.getID().equals(id)) {
						return body;
					}
			}
		return null;
	}
/*
=================================================================================================
*/
}
