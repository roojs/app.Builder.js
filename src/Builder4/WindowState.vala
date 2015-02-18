/**
 * as state management is a bit too complicated inside the builder
 * it's better to seperate this into this class
 * 
 * This class has references to all the Class instances that make up the window..
 * 
 */
public class WindowState : Object 
{
    public MainWindow win;

    public enum State {
	OBJECT,
	PROP,
	LISTENER,
	CODEEDIT
    };

    public State state;

    
    public Xcls_WindowLeftTree  left_tree;
    public Xcls_WindowAddProp   add_props;
    public Xcls_LeftProps       left_props;
    public Xcls_ProjectSettings projectsettings;
    public ValaProjectSettings  vala_projectsettings;
    public Xcls_RightPalete     rightpalete;
    public Editor		code_editor;    
    public Xcls_WindowRooView   window_rooview;
    public Xcls_GtkView		window_gladeview;
    public Xcls_DialogNewComponent new_file_dialog;     

    // ctor 
    public WindowState(MainWindow win)
    {
	this.win = win;
	// initialize

	// left elements..
	this.leftTreeInit();
	this.propsListInit();

	// on clutter space...
	this.projectEditInit();
	this.codeEditInit();
	this.fileViewInit();
	
	// adding stuff
	this.objectAddInit();
	this.propsAddInit();
 
	
	// previews...
	this.gtkViewInit();
	this.webkitViewInit();

	// dialogs

	this.fileNewInit();
    }


    // left tree

    public void leftTreeInit()
    {
	 
	this.left_tree = new Xcls_WindowLeftTree();
	this.left_tree.ref();
	this.left_tree.main_window = _this.win;
	
	this.win.tree.el.pack_start(this.left_tree.el,true, true,0);
	this.left_tree.el.show_all();
       
	this.left_tree.before_node_change.connect(() => {
	    return this.leftTreeBeforeChange();

	});

	this.left_tree.node_selected.connect((sel) => {
	    this.leftTreeNodeSelected(sel);
	});
 
	this.left_tree.changed.connect(() => {
	    this.window_rooview.requestRedraw();
	    this.left_tree.model.file.save();
        });
     
    }

    public bool leftTreeBeforeChange(JsRender.Node? sel)
    {
	if (this.state != "codeedit") {
	    this.left_props.finish_editing();
	    return true;
	}
	if (!this.code_editor.saveContents()) {
	    return false;
	}
	return false;
    }
    
    public void leftTreeNodeSelected(JsRender.Node? sel)
    {

	print("node_selected called %s\n", (sel == null) ? "NULL" : "a value");

	if (sel == null) {
	    this.left_props.el.hide();
	} 
	this.left_props.el.show();
	this.left_props.load(this.left_tree.getActiveFile(), sel);
	switch (this.state) {
	    
	    case State.OBJECT: 
		  
		 if (sel == null) {
		    this.rightpalete.clear();
		    break;
		}
		this.rightpalete.load(this.left_tree.getActiveFile().palete(), sel.fqn());
		break;
		 
		
	   case State.PROP:
		if (sel == null) {
		    this.add_props.clear();
		    break;
		}
		this.add_props.show(this.left_tree.getActiveFile().palete(), "props", sel.fqn());
		break;

	    case State.LISTENER:
	   
		if (sel == null) {
		    this.add_props.clear();
		    break;
		}
		this.add_props.show(_this.left_tree.getActiveFile().palete(), "signals", sel.fqn());
		break;
	    case State.CODEEDIT:
		// SAVE FIRST???
		
		this.codeEditHide();
		break;
	       
		                
	}
	 

    }




    public void propsListInit()
    {
	
	this.left_props =new Xcls_LeftProps();
	this.left_props.ref();
	this.left_props.main_window = _this;
	this.win.props.el.pack_start(this.left_props.el,true, true,0);
	this.left_props.el.show_all();
	
	this.left_props.show_editor.connect( (file, node, type,  key) => {
	    this.codeEditShow(file, node, type,  key);
	});

	
	this.left_props.stop_editor.connect( () => {
	    if (this.state != "codeedit") {
	        return true;
	    }
	
	    var ret =  this.code_editor.saveContents();
	    if (!ret) {
	        return false;
	    }
	    this.codeEditHide();
	    return ret;
	});
	
	this.left_props.changed.connect(() => {
	      if (this.left_tree.getActiveFile().xtype == "Roo" ) {
	           this.window_rooview.requestRedraw();
	           
	       } else {
	          this.window_gladeview.loadFile(this.left_tree.getActiveFile());
	      }
	      this.left_tree.model.updateSelected();
	      this.left_tree.model.file.save();
	});
	


    }

    //-------------  projects edit

    public void projectEditInit()
    {
	this.projectsettings  =new Xcls_ProjectSettings();
	this.projectsettings.ref();  /// really?
	
	this.vala_projectsettings  =new ValaProjectSettings();
	this.vala_projectsettings.ref();
	this.vala_projectsettings.window = this;
	
	((Gtk.Container)(this.win.projecteditview.el.get_widget())).add(this.projectsettings.el);
	//this.projectsettings.el.show_all();

	var stage = this.win.projecteditview.el.get_stage();
	stage.set_background_color(  Clutter.Color.from_string("#000"));
	
	this.projectsettings.buttonPressed.connect((btn) => {
	     if (this.left_tree.getActiveFile().xtype == "Roo" ) {
	        if (btn == "save") {
	            this.window_rooview.view.renderJS(true);
	        }
	        if (btn == "apply") {
	            this.window_rooview.view.renderJS(true);
	            return;
	        }
	    } else {
	        // do nothing for gtk..
	    }
	    if (btn == "save" || btn == "apply") {
	        this.win.project.save();
     
	    }
	    
	    this.projectEditHide();
	     
	 });

    }
    // ----------- object adding
    public void objectAddInit()
    {

	this.rightpalete  = new Xcls_RightPalete();
	this.rightpalete.ref();  /// really?
	((Gtk.Container)(this.win.objectview.el.get_widget())).add(this.rightpalete.el);
	//this.projectsettings.el.show_all();

	stage = _this.win.objectview.el.get_stage();
	stage.set_background_color(  Clutter.Color.from_string("#000"));
       
    }
    
    // -----------  properties adding list...
    // listener uses the properties 
    public void propsAddInit()
    {
	// Add properties
	this.add_props  = new Xcls_WindowAddProp();
	this.add_props.ref();  /// really?
	((Gtk.Container)(this.win.addpropsview.el.get_widget())).add(this.add_props.el);
	//this.projectsettings.el.show_all();

	var  stage = _this.win.addpropsview.el.get_stage();
	stage.set_background_color(  Clutter.Color.from_string("#000"));

	
	this.add_props.select.connect( (key,type,skel, etype) => {
	    this.left_props.addProp(etype, key, skel, type);
	});
	
    }
    public void propsAddShow()
    {

    }
    public void propsAddHide()
    {
	
    }



    
    // ----------- Add / Edit listener
    // listener uses the properties 
    //public void listenerInit()     { }
    public void listenerShow()
    {

    }
    public void listenerHide()
    {
	
    }

    // -------------- codeEditor

    public void codeEditInit()
    {
	this.code_editor  = new  Editor();
	this.code_editor.ref();  /// really?
	((Gtk.Container)(this.win.codeeditview.el.get_widget())).add(this.code_editor.el);
	//this.projectsettings.el.show_all();

	stage = _this.win.codeeditview.el.get_stage();
	stage.set_background_color(  Clutter.Color.from_string("#000"));
	// editor.save...

	this.code_editor.save.connect( () => {
	     this.left_tree.model.file.save();
	     this.left_tree.model.updateSelected();
	});
    
    }

    // ----------- file view

    public void fileViewInit()
    {

	this.clutterfiles = new Xcls_ClutterFiles();
	this.clutterfiles.ref();
	stage.add_child(this.clutterfiles.el);
	this.clutterfiles.el.show_all();


	this.clutterfiles.open.connect((file) => { 
	    this.fileViewOpen(file);
	});

    }
    public void fileNewInit()
    {
	this.new_file_dialog = new Xcls_DialogNewComponent();
	// force it modal to the main window..
	this.new_file_dialog.el.set_transient_for(this.el);
	this.new_file_dialog.el.set_modal(true);
	
	this.new_file_dialog.success.connect((project,file) =>
	{
	    this.fileViewOpen(file);
	});

    }

    
    public void fileViewOpen(JsRender.JsRender file)
    {
	this.win.project = file.project;
	this.previewShow();
        this.left_tree.model.loadFile(file);
	
	var ctr= ((Gtk.Container)(this.win.rooview.el.get_widget()));
	var ctr_p= ((Gtk.Container)(this.win.projecteditview.el.get_widget()));
	
	if (file.xtype == "Roo" ) { 
	    ctr.foreach( (w) => { ctr.remove(w); });
	    ctr_p.foreach( (w) => { ctr_p.remove(w); });
	    ctr.add(this.window_rooview.el);
	    ctr_p.add(this.projectsettings.el);            
	    this.window_rooview.loadFile(file);
	    this.window_rooview.el.show_all();
	    this.projectsettings.el.show_all();            

	} else {
	    ctr.foreach( (w) => { ctr.remove(w); });
	    ctr_p.foreach( (w) => { ctr_p.remove(w); });            
	    ctr.add(this.window_gladeview.el);
	    ctr_p.add(this.vala_projectsettings.el);
	    this.window_gladeview.loadFile(file);
	    this.window_gladeview.el.show_all();
	    this.vala_projectsettings.el.show_all();
	}
	print("OPEN : " + file.name);
	this.editpane.el.set_position(_this.editpane.el.max_position);
	this.win.setTitle(file.project.name + " : " +file.name);
	     

    }

    
    // ---------  webkit view
    public void webkitViewInit()
    {
	this.window_rooview  =new Xcls_WindowRooView();
	this.window_rooview.ref();
	((Gtk.Container)(this.win.rooview.el.get_widget())).add(this.window_rooview.el);
	this.window_rooview.el.show_all();

	stage = this.win.rooview.el.get_stage();
	stage.set_background_color(  Clutter.Color.from_string("#000"));
    }

    // ------ Gtk  - view

    public void gtkViewInit()
    {
	this.window_gladeview  =new Xcls_GtkView();
	this.window_gladeview.ref();
    }



    
}

    