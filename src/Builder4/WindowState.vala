/**
 * as state management is a bit too complicated inside the builder
 * it's better to seperate this into this class
 * 
 * 
 */
public class WindowState : Object 
{
    public MainWindow win;

    public enum State {
	OBJECT,
    };

    public State state;
	
    public Xcls_WindowLeftTree left_tree;

    left_props
    code_editor
    rightpalete
	
        // my vars (def)

    // ctor 
    public About(MainWindow win)
    {
	this.win = win;
	// initialize
	this.propsInit();
	this.listenerInit();
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
		     
		    
	       case "addprop":
		    if (sel == null) {
		        this.add_props.clear();
		        break;
		    }
		    this.add_props.show(this.left_tree.getActiveFile().palete(), "props", sel.fqn());
		    break;
		    
	       case "addlistener":
		    if (sel == null) {
		        this.add_props.clear();
		        break;
		    }
		    this.add_props.show(_this.left_tree.getActiveFile().palete(), "signals", sel.fqn());
		    break;

	       case "codeedit":
		   
		    this.hideCodeEdit();
		    break;
		   
		                    
	    }
	    return  ;
	      
	});

    }

    public bool leftTreeBeforeChange(sel)
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
    public void leftTreeNodeSelected()
    {


    }
    // -----------  properties
    // listener uses the properties 
    public void propsInit()
    {
	// Add properties
	    this.win.add_props  = new Xcls_WindowAddProp();
	    this.add_props.ref();  /// really?
	    ((Gtk.Container)(this.win.addpropsview.el.get_widget())).add(this.win.add_props.el);
	    //this.projectsettings.el.show_all();

	    var  stage = _this.win.addpropsview.el.get_stage();
	    stage.set_background_color(  Clutter.Color.from_string("#000"));
	
	
	    _this.win.add_props.select.connect( (key,type,skel, etype) => {
		this.win.left_props.addProp(etype, key, skel, type);
	    });
	
    }
    public void propsShow()
    {

    }
    public propsHide()
    {
	
    }
    
    // ----------- Add / Edit listener
    // listener uses the properties 
    public listenerInit()
    {

    }
    public listenerShow()
    {

    }
    public listenerHide()
    {
	
    }