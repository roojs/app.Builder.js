/* -- to compile
valac  --pkg gio-2.0  --pkg posix  --pkg gtk+-3.0 --pkg libnotify --pkg gtksourceview-3.0  --pkg  libwnck-3.0 \
    /tmp/MainWindow.vala  -o /tmp/MainWindow
*/


/* -- to test class
static int main (string[] args) {
    Gtk.init (ref args);
    new Xcls_MainWindow();
    MainWindow.show_all();
     Gtk.main ();
    return 0;
}
*/


public static Xcls_MainWindow  MainWindow;

public class Xcls_MainWindow
{
    public Gtk.Window el;
    private Xcls_MainWindow  _this;

    public Xcls_vbox vbox;

        // my vars
    public Xcls_WindowLeftTree left_tree;
    public string title;

        // ctor 
    public Xcls_MainWindow()
    {
        this.el = new Gtk.Window( Gtk.WindowType.TOPLEVEL );
        _this = this;
        MainWindow = this;

        // my vars
        this.left_tree = null;
        this.title = "Application Builder";

        // set gobject values
        this.el.border_width = 0;
        this.el.default_height = 500;
        this.el.default_width = 800;
        var child_0 = new Xcls_vbox(_this);
        this.el.add (  child_0.el  );

        // init method 
         
        	  
            this.el.show_all();
            
            

        // listeners 
        this.el.show.connect(   ( ) => {
        
            //imports.Builder.Provider.ProjectManager.ProjectManager.loadConfig();
            //this.get('/MidPropTree').hideWin();
            //this.get('/RightPalete').hide();
            //this.get('/BottomPane').el.hide();
            //this.get('/Editor').el.show_all();
        
        } );
        this.el.delete_event.connect(   (   event) => {
            return false;
        } );
    }

    // userdefined functions 

    // skip listeners - not pipe 

    // skip .Xcls_WindowLeftTree:left_tree - already used 

    // skip .string:title - already used 

    // skip border_width - already used 

    // skip default_height - already used 

    // skip default_width - already used 

    // skip destroy - not pipe 

    // skip id - not pipe 

    // skip xtype - not pipe 

    // skip |init - already used 

    // skip |type - already used 
    public void setTitle (string str) {
            this.el.set_title(this.title + " - " + str);
        }
    public void show() {
            this.left_tree =new Xcls_WindowLeftTree();
            _this.vbox.el.pack_start(this.left_tree.el,true, true,0);
            this.el.show_all();
        
        }

    // skip |xns - no return type

    // skip items - not pipe 

    // skip xvala_cls - not pipe 

    // skip xvala_xcls - not pipe 

    // skip xvala_id - not pipe 
    public class Xcls_vbox
    {
        public Gtk.VBox el;
        private Xcls_MainWindow  _this;


            // my vars

            // ctor 
        public Xcls_vbox(Xcls_MainWindow _owner)
        {
            this.el = new Gtk.VBox( true, 0 );
            _this = _owner;
            _this.vbox = this;

            // my vars

            // set gobject values
        }

        // userdefined functions 

        // skip id - not pipe 

        // skip xtype - not pipe 

        // skip |xns - no return type

        // skip xvala_cls - not pipe 

        // skip xvala_xcls - not pipe 

        // skip xvala_id - not pipe 
    }
}
