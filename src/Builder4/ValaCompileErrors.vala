static Xcls_ValaCompileErrors  _ValaCompileErrors;

public class Xcls_ValaCompileErrors : Object 
{
    public Gtk.Popover el;
    private Xcls_ValaCompileErrors  _this;

    public static Xcls_ValaCompileErrors singleton()
    {
        if (_ValaCompileErrors == null) {
            _ValaCompileErrors= new Xcls_ValaCompileErrors();
        }
        return _ValaCompileErrors;
    }
    public Xcls_compile_view compile_view;
    public Xcls_compile_tree compile_tree;
    public Xcls_compile_result_store compile_result_store;
    public Xcls_renderer renderer;

        // my vars (def)

    // ctor 
    public Xcls_ValaCompileErrors()
    {
        _this = this;
        this.el = new Gtk.Popover();

        // my vars (dec)
        var child_0 = new Xcls_compile_view( _this );
        child_0.ref();
        this.el.add (  child_0.el  );
    }

    // user defined functions 
    public void loadErrors (Json.Object tree) {
       Gtk.TreeIter piter;
        //print("looking for %s\n", id);
        // loop through parent childnre
          
        Gtk.TreeIter iter;
        Gtk.TreeIter citer;  
        
        var store = this.compile_result_store;    
        
        store.clear();
     
        
        tree.foreach_member((obj, file, node) => {
            // id line "display text", file
            
            var title = GLib.Path.get_basename( file) ;
            
            store.append(out iter, null);
            store.set(iter, 0, file, 1, 0, 2, title, 3, file,-1);
            var lines = tree.get_object_member(file);
            lines.foreach_member((obja, line, nodea) => {
                var msg  = "";
                var ar = lines.get_array_member(line);
                for (var i = 0 ; i < ar.get_length(); i++) {
    		    msg += (msg.length > 0) ? "\n" : "";
    		    msg += ar.get_string_element(i);
    	    }
                store.append(out citer, iter);
                store.set(iter, 
                    0, file + ":" + line, 
                    1, int.parse(line), 
                    2, GLib.Markup.escape_text(line + ": " + msg), 
                    3, file,-1);
            
            });
            
            
        
        });     
             
         
          
        return   this.el.get_path(iter);
    
    }
    public class Xcls_compile_view : Object 
    {
        public Gtk.VBox el;
        private Xcls_ValaCompileErrors  _this;


            // my vars (def)

        // ctor 
        public Xcls_compile_view(Xcls_ValaCompileErrors _owner )
        {
            _this = _owner;
            _this.compile_view = this;
            this.el = new Gtk.VBox();

            // my vars (dec)
            var child_0 = new Xcls_HBox3( _this );
            child_0.ref();
            this.el.pack_start (  child_0.el , false,false,0 );
            var child_1 = new Xcls_HPaned5( _this );
            child_1.ref();
            this.el.pack_start (  child_1.el , true,true,0 );
        }

        // user defined functions 
    }
    public class Xcls_HBox3 : Object 
    {
        public Gtk.HBox el;
        private Xcls_ValaCompileErrors  _this;


            // my vars (def)

        // ctor 
        public Xcls_HBox3(Xcls_ValaCompileErrors _owner )
        {
            _this = _owner;
            this.el = new Gtk.HBox();

            // my vars (dec)
            var child_0 = new Xcls_Button4( _this );
            child_0.ref();
            this.el.pack_start (  child_0.el , true,true,0 );
        }

        // user defined functions 
    }
    public class Xcls_Button4 : Object 
    {
        public Gtk.Button el;
        private Xcls_ValaCompileErrors  _this;


            // my vars (def)

        // ctor 
        public Xcls_Button4(Xcls_ValaCompileErrors _owner )
        {
            _this = _owner;
            this.el = new Gtk.Button();

            // my vars (dec)
        }

        // user defined functions 
    }
    public class Xcls_HPaned5 : Object 
    {
        public Gtk.HPaned el;
        private Xcls_ValaCompileErrors  _this;


            // my vars (def)

        // ctor 
        public Xcls_HPaned5(Xcls_ValaCompileErrors _owner )
        {
            _this = _owner;
            this.el = new Gtk.HPaned();

            // my vars (dec)
            var child_0 = new Xcls_ScrolledWindow6( _this );
            child_0.ref();
            this.el.add (  child_0.el  );
            var child_1 = new Xcls_ScrolledWindow11( _this );
            child_1.ref();
            this.el.add (  child_1.el  );
        }

        // user defined functions 
    }
    public class Xcls_ScrolledWindow6 : Object 
    {
        public Gtk.ScrolledWindow el;
        private Xcls_ValaCompileErrors  _this;


            // my vars (def)

        // ctor 
        public Xcls_ScrolledWindow6(Xcls_ValaCompileErrors _owner )
        {
            _this = _owner;
            this.el = new Gtk.ScrolledWindow();

            // my vars (dec)
            var child_0 = new Xcls_compile_tree( _this );
            child_0.ref();
            this.el.add (  child_0.el  );

            // init method 

            {
             this.el.set_policy (Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC);
             
            
            }
        }

        // user defined functions 
    }
    public class Xcls_compile_tree : Object 
    {
        public Gtk.TreeView el;
        private Xcls_ValaCompileErrors  _this;


            // my vars (def)

        // ctor 
        public Xcls_compile_tree(Xcls_ValaCompileErrors _owner )
        {
            _this = _owner;
            _this.compile_tree = this;
            this.el = new Gtk.TreeView();

            // my vars (dec)
            var child_0 = new Xcls_compile_result_store( _this );
            child_0.ref();
            this.el.set_model (  child_0.el  );
            var child_1 = new Xcls_column( _this );
            child_1.ref();
            this.el.append_column (  child_1.el  );
        }

        // user defined functions 
    }
    public class Xcls_compile_result_store : Object 
    {
        public Gtk.TreeStore el;
        private Xcls_ValaCompileErrors  _this;


            // my vars (def)

        // ctor 
        public Xcls_compile_result_store(Xcls_ValaCompileErrors _owner )
        {
            _this = _owner;
            _this.compile_result_store = this;
            this.el = new Gtk.TreeStore();

            // my vars (dec)
        }

        // user defined functions 
    }
    public class Xcls_column : Object 
    {
        public Gtk.TreeViewColumn el;
        private Xcls_ValaCompileErrors  _this;


            // my vars (def)

        // ctor 
        public Xcls_column(Xcls_ValaCompileErrors _owner )
        {
            _this = _owner;
            this.el = new Gtk.TreeViewColumn();

            // my vars (dec)
            var child_0 = new Xcls_renderer( _this );
            child_0.ref();
            this.el.pack_start (  child_0.el , true );

            // init method 

            {
              this.el.add_attribute(_this.renderer.el , "markup", 2 );
             
            }
        }

        // user defined functions 
    }
    public class Xcls_renderer : Object 
    {
        public Gtk.CellRendererText el;
        private Xcls_ValaCompileErrors  _this;


            // my vars (def)

        // ctor 
        public Xcls_renderer(Xcls_ValaCompileErrors _owner )
        {
            _this = _owner;
            _this.renderer = this;
            this.el = new Gtk.CellRendererText();

            // my vars (dec)
        }

        // user defined functions 
    }
    public class Xcls_ScrolledWindow11 : Object 
    {
        public Gtk.ScrolledWindow el;
        private Xcls_ValaCompileErrors  _this;


            // my vars (def)

        // ctor 
        public Xcls_ScrolledWindow11(Xcls_ValaCompileErrors _owner )
        {
            _this = _owner;
            this.el = new Gtk.ScrolledWindow();

            // my vars (dec)
            var child_0 = new Xcls_SourceView12( _this );
            child_0.ref();
            this.el.add (  child_0.el  );
        }

        // user defined functions 
    }
    public class Xcls_SourceView12 : Object 
    {
        public Gtk.SourceView el;
        private Xcls_ValaCompileErrors  _this;


            // my vars (def)

        // ctor 
        public Xcls_SourceView12(Xcls_ValaCompileErrors _owner )
        {
            _this = _owner;
            this.el = new Gtk.SourceView();

            // my vars (dec)
        }

        // user defined functions 
    }
}