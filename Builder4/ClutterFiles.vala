/* -- to compile
valac  --pkg gio-2.0  --pkg posix  --pkg gtk+-3.0 --pkg libnotify --pkg gtksourceview-3.0  --pkg  libwnck-3.0 \
    /tmp/ClutterFiles.vala  -o /tmp/ClutterFiles
*/


/* -- to test class
static int main (string[] args) {
    Gtk.init (ref args);
    new Xcls_ClutterFiles();
    ClutterFiles.show_all();
     Gtk.main ();
    return 0;
}
*/


public static Xcls_ClutterFiles  ClutterFiles;

public class Xcls_ClutterFiles : Object 
{
    public Clutter.ScrollActor el;
    private Xcls_ClutterFiles  _this;

    public Xcls_filelayout filelayout;
    public Xcls_filelayout_manager filelayout_manager;

        // my vars
    public signal void open(JsRender.JsRender file);

        // ctor 
    public Xcls_ClutterFiles()
    {
        _this = this;
        ClutterFiles = this;
        this.el = new Clutter.ScrollActor();

        // my vars

        // set gobject values
        this.el.reactive = true;
        var child_0 = new Xcls_filelayout( _this );
        child_0.ref();
        this.el.add_child (  child_0.el  );

        // init method 
        this.fileitems = new Gee.ArrayList<Xcls_fileitem>();
    }

    // userdefined functions 
    public void clearFiles() {
            
            this.filelayout.el.remove_all_children();
            // we need to unref all the chidren that we loaded though...
            
        }
    public void loadProject(Project.Project pr) {
            // list all the files, and create new Xcls_fileitem for each one.
            
            // LEAK --- we should unref all the chilren...
            this.clearFiles();
            
            print("clutter files - load project: " + pr.name +"\n");
            // should unref.. them hopefully.
            this.fileitems = new Gee.ArrayList<Xcls_fileitem>();
        
            var fiter = pr.files.map_iterator();
            while (fiter.next()) {
                var a = new Xcls_fileitem(this,fiter.get_value());
                this.fileitems.add(a);
        
        //        a.ref();
                print("add to clutter file view: " + fiter.get_value().name + "\n");
                this.filelayout.el.add_child(a.el);
            }
            this.el.show_all();
        }
    public void set_size(float w, float h) 
        {
             if (this.el == null) {
                print("object not ready yet?");
                return;
            }
           _this.filelayout_manager.el.max_column_width = w - 150;
           this.el.set_size(this.el.get_stage().width-150,
                                this.el.get_stage().height);
                    this.el.set_position(100,50);
        }

    // skip |xns - no return type
    public class Xcls_filelayout : Object 
    {
        public Clutter.Actor el;
        private Xcls_ClutterFiles  _this;


            // my vars

            // ctor 
        public Xcls_filelayout(Xcls_ClutterFiles _owner )
        {
            _this = _owner;
            _this.filelayout = this;
            this.el = new Clutter.Actor();

            // my vars

            // set gobject values
            this.el.reactive = true;
            var child_0 = new Xcls_filelayout_manager( _this );
            child_0.ref();
            this.el.layout_manager = child_0.el;

            // init method 
            this.el.add_constraint(
                new Clutter.BindConstraint(_this.el,Clutter.BindCoordinate.SIZE, 0.0f)
            );
        }

        // userdefined functions 

        // skip |xns - no return type
    }
    public class Xcls_filelayout_manager : Object 
    {
        public Clutter.FlowLayout el;
        private Xcls_ClutterFiles  _this;


            // my vars

            // ctor 
        public Xcls_filelayout_manager(Xcls_ClutterFiles _owner )
        {
            _this = _owner;
            _this.filelayout_manager = this;
            this.el = new Clutter.FlowLayout( Clutter.FlowOrientation.HORIZONTAL );

            // my vars

            // set gobject values
            this.el.column_spacing = 20;
            this.el.homogeneous = true;
            this.el.row_spacing = 20;
        }

        // userdefined functions 

        // skip |xns - no return type
    }
    public class Xcls_fileitem : Object 
    {
        public Clutter.Actor el;
        private Xcls_ClutterFiles  _this;


            // my vars
        public JsRender.JsRender file;
        public Xcls_image image;
        public Xcls_typetitle typetitle;
        public Xcls_title title;

            // ctor 
        public Xcls_fileitem(Xcls_ClutterFiles _owner , JsRender.JsRender file)
        {
            _this = _owner;
            this.el = new Clutter.Actor();

            // my vars

            // set gobject values
            this.el.reactive = true;
            var child_0 = new Xcls_BoxLayout5( _this );
            child_0.ref();
            this.el.layout_manager = child_0.el;
            var child_1 = new Xcls_image( _this ,file);
            child_1.ref();
            this.el.add_child (  child_1.el  );
            this.image =  child_1;
            var child_2 = new Xcls_typetitle( _this ,file);
            child_2.ref();
            this.el.add_child (  child_2.el  );
            this.typetitle =  child_2;
            var child_3 = new Xcls_title( _this ,file);
            child_3.ref();
            this.el.add_child (  child_3.el  );
            this.title =  child_3;

            // init method 
            this.file = file;
            this.el.set_size(100,100);

            // listeners 
            this.el.enter_event.connect( (  event)  => {
                this.el.background_color = new Clutter.Color.from_string("#333");
                    return false;
            } );
            this.el.leave_event.connect( (  event)  => {
                this.el.background_color = new Clutter.Color.from_string("#000");
                return false;
            } );
            this.el.button_press_event.connect(   (  event) => {
                _this.open(this.file);
                return false;
            } );
        }

        // userdefined functions 

        // skip |xns - no return type
    }
    public class Xcls_BoxLayout5 : Object 
    {
        public Clutter.BoxLayout el;
        private Xcls_ClutterFiles  _this;


            // my vars

            // ctor 
        public Xcls_BoxLayout5(Xcls_ClutterFiles _owner )
        {
            _this = _owner;
            this.el = new Clutter.BoxLayout();

            // my vars

            // set gobject values
            this.el.orientation = Clutter.Orientation.VERTICAL;
            this.el.spacing = 4;
        }

        // userdefined functions 

        // skip |xns - no return type
    }
    public class Xcls_image : Object 
    {
        public Clutter.Texture el;
        private Xcls_ClutterFiles  _this;


            // my vars

            // ctor 
        public Xcls_image(Xcls_ClutterFiles _owner , JsRender.JsRender file)
        {
            _this = _owner;
            this.el = new Clutter.Texture.from_file(file.getIconFileName(true));

            // my vars

            // set gobject values
            this.el.margin_left = 5;
            this.el.margin_right = 5;
            this.el.margin_top = 5;
            this.el.x_align = Clutter.ActorAlign.START;
            this.el.x_expand = true;
            this.el.y_align = Clutter.ActorAlign.START;
            this.el.y_expand = false;
        }

        // userdefined functions 

        // skip |xns - no return type
    }
    public class Xcls_typetitle : Object 
    {
        public Clutter.Text el;
        private Xcls_ClutterFiles  _this;


            // my vars

            // ctor 
        public Xcls_typetitle(Xcls_ClutterFiles _owner , JsRender.JsRender file)
        {
            _this = _owner;
            this.el = new Clutter.Text.full("Sans 10px", file.nickType(),new Clutter.Color.from_string("#fff"));

            // my vars

            // set gobject values
            this.el.x_align = Clutter.ActorAlign.START;
            this.el.x_expand = true;
            this.el.y_align = Clutter.ActorAlign.START;
            this.el.y_expand = false;
        }

        // userdefined functions 

        // skip |xns - no return type
    }
    public class Xcls_title : Object 
    {
        public Clutter.Text el;
        private Xcls_ClutterFiles  _this;


            // my vars

            // ctor 
        public Xcls_title(Xcls_ClutterFiles _owner , JsRender.JsRender file)
        {
            _this = _owner;
            this.el = new Clutter.Text.full("Sans 10px", file.nickName(),new Clutter.Color.from_string("#fff"));

            // my vars

            // set gobject values
            this.el.x_align = Clutter.ActorAlign.START;
            this.el.x_expand = true;
            this.el.y_align = Clutter.ActorAlign.START;
            this.el.y_expand = false;
        }

        // userdefined functions 

        // skip |xns - no return type
    }
}
