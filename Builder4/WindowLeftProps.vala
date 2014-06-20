/* -- to compile
valac  --pkg gio-2.0  --pkg posix  --pkg gtk+-3.0 --pkg libnotify --pkg gtksourceview-3.0  --pkg  libwnck-3.0 \
    /tmp/WindowLeftProps.vala  -o /tmp/WindowLeftProps
*/


/* -- to test class
static int main (string[] args) {
    Gtk.init (ref args);
    new Xcls_MidPropTree();
    WindowLeftProps.show_all();
     Gtk.main ();
    return 0;
}
*/


public static Xcls_MidPropTree  WindowLeftProps;

public class Xcls_MidPropTree : Object 
{
    public Gtk.ScrolledWindow el;
    private Xcls_MidPropTree  _this;

    public Xcls_model model;

        // my vars

        // ctor 
    public Xcls_MidPropTree()
    {
        _this = this;
        WindowLeftProps = this;
        this.el = new Gtk.ScrolledWindow( null, null );

        // my vars

        // set gobject values
        this.el.shadow_type = Gtk.ShadowType.IN;
        var child_0 = new Xcls_TreeView2(_this);
        child_0.ref();
        this.el.add (  child_0.el  );

        // init method 
        function() {
            XObject.prototype.init.call(this);
               XObject.prototype.init.call(this); 
            this.el.set_policy (Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC)
            this.el.set_size_request ( 150, -1 );
            this.shown = true;
        }
    }

    // userdefined functions 

    // skip activeElement - not pipe 

    // skip id - not pipe 

    // skip pack - not pipe 

    // skip xtype - not pipe 

    // skip |hideWin - no return type

    // skip |init - already used 

    // skip |shadow_type - already used 

    // skip |xns - no return type

    // skip items - not pipe 

    // skip xvala_cls - not pipe 

    // skip xvala_xcls - not pipe 

    // skip xvala_id - not pipe 
    public class Xcls_TreeView2 : Object 
    {
        public Gtk.TreeView el;
        private Xcls_MidPropTree  _this;


            // my vars

            // ctor 
        public Xcls_TreeView2(Xcls_MidPropTree _owner)
        {
            _this = _owner;
            this.el = new Gtk.TreeView();

            // my vars

            // set gobject values
            this.el.enable_tree_lines = true;
            this.el.headers_visible = false;
            this.el.tooltip_column = 2;
            var child_0 = new Xcls_model(_this);
            child_0.ref();
            this.el.set_model (  child_0.el  );
            var child_1 = new Xcls_TreeViewColumn4(_this);
            child_1.ref();

            // init method 
            function() {
            	XObject.prototype.init.call(this); 
                                
                   var description = new Pango.FontDescription.c_new();
                 description.set_size(8000);
                this.el.modify_font(description);     
                                
                //this.selection = this.el.get_selection();
                // this.selection.set_mode( Gtk.SelectionMode.SINGLE);
             
            
                
              
                
            }

            // listeners 
            this.el.cursor_changed.connect( function (self) {
                   var iter = new Gtk.TreeIter();
                                    
                                    //console.log('changed');
                    var m = this.get('model');
            	if (!this.selection){
            		this.selection = this.el.get_selection();
            	}
            
                    var s = this.selection;
                    if (!s.get_selected(m.el, iter)) {
            		return; 
            	}
                    var tp = m.el.get_path(iter).to_string();
                    
                    
                    // var val = "";
                    
                    var key = m.getValue(tp, 0);
                    
                    var type = m.getValue(tp, 1);
                    var skel = m.getValue(tp, 3);
                    var etype = m.getValue(tp, 5);
                    
                    
                    this.get('/MidPropTree').hideWin();
            
                    if (type.toLowerCase() == 'function') {
                        
                        if (etype != 'events') {
                            key = '|' + key;
                        }
                        
                        this.get('/LeftPanel.model').add({
                            key :  key, 
                            type : type,
                            val  : skel,
                            etype : etype
                        })  
                        return;
                    }
                    // has dot in name, and is boolean???? this does not make sense..
                    //if (type.indexOf('.') > -1 ||  type.toLowerCase() == 'boolean') {
                    //     key = '|' + key;
                   // }
                    
                    this.get('/LeftPanel.model').add( {
                        key : key, 
                        type : type,
                        //skel  : skel,
                        etype : etype
                       }) //, 
            } );
        }

        // userdefined functions 

        // skip listeners - not pipe 

        // skip pack - not pipe 

        // skip tooltip_column - already used 

        // skip xtype - not pipe 

        // skip |enable_tree_lines - already used 

        // skip |headers_visible - already used 

        // skip |init - already used 

        // skip |xns - no return type

        // skip items - not pipe 

        // skip xvala_cls - not pipe 

        // skip xvala_xcls - not pipe 

        // skip xvala_id - not pipe 
    }
    public class Xcls_model : Object 
    {
        public Gtk.ListStore el;
        private Xcls_MidPropTree  _this;


            // my vars

            // ctor 
        public Xcls_model(Xcls_MidPropTree _owner)
        {
            _this = _owner;
            _this.model = this;
            this.el = new Gtk.ListStore( null, null );

            // my vars

            // set gobject values

            // init method 
            function() {
                XObject.prototype.init.call(this);
               this.el.set_column_types ( 6, [
                    GObject.TYPE_STRING,  // real key
                     GObject.TYPE_STRING, // real type
                     GObject.TYPE_STRING, // docs ?
                     GObject.TYPE_STRING, // visable desc
                     GObject.TYPE_STRING, // function desc
                     GObject.TYPE_STRING // element type (event|prop)
                    
                ] );
            }
        }

        // userdefined functions 

        // skip id - not pipe 

        // skip pack - not pipe 

        // skip xtype - not pipe 

        // skip |getValue - no return type

        // skip |init - already used 

        // skip |showData - no return type

        // skip |xns - no return type

        // skip xvala_cls - not pipe 

        // skip xvala_xcls - not pipe 

        // skip xvala_id - not pipe 
    }
    public class Xcls_TreeViewColumn4 : Object 
    {
        public Gtk.TreeViewColumn el;
        private Xcls_MidPropTree  _this;


            // my vars

            // ctor 
        public Xcls_TreeViewColumn4(Xcls_MidPropTree _owner)
        {
            _this = _owner;
            this.el = new Gtk.TreeViewColumn();

            // my vars

            // set gobject values
            var child_0 = new Xcls_CellRendererText5(_this);
            child_0.ref();
            this.el.pack_start (  child_0.el , true );

            // init method 
            function() {
                this.el = new Gtk.TreeViewColumn();
                this.parent.el.append_column(this.el);
                
                XObject.prototype.init.call(this);
                this.el.add_attribute(this.items[0].el , 'markup', 4  );
            }
        }

        // userdefined functions 

        // skip pack - not pipe 

        // skip xtype - not pipe 

        // skip |init - already used 

        // skip |xns - no return type

        // skip items - not pipe 

        // skip xvala_cls - not pipe 

        // skip xvala_xcls - not pipe 

        // skip xvala_id - not pipe 
    }
    public class Xcls_CellRendererText5 : Object 
    {
        public Gtk.CellRendererText el;
        private Xcls_MidPropTree  _this;


            // my vars

            // ctor 
        public Xcls_CellRendererText5(Xcls_MidPropTree _owner)
        {
            _this = _owner;
            this.el = new Gtk.CellRendererText();

            // my vars

            // set gobject values
        }

        // userdefined functions 

        // skip |xns - no return type

        // skip xtype - not pipe 

        // skip pack - not pipe 

        // skip xvala_cls - not pipe 

        // skip xvala_xcls - not pipe 

        // skip xvala_id - not pipe 
    }
}
