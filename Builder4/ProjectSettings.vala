/* -- to compile
valac  --pkg gio-2.0  --pkg posix  --pkg gtk+-3.0 --pkg libnotify --pkg gtksourceview-3.0  --pkg  libwnck-3.0 \
    /tmp/ProjectSettings.vala  -o /tmp/ProjectSettings
*/


/* -- to test class
static int main (string[] args) {
    Gtk.init (ref args);
    new Xcls_ProjectSettings();
    ProjectSettings.show_all();
     Gtk.main ();
    return 0;
}
*/


public static Xcls_ProjectSettings  ProjectSettings;

public class Xcls_ProjectSettings : Object 
{
    public Gtk.VBox el;
    private Xcls_ProjectSettings  _this;

    public Xcls_view view;

        // my vars
    public signal void buttonPressed(string btn);
    public Project.Project project;

        // ctor 
    public Xcls_ProjectSettings()
    {
        _this = this;
        ProjectSettings = this;
        this.el = new Gtk.VBox( false, 0 );

        // my vars

        // set gobject values
        this.el.border_width = 5;
        var child_0 = new Xcls_HBox2( _this );
        child_0.ref();
        this.el.pack_end (  child_0.el , false,false,0 );
        var child_1 = new Xcls_Label6( _this );
        child_1.ref();
        this.el.pack_start (  child_1.el , false,false,0 );
        var child_2 = new Xcls_ScrolledWindow7( _this );
        child_2.ref();
        this.el.pack_start (  child_2.el , true,true,0 );
    }

    // userdefined functions 
    public void show (Project.Project project) {
            _this.project = project;
            // get the active project.
            
            //print (project.fn);
            //project.runhtml = project.runhtml || '';
            _this.view.el.get_buffer().set_text(project.runhtml);
            
            //this.el.show_all();
        }

    // skip |xns - no return type
    public class Xcls_HBox2 : Object 
    {
        public Gtk.HBox el;
        private Xcls_ProjectSettings  _this;


            // my vars

            // ctor 
        public Xcls_HBox2(Xcls_ProjectSettings _owner )
        {
            _this = _owner;
            this.el = new Gtk.HBox( false, 0 );

            // my vars

            // set gobject values
            var child_0 = new Xcls_Button3( _this );
            child_0.ref();
            this.el.add (  child_0.el  );
            var child_1 = new Xcls_Button4( _this );
            child_1.ref();
            this.el.add (  child_1.el  );
            var child_2 = new Xcls_Button5( _this );
            child_2.ref();
            this.el.add (  child_2.el  );
        }

        // userdefined functions 

        // skip |xns - no return type
    }
    public class Xcls_Button3 : Object 
    {
        public Gtk.Button el;
        private Xcls_ProjectSettings  _this;


            // my vars

            // ctor 
        public Xcls_Button3(Xcls_ProjectSettings _owner )
        {
            _this = _owner;
            this.el = new Gtk.Button();

            // my vars

            // set gobject values
            this.el.label = "Cancel";

            // listeners 
            this.el.button_press_event.connect( () => {
                _this.buttonPressed("cancel");
                return false;
            } );
        }

        // userdefined functions 

        // skip |xns - no return type
    }
    public class Xcls_Button4 : Object 
    {
        public Gtk.Button el;
        private Xcls_ProjectSettings  _this;


            // my vars

            // ctor 
        public Xcls_Button4(Xcls_ProjectSettings _owner )
        {
            _this = _owner;
            this.el = new Gtk.Button();

            // my vars

            // set gobject values
            this.el.label = "Apply";

            // listeners 
            this.el.button_press_event.connect( () => {
                var buf =    _this.view.el.get_buffer();
               Gtk.TextIter s;
                 Gtk.TextIter e;
                buf.get_start_iter(out s);
                buf.get_end_iter(out e);
                  _this.project.runhtml = buf.get_text(s,e,true);
                
                      
                _this.buttonPressed("apply");
                    return false;
            } );
        }

        // userdefined functions 

        // skip |xns - no return type
    }
    public class Xcls_Button5 : Object 
    {
        public Gtk.Button el;
        private Xcls_ProjectSettings  _this;


            // my vars

            // ctor 
        public Xcls_Button5(Xcls_ProjectSettings _owner )
        {
            _this = _owner;
            this.el = new Gtk.Button();

            // my vars

            // set gobject values
            this.el.label = "Save";

            // listeners 
            this.el.button_press_event.connect( () => {
                var buf =    _this.view.el.get_buffer();
                Gtk.TextIter s;
                Gtk.TextIter e;
                buf.get_start_iter(out s);
                buf.get_end_iter(out e);
                _this.project.runhtml = buf.get_text(s,e,true);
                
                      
                _this.buttonPressed("save");
                    return false;
            } );
        }

        // userdefined functions 

        // skip |xns - no return type
    }
    public class Xcls_Label6 : Object 
    {
        public Gtk.Label el;
        private Xcls_ProjectSettings  _this;


            // my vars

            // ctor 
        public Xcls_Label6(Xcls_ProjectSettings _owner )
        {
            _this = _owner;
            this.el = new Gtk.Label( "HTML To insert at end of <HEAD>" );

            // my vars

            // set gobject values
        }

        // userdefined functions 

        // skip |xns - no return type
    }
    public class Xcls_ScrolledWindow7 : Object 
    {
        public Gtk.ScrolledWindow el;
        private Xcls_ProjectSettings  _this;


            // my vars

            // ctor 
        public Xcls_ScrolledWindow7(Xcls_ProjectSettings _owner )
        {
            _this = _owner;
            this.el = new Gtk.ScrolledWindow( null, null );

            // my vars

            // set gobject values
            var child_0 = new Xcls_view( _this );
            child_0.ref();
            this.el.add (  child_0.el  );
        }

        // userdefined functions 

        // skip |xns - no return type
    }
    public class Xcls_view : Object 
    {
        public Gtk.SourceView el;
        private Xcls_ProjectSettings  _this;


            // my vars

            // ctor 
        public Xcls_view(Xcls_ProjectSettings _owner )
        {
            _this = _owner;
            _this.view = this;
            this.el = new Gtk.SourceView();

            // my vars

            // set gobject values
        }

        // userdefined functions 

        // skip |xns - no return type
    }
}
