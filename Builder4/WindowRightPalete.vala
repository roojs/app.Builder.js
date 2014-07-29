/* -- to compile
valac  --pkg gio-2.0  --pkg posix  --pkg gtk+-3.0 --pkg libnotify --pkg gtksourceview-3.0  --pkg  libwnck-3.0 \
    /tmp/WindowRightPalete.vala  -o /tmp/WindowRightPalete
*/


/* -- to test class
static int main (string[] args) {
    Gtk.init (ref args);
    new Xcls_RightPalete();
    WindowRightPalete.show_all();
     Gtk.main ();
    return 0;
}
*/


public static Xcls_RightPalete  WindowRightPalete;

public class Xcls_RightPalete : Object 
{
    public Gtk.VBox el;
    private Xcls_RightPalete  _this;

    public Xcls_viewbox viewbox;
    public Xcls_model model;
    public Xcls_txtrender txtrender;

        // my vars
    public signal void after_node_change(JsRender.Node? node);
    public signal void before_node_change(JsRender.Node? node);
    public signal void drag_end();

        // ctor 
    public Xcls_RightPalete()
    {
        _this = this;
        WindowRightPalete = this;
        this.el = new Gtk.VBox( true, 0 );

        // my vars

        // set gobject values
        var child_0 = new Xcls_viewbox( _this );
        child_0.ref();
        this.el.add (  child_0.el  );
    }

    // userdefined functions 
    public void clear() {
           this.model.el.clear();
        }
    public void load (Palete.Palete pal, string cls ) {
           
           // this.get('model').expanded();
            
            var tr = pal.getChildList(cls);
            this.model.el.clear();
        
        
            Gtk.TreeIter citer;
        
            for(var i =0 ; i < tr.length; i++) {
                 this.model.el.append(out citer);   
                 
                this.model.el.set_value(citer, 0,   tr[i] ); // title 
                
            }
            
            
        } 

    // skip |xns - no return type
    public class Xcls_viewbox : Object 
    {
        public Gtk.VBox el;
        private Xcls_RightPalete  _this;


            // my vars

            // ctor 
        public Xcls_viewbox(Xcls_RightPalete _owner )
        {
            _this = _owner;
            _this.viewbox = this;
            this.el = new Gtk.VBox( true, 0 );

            // my vars

            // set gobject values
            var child_0 = new Xcls_ScrolledWindow3( _this );
            child_0.ref();
            this.el.add (  child_0.el  );
        }

        // userdefined functions 

        // skip |xns - no return type
    }
    public class Xcls_ScrolledWindow3 : Object 
    {
        public Gtk.ScrolledWindow el;
        private Xcls_RightPalete  _this;


            // my vars

            // ctor 
        public Xcls_ScrolledWindow3(Xcls_RightPalete _owner )
        {
            _this = _owner;
            this.el = new Gtk.ScrolledWindow( null, null );

            // my vars

            // set gobject values
            this.el.shadow_type = Gtk.ShadowType.IN;
            var child_0 = new Xcls_TreeView4( _this );
            child_0.ref();
            this.el.add (  child_0.el  );

            // init method 
              this.el.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC);
               this.el.set_size_request(-1,200);
             
        }

        // userdefined functions 

        // skip |xns - no return type
    }
    public class Xcls_TreeView4 : Object 
    {
        public Gtk.TreeView el;
        private Xcls_RightPalete  _this;


            // my vars
        public string dragData;

            // ctor 
        public Xcls_TreeView4(Xcls_RightPalete _owner )
        {
            _this = _owner;
            this.el = new Gtk.TreeView();

            // my vars

            // set gobject values
            this.el.enable_tree_lines = true;
            this.el.headers_visible = false;
            var child_0 = new Xcls_model( _this );
            child_0.ref();
            this.el.set_model (  child_0.el  );
            var child_1 = new Xcls_TreeViewColumn6( _this );
            child_1.ref();
            this.el.append_column (  child_1.el  );

            // init method 
             {
                this.el.set_size_request(150,-1);
                                      //  set_reorderable: [1]
                                              
                var description = new Pango.FontDescription();
                description.set_size(8000);
                this.el.modify_font(description);
                
                var selection = this.el.get_selection();
                selection.set_mode( Gtk.SelectionMode.SINGLE);
               // this.selection.signal['changed'].connect(function() {
                //    _view.listeners['cursor-changed'].apply(_view, [ _view, '']);
                //});
                // see: http://live.gnome.org/GnomeLove/DragNDropTutorial
                 
                Gtk.drag_source_set (
                        this.el,            /* widget will be drag-able */
                        Gdk.ModifierType.BUTTON1_MASK,       /* modifier that will start a drag */
                        Builder4.Application.targetList,            /* lists of target to support */
                        Gdk.DragAction.COPY         /* what to do with data after dropped */
                );
                //Gtk.drag_source_set_target_list(this.el, LeftTree.targetList);
               
               // Gtk.drag_source_set_target_list(this.el, Application.targetList);
               // Gtk.drag_source_add_text_targets(this.el); 
             
            }

            // listeners 
            this.el.drag_begin.connect(   ( ctx) => {
                // we could fill this in now...
            //        Seed.print('SOURCE: drag-begin');
                    
                    
                    
                    Gtk.TreeIter iter;
                    var s = this.el.get_selection();
                    
                    Gtk.TreeModel mod;
                    s.get_selected(out mod, out iter);
                    var path = mod.get_path(iter);
                    
                    /// pix is a surface..
                    var pix = this.el.create_row_drag_icon ( path);
                        
                            
                    Gtk.drag_set_icon_surface (ctx, pix);
                    GLib.Value value;
                    
            
                    _this.model.el.get_value(iter, 0, out value);
                    
                    this.dragData = (string) value;
                     
                    
                    return;
            } );
            this.el.drag_data_get.connect(   (drag_context, selection_data, info, time) => {
             	//Seed.print('Palete: drag-data-get: ' + target_type);
                    if (this.dragData.length > 0 ) {
                        selection_data.set_text(this.dragData ,this.dragData.length);
                    }
                    
                    
                    //this.el.dragData = "TEST from source widget";
                    
                    
            } );
            this.el.drag_end.connect( ( drag_context)  => {
             	//Seed.print('SOURCE: drag-end');
            	
            	this.dragData = "";
            	//this.dropList = null;
            	_this.drag_end(); // call signal..
            	//this.get('/LeftTree.view').highlight(false);
            	 
            } );
            this.el.button_press_event.connect(  ( event) => {
            
             //	if (!this.get('/Editor').save()) {
             //	    // popup!! - click handled.. 
            // 	    return true;
            //        }
                return false;
            } );
        }

        // userdefined functions 

        // skip |xns - no return type
    }
    public class Xcls_model : Object 
    {
        public Gtk.ListStore el;
        private Xcls_RightPalete  _this;


            // my vars

            // ctor 
        public Xcls_model(Xcls_RightPalete _owner )
        {
            _this = _owner;
            _this.model = this;
            this.el = new Gtk.ListStore( 2, typeof(string),typeof(string) );

            // my vars

            // set gobject values
        }

        // userdefined functions 
        public string getValue (Gtk.TreeIter iter, int col)  {
                GLib.Value gval;
                 this.el.get_value(iter, col , out gval);
                return  (string)gval;
                
                
            }

        // skip |xns - no return type
    }
    public class Xcls_TreeViewColumn6 : Object 
    {
        public Gtk.TreeViewColumn el;
        private Xcls_RightPalete  _this;


            // my vars

            // ctor 
        public Xcls_TreeViewColumn6(Xcls_RightPalete _owner )
        {
            _this = _owner;
            this.el = new Gtk.TreeViewColumn();

            // my vars

            // set gobject values
            var child_0 = new Xcls_txtrender( _this );
            child_0.ref();
            this.el.pack_start (  child_0.el , true );

            // init method 
             this.el.add_attribute(_this.txtrender.el , "markup", 0 );
             
        }

        // userdefined functions 

        // skip |xns - no return type
    }
    public class Xcls_txtrender : Object 
    {
        public Gtk.CellRendererText el;
        private Xcls_RightPalete  _this;


            // my vars

            // ctor 
        public Xcls_txtrender(Xcls_RightPalete _owner )
        {
            _this = _owner;
            _this.txtrender = this;
            this.el = new Gtk.CellRendererText();

            // my vars

            // set gobject values
        }

        // userdefined functions 

        // skip |xns - no return type
    }
}
