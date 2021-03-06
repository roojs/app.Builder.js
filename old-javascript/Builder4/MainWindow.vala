static Xcls_MainWindow  _MainWindow;

public class Xcls_MainWindow : Object 
{
    public Gtk.Window el;
    private Xcls_MainWindow  _this;

    public static Xcls_MainWindow singleton()
    {
        if (_MainWindow == null) {
            _MainWindow= new Xcls_MainWindow();
        }
        return _MainWindow;
    }
    public Xcls_vbox vbox;
    public Xcls_mainpane mainpane;
    public Xcls_leftpane leftpane;
    public Xcls_editpane editpane;
    public Xcls_tree tree;
    public Xcls_props props;
    public Xcls_clutterembed clutterembed;
    public Xcls_rooview rooview;
    public Xcls_objectview objectview;
    public Xcls_codeeditview codeeditview;
    public Xcls_addpropsview addpropsview;
    public Xcls_projecteditview projecteditview;
    public Xcls_buttonlayout buttonlayout;
    public Xcls_backbutton backbutton;
    public Xcls_projectbutton projectbutton;
    public Xcls_editfilebutton editfilebutton;
    public Xcls_projecteditbutton projecteditbutton;
    public Xcls_objectshowbutton objectshowbutton;
    public Xcls_addpropbutton addpropbutton;
    public Xcls_addlistenerbutton addlistenerbutton;
    public Xcls_addprojectbutton addprojectbutton;
    public Xcls_addfilebutton addfilebutton;
    public Xcls_delprojectbutton delprojectbutton;
    public Xcls_new_window new_window;

        // my vars (def)
    public int no_windows;
    public Project.Project project;
    public bool children_loaded;
    public Xcls_WindowLeftProjects left_projects;
    public Xcls_WindowRooView window_rooview;
    public Xcls_WindowLeftTree left_tree;
    public Editor code_editor;
    public Xcls_DialogNewComponent new_file_dialog;
    public Xcls_ProjectSettings projectsettings;
    public Xcls_ClutterFiles clutterfiles;
    public Xcls_LeftProps left_props;
    public string state;
    public Xcls_RightPalete rightpalete;
    public string title;
    public ValaProjectSettings vala_projectsettings;
    public Xcls_WindowAddProp add_props;
    public Xcls_GtkView window_gladeview;

    // ctor 
    public Xcls_MainWindow()
    {
        _this = this;
        this.el = new Gtk.Window( Gtk.WindowType.TOPLEVEL );

        // my vars (dec)
        this.no_windows = 1;
        this.project = null;
        this.children_loaded = false;
        this.left_projects = null;
        this.window_rooview = null;
        this.left_tree = null;
        this.code_editor = null;
        this.new_file_dialog = null;
        this.projectsettings = null;
        this.clutterfiles = null;
        this.left_props = null;
        this.rightpalete = null;
        this.title = "Application Builder";
        this.vala_projectsettings = null;
        this.add_props = null;
        this.window_gladeview = null;

        // set gobject values
        this.el.border_width = 0;
        this.el.default_height = 500;
        this.el.default_width = 800;
        var child_0 = new Xcls_vbox( _this );
        child_0.ref();
        this.el.add (  child_0.el  );

        // init method 

        this.state = "files";
        	  
            //this.el.show_all();
        // listeners 
        this.el.delete_event.connect( (   event) => {
            return false;
        });
        this.el.destroy.connect( () =>  {
         Xcls_MainWindow.singleton().no_windows--;
         
         if (Xcls_MainWindow.singleton().no_windows < 1) {
        
             Gtk.main_quit();
         }
        });
        this.el.show.connect( ( ) => {
            // hide the file editing..
           
            //this.hideViewEditing();
        });
    }

    // user defined functions 
    public             void hideAddListener () {
          _this.backbutton.el.hide();
         _this.projectbutton.el.show(); 
              _this.projecteditbutton.el.show();
             _this.editfilebutton.el.show();   
         _this.addpropsview.el.save_easing_state();
        var el = _this.rooview.el;
        el.save_easing_state();
    
        
        el.set_scale(1.0f,1.0f);
        _this.addpropsview.el.set_scale(0.0f,0.0f);
        _this.state = "edit";
    
     
        //_this.clutterfiles.loadProject(_this.project);
    
        el.restore_easing_state();
         _this.addpropsview.el.restore_easing_state();  
      }
    public        void initChildren () {
        // this needs putting in a better place..
        
        print("init children");
        this.left_tree = new Xcls_WindowLeftTree();
        this.left_tree.ref();
        this.left_tree.main_window = _this;
        this.tree.el.pack_start(this.left_tree.el,true, true,0);
        this.left_tree.el.show_all();
       
        this.left_tree.before_node_change.connect(() => {
            if (this.state != "codeedit") {
                this.left_props.finish_editing();
                return true;
            }
            if (!this.code_editor.saveContents()) {
                return false;
            }
            return false;
        
        });
        
        this.left_tree.node_selected.connect((sel) => {
            
            print("node_selected called %s\n", (sel == null) ? "NULL" : "a value");
            
            if (sel == null) {
                this.left_props.el.hide();
            } 
            this.left_props.el.show();
            this.left_props.load(this.left_tree.getActiveFile(), sel);
            switch (this.state) {
                case "object": 
                      
                     if (sel == null) {
                        this.rightpalete.clear();
                        break;
                    }
                    this.rightpalete.load(_this.left_tree.getActiveFile().palete(), sel.fqn());
                    break;
                     
                    
               case "addprop":
                    if (sel == null) {
                        this.add_props.clear();
                        break;
                    }
                    this.add_props.show(_this.left_tree.getActiveFile().palete(), "props", sel.fqn());
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
        
         this.left_tree.changed.connect(() => {
           this.window_rooview.requestRedraw();
           this.left_tree.model.file.save();
        });
         
        
    
        // left properties
    
        this.left_props =new Xcls_LeftProps();
        this.left_props.ref();
        this.left_props.main_window = _this;
        this.props.el.pack_start(this.left_props.el,true, true,0);
        this.left_props.el.show_all();
        
        this.left_props.show_editor.connect( (file, node, type,  key) => {
            this.showCodeEdit(file, node, type,  key);
        });
        this.left_props.stop_editor.connect( () => {
            if (this.state != "codeedit") {
                return true;
            }
        
            var ret =  this.code_editor.saveContents();
            if (!ret) {
                return false;
            }
            this.hideCodeEdit();
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
        
    
    
    
        // left projects..
         this.left_projects = new Xcls_WindowLeftProjects();
         this.left_projects.ref();
         this.leftpane.el.pack_start(this.left_projects.el,true, true,0);
         this.left_projects.el.show_all();
         this.left_projects.project_selected.connect((proj) => {
            proj.scanDirs();
            _this.clutterfiles.loadProject(proj);
        
         });
        
       
        // project edit..
        this.projectsettings  =new Xcls_ProjectSettings();
        this.projectsettings.ref();  /// really?
        
        this.vala_projectsettings  =new ValaProjectSettings();
        this.vala_projectsettings.ref();
        this.vala_projectsettings.window = this;
        
        ((Gtk.Container)(this.projecteditview.el.get_widget())).add(this.projectsettings.el);
        //this.projectsettings.el.show_all();
    
        var stage = _this.projecteditview.el.get_stage();
        stage.set_background_color(  Clutter.Color.from_string("#000"));
        
         this.projectsettings.buttonPressed.connect((btn) => {
             if (this.left_tree.getActiveFile().xtype == "Roo" ) {
             
                if (btn == "save") {
                     _this.window_rooview.view.renderJS(true);
                }
                if (btn == "apply") {
                    _this.window_rooview.view.renderJS(true);
                    return;
                }
            } else {
                // do nothing for gtk..
            }
            if (btn == "save" || btn == "apply") {
                _this.project.save();
     
            }
            
            this.hideProjectEdit();
             
         });
        
        
        // objects (palate..)
        this.rightpalete  = new Xcls_RightPalete();
        this.rightpalete.ref();  /// really?
        ((Gtk.Container)(this.objectview.el.get_widget())).add(this.rightpalete.el);
        //this.projectsettings.el.show_all();
    
        stage = _this.objectview.el.get_stage();
        stage.set_background_color(  Clutter.Color.from_string("#000"));
        
        /*this.projectsettings.buttonPressed.connect((btn) => {
            if (btn == "save") {
                 _this.window_rooview.view.renderJS(true);
            }
            if (btn == "apply") {
                _this.window_rooview.view.renderJS(true);
                return;
            }
            this.hideProjectEdit();
             
         });
        */
        
        
          
        // Add properties
        this.add_props  = new Xcls_WindowAddProp();
        this.add_props.ref();  /// really?
        ((Gtk.Container)(this.addpropsview.el.get_widget())).add(this.add_props.el);
        //this.projectsettings.el.show_all();
    
        stage = _this.addpropsview.el.get_stage();
        stage.set_background_color(  Clutter.Color.from_string("#000"));
        
        
        _this.add_props.select.connect( (key,type,skel, etype) => {
            this.left_props.addProp(etype, key, skel, type);
        });
        
        // editor
        
        
        this.code_editor  = new  Editor();
        this.code_editor.ref();  /// really?
        ((Gtk.Container)(this.codeeditview.el.get_widget())).add(this.code_editor.el);
        //this.projectsettings.el.show_all();
    
        stage = _this.codeeditview.el.get_stage();
        stage.set_background_color(  Clutter.Color.from_string("#000"));
        // editor.save...
    
        _this.code_editor.save.connect( () => {
            this.left_tree.model.file.save();
             this.left_tree.model.updateSelected();
        });
        
         
        
        
        //  roo view
        
         this.window_rooview  =new Xcls_WindowRooView();
        this.window_rooview.ref();
        ((Gtk.Container)(this.rooview.el.get_widget())).add(this.window_rooview.el);
        this.window_rooview.el.show_all();
    
        stage = _this.rooview.el.get_stage();
        stage.set_background_color(  Clutter.Color.from_string("#000"));
        
          
        //  glade view
        
        this.window_gladeview  =new Xcls_GtkView();
        this.window_gladeview.ref();
    
        //((Gtk.Container)(this.rooview.el.get_widget())).add(this.window_gladeview.el);
        ///this.window_gladeview.el.hide();
    
       
        
        // clutter files
        
        
        this.clutterfiles = new Xcls_ClutterFiles();
        this.clutterfiles.ref();
        stage.add_child(this.clutterfiles.el);
        this.clutterfiles.el.show_all();
    
    
        this.clutterfiles.open.connect((file) => { 
            _this.project = file.project;
            _this.showViewEditing();
            this.left_tree.model.loadFile(file);
            var ctr= ((Gtk.Container)(this.rooview.el.get_widget()));
            var ctr_p= ((Gtk.Container)(this.projecteditview.el.get_widget()));
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
            _this.editpane.el.set_position(_this.editpane.el.max_position);
             
    
        });
    
        // new file dialog
        this.new_file_dialog = new Xcls_DialogNewComponent();
        // force it modal to the main window..
        this.new_file_dialog.el.set_transient_for(this.el);
        this.new_file_dialog.el.set_modal(true);
        
        this.new_file_dialog.success.connect((project,file) =>
        {
            _this.project = project;
            _this.showViewEditing();
            this.left_tree.model.loadFile(file);
            var ctr= ((Gtk.Container)(this.rooview.el.get_widget()));
            var ctr_p= ((Gtk.Container)(this.projecteditview.el.get_widget()));
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
        
        });
        
         
    
        //w.el.show_all();
        var tl = new Clutter.Timeline(6000);
        tl.set_repeat_count(-1);
        tl.start();
        tl.ref();
    
        this.children_loaded = true;
    
    
    
    
    }
    public             void hideCodeEdit () {
        //this.code_editor.saveContents();
         _this.backbutton.el.hide();
          _this.projectbutton.el.show(); 
           _this.projecteditbutton.el.show();
           _this.editfilebutton.el.show();   
         _this.codeeditview.el.save_easing_state();
        var el = _this.rooview.el;
        el.save_easing_state();
    
        
        el.set_scale(1.0f,1.0f);
        _this.codeeditview.el.set_scale(0.0f,0.0f);
        _this.state = "edit";
    
     
        //_this.clutterfiles.loadProject(_this.project);
    
        el.restore_easing_state();
         _this.codeeditview.el.restore_easing_state();  
     }
    public             void showAddProp () {
    
         
         var ae =      this.left_tree.getActiveElement();
        if (ae == null) {
            return;
        }
         _this.backbutton.el.show();
           _this.projectbutton.el.hide();
        _this.editfilebutton.el.hide();
        _this.projecteditbutton.el.hide();    
        
         
         
        //this.rooview.el.hide();
        this.add_props.el.show_all();
        this.add_props.show(
            Palete.factory(this.project.xtype), 
            "props",
            ae.fqn()
        );
    
        _this.addpropsview.el.save_easing_state();
            
        var el = _this.rooview.el;
        el.save_easing_state();
        _this.clutterembed.setSizesAlloc("addprop");
         
         
    
        _this.addpropsview.el.set_scale(1.0f,1.0f);
       
       
     
        //_this.clutterfiles.loadProject(_this.project);
    
        el.restore_easing_state();
        _this.addpropsview.el.restore_easing_state();
        this.state = "addprop";
    }
    public             void showViewEditing ( )  {
         this.editpane.el.show();
      //   this.rooview.el.show();
         this.left_projects.el.hide();
        
        _this.addprojectbutton.el.hide();   
        _this.delprojectbutton.el.hide();
        _this.addfilebutton.el.hide();       
        _this.backbutton.el.hide();
       _this.new_window.el.hide();      
            
            
          _this.projectbutton.el.show();         
        _this.editfilebutton.el.show();   
       _this.projecteditbutton.el.show();
      _this.objectshowbutton.el.show();
      _this.addpropbutton.el.show();      
      _this.addlistenerbutton.el.show();   
    
          
        var el = _this.rooview.el;
            el.save_easing_state();
      
        
            el.set_rotation_angle(Clutter.RotateAxis.Y_AXIS, 0.0f);
            el.set_scale(1.0f,1.0f);
            _this.state = "edit";
           // _this.mainpane.el.set_position(_this.leftpane.lastWidth);
            _this.clutterfiles.el.hide();
        
        el.restore_easing_state();
            
        print("show view editing");
    }
    public             void hideProjectEdit () {
        // return to editing state..
           
          _this.projectbutton.el.show();
         _this.projecteditbutton.el.show();
          _this.backbutton.el.hide();
             _this.editfilebutton.el.show();   
    
         
           if (this.project.xtype == "Roo") {
            
            //this.projectsettings.show(this.project);
        } else {
    
            this.vala_projectsettings.project.writeConfig();
        }
        _this.projecteditview.el.save_easing_state();
        var el = _this.rooview.el;
        el.save_easing_state();
    
        
        el.set_scale(1.0f,1.0f);
           _this.projecteditview.el.set_scale(1.0f,0.0f);
        _this.state = "edit";
    
     
        //_this.clutterfiles.loadProject(_this.project);
    
        el.restore_easing_state();
          _this.projecteditview.el.restore_easing_state();  
      
    }
    public             void showProjectEdit () {
        // make the browser smaller, and show the edit dialog
        
        
         _this.projectbutton.el.hide();
         _this.projecteditbutton.el.hide();
         _this.editfilebutton.el.hide();
         
        _this.backbutton.el.show();
         
        //this.rooview.el.hide();
        
        
        if (this.project.xtype == "Roo") {
            this.projectsettings.el.show_all();
            this.projectsettings.show(this.project);
        } else {
            this.vala_projectsettings.el.show_all();
            this.vala_projectsettings.show((Project.Gtk)this.project);
        }
        _this.projecteditview.el.save_easing_state();
            
        var el = _this.rooview.el;
        el.save_easing_state();
       
        
        el.set_scale(0.5f,0.5f);
    
        _this.projecteditview.el.set_scale(1.0f,1.0f);
       
        _this.state = "projectedit";
         
     
        //_this.clutterfiles.loadProject(_this.project);
    
        el.restore_easing_state();
        _this.projecteditview.el.restore_easing_state();
      //  print("show view browsing");
        
    }
    public             void showAddListener () {
    
         
         
        var ae =      this.left_tree.getActiveElement();
        if (ae == null) {
            return;
        }
         
       _this.backbutton.el.show();
        _this.projectbutton.el.hide();
        _this.editfilebutton.el.hide();
        _this.projecteditbutton.el.hide();    
        
        
        //this.rooview.el.hide();
        this.add_props.el.show_all();
        this.add_props.show(
            Palete.factory(this.project.xtype), 
            "signals",
            ae.fqn()
        );
        //this.rightpalete.show(this.project);
    
        _this.addpropsview.el.save_easing_state();
            
        var el = _this.rooview.el;
        el.save_easing_state();
       
          _this.clutterembed.setSizesAlloc("addlistener");
    
        
      
    
        _this.addpropsview.el.set_scale(1.0f,1.0f);
       
       
     
        //_this.clutterfiles.loadProject(_this.project);
    
        el.restore_easing_state();
        _this.addpropsview.el.restore_easing_state();
        this.state = "addlistener";
    }
    public             void hideAddProp () {
          _this.backbutton.el.hide();
         _this.projectbutton.el.show(); 
              _this.projecteditbutton.el.show();
             _this.editfilebutton.el.show();   
         _this.addpropsview.el.save_easing_state();
         
        var el = _this.rooview.el;
        el.save_easing_state();
    
        
        el.set_scale(1.0f,1.0f);
        _this.addpropsview.el.set_scale(0.0f,0.0f);
        _this.state = "edit";
    
     
        //_this.clutterfiles.loadProject(_this.project);
    
        el.restore_easing_state();
         _this.addpropsview.el.restore_easing_state();  
     }
    public             void showCodeEdit (JsRender.JsRender file, JsRender.Node node, string ptype, string key)
    {
        // this is a bit different,
        // it's not called via a button - but triggered by the prop edit class signal.
        // so it has to hide any other state..
        
        switch(this.state) {
            case "object":
                this.hideObject();
                break;
            case "addprop":
                this.hideAddProp();
                break;
            case "addlistener":
                this.hideAddListener();
                break;
        }
     
       _this.backbutton.el.show();
       
        _this.projectbutton.el.hide();
        _this.editfilebutton.el.hide();
        _this.projecteditbutton.el.hide();    
       // more?? 
         
        //this.rooview.el.hide();
        this.code_editor.el.show_all();
        this.code_editor.show(
            file,
            node,
            ptype,
            key
        );
    
        _this.codeeditview.el.save_easing_state();
            
        var el = _this.rooview.el;
        el.save_easing_state();
        _this.clutterembed.setSizesAlloc("codedit");
       
        _this.codeeditview.el.set_scale(1.0f,1.0f);
       
       
     
        //_this.clutterfiles.loadProject(_this.project);
    
        el.restore_easing_state();
        _this.codeeditview.el.restore_easing_state();
        this.state = "codeedit";
    }
    public             void setTitle (string str) {
        this.el.set_title(this.title + " - " + str);
    }
    public             void show () {
        this.left_tree =new Xcls_WindowLeftTree();
        _this.vbox.el.pack_start(this.left_tree.el,true, true,0);
        this.el.show_all();
    
    }
    public             void hideViewEditing ( )   {
    
    // show the file navigation...
      
        if (this.left_tree.getActiveFile() != null) {
             if (this.left_tree.getActiveFile().xtype == "Roo" ) {
                 this.window_rooview.createThumb();
             } else {
                  this.window_gladeview.createThumb();
              }
          }
          
        _this.addprojectbutton.el.show();   
        _this.addfilebutton.el.show();       
          _this.backbutton.el.show();
        _this.delprojectbutton.el.show();
          _this.new_window.el.show();  
              
          _this.editfilebutton.el.hide();   
          _this.projectbutton.el.hide();         
          _this.projecteditbutton.el.hide();
          _this.objectshowbutton.el.hide();
          _this.addpropbutton.el.hide();      
          _this.addlistenerbutton.el.hide();  
    
    
    
    
              
        // show the add file button..
        
              
          
         this.editpane.el.hide();
        //this.rooview.el.hide();
         this.left_projects.el.show();
        
        var el = _this.rooview.el;
        el.save_easing_state();
          el.set_easing_duration(1000);
        // show project / file view..
        //_this.mainpane.lastWidth = _this.leftpane.el.get_position();
        //_this.mainpane.el.set_position(0);
        // rotate y 180..
        el.set_rotation_angle(Clutter.RotateAxis.Y_AXIS, 360.0f);
        el.set_scale(0.0f,0.0f);
       
            _this.state = "files";
        if (_this.project != null) {
            _this.left_projects.selectProject(_this.project);
            }
        //_this.clutterfiles.loadProject(_this.project);
    
        el.restore_easing_state();
            
        print("show view browsing");
    }
    public             void showObject () {
    
         
        // what's the active node on the left hand side..
        
        var n = _this.left_tree.getActiveElement();
    
        if (_this.left_tree.model.file == null) {
            return;
        }
        
        if (n == null && _this.left_tree.model.file.tree != null) {
            return;
        }
        
         _this.backbutton.el.show();
           _this.projectbutton.el.hide();
        _this.editfilebutton.el.hide();
        _this.projecteditbutton.el.hide();    
        
         
        //this.rooview.el.hide();
        this.rightpalete.el.show_all();
        this.rightpalete.load(_this.left_tree.getActiveFile().palete(), n == null ? "*top" : n.fqn());
    
        
        //this.rightpalete.show(this.project);
    
        _this.objectview.el.save_easing_state();
            
        var el = _this.rooview.el;
        el.save_easing_state();
       
         _this.clutterembed.setSizesAlloc("object");
        
    
        _this.objectview.el.set_scale(1.0f,1.0f);
       
       
     
        //_this.clutterfiles.loadProject(_this.project);
    
        el.restore_easing_state();
        _this.objectview.el.restore_easing_state();
        this.state = "object";
    }
    public             void hideObject () {
          // return to editing state..
           
              _this.projecteditbutton.el.show();
          _this.backbutton.el.hide();
         _this.projectbutton.el.show(); 
             _this.editfilebutton.el.show();   
         _this.objectview.el.save_easing_state();
        var el = _this.rooview.el;
        el.save_easing_state();
    
        
        el.set_scale(1.0f,1.0f);
        _this.objectview.el.set_scale(0.0f,0.0f);
        _this.state = "edit";
    
     
        //_this.clutterfiles.loadProject(_this.project);
    
        el.restore_easing_state();
         _this.objectview.el.restore_easing_state();  
     
    
    }
    public class Xcls_vbox : Object 
    {
        public Gtk.VBox el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_vbox(Xcls_MainWindow _owner )
        {
            _this = _owner;
            _this.vbox = this;
            this.el = new Gtk.VBox( false, 0 );

            // my vars (dec)

            // set gobject values
            var child_0 = new Xcls_mainpane( _this );
            child_0.ref();
            this.el.pack_end (  child_0.el , true,true,0 );
        }

        // user defined functions 
    }
    public class Xcls_mainpane : Object 
    {
        public Gtk.HPaned el;
        private Xcls_MainWindow  _this;


            // my vars (def)
        public int lastWidth;

        // ctor 
        public Xcls_mainpane(Xcls_MainWindow _owner )
        {
            _this = _owner;
            _this.mainpane = this;
            this.el = new Gtk.HPaned();

            // my vars (dec)
            this.lastWidth = 0;

            // set gobject values
            this.el.position = 400;
            var child_0 = new Xcls_leftpane( _this );
            child_0.ref();
            this.el.add1 (  child_0.el  );
            var child_1 = new Xcls_VBox8( _this );
            child_1.ref();
            this.el.add2 (  child_1.el  );
        }

        // user defined functions 
    }
    public class Xcls_leftpane : Object 
    {
        public Gtk.VBox el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_leftpane(Xcls_MainWindow _owner )
        {
            _this = _owner;
            _this.leftpane = this;
            this.el = new Gtk.VBox( true, 0 );

            // my vars (dec)

            // set gobject values
            var child_0 = new Xcls_editpane( _this );
            child_0.ref();
            this.el.pack_start (  child_0.el , false,true,0 );
        }

        // user defined functions 
    }
    public class Xcls_editpane : Object 
    {
        public Gtk.VPaned el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_editpane(Xcls_MainWindow _owner )
        {
            _this = _owner;
            _this.editpane = this;
            this.el = new Gtk.VPaned();

            // my vars (dec)

            // set gobject values
            var child_0 = new Xcls_tree( _this );
            child_0.ref();
            this.el.add1 (  child_0.el  );
            var child_1 = new Xcls_props( _this );
            child_1.ref();
            this.el.add2 (  child_1.el  );
        }

        // user defined functions 
    }
    public class Xcls_tree : Object 
    {
        public Gtk.VBox el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_tree(Xcls_MainWindow _owner )
        {
            _this = _owner;
            _this.tree = this;
            this.el = new Gtk.VBox( true, 0 );

            // my vars (dec)

            // set gobject values
        }

        // user defined functions 
    }
    public class Xcls_props : Object 
    {
        public Gtk.VBox el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_props(Xcls_MainWindow _owner )
        {
            _this = _owner;
            _this.props = this;
            this.el = new Gtk.VBox( true, 0 );

            // my vars (dec)

            // set gobject values
        }

        // user defined functions 
    }
    public class Xcls_VBox8 : Object 
    {
        public Gtk.VBox el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_VBox8(Xcls_MainWindow _owner )
        {
            _this = _owner;
            this.el = new Gtk.VBox( true, 0 );

            // my vars (dec)

            // set gobject values
            var child_0 = new Xcls_clutterembed( _this );
            child_0.ref();
            this.el.pack_start (  child_0.el , true,true,0 );
        }

        // user defined functions 
    }
    public class Xcls_clutterembed : Object 
    {
        public GtkClutter.Embed el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_clutterembed(Xcls_MainWindow _owner )
        {
            _this = _owner;
            _this.clutterembed = this;
            this.el = new GtkClutter.Embed();

            // my vars (dec)

            // set gobject values
            var child_0 = new Xcls_rooview( _this );
            child_0.ref();
            this.el.get_stage().add_child (  child_0.el  );
            var child_1 = new Xcls_objectview( _this );
            child_1.ref();
            this.el.get_stage().add_child (  child_1.el  );
            var child_2 = new Xcls_codeeditview( _this );
            child_2.ref();
            this.el.get_stage().add_child (  child_2.el  );
            var child_3 = new Xcls_addpropsview( _this );
            child_3.ref();
            this.el.get_stage().add_child (  child_3.el  );
            var child_4 = new Xcls_projecteditview( _this );
            child_4.ref();
            this.el.get_stage().add_child (  child_4.el  );
            var child_5 = new Xcls_buttonlayout( _this );
            child_5.ref();
            this.el.get_stage().add_child (  child_5.el  );

            // init method 

            var stage = this.el.get_stage();
                stage.set_background_color(  Clutter.Color.from_string("#000"));
            // listeners 
            this.el.size_allocate.connect( (  alloc) => {
                this.setSizes(alloc, _this.state); 
                    
            });
        }

        // user defined functions 
        public           void setSizes (  Gtk.Allocation alloc, string state) {
            if (!_this.children_loaded) {  return; }
             
            _this.clutterfiles.set_size(alloc.width-50, alloc.height);
            
            // project view appears at top...
            
            _this.projecteditview.el.set_size(alloc.width-50, alloc.height / 2.0f);
                   
                   
            
            var avail = alloc.width < 50.0f ? 0 :  alloc.width - 50.0f;
         
            
            var palsize = avail < 300.0f ? avail : 300.0f;
            print("set palsize size %f\n", palsize);
           // palate / props : fixed 300 pix
                    
            _this.objectview.el.set_size(palsize, alloc.height);    
            _this.addpropsview.el.set_size(palsize, alloc.height);
            
             
            
            // code edit min 600
            
            var codesize = avail < 800.0f ? avail : 800.0f;
            print("set code size %f\n", codesize);
        
            _this.codeeditview.el.set_size(codesize, alloc.height);
            _this.rooview.el.set_size(alloc.width-50, alloc.height);    
           
            switch ( state) {
                case "codeedit": 
        
        	var scale = avail > 0.0f ? (avail - codesize -10 ) / avail : 0.0f;
        	
        	
                   _this.rooview.el.set_scale(scale,scale);
                   break;
                case "addprop":
                case "addlistener":        
                  case "object":   
        	var scale = avail > 0.0f ? (avail - palsize -10 ) / avail : 0.0f;
                   _this.rooview.el.set_scale(scale,scale);
                   break;
            }
                
        }
        public           void setSizesAlloc (string state) {
        
            Gtk.Allocation alloc;
            this.el.get_allocation(out alloc);
            this.setSizes(alloc, state);
        }
    }
    public class Xcls_rooview : Object 
    {
        public GtkClutter.Actor el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_rooview(Xcls_MainWindow _owner )
        {
            _this = _owner;
            _this.rooview = this;
            this.el = new GtkClutter.Actor();

            // my vars (dec)

            // set gobject values

            // init method 

            {
               
               
                this.el.add_constraint(
                    new Clutter.AlignConstraint(
                        _this.clutterembed.el.get_stage(), 
                        Clutter.AlignAxis.X_AXIS,
                        1.0f
                    )
                );
                    
                //this.el.set_position(100,100);
                this.el.set_pivot_point(1.0f,1.0f);
                
                this.el.set_size(_this.clutterembed.el.get_stage().width-50,
                        _this.clutterembed.el.get_stage().height);
                        
            }        }

        // user defined functions 
    }
    public class Xcls_objectview : Object 
    {
        public GtkClutter.Actor el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_objectview(Xcls_MainWindow _owner )
        {
            _this = _owner;
            _this.objectview = this;
            this.el = new GtkClutter.Actor();

            // my vars (dec)

            // set gobject values

            // init method 

            {
               
               /*
                this.el.add_constraint(
                    new Clutter.AlignConstraint(
                        _this.clutterembed.el.get_stage(), 
                        Clutter.AlignAxis.X_AXIS,
                        0.0f
                    )
                );
                */
                this.el.fixed_x = 50.0f;
                this.el.fixed_y = 0.0f;
                //this.el.set_position(100,100);
                this.el.set_pivot_point(0.0f,0.0f);
                this.el.set_scale(0.0f,1.0f);
                this.el.set_size((_this.clutterembed.el.get_stage().width-50)/2,
                        _this.clutterembed.el.get_stage().height);
                        
            }        }

        // user defined functions 
    }
    public class Xcls_codeeditview : Object 
    {
        public GtkClutter.Actor el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_codeeditview(Xcls_MainWindow _owner )
        {
            _this = _owner;
            _this.codeeditview = this;
            this.el = new GtkClutter.Actor();

            // my vars (dec)

            // set gobject values

            // init method 

            {
               
               /*
                this.el.add_constraint(
                    new Clutter.AlignConstraint(
                        _this.clutterembed.el.get_stage(), 
                        Clutter.AlignAxis.X_AXIS,
                        0.0f
                    )
                );
                */
                this.el.fixed_x = 50.0f;
                this.el.fixed_y = 0.0f;
                //this.el.set_position(100,100);
                this.el.set_pivot_point(0.0f,0.0f);
                this.el.set_scale(0.0f,1.0f);
                this.el.set_size((_this.clutterembed.el.get_stage().width-50)/2,
                        _this.clutterembed.el.get_stage().height);
                        
            }        }

        // user defined functions 
    }
    public class Xcls_addpropsview : Object 
    {
        public GtkClutter.Actor el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_addpropsview(Xcls_MainWindow _owner )
        {
            _this = _owner;
            _this.addpropsview = this;
            this.el = new GtkClutter.Actor();

            // my vars (dec)

            // set gobject values

            // init method 

            {
               
               /*
                this.el.add_constraint(
                    new Clutter.AlignConstraint(
                        _this.clutterembed.el.get_stage(), 
                        Clutter.AlignAxis.X_AXIS,
                        0.0f
                    )
                );
                */
                this.el.fixed_x = 50.0f;
                this.el.fixed_y = 0.0f;
                //this.el.set_position(100,100);
                this.el.set_pivot_point(0.0f,0.0f);
                this.el.set_scale(0.0f,1.0f);
                this.el.set_size((_this.clutterembed.el.get_stage().width-50)/2,
                        _this.clutterembed.el.get_stage().height);
                        
            }        }

        // user defined functions 
    }
    public class Xcls_projecteditview : Object 
    {
        public GtkClutter.Actor el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_projecteditview(Xcls_MainWindow _owner )
        {
            _this = _owner;
            _this.projecteditview = this;
            this.el = new GtkClutter.Actor();

            // my vars (dec)

            // set gobject values

            // init method 

            {
               
               
                this.el.add_constraint(
                    new Clutter.AlignConstraint(
                        _this.clutterembed.el.get_stage(), 
                        Clutter.AlignAxis.X_AXIS,
                        1.0f
                    )
                );
                    
                //this.el.set_position(100,100);
                this.el.set_pivot_point(0.0f,0.0f);
                this.el.set_scale(1.0f,0.0f);
                this.el.set_size(_this.clutterembed.el.get_stage().width-50,
                        _this.clutterembed.el.get_stage().height /2);
                        
            }        }

        // user defined functions 
    }
    public class Xcls_buttonlayout : Object 
    {
        public Clutter.Actor el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_buttonlayout(Xcls_MainWindow _owner )
        {
            _this = _owner;
            _this.buttonlayout = this;
            this.el = new Clutter.Actor();

            // my vars (dec)

            // set gobject values
            var child_0 = new Xcls_BoxLayout16( _this );
            child_0.ref();
            this.el.layout_manager = child_0.el;
            var child_1 = new Xcls_backbutton( _this );
            child_1.ref();
            this.el.add_child (  child_1.el  );
            var child_2 = new Xcls_projectbutton( _this );
            child_2.ref();
            this.el.add_child (  child_2.el  );
            var child_3 = new Xcls_editfilebutton( _this );
            child_3.ref();
            this.el.add_child (  child_3.el  );
            var child_4 = new Xcls_projecteditbutton( _this );
            child_4.ref();
            this.el.add_child (  child_4.el  );
            var child_5 = new Xcls_objectshowbutton( _this );
            child_5.ref();
            this.el.add_child (  child_5.el  );
            var child_6 = new Xcls_addpropbutton( _this );
            child_6.ref();
            this.el.add_child (  child_6.el  );
            var child_7 = new Xcls_addlistenerbutton( _this );
            child_7.ref();
            this.el.add_child (  child_7.el  );
            var child_8 = new Xcls_addprojectbutton( _this );
            child_8.ref();
            this.el.add_child (  child_8.el  );
            var child_9 = new Xcls_addfilebutton( _this );
            child_9.ref();
            this.el.add_child (  child_9.el  );
            var child_10 = new Xcls_delprojectbutton( _this );
            child_10.ref();
            this.el.add_child (  child_10.el  );
            var child_11 = new Xcls_new_window( _this );
            child_11.ref();
            this.el.add_child (  child_11.el  );

            // init method 

            {
                
                this.el.add_constraint(
                    new Clutter.AlignConstraint(
                        _this.clutterembed.el.get_stage(), 
                        Clutter.AlignAxis.X_AXIS,
                        0.0f
                    )
                );
                 
                
                //this.el.set_position(100,100);
                this.el.set_pivot_point(0.5f,0.5f);
                 this.el.set_size(50,
                       _this.clutterembed.el.get_stage().height);
                 
            }        }

        // user defined functions 
    }
    public class Xcls_BoxLayout16 : Object 
    {
        public Clutter.BoxLayout el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_BoxLayout16(Xcls_MainWindow _owner )
        {
            _this = _owner;
            this.el = new Clutter.BoxLayout();

            // my vars (dec)

            // set gobject values
            this.el.orientation = Clutter.Orientation.VERTICAL;
        }

        // user defined functions 
    }
    public class Xcls_backbutton : Object 
    {
        public Clutter.Actor el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_backbutton(Xcls_MainWindow _owner )
        {
            _this = _owner;
            _this.backbutton = this;
            this.el = new Clutter.Actor();

            // my vars (dec)

            // set gobject values
            var child_0 = new Xcls_Actor18( _this );
            child_0.ref();
            this.el.add_child (  child_0.el  );

            // init method 

            this.el.set_size(50,50);        }

        // user defined functions 
    }
    public class Xcls_Actor18 : Object 
    {
        public GtkClutter.Actor el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_Actor18(Xcls_MainWindow _owner )
        {
            _this = _owner;
            this.el = new GtkClutter.Actor();

            // my vars (dec)

            // set gobject values
            var child_0 = new Xcls_Button19( _this );
            child_0.ref();

            // init method 

            ((Gtk.Container)(this.el.get_widget())).add ( child_0.el);        }

        // user defined functions 
    }
    public class Xcls_Button19 : Object 
    {
        public Gtk.Button el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_Button19(Xcls_MainWindow _owner )
        {
            _this = _owner;
            this.el = new Gtk.Button();

            // my vars (dec)

            // set gobject values
            this.el.width_request = 50;
            this.el.height_request = 50;
            this.el.tooltip_text = "Back";
            var child_0 = new Xcls_Image20( _this );
            child_0.ref();
            this.el.set_image (  child_0.el  );

            // listeners 
            this.el.clicked.connect( ( ) => {
                switch (_this.state) {
                    case "edit":
                    
                        _this.hideViewEditing();
                        break;  
                    case "files":
                        // should only occur if there is an active file..
                        _this.showViewEditing();
                        break; 
                        
                      case "addprop":
                        _this.hideAddProp();
            
                        break;
                    case "addlistener":
                        _this.hideAddListener();
            
                        break;
                         
                     case "object":
                        _this.hideObject();
                        break;    
                     
                     case "codeedit":
                        
                        _this.hideCodeEdit();  
                        break;
                        
                     case  "projectedit":
                     // save?
                        _this.hideProjectEdit();
                        break;
                        
                    default:
                        break;
                }
                return  ;    
            
            });
        }

        // user defined functions 
    }
    public class Xcls_Image20 : Object 
    {
        public Gtk.Image el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_Image20(Xcls_MainWindow _owner )
        {
            _this = _owner;
            this.el = new Gtk.Image();

            // my vars (dec)

            // set gobject values
            this.el.icon_name = "go-previous";
        }

        // user defined functions 
    }
    public class Xcls_projectbutton : Object 
    {
        public Clutter.Actor el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_projectbutton(Xcls_MainWindow _owner )
        {
            _this = _owner;
            _this.projectbutton = this;
            this.el = new Clutter.Actor();

            // my vars (dec)

            // set gobject values
            var child_0 = new Xcls_Actor22( _this );
            child_0.ref();
            this.el.add_child (  child_0.el  );

            // init method 

            this.el.set_size(50,50);        }

        // user defined functions 
    }
    public class Xcls_Actor22 : Object 
    {
        public GtkClutter.Actor el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_Actor22(Xcls_MainWindow _owner )
        {
            _this = _owner;
            this.el = new GtkClutter.Actor();

            // my vars (dec)

            // set gobject values
            var child_0 = new Xcls_Button23( _this );
            child_0.ref();

            // init method 

            ((Gtk.Container)(this.el.get_widget())).add ( child_0.el);        }

        // user defined functions 
    }
    public class Xcls_Button23 : Object 
    {
        public Gtk.Button el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_Button23(Xcls_MainWindow _owner )
        {
            _this = _owner;
            this.el = new Gtk.Button();

            // my vars (dec)

            // set gobject values
            this.el.width_request = 50;
            this.el.height_request = 50;
            var child_0 = new Xcls_Image24( _this );
            child_0.ref();
            this.el.set_image (  child_0.el  );

            // listeners 
            this.el.clicked.connect( ( ) => {
                switch (_this.state) {
                    case "edit":
                    
                        _this.hideViewEditing();
                        break;  
                    case "files":
                        _this.showViewEditing();
                        break; 
                        
                      case "addprop":
                        _this.hideAddProp();
                        _this.hideViewEditing();
                        break;
                    case "addlistener":
                        _this.hideAddListener();
                        _this.hideViewEditing();
                        break;
                         
                     case "object":
                        _this.hideObject();
                        _this.hideViewEditing();
                        break;    
                        
                    default:
                        break;
                }
                return  ;    
            
            });
        }

        // user defined functions 
    }
    public class Xcls_Image24 : Object 
    {
        public Gtk.Image el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_Image24(Xcls_MainWindow _owner )
        {
            _this = _owner;
            this.el = new Gtk.Image();

            // my vars (dec)

            // set gobject values
            this.el.icon_name = "document-open";
        }

        // user defined functions 
    }
    public class Xcls_editfilebutton : Object 
    {
        public Clutter.Actor el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_editfilebutton(Xcls_MainWindow _owner )
        {
            _this = _owner;
            _this.editfilebutton = this;
            this.el = new Clutter.Actor();

            // my vars (dec)

            // set gobject values
            var child_0 = new Xcls_Actor26( _this );
            child_0.ref();
            this.el.add_child (  child_0.el  );

            // init method 

            this.el.set_size(50.0f,50.0f);        }

        // user defined functions 
    }
    public class Xcls_Actor26 : Object 
    {
        public GtkClutter.Actor el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_Actor26(Xcls_MainWindow _owner )
        {
            _this = _owner;
            this.el = new GtkClutter.Actor();

            // my vars (dec)

            // set gobject values
            var child_0 = new Xcls_Button27( _this );
            child_0.ref();

            // init method 

            ((Gtk.Container)(this.el.get_widget())).add ( child_0.el);        }

        // user defined functions 
    }
    public class Xcls_Button27 : Object 
    {
        public Gtk.Button el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_Button27(Xcls_MainWindow _owner )
        {
            _this = _owner;
            this.el = new Gtk.Button();

            // my vars (dec)

            // set gobject values
            this.el.width_request = 50;
            this.el.height_request = 50;
            this.el.tooltip_text = "File Details";
            var child_0 = new Xcls_Image28( _this );
            child_0.ref();
            this.el.set_image (  child_0.el  );

            // listeners 
            this.el.clicked.connect( ( ) => {
              
                // create a new file in project..
                if (_this.project == null || _this.left_tree.model.file == null) {
                    return  ;
                }
                 
                _this.new_file_dialog.show(_this.left_tree.model.file);
                
                return  ;    
            
            
            });
        }

        // user defined functions 
    }
    public class Xcls_Image28 : Object 
    {
        public Gtk.Image el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_Image28(Xcls_MainWindow _owner )
        {
            _this = _owner;
            this.el = new Gtk.Image();

            // my vars (dec)

            // set gobject values
            this.el.icon_name = "document-properties";
        }

        // user defined functions 
    }
    public class Xcls_projecteditbutton : Object 
    {
        public Clutter.Actor el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_projecteditbutton(Xcls_MainWindow _owner )
        {
            _this = _owner;
            _this.projecteditbutton = this;
            this.el = new Clutter.Actor();

            // my vars (dec)

            // set gobject values
            var child_0 = new Xcls_Actor30( _this );
            child_0.ref();
            this.el.add_child (  child_0.el  );

            // init method 

            this.el.set_size(50,50);        }

        // user defined functions 
    }
    public class Xcls_Actor30 : Object 
    {
        public GtkClutter.Actor el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_Actor30(Xcls_MainWindow _owner )
        {
            _this = _owner;
            this.el = new GtkClutter.Actor();

            // my vars (dec)

            // set gobject values
            var child_0 = new Xcls_Button31( _this );
            child_0.ref();

            // init method 

            ((Gtk.Container)(this.el.get_widget())).add ( child_0.el);        }

        // user defined functions 
    }
    public class Xcls_Button31 : Object 
    {
        public Gtk.Button el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_Button31(Xcls_MainWindow _owner )
        {
            _this = _owner;
            this.el = new Gtk.Button();

            // my vars (dec)

            // set gobject values
            this.el.width_request = 50;
            this.el.height_request = 50;
            this.el.tooltip_text = "Project Details";
            var child_0 = new Xcls_Image32( _this );
            child_0.ref();
            this.el.set_image (  child_0.el  );

            // listeners 
            this.el.clicked.connect( ( ) => {
                switch (_this.state) {
                    case "edit":
                        _this.showProjectEdit();
                        break;  
                    case "files":
                        // _this.showViewEditing();
                        break; 
                    case "projectedit":
                        _this.hideProjectEdit();
                        break;
                        
                        
                          
                    case "addprop":
                        _this.hideAddProp();
                        _this.showProjectEdit();
                        break;
                    case "addlistener":
                        _this.hideAddListener();
                        _this.showProjectEdit();
                        break;
                         
                     case "object":
                        _this.hideObject();
                        _this.showProjectEdit();    
                        break;
                    default:
                        break;
                }
                return  ;    
            
            
            });
        }

        // user defined functions 
    }
    public class Xcls_Image32 : Object 
    {
        public Gtk.Image el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_Image32(Xcls_MainWindow _owner )
        {
            _this = _owner;
            this.el = new Gtk.Image();

            // my vars (dec)

            // set gobject values
            this.el.icon_name = "emblem-system";
        }

        // user defined functions 
    }
    public class Xcls_objectshowbutton : Object 
    {
        public Clutter.Actor el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_objectshowbutton(Xcls_MainWindow _owner )
        {
            _this = _owner;
            _this.objectshowbutton = this;
            this.el = new Clutter.Actor();

            // my vars (dec)

            // set gobject values
            var child_0 = new Xcls_Actor34( _this );
            child_0.ref();
            this.el.add_child (  child_0.el  );

            // init method 

            this.el.set_size(50,50);
            // listeners 
            this.el.button_press_event.connect( ( ) => {
                
                
                
                switch (_this.state) {
            
             
                    case "addprop":
                        _this.hideAddProp();
                        _this.showObject();
                        break;
                case "addlistener":
                        _this.hideAddListener();
                        _this.showObject();
                        break;
            
            // show            
                    case "edit":
                        _this.showObject();
                        break;
                        
            // hide            
                    case "object":
                        _this.hideObject();
                        break;
                        break;
                                    
                    default:
                        print("unhandled add objects from %s\n",_this.state);
                        break;
                }
                return false;    
            
            
            });
            this.el.enter_event.connect( (  event)  => {
                this.el.background_color = new Clutter.Color.from_string("#333");
                    return false;
            });
            this.el.leave_event.connect( (  event)  => {
                this.el.background_color = new Clutter.Color.from_string("#000");
                return false;
            });
        }

        // user defined functions 
    }
    public class Xcls_Actor34 : Object 
    {
        public GtkClutter.Actor el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_Actor34(Xcls_MainWindow _owner )
        {
            _this = _owner;
            this.el = new GtkClutter.Actor();

            // my vars (dec)

            // set gobject values
            var child_0 = new Xcls_Button35( _this );
            child_0.ref();

            // init method 

            ((Gtk.Container)(this.el.get_widget())).add ( child_0.el);        }

        // user defined functions 
    }
    public class Xcls_Button35 : Object 
    {
        public Gtk.Button el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_Button35(Xcls_MainWindow _owner )
        {
            _this = _owner;
            this.el = new Gtk.Button();

            // my vars (dec)

            // set gobject values
            this.el.width_request = 50;
            this.el.height_request = 50;
            this.el.tooltip_text = "Add Child Element";
            var child_0 = new Xcls_Image36( _this );
            child_0.ref();
            this.el.set_image (  child_0.el  );

            // listeners 
            this.el.clicked.connect( ( ) => {
                
                
                
                switch (_this.state) {
            
             
                    case "addprop":
                        _this.hideAddProp();
                        _this.showObject();
                        break;
                case "addlistener":
                        _this.hideAddListener();
                        _this.showObject();
                        break;
            
            // show            
                    case "edit":
                        _this.showObject();
                        break;
                        
            // hide            
                    case "object":
                        _this.hideObject();
                        break;
                        break;
                                    
                    default:
                        print("unhandled add objects from %s\n",_this.state);
                        break;
                }
                return  ;    
            
            
            });
        }

        // user defined functions 
    }
    public class Xcls_Image36 : Object 
    {
        public Gtk.Image el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_Image36(Xcls_MainWindow _owner )
        {
            _this = _owner;
            this.el = new Gtk.Image();

            // my vars (dec)

            // set gobject values
            this.el.icon_name = "list-add";
        }

        // user defined functions 
    }
    public class Xcls_addpropbutton : Object 
    {
        public Clutter.Actor el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_addpropbutton(Xcls_MainWindow _owner )
        {
            _this = _owner;
            _this.addpropbutton = this;
            this.el = new Clutter.Actor();

            // my vars (dec)

            // set gobject values
            var child_0 = new Xcls_Actor38( _this );
            child_0.ref();
            this.el.add_child (  child_0.el  );

            // init method 

            this.el.set_size(50,50);        }

        // user defined functions 
    }
    public class Xcls_Actor38 : Object 
    {
        public GtkClutter.Actor el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_Actor38(Xcls_MainWindow _owner )
        {
            _this = _owner;
            this.el = new GtkClutter.Actor();

            // my vars (dec)

            // set gobject values
            var child_0 = new Xcls_Button39( _this );
            child_0.ref();

            // init method 

            ((Gtk.Container)(this.el.get_widget())).add ( child_0.el);        }

        // user defined functions 
    }
    public class Xcls_Button39 : Object 
    {
        public Gtk.Button el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_Button39(Xcls_MainWindow _owner )
        {
            _this = _owner;
            this.el = new Gtk.Button();

            // my vars (dec)

            // set gobject values
            this.el.width_request = 50;
            this.el.height_request = 50;
            this.el.tooltip_text = "Add Property";
            var child_0 = new Xcls_Image40( _this );
            child_0.ref();
            this.el.set_image (  child_0.el  );

            // listeners 
            this.el.clicked.connect( ( ) => {
                
                
                
                switch (_this.state) {
                    case "edit":
                        _this.showAddProp();
                        break;
                        
                    case "object":
                        _this.hideObject();
                        _this.showAddProp();
                        break;
                   
                    case "addlistener":
                        _this.hideAddListener();
                        _this.showAddProp();            
                        break;
                        
                        
                    case "addprop":
                        _this.hideAddProp();
                        break;
                        
                    default:
                        print("unhandled add property from %s\n",_this.state);
                        break;
                        
                }
                return  ;    
            
            
            });
        }

        // user defined functions 
    }
    public class Xcls_Image40 : Object 
    {
        public Gtk.Image el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_Image40(Xcls_MainWindow _owner )
        {
            _this = _owner;
            this.el = new Gtk.Image();

            // my vars (dec)

            // set gobject values
            this.el.icon_name = "format-justify-left";
        }

        // user defined functions 
    }
    public class Xcls_addlistenerbutton : Object 
    {
        public Clutter.Actor el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_addlistenerbutton(Xcls_MainWindow _owner )
        {
            _this = _owner;
            _this.addlistenerbutton = this;
            this.el = new Clutter.Actor();

            // my vars (dec)

            // set gobject values
            var child_0 = new Xcls_Actor42( _this );
            child_0.ref();
            this.el.add_child (  child_0.el  );

            // init method 

            this.el.set_size(50,50);        }

        // user defined functions 
    }
    public class Xcls_Actor42 : Object 
    {
        public GtkClutter.Actor el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_Actor42(Xcls_MainWindow _owner )
        {
            _this = _owner;
            this.el = new GtkClutter.Actor();

            // my vars (dec)

            // set gobject values
            var child_0 = new Xcls_Button43( _this );
            child_0.ref();

            // init method 

            ((Gtk.Container)(this.el.get_widget())).add ( child_0.el);        }

        // user defined functions 
    }
    public class Xcls_Button43 : Object 
    {
        public Gtk.Button el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_Button43(Xcls_MainWindow _owner )
        {
            _this = _owner;
            this.el = new Gtk.Button();

            // my vars (dec)

            // set gobject values
            this.el.width_request = 50;
            this.el.height_request = 50;
            this.el.tooltip_text = "Add Event Code";
            var child_0 = new Xcls_Image44( _this );
            child_0.ref();
            this.el.set_image (  child_0.el  );

            // listeners 
            this.el.clicked.connect( ( ) => {
                
                
                
                switch (_this.state) {
                    case "edit":
                        _this.showAddListener();
                        break;
                        
                   
                    case "addlistener":
                        _this.hideAddListener();
                        break;
            
                        
                    case "addprop":
                        _this.hideAddProp();
                        _this.showAddListener();
                        break;
                     case "object":
                        _this.hideObject();
                        _this.showAddListener();
                        break;
                
                      default:
                        print("unhandled add listener from %s\n",_this.state);
            
                        break;
                        
                }
                return  ;    
            
            
            });
        }

        // user defined functions 
    }
    public class Xcls_Image44 : Object 
    {
        public Gtk.Image el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_Image44(Xcls_MainWindow _owner )
        {
            _this = _owner;
            this.el = new Gtk.Image();

            // my vars (dec)

            // set gobject values
            this.el.icon_name = "appointment-new";
        }

        // user defined functions 
    }
    public class Xcls_addprojectbutton : Object 
    {
        public Clutter.Actor el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_addprojectbutton(Xcls_MainWindow _owner )
        {
            _this = _owner;
            _this.addprojectbutton = this;
            this.el = new Clutter.Actor();

            // my vars (dec)

            // set gobject values
            var child_0 = new Xcls_Actor46( _this );
            child_0.ref();
            this.el.add_child (  child_0.el  );

            // init method 

            this.el.set_size(50.0f,50.0f);        }

        // user defined functions 
    }
    public class Xcls_Actor46 : Object 
    {
        public GtkClutter.Actor el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_Actor46(Xcls_MainWindow _owner )
        {
            _this = _owner;
            this.el = new GtkClutter.Actor();

            // my vars (dec)

            // set gobject values
            var child_0 = new Xcls_Button47( _this );
            child_0.ref();

            // init method 

            ((Gtk.Container)(this.el.get_widget())).add ( child_0.el);        }

        // user defined functions 
    }
    public class Xcls_Button47 : Object 
    {
        public Gtk.Button el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_Button47(Xcls_MainWindow _owner )
        {
            _this = _owner;
            this.el = new Gtk.Button();

            // my vars (dec)

            // set gobject values
            this.el.width_request = 50;
            this.el.height_request = 50;
            this.el.tooltip_text = "New\nProj.";
            var child_0 = new Xcls_Image48( _this );
            child_0.ref();
            this.el.set_image (  child_0.el  );

            // listeners 
            this.el.clicked.connect( ( ) => {
              
                // create a new file in project..
                //Xcls_DialogNewComponent.singleton().show(
               var  pe =     Xcls_EditProject.singleton();
                pe.el.set_transient_for(_this.el);
                pe.el.set_modal(true);   
               
                var p  = pe.show();
            
                if (p == null) {
                    return;
                }
                _this.left_projects.is_loaded = false;    
                _this.left_projects.load();
                _this.left_projects.selectProject(p);
                return  ;    
            
            
            });
        }

        // user defined functions 
    }
    public class Xcls_Image48 : Object 
    {
        public Gtk.Image el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_Image48(Xcls_MainWindow _owner )
        {
            _this = _owner;
            this.el = new Gtk.Image();

            // my vars (dec)

            // set gobject values
            this.el.icon_name = "folder-new";
        }

        // user defined functions 
    }
    public class Xcls_addfilebutton : Object 
    {
        public Clutter.Actor el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_addfilebutton(Xcls_MainWindow _owner )
        {
            _this = _owner;
            _this.addfilebutton = this;
            this.el = new Clutter.Actor();

            // my vars (dec)

            // set gobject values
            var child_0 = new Xcls_Actor50( _this );
            child_0.ref();
            this.el.add_child (  child_0.el  );

            // init method 

            this.el.set_size(50.0f,50.0f);        }

        // user defined functions 
    }
    public class Xcls_Actor50 : Object 
    {
        public GtkClutter.Actor el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_Actor50(Xcls_MainWindow _owner )
        {
            _this = _owner;
            this.el = new GtkClutter.Actor();

            // my vars (dec)

            // set gobject values
            var child_0 = new Xcls_Button51( _this );
            child_0.ref();

            // init method 

            ((Gtk.Container)(this.el.get_widget())).add ( child_0.el);        }

        // user defined functions 
    }
    public class Xcls_Button51 : Object 
    {
        public Gtk.Button el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_Button51(Xcls_MainWindow _owner )
        {
            _this = _owner;
            this.el = new Gtk.Button();

            // my vars (dec)

            // set gobject values
            this.el.width_request = 50;
            this.el.height_request = 50;
            this.el.tooltip_text = "Add File";
            var child_0 = new Xcls_Image52( _this );
            child_0.ref();
            this.el.set_image (  child_0.el  );

            // listeners 
            this.el.clicked.connect( () => {
                // create a new file in project..
                
                // what's the currently selected project...
                var proj = _this.left_projects.getSelectedProject();
                
                if (proj == null) {
                    return  ;
                }
                
                
                
                var f = JsRender.JsRender.factory(proj.xtype,  proj, "");
                _this.project = proj;
                _this.new_file_dialog.show(f);
                
                return  ;    
            });
        }

        // user defined functions 
    }
    public class Xcls_Image52 : Object 
    {
        public Gtk.Image el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_Image52(Xcls_MainWindow _owner )
        {
            _this = _owner;
            this.el = new Gtk.Image();

            // my vars (dec)

            // set gobject values
            this.el.icon_name = "document-new";
        }

        // user defined functions 
    }
    public class Xcls_delprojectbutton : Object 
    {
        public Clutter.Actor el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_delprojectbutton(Xcls_MainWindow _owner )
        {
            _this = _owner;
            _this.delprojectbutton = this;
            this.el = new Clutter.Actor();

            // my vars (dec)

            // set gobject values
            var child_0 = new Xcls_Actor54( _this );
            child_0.ref();
            this.el.add_child (  child_0.el  );

            // init method 

            this.el.set_size(50,50);        }

        // user defined functions 
    }
    public class Xcls_Actor54 : Object 
    {
        public GtkClutter.Actor el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_Actor54(Xcls_MainWindow _owner )
        {
            _this = _owner;
            this.el = new GtkClutter.Actor();

            // my vars (dec)

            // set gobject values
            var child_0 = new Xcls_Button55( _this );
            child_0.ref();

            // init method 

            ((Gtk.Container)(this.el.get_widget())).add ( child_0.el);        }

        // user defined functions 
    }
    public class Xcls_Button55 : Object 
    {
        public Gtk.Button el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_Button55(Xcls_MainWindow _owner )
        {
            _this = _owner;
            this.el = new Gtk.Button();

            // my vars (dec)

            // set gobject values
            this.el.width_request = 50;
            this.el.height_request = 50;
            this.el.tooltip_text = "Delelte Project";
            var child_0 = new Xcls_Image56( _this );
            child_0.ref();
            this.el.set_image (  child_0.el  );

            // listeners 
            this.el.clicked.connect( ( ) => {
                 
                 var cd = DialogConfirm.singleton();
                 cd.el.set_transient_for(_this.el);
                cd.el.set_modal(true);
            
                 var project =   _this.left_projects.getSelectedProject();
                if (project == null) {
                    print("SKIP - no project\n");
                    return;
                }
                
                    
                 if (Gtk.ResponseType.YES != cd.show("Confirm", 
                    "Are you sure you want to delete project %s".printf(project.name))) {
                    return;
                }
                 
            
                // confirm?
                Project.Project.remove(project);
                _this.project = null;
                
                _this.left_projects.is_loaded =  false;
                _this.left_projects.load();
                _this.clutterfiles.clearFiles();
            
            });
        }

        // user defined functions 
    }
    public class Xcls_Image56 : Object 
    {
        public Gtk.Image el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_Image56(Xcls_MainWindow _owner )
        {
            _this = _owner;
            this.el = new Gtk.Image();

            // my vars (dec)

            // set gobject values
            this.el.icon_name = "user-trash";
        }

        // user defined functions 
    }
    public class Xcls_new_window : Object 
    {
        public Clutter.Actor el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_new_window(Xcls_MainWindow _owner )
        {
            _this = _owner;
            _this.new_window = this;
            this.el = new Clutter.Actor();

            // my vars (dec)

            // set gobject values
            var child_0 = new Xcls_Actor58( _this );
            child_0.ref();
            this.el.add_child (  child_0.el  );

            // init method 

            this.el.set_size(50,50);        }

        // user defined functions 
    }
    public class Xcls_Actor58 : Object 
    {
        public GtkClutter.Actor el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_Actor58(Xcls_MainWindow _owner )
        {
            _this = _owner;
            this.el = new GtkClutter.Actor();

            // my vars (dec)

            // set gobject values
            var child_0 = new Xcls_Button59( _this );
            child_0.ref();

            // init method 

            ((Gtk.Container)(this.el.get_widget())).add ( child_0.el);        }

        // user defined functions 
    }
    public class Xcls_Button59 : Object 
    {
        public Gtk.Button el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_Button59(Xcls_MainWindow _owner )
        {
            _this = _owner;
            this.el = new Gtk.Button();

            // my vars (dec)

            // set gobject values
            this.el.width_request = 50;
            this.el.height_request = 50;
            this.el.tooltip_text = "Open New Window";
            var child_0 = new Xcls_Image60( _this );
            child_0.ref();
            this.el.set_image (  child_0.el  );

            // listeners 
            this.el.clicked.connect( ( ) => {
                    Xcls_MainWindow.singleton().no_windows++;
                    var w = new Xcls_MainWindow();
                    w.ref();
            
                    w.el.show_all();
                    w.initChildren();
                    w.hideViewEditing();
            });
        }

        // user defined functions 
    }
    public class Xcls_Image60 : Object 
    {
        public Gtk.Image el;
        private Xcls_MainWindow  _this;


            // my vars (def)

        // ctor 
        public Xcls_Image60(Xcls_MainWindow _owner )
        {
            _this = _owner;
            this.el = new Gtk.Image();

            // my vars (dec)

            // set gobject values
            this.el.icon_name = "window-new";
        }

        // user defined functions 
    }
}
