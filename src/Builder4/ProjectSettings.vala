static Xcls_ProjectSettings  _ProjectSettings;

public class Xcls_ProjectSettings : Object 
{
    public Gtk.VBox el;
    private Xcls_ProjectSettings  _this;

    public static Xcls_ProjectSettings singleton()
    {
        if (_ProjectSettings == null) {
            _ProjectSettings= new Xcls_ProjectSettings();
        }
        return _ProjectSettings;
    }
    public Xcls_label_global label_global;
    public Xcls_label_database label_database;
    public Xcls_path path;
    public Xcls_base_template base_template;
    public Xcls_rootURL rootURL;
    public Xcls_view view;
    public Xcls_database_DBTYPE database_DBTYPE;
    public Xcls_database_DBTYPE database_DBTYPE;
    public Xcls_database_DBUSERNAME database_DBUSERNAME;
    public Xcls_database_DBPASSWORD database_DBPASSWORD;

        // my vars (def)
    public signal void buttonPressed (string btn);
    public Project.Project project;

    // ctor 
    public Xcls_ProjectSettings()
    {
        _this = this;
        this.el = new Gtk.VBox( false, 0 );

        // my vars (dec)

        // set gobject values
        this.el.border_width = 5;
        var child_0 = new Xcls_HBox2( _this );
        child_0.ref();
        this.el.pack_start (  child_0.el , false,false,0 );
        var child_1 = new Xcls_Notebook5( _this );
        child_1.ref();
        this.el.pack_end (  child_1.el , true,true,0 );
    }

    // user defined functions 
    public void show (Project.Project project) {
        _this.project = project;
        _this.path.el.label = project.firstPath();
        // get the active project.
         var lm = Gtk.SourceLanguageManager.get_default();
                    
        ((Gtk.SourceBuffer)(_this.view.el.get_buffer())) .set_language(
        
            lm.get_language("html"));
      
        //print (project.fn);
        //project.runhtml = project.runhtml || '';
        _this.view.el.get_buffer().set_text(project.runhtml);
        
           
        _this.rootURL.el.set_text( _this.project.rootURL );
        _this.base_template.el.set_text(_this.project.base_template);    
       
        
        //this.el.show_all();
    }
    public void save ()
    {
       var buf =    _this.view.el.get_buffer();
       Gtk.TextIter s;
         Gtk.TextIter e;
        buf.get_start_iter(out s);
        buf.get_end_iter(out e);
          _this.project.runhtml = buf.get_text(s,e,true);
          
        _this.project.rootURL = _this.rootURL.el.get_text();
        _this.project.base_template = _this.base_template.el.get_text();    
        
        
    }
    public class Xcls_HBox2 : Object 
    {
        public Gtk.HBox el;
        private Xcls_ProjectSettings  _this;


            // my vars (def)

        // ctor 
        public Xcls_HBox2(Xcls_ProjectSettings _owner )
        {
            _this = _owner;
            this.el = new Gtk.HBox( true, 0 );

            // my vars (dec)

            // set gobject values
            this.el.expand = false;
            this.el.vexpand = false;
            var child_0 = new Xcls_Button3( _this );
            child_0.ref();
            this.el.add (  child_0.el  );
            var child_1 = new Xcls_Button4( _this );
            child_1.ref();
            this.el.add (  child_1.el  );
        }

        // user defined functions 
    }
    public class Xcls_Button3 : Object 
    {
        public Gtk.Button el;
        private Xcls_ProjectSettings  _this;


            // my vars (def)

        // ctor 
        public Xcls_Button3(Xcls_ProjectSettings _owner )
        {
            _this = _owner;
            this.el = new Gtk.Button();

            // my vars (dec)

            // set gobject values
            this.el.label = "Apply";

            // listeners 
            this.el.button_press_event.connect( () => {
                _this.save();
                      
                _this.buttonPressed("apply");
                    return false;
            });
        }

        // user defined functions 
    }
    public class Xcls_Button4 : Object 
    {
        public Gtk.Button el;
        private Xcls_ProjectSettings  _this;


            // my vars (def)

        // ctor 
        public Xcls_Button4(Xcls_ProjectSettings _owner )
        {
            _this = _owner;
            this.el = new Gtk.Button();

            // my vars (dec)

            // set gobject values
            this.el.label = "Save";

            // listeners 
            this.el.button_press_event.connect( () => {
                   _this.save();
                      
                _this.buttonPressed("save");
                    return false;
            });
        }

        // user defined functions 
    }
    public class Xcls_Notebook5 : Object 
    {
        public Gtk.Notebook el;
        private Xcls_ProjectSettings  _this;


            // my vars (def)

        // ctor 
        public Xcls_Notebook5(Xcls_ProjectSettings _owner )
        {
            _this = _owner;
            this.el = new Gtk.Notebook();

            // my vars (dec)

            // set gobject values
            var child_0 = new Xcls_label_global( _this );
            child_0.ref();
            var child_1 = new Xcls_label_database( _this );
            child_1.ref();
            var child_2 = new Xcls_VBox8( _this );
            child_2.ref();
            this.el.append_page (  child_2.el , _this.label_global.el );
            var child_3 = new Xcls_VBox19( _this );
            child_3.ref();
            this.el.append_page (  child_3.el , _this.label_database.el );
        }

        // user defined functions 
    }
    public class Xcls_label_global : Object 
    {
        public Gtk.Label el;
        private Xcls_ProjectSettings  _this;


            // my vars (def)

        // ctor 
        public Xcls_label_global(Xcls_ProjectSettings _owner )
        {
            _this = _owner;
            _this.label_global = this;
            this.el = new Gtk.Label( "Global" );

            // my vars (dec)

            // set gobject values
        }

        // user defined functions 
    }
    public class Xcls_label_database : Object 
    {
        public Gtk.Label el;
        private Xcls_ProjectSettings  _this;


            // my vars (def)

        // ctor 
        public Xcls_label_database(Xcls_ProjectSettings _owner )
        {
            _this = _owner;
            _this.label_database = this;
            this.el = new Gtk.Label( "Database" );

            // my vars (dec)

            // set gobject values
        }

        // user defined functions 
    }
    public class Xcls_VBox8 : Object 
    {
        public Gtk.VBox el;
        private Xcls_ProjectSettings  _this;


            // my vars (def)

        // ctor 
        public Xcls_VBox8(Xcls_ProjectSettings _owner )
        {
            _this = _owner;
            this.el = new Gtk.VBox( false, 0 );

            // my vars (dec)

            // set gobject values
            var child_0 = new Xcls_path( _this );
            child_0.ref();
            this.el.pack_start (  child_0.el , false,false,0 );
            var child_1 = new Xcls_Label10( _this );
            child_1.ref();
            this.el.pack_start (  child_1.el , false,false,0 );
            var child_2 = new Xcls_HBox11( _this );
            child_2.ref();
            this.el.pack_start (  child_2.el , false,false,0 );
            var child_3 = new Xcls_HBox14( _this );
            child_3.ref();
            this.el.pack_start (  child_3.el , false,false,0 );
            var child_4 = new Xcls_ScrolledWindow17( _this );
            child_4.ref();
            this.el.pack_start (  child_4.el , true,true,0 );
        }

        // user defined functions 
    }
    public class Xcls_path : Object 
    {
        public Gtk.Label el;
        private Xcls_ProjectSettings  _this;


            // my vars (def)

        // ctor 
        public Xcls_path(Xcls_ProjectSettings _owner )
        {
            _this = _owner;
            _this.path = this;
            this.el = new Gtk.Label( "filename" );

            // my vars (dec)

            // set gobject values
            this.el.xalign = 0f;
        }

        // user defined functions 
    }
    public class Xcls_Label10 : Object 
    {
        public Gtk.Label el;
        private Xcls_ProjectSettings  _this;


            // my vars (def)

        // ctor 
        public Xcls_Label10(Xcls_ProjectSettings _owner )
        {
            _this = _owner;
            this.el = new Gtk.Label( "HTML To insert at end of <HEAD>" );

            // my vars (dec)

            // set gobject values
        }

        // user defined functions 
    }
    public class Xcls_HBox11 : Object 
    {
        public Gtk.HBox el;
        private Xcls_ProjectSettings  _this;


            // my vars (def)

        // ctor 
        public Xcls_HBox11(Xcls_ProjectSettings _owner )
        {
            _this = _owner;
            this.el = new Gtk.HBox( false, 0 );

            // my vars (dec)

            // set gobject values
            this.el.expand = false;
            var child_0 = new Xcls_Label12( _this );
            child_0.ref();
            this.el.pack_start (  child_0.el , false,false,0 );
            var child_1 = new Xcls_base_template( _this );
            child_1.ref();
            this.el.add (  child_1.el  );
        }

        // user defined functions 
    }
    public class Xcls_Label12 : Object 
    {
        public Gtk.Label el;
        private Xcls_ProjectSettings  _this;


            // my vars (def)

        // ctor 
        public Xcls_Label12(Xcls_ProjectSettings _owner )
        {
            _this = _owner;
            this.el = new Gtk.Label( "HTML template file" );

            // my vars (dec)

            // set gobject values
        }

        // user defined functions 
    }
    public class Xcls_base_template : Object 
    {
        public Gtk.Entry el;
        private Xcls_ProjectSettings  _this;


            // my vars (def)

        // ctor 
        public Xcls_base_template(Xcls_ProjectSettings _owner )
        {
            _this = _owner;
            _this.base_template = this;
            this.el = new Gtk.Entry();

            // my vars (dec)

            // set gobject values
        }

        // user defined functions 
    }
    public class Xcls_HBox14 : Object 
    {
        public Gtk.HBox el;
        private Xcls_ProjectSettings  _this;


            // my vars (def)

        // ctor 
        public Xcls_HBox14(Xcls_ProjectSettings _owner )
        {
            _this = _owner;
            this.el = new Gtk.HBox( false, 0 );

            // my vars (dec)

            // set gobject values
            this.el.expand = false;
            var child_0 = new Xcls_Label15( _this );
            child_0.ref();
            this.el.pack_start (  child_0.el , false,false,0 );
            var child_1 = new Xcls_rootURL( _this );
            child_1.ref();
            this.el.add (  child_1.el  );
        }

        // user defined functions 
    }
    public class Xcls_Label15 : Object 
    {
        public Gtk.Label el;
        private Xcls_ProjectSettings  _this;


            // my vars (def)

        // ctor 
        public Xcls_Label15(Xcls_ProjectSettings _owner )
        {
            _this = _owner;
            this.el = new Gtk.Label( "root URL" );

            // my vars (dec)

            // set gobject values
        }

        // user defined functions 
    }
    public class Xcls_rootURL : Object 
    {
        public Gtk.Entry el;
        private Xcls_ProjectSettings  _this;


            // my vars (def)

        // ctor 
        public Xcls_rootURL(Xcls_ProjectSettings _owner )
        {
            _this = _owner;
            _this.rootURL = this;
            this.el = new Gtk.Entry();

            // my vars (dec)

            // set gobject values
        }

        // user defined functions 
    }
    public class Xcls_ScrolledWindow17 : Object 
    {
        public Gtk.ScrolledWindow el;
        private Xcls_ProjectSettings  _this;


            // my vars (def)

        // ctor 
        public Xcls_ScrolledWindow17(Xcls_ProjectSettings _owner )
        {
            _this = _owner;
            this.el = new Gtk.ScrolledWindow( null, null );

            // my vars (dec)

            // set gobject values
            var child_0 = new Xcls_view( _this );
            child_0.ref();
            this.el.add (  child_0.el  );
        }

        // user defined functions 
    }
    public class Xcls_view : Object 
    {
        public Gtk.SourceView el;
        private Xcls_ProjectSettings  _this;


            // my vars (def)

        // ctor 
        public Xcls_view(Xcls_ProjectSettings _owner )
        {
            _this = _owner;
            _this.view = this;
            this.el = new Gtk.SourceView();

            // my vars (dec)

            // set gobject values

            // init method 

            var description =   Pango.FontDescription.from_string("monospace");
                description.set_size(9000);
                this.el.override_font(description);

            // listeners 
            this.el.key_release_event.connect( ( event) =>{
                if (event.keyval != 115) {
                    return false;
                     
                }
                if   ( (event.state & Gdk.ModifierType.CONTROL_MASK ) < 1 ) {
                    return false;
                }
                 var buf =    this.el.get_buffer();
                Gtk.TextIter s;
                Gtk.TextIter e;
                buf.get_start_iter(out s);
                buf.get_end_iter(out e);
                _this.project.runhtml = buf.get_text(s,e,true);
                
                      
                _this.buttonPressed("save");
                 
                return false;
                     
            });
        }

        // user defined functions 
    }
    public class Xcls_VBox19 : Object 
    {
        public Gtk.VBox el;
        private Xcls_ProjectSettings  _this;


            // my vars (def)

        // ctor 
        public Xcls_VBox19(Xcls_ProjectSettings _owner )
        {
            _this = _owner;
            this.el = new Gtk.VBox( false, 0 );

            // my vars (dec)

            // set gobject values
            var child_0 = new Xcls_Label20( _this );
            child_0.ref();
            this.el.pack_start (  child_0.el , false,false,0 );
            var child_1 = new Xcls_database_DBTYPE( _this );
            child_1.ref();
            this.el.pack_start (  child_1.el , false,false,0 );
            var child_2 = new Xcls_Label22( _this );
            child_2.ref();
            this.el.pack_start (  child_2.el , false,false,0 );
            var child_3 = new Xcls_database_DBTYPE( _this );
            child_3.ref();
            this.el.pack_start (  child_3.el , false,false,0 );
            var child_4 = new Xcls_Label24( _this );
            child_4.ref();
            this.el.pack_start (  child_4.el , false,false,0 );
            var child_5 = new Xcls_database_DBUSERNAME( _this );
            child_5.ref();
            this.el.pack_start (  child_5.el , false,false,0 );
            var child_6 = new Xcls_Label26( _this );
            child_6.ref();
            this.el.pack_start (  child_6.el , false,false,0 );
            var child_7 = new Xcls_database_DBPASSWORD( _this );
            child_7.ref();
            this.el.pack_start (  child_7.el , false,false,0 );
            var child_8 = new Xcls_Button28( _this );
            child_8.ref();
            this.el.pack_start (  child_8.el , true,true,0 );
        }

        // user defined functions 
    }
    public class Xcls_Label20 : Object 
    {
        public Gtk.Label el;
        private Xcls_ProjectSettings  _this;


            // my vars (def)

        // ctor 
        public Xcls_Label20(Xcls_ProjectSettings _owner )
        {
            _this = _owner;
            this.el = new Gtk.Label( "Type (eg. MySQL or PostgreSQL)" );

            // my vars (dec)

            // set gobject values
            this.el.xalign = 0f;
        }

        // user defined functions 
    }
    public class Xcls_database_DBTYPE : Object 
    {
        public Gtk.Entry el;
        private Xcls_ProjectSettings  _this;


            // my vars (def)

        // ctor 
        public Xcls_database_DBTYPE(Xcls_ProjectSettings _owner )
        {
            _this = _owner;
            _this.database_DBTYPE = this;
            this.el = new Gtk.Entry();

            // my vars (dec)

            // set gobject values
        }

        // user defined functions 
    }
    public class Xcls_Label22 : Object 
    {
        public Gtk.Label el;
        private Xcls_ProjectSettings  _this;


            // my vars (def)

        // ctor 
        public Xcls_Label22(Xcls_ProjectSettings _owner )
        {
            _this = _owner;
            this.el = new Gtk.Label( "Name" );

            // my vars (dec)

            // set gobject values
            this.el.xalign = 0f;
        }

        // user defined functions 
    }
    public class Xcls_database_DBTYPE : Object 
    {
        public Gtk.Entry el;
        private Xcls_ProjectSettings  _this;


            // my vars (def)

        // ctor 
        public Xcls_database_DBTYPE(Xcls_ProjectSettings _owner )
        {
            _this = _owner;
            _this.database_DBTYPE = this;
            this.el = new Gtk.Entry();

            // my vars (dec)

            // set gobject values
        }

        // user defined functions 
    }
    public class Xcls_Label24 : Object 
    {
        public Gtk.Label el;
        private Xcls_ProjectSettings  _this;


            // my vars (def)

        // ctor 
        public Xcls_Label24(Xcls_ProjectSettings _owner )
        {
            _this = _owner;
            this.el = new Gtk.Label( "Username" );

            // my vars (dec)

            // set gobject values
            this.el.xalign = 0f;
        }

        // user defined functions 
    }
    public class Xcls_database_DBUSERNAME : Object 
    {
        public Gtk.Entry el;
        private Xcls_ProjectSettings  _this;


            // my vars (def)

        // ctor 
        public Xcls_database_DBUSERNAME(Xcls_ProjectSettings _owner )
        {
            _this = _owner;
            _this.database_DBUSERNAME = this;
            this.el = new Gtk.Entry();

            // my vars (dec)

            // set gobject values
        }

        // user defined functions 
    }
    public class Xcls_Label26 : Object 
    {
        public Gtk.Label el;
        private Xcls_ProjectSettings  _this;


            // my vars (def)

        // ctor 
        public Xcls_Label26(Xcls_ProjectSettings _owner )
        {
            _this = _owner;
            this.el = new Gtk.Label( "Password" );

            // my vars (dec)

            // set gobject values
            this.el.xalign = 0f;
        }

        // user defined functions 
    }
    public class Xcls_database_DBPASSWORD : Object 
    {
        public Gtk.Entry el;
        private Xcls_ProjectSettings  _this;


            // my vars (def)

        // ctor 
        public Xcls_database_DBPASSWORD(Xcls_ProjectSettings _owner )
        {
            _this = _owner;
            _this.database_DBPASSWORD = this;
            this.el = new Gtk.Entry();

            // my vars (dec)

            // set gobject values
        }

        // user defined functions 
    }
    public class Xcls_Button28 : Object 
    {
        public Gtk.Button el;
        private Xcls_ProjectSettings  _this;


            // my vars (def)

        // ctor 
        public Xcls_Button28(Xcls_ProjectSettings _owner )
        {
            _this = _owner;
            this.el = new Gtk.Button();

            // my vars (dec)

            // set gobject values
        }

        // user defined functions 
    }
}
