static Xcls_DialogPluginWebkit  _DialogPluginWebkit;

public class Xcls_DialogPluginWebkit : Object 
{
    public Gtk.Dialog el;
    private Xcls_DialogPluginWebkit  _this;

    public static Xcls_DialogPluginWebkit singleton()
    {
        if (_DialogPluginWebkit == null) {
            _DialogPluginWebkit= new Xcls_DialogPluginWebkit();
        }
        return _DialogPluginWebkit;
    }
    public Xcls_webview webview;

        // my vars (def)
    public string tmpjs;
    public string result_json;

    // ctor 
    public Xcls_DialogPluginWebkit()
    {
        _this = this;
        this.el = new Gtk.Dialog();

        // my vars (dec)

        // set gobject values
        this.el.title = "Add / Edit Component";
        this.el.default_height = 500;
        this.el.default_width = 500;
        this.el.deletable = true;
        this.el.modal = true;
        var child_0 = new Xcls_VBox2( _this );
        child_0.ref();
        this.el.get_content_area().add (  child_0.el  );
        var child_1 = new Xcls_Button5( _this );
        child_1.ref();
        this.el.add_action_widget (  child_1.el , 3 );
        var child_2 = new Xcls_Button6( _this );
        child_2.ref();
        this.el.add_action_widget (  child_2.el , 0 );
        var child_3 = new Xcls_Button7( _this );
        child_3.ref();
        this.el.add_action_widget (  child_3.el , 1 );

        // listeners 
        this.el.delete_event.connect( (self, event) => {
            this.el.hide();
            return true; 
            //test  
        });
    }

    // user defined functions 
    public string show (Gtk.Window ?parent, Project.Project project, string cls, string tbl) {// JsRender.Node node) {
     
        if (parent  != null) {
            this.el.set_transient_for(parent);
            this.el.modal = true;
        }
        this.result_json = "";
         var  db = project.roo_database;
         
        
         this.el.show_all();
         var   ret = "";
         while (true) {
        
            var runhtml = "<script type=\"text/javascript\">\n" ;
            string builderhtml;
            
            
            GLib.FileUtils.get_contents(BuilderApplication.configDirectory() + "/resources/roo.builder.js", out builderhtml);
    
            runhtml += builderhtml + "\n";
            
            
            runhtml += "\n" +
                "Builder.saveHTML = function() {};\n" + 
    	    "Roo.onReady(function() {\n" +
    
    	    "Roo.XComponent.build();\n" +
    	    "});\n";
    	
    	
            
    
            var ar = db.readForeignKeys(tbl);
            var  generator = new Json.Generator ();
            var  root = new Json.Node(Json.NodeType.OBJECT);
            root.init_object(ar);
            generator.set_root (root);
            
            generator.pretty = true;
            generator.indent = 4;
            
            runhtml += "\n" +
            " Roo.XComponent.on('buildcomplete', function() {\n" +
             "    Editor." + cls + ".panel.loadData(" + generator.to_data (null) + "); " +
            "});\n";
    
            
    	
    	
    
            runhtml += "</script>\n" ;
    
            print(runhtml);
            // fix to make sure they are the same..
            
            // need to modify paths
    
            string inhtml;
            
            GLib.FileUtils.get_contents(
                BuilderApplication.configDirectory() + "/resources/roo.builder.html"
                    , out inhtml);
            
            
            // fetch the json from the database...
            
            //print(runhtml);
            
            var html = inhtml.replace("</head>", runhtml + // + this.runhtml + 
                "<script type=\"text/javascript\" src=\"resources://localhost/Editors/Editor." + cls + ".js\"></script>" + 
          
                            
            "</head>");
            //print("LOAD HTML " + html);
            
             //var rootURL = _this.file.project.rootURL;
       
            
            
            this.webview.el.load_html( html , 
                //fixme - should be a config option!
                "xhttp://localhost/app.Builder.js/"
            );
        
            
        
       
             var response_id = this.el.run();
            
             if (response_id == 1) { // OK...
                 var loop = new MainLoop();
                 // run toBJS to get the data... (calls back into alert handler)
                   this.webview.el.run_javascript.begin("Editor." + cls + ".panel.toBJS();", null, (obj, res) => {
    
                     this.webview.el.run_javascript.end(res);
    
                        loop.quit();
                    });
                 loop.run();
                 ret = _this.result_json;
        //           print("LOOP END?");
                 // try and get the resopse...
                break;
             }
            if (response_id < 1) {
                this.el.hide();
                 return "";
            }
            // keep showing...?
            continue;
        }
        
        // now we save it..
        this.el.hide();
        
        return ret;
        
        
        
    }
    public bool has_plugin (string cls) {
    
         return GLib.FileUtils.test(
                BuilderApplication.configDirectory() + "/resources/Editors/Editor." + cls + ".js",
                GLib.FileTest.IS_REGULAR
          );
        
    
    
    }
    public class Xcls_VBox2 : Object 
    {
        public Gtk.VBox el;
        private Xcls_DialogPluginWebkit  _this;


            // my vars (def)

        // ctor 
        public Xcls_VBox2(Xcls_DialogPluginWebkit _owner )
        {
            _this = _owner;
            this.el = new Gtk.VBox( false, 0 );

            // my vars (dec)

            // set gobject values
            var child_0 = new Xcls_ScrolledWindow3( _this );
            child_0.ref();
            this.el.pack_start (  child_0.el , false,true,3 );
        }

        // user defined functions 
    }
    public class Xcls_ScrolledWindow3 : Object 
    {
        public Gtk.ScrolledWindow el;
        private Xcls_DialogPluginWebkit  _this;


            // my vars (def)

        // ctor 
        public Xcls_ScrolledWindow3(Xcls_DialogPluginWebkit _owner )
        {
            _this = _owner;
            this.el = new Gtk.ScrolledWindow( null, null );

            // my vars (dec)

            // set gobject values
            this.el.expand = true;
            var child_0 = new Xcls_webview( _this );
            child_0.ref();
            this.el.add (  child_0.el  );

            // init method 

            this.el.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC);
        }

        // user defined functions 
    }
    public class Xcls_webview : Object 
    {
        public WebKit.WebView el;
        private Xcls_DialogPluginWebkit  _this;


            // my vars (def)

        // ctor 
        public Xcls_webview(Xcls_DialogPluginWebkit _owner )
        {
            _this = _owner;
            _this.webview = this;
            this.el = new WebKit.WebView();

            // my vars (dec)

            // set gobject values

            // init method 

            {
                // this may not work!?
                var settings =  this.el.get_settings();
                settings.enable_write_console_messages_to_stdout = true;
                 
                var fs= new FakeServer(this.el);
                fs.ref();
                // this was an attempt to change the url perms.. did not work..
                // settings.enable_file_access_from_file_uris = true;
                // settings.enable_offline_web_application_cache - true;
                // settings.enable_universal_access_from_file_uris = true;
               
                 
                
                
                
            
                 // FIXME - base url of script..
                 // we need it so some of the database features work.
                this.el.load_html( "Render not ready" , 
                        //fixme - should be a config option!
                        // or should we catch stuff and fix it up..
                        "xhttp://localhost/app.Builder/"
                );
                    
                    
                
                
            }

            // listeners 
            this.el.script_dialog.connect( (dialog) => {
                if (this.el == null) {
                    return true;
                }
                
                 var msg = dialog.get_message();
                 if (msg.length < 4) {
                    return false;
                 }
                 if (msg.substring(0,4) != "IPC:") {
                     return false;
                 }
                 var ar = msg.split(":", 3);
                if (ar.length < 3) {
                    return false;
                }
                print("CMD: %s\n",ar[1]);
                print("ARGS: %s\n",ar[2]);
                switch(ar[1]) {
                
                    case "SAVEHTML":
                        // print("%sw",ar[2]);
                        //  _this.file.saveHTML(ar[2]);
                        return true;
                        
                    case "OUT":
                        _this.result_json = ar[2];
                        return true;
                        
                    default:
                        return true;
                }
                
            });
        }

        // user defined functions 
    }
    public class Xcls_Button5 : Object 
    {
        public Gtk.Button el;
        private Xcls_DialogPluginWebkit  _this;


            // my vars (def)

        // ctor 
        public Xcls_Button5(Xcls_DialogPluginWebkit _owner )
        {
            _this = _owner;
            this.el = new Gtk.Button();

            // my vars (dec)

            // set gobject values
            this.el.label = "Reload";
        }

        // user defined functions 
    }
    public class Xcls_Button6 : Object 
    {
        public Gtk.Button el;
        private Xcls_DialogPluginWebkit  _this;


            // my vars (def)

        // ctor 
        public Xcls_Button6(Xcls_DialogPluginWebkit _owner )
        {
            _this = _owner;
            this.el = new Gtk.Button();

            // my vars (dec)

            // set gobject values
            this.el.label = "Cancel";
        }

        // user defined functions 
    }
    public class Xcls_Button7 : Object 
    {
        public Gtk.Button el;
        private Xcls_DialogPluginWebkit  _this;


            // my vars (def)

        // ctor 
        public Xcls_Button7(Xcls_DialogPluginWebkit _owner )
        {
            _this = _owner;
            this.el = new Gtk.Button();

            // my vars (dec)

            // set gobject values
            this.el.label = "OK";
        }

        // user defined functions 
    }
}
