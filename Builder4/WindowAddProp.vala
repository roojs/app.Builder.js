/* -- to compile
valac  --pkg gio-2.0  --pkg posix  --pkg gtk+-3.0 --pkg libnotify --pkg gtksourceview-3.0  --pkg  libwnck-3.0 \
    /tmp/WindowAddProp.vala  -o /tmp/WindowAddProp
*/


/* -- to test class
static int main (string[] args) {
    Gtk.init (ref args);
    new Xcls_WindowAddProp();
    WindowAddProp.show_all();
     Gtk.main ();
    return 0;
}
*/


public static Xcls_WindowAddProp  WindowAddProp;

public class Xcls_WindowAddProp : Object 
{
    public Gtk.ScrolledWindow el;
    private Xcls_WindowAddProp  _this;

    public Xcls_model model;
    public Xcls_namecol namecol;
    public Xcls_namerender namerender;

        // my vars
    public signal void select(string key, string type, string skel, string etype);

        // ctor 
    public Xcls_WindowAddProp()
    {
        _this = this;
        WindowAddProp = this;
        this.el = new Gtk.ScrolledWindow( null, null );

        // my vars

        // set gobject values
        this.el.shadow_type = Gtk.ShadowType.IN;
        var child_0 = new Xcls_TreeView2( _this );
        child_0.ref();
        this.el.add (  child_0.el  );

        // init method 
            this.el.set_policy (Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC);
         
    }

    // userdefined functions 
    public void show(Palete.Palete pal, string etype, string xtype) {
            this.model.el.clear();
        
            Gtk.TreeIter iter;
            var elementList = palete.getPropertiesFor(etype, xtype);
            
            
            print ("GOT " + elementList.length + " items for " + fullpath + "|" + type);
                   // console.dump(elementList);
                   
            var miter = elementsList.map_iterator();
            while (miter.next()) {
               var p = miter.get_value();
                
                this.model.el.append(out iter);
        
                this.model.el.set_values(iter,
                        0,  p.name, 
                        1, p.type,
                        2, "<span size=\"small\"><b>" + p.name +"</b> ["+p.type+"]</span>\n" + p.doctxt,
                        3, p.sig ? p.sig  : '',
                        4, "<span size=\"small\"><b>" + p.name +"</b> ["+p.type+"]</span>'",
                        5, etype
                );
            }
                                     
        }

    // skip |xns - no return type
    public class Xcls_TreeView2 : Object 
    {
        public Gtk.TreeView el;
        private Xcls_WindowAddProp  _this;


            // my vars

            // ctor 
        public Xcls_TreeView2(Xcls_WindowAddProp _owner )
        {
            _this = _owner;
            this.el = new Gtk.TreeView();

            // my vars

            // set gobject values
            this.el.enable_tree_lines = true;
            this.el.headers_visible = false;
            this.el.tooltip_column = 2;
            var child_0 = new Xcls_model( _this );
            child_0.ref();
            this.el.set_model (  child_0.el  );
            var child_1 = new Xcls_namecol( _this );
            child_1.ref();
            this.el.append_column (  child_1.el  );

            // init method 
            {  
                   var description = new Pango.FontDescription();
                 description.set_size(8000);
                this.el.modify_font(description);     
                                
                this.el.get_selection().set_mode( Gtk.SelectionMode.SINGLE);
             
            
                
              
                
            }

            // listeners 
            this.el.cursor_changed.connect( () => {
                    Gtk.TreeIter iter;
                    Gtk.TreeModel mode;
            
                    var m = _this.model;
                    var s = this.el.get_selection();
                    if (!s.get_selected(out mod, out iter)) {
            		return; 
            	}
                    var tp = m.el.get_path(iter).to_string();
                    
                    
                    // var val = "";
                    
                    
                    var key = m.getValue(iter, 0);
                    
                    var type = m.getValue(iter, 1);
                    var skel = m.getValue(iter, 3);
                    var etype = m.getValue(iter, 5);
                    
                    
                    
                    _this.select(key,type,skel, etype);
                    
            } );
        }

        // userdefined functions 

        // skip |xns - no return type
    }
    public class Xcls_model : Object 
    {
        public Gtk.ListStore el;
        private Xcls_WindowAddProp  _this;


            // my vars

            // ctor 
        public Xcls_model(Xcls_WindowAddProp _owner )
        {
            _this = _owner;
            _this.model = this;
            this.el = new Gtk.ListStore( 6, typeof(string),  // 0 real key
typeof(string), // 1 real type
typeof(string), // 2 docs ?
typeof(string), // 3 visable desc
typeof(string), // 4 function desc
typeof(string) // 5 element type (event|prop)
         );

            // my vars

            // set gobject values
        }

        // userdefined functions 
        public string getValue(Gtk.TreeIter iter, int col)
            {
            
                GLib.Value value;
                this.get_value(iter, col, out value)
            
                return (string)value;
                
            }

        // skip |xns - no return type
    }
    public class Xcls_namecol : Object 
    {
        public Gtk.TreeViewColumn el;
        private Xcls_WindowAddProp  _this;


            // my vars

            // ctor 
        public Xcls_namecol(Xcls_WindowAddProp _owner )
        {
            _this = _owner;
            _this.namecol = this;
            this.el = new Gtk.TreeViewColumn();

            // my vars

            // set gobject values
            var child_0 = new Xcls_namerender( _this );
            child_0.ref();
            this.el.pack_start (  child_0.el , true );

            // init method 
              this.el.add_attribute(_this.namerender.el , 'markup', 4  );
             
        }

        // userdefined functions 

        // skip |xns - no return type
    }
    public class Xcls_namerender : Object 
    {
        public Gtk.CellRendererText el;
        private Xcls_WindowAddProp  _this;


            // my vars

            // ctor 
        public Xcls_namerender(Xcls_WindowAddProp _owner )
        {
            _this = _owner;
            _this.namerender = this;
            this.el = new Gtk.CellRendererText();

            // my vars

            // set gobject values
        }

        // userdefined functions 

        // skip |xns - no return type
    }
}
