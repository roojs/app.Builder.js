

namespace JsRender {


 
    int gid = 1;

  
    public  class Gtk : JsRender
    {
        Gee.HashMap<string,string> ctors ;

        public Gtk(Project.Project project, string path) {
            this.xtype = "Gtk";
            base( project, path);
            
             
            
            
            //this.items = false;
            //if (cfg.json) {
            //    var jstr =  JSON.parse(cfg.json);
            //    this.items = [ jstr ];
            //    //console.log(cfg.items.length);
            //    delete cfg.json; // not needed!
            // }
             
            
            
            // super?!?!
            this.id = "file-gtk-%d".printf(gid++);
            //console.dump(this);
            // various loader methods..

            // Class = list of arguments ... and which property to use as a value.
            string[] cc = {
                "Gtk.MessageDialog=parent:null|flags:Gtk.DialogFlags.MODAL|message_type|buttons|text" ,
                "Gtk.ToolButton=icon_widget:null|label:null" ,

                "Gtk.ScrolledWindow=hadjustment:null|vadjustment:null" ,
                "Gtk.SourceBuffer=table:null" ,
                "Gtk.VBox=homogeneous:true|spacing:0" 
            };

            this.ctors = new Gee.HashMap<string,string>();
            for (var i = 0;i<cc.length;i++) {
                var ar = cc[i].split("=");
                this.ctors.set(ar[0], ar[1]);
            }

            
            
        }
          

        /*
        setNSID : function(id)
        {
            
            this.items[0]['*class'] = id;
            
            
        },
        getType: function() {
            return 'Gtk';
        },
        */

        
         public  new void  loadItems() throws Error // : function(cb, sync) == original was async.
      
        {
          
            print("load Items!");
            if (this.tree != null) {
                return;
            }
            
            print("load: " + this.path);


            var pa = new Json.Parser();
            pa.load_from_file(this.path);
            var node = pa.get_root();
            
            if (node.get_node_type () != Json.NodeType.OBJECT) {
		        throw new Error.INVALID_FORMAT ("Unexpected element type %s", node.type_name ());
	        }
            var obj = node.get_object ();
            //this.modOrder = obj.get_string_member("modOrder");
            this.name = obj.get_string_member("name");
            this.parent = obj.get_string_member("parent");
            //this.permname = obj.get_string_member("permname");
            this.title = obj.get_string_member("title");
            //this.modOrder = obj.get_string_member("modOrder");
             
            // load items[0] ??? into tree...

            var ar = obj.get_array_member("items");
            var tree_base = ar.get_object_element(1);
            this.tree = new Node();
            this.tree.loadFromJson(tree_base);
            
            
            
            
        }
         
         // convert xtype for munged output..
         
         /*
        mungeXtype : function(xtype, els)
        {
            els.push('xtype: '+ xtype);
        },
        */
      
        public string toSource()
        {
        
            
            if (this.tree == null) {
                return false;
            }
            
            var data = JSON.parse(JSON.stringify(this.items[0]));
            // we should base this on the objects in the tree really..
            string[]  inc = { 'Gtk', 'Gdk', 'Pango', 'GLib', 'Gio', 'GObject', 
                'GtkSource', 'WebKit', 'Vte' ]; //, 'GtkClutter' , 'Gdl'];
            var src = "";
			 
            for (var i=0; i< inc.length; i++) {
				var e = inc[i]
                src += e+" = imports.gi." + e +";\n";
            }
            
            src += "console = imports.console;\n"; // path?!!?
            src += "XObject = imports.XObject.XObject;\n"; // path?!!?
            
            
            src += this.name + "=new XObject("+ this.mungeToString(data) + ");\n";
            src += this.name + '.init();\n';
            // register it in the cache
            src += "XObject.cache['/" + this.name + "'] = " + this.name + ";\n";
            
            
            return src;
            
            
        }
		
        public void save() {
            base.save();
            this.saveJS();
            this.saveVala();
        }
        
        /** 
         *  saveJS
         * 
         * save as a javascript file.
         * why is this not save...???
         * 
         */ 
          
        void saveJS()
        {
             
            var fn = GLib.Path.get_dirname(this.path) + "/" + this.name + ".js";
            print("WRITE : " + fn);
            FileUtils.put_contents(fn, this.toSource());
            
        }
        
       void  saveVala()
        {
             
            var fn = GLib.Path.get_dirname(this.path) + "/" + this.name + ".vala";
            print("WRITE : " + fn);
			FileUtils.put_contents(fn, this.toVala(false));
            
            
        }
		/*
        valaCompileCmd : function()
        {
            
            var fn = '/tmp/' + this.name + '.vala';
            print("WRITE : " + fn);
            File.write(fn, this.toVala(true));
            
            
            
            return ["valac",
                   "--pkg",  "gio-2.0",
                   "--pkg" , "posix" ,
                   "--pkg" , "gtk+-3.0",
                   "--pkg",  "libnotify",
                   "--pkg",  "gtksourceview-3.0",
                   "--pkg", "libwnck-3.0",
                   fn ,   "-o", "/tmp/" + this.name];
            
           
             
            
        },
        */
        
   
        string getHelpUrl(string cls)
        {
            return "http://devel.akbkhome.com/seed/" + cls + ".html";
        },
        
        int vcnt = 0;

		Palete palete;
		GLib.List<Node> vitems;
		string xvala_xcls;
		
        string toVala(bool testcompile)
        {
            var ret = "";
            
            
            this.vcnt = 0;
            //print(JSON.stringify(this.items[0],null,4));
            //print(JSON.stringify(this.items[0],null,4));Seed.quit();

            
            this.palete  = new Palete.Palete.factory("Gtk");
            
            this.vitems = new GLib.List<Node>();

			this.toValaName(this.tree);
           // print(JSON.stringify(item,null,4));Seed.quit();
            
            ret += "/* -- to compile\n";
            ret += "valac  --pkg gio-2.0  --pkg posix  --pkg gtk+-3.0 --pkg libnotify --pkg gtksourceview-3.0  --pkg  libwnck-3.0 \\\n";
            //ret += "    " + item.xvala_id + ".vala  -o /tmp/" + item.xvala_id +"\n";
            ret += "    /tmp/" + this.name + ".vala  -o /tmp/" + this.name +"\n";
            ret += "*" + "/\n";
            ret += "\n\n";
            if (!testcompile) {
           
                ret += "/* -- to test class\n";  
            }
            //
            ret += "static int main (string[] args) {\n";
            ret += "    Gtk.init (ref args);\n";
            ret += "    new " + this.tree.xvala_xcls +"();\n";
            ret += "    " + this.name +".show_all();\n";
            ret += "     Gtk.main ();\n";
            ret += "    return 0;\n";
            ret += "}\n";
            if (!testcompile) {
                ret += "*" + "/\n";
            }
            ret += "\n\n";
            // print(JSON.stringify(item,null,4));
            ret += this.toValaItem(this.tree,0);
            
            return ret;
            
        }
        
        string toValaNS : function(Node item)
        {
            var ns = item.get("|xns") ;
            if (ns == "GtkSource") {
                return "Gtk.Source."
            }
            return ns + ".";
        }
        
        void  toValaName : function(Node.item) {
            this.vcnt++;

			var cls = this.toValaNS(item) + item.get("xtype");

			var id = item.get("id").length > 0 ? item.get("id") : ("%s%d".printg(item.get("xtype"), this.vcnt);

			var props = this.palete.getPropertiesFor(cls, :"props");
            
            
            
            item.xvala_cls = cls;
            item.xvala_xcls = "Xcls_" + id;
            item.xvala_id = item.get("id").length > 0  ? item.get("id") : "";
			                                                       
            this.vitems.append(item);  
            // loop children..
			                                                       
            if (item.items.length() < 1) {
                return;
            }
            for(var i =0;i<item.items.length();i++) {
                this.toValaName(item.items[i]);
            }
			          
        }
        
        string toValaItem(Node item, int depth)
        {
        // print(JSON.stringify(item,null,4));
            
            var inpad = string.nfill(deptnew Array( depth +1 ).join("    ");
            
            var pad = new Array( depth +2 ).join("    ");
            var ipad = new Array( depth +3 ).join("    ");
            
            var cls = item.xvala_cls;
            
            var xcls = item.xvala_xcls;
            
            var citems = {};
            
            if (!depth) {
                // Global Vars..
                strbuilder(inpad + "public static " + xcls + "  " + this.name + ";\n\n");
                 
                
            }
            
            // class header..
            // class xxx {   WrappedGtk  el; }
            strbuilder(inpad + "public class " + xcls + "\n" + inpad + "{\n");
            strbuilder(pad + "public " + cls + " el;\n");
             if (!depth) {
                
                strbuilder(pad + "private static " + xcls + "  _this;\n\n");
            }
            
            
            // properties??
                
                //public bool paused = false;
                //public static StatusIconA statusicon;
            if (!depth) {
                //strbuilder(pad + "public static " + xcls + "  _this;\n");
                for(var i=1;i < this.vitems.length; i++) {
                    if (this.vitems[i].xvala_id  !== false) {
                        strbuilder(pad + "public " + this.vitems[i].xvala_xcls + " " + this.vitems[i].xvala_id + ";\n");
                    }
                }
                
            }
            
            strbuilder("\n" + ipad + "// my vars\n");
            
            
            for (var k in item) {
                if (k[0] != '.') {
                   
                    continue;
                }
                if (k == '.ctor') {
                    continue; 
                }
                
                var kk = k.substring(1);
                var v = item[k];
                var vv = v.split(':');
                strbuilder(pad + "public " + vv[0] + " " + kk + ";\n");
                 citems[k] = true; 
                
            }
            // .vala props.. 
             
            // ctor..
            strbuilder("\n" + ipad + "// ctor \n");
            strbuilder(pad + "public " + xcls + "()\n" + pad + "{\n");
            
            // wrapped ctor..
            // this may need to look up properties to fill in the arguments..
            // introspection does not workk..... - as things like gtkmessagedialog
            
            
            if (typeof(ctors[cls]) !== 'undefined') {
                var args = [];
                for(var i =0;i< ctors[cls].length;i++) {
                    
                    var nv = ctors[cls][i].split(':');
                    
                    if (typeof(item[nv[0]]) != 'undefined' && typeof(item[nv[0]]) != 'object' ) {
                        citems[nv[0]] = true;
                        args.push(JSON.stringify(item[nv[0]]));
                        continue;
                    }
                    if (typeof(item['|' + nv[0]]) != 'undefined' && typeof(item['|' + nv[0]]) != 'object' ) {
                        citems[nv[0]] = true;
                        citems['|' + nv[0]] = true;
                        args.push(item['|' + nv[0]]);
                        continue;
                    }
                    args.push(nv.length > 1 ? nv[1] : 'null'); 
                    
                }
                strbuilder(ipad + "this.el = new " + cls + "( "+ args.join(", ") + " );\n" );

            } else {
                strbuilder(ipad + "this.el = new " + cls + "();\n" );

            }
            //var meths = this.palete.getPropertiesFor(item['|xns'] + '.' + item.xtype, 'methods');
            //print(JSON.stringify(meths,null,4));Seed.quit();
            
             
            
            // public static?
            if (!depth) {
                strbuilder(ipad + "_this = this;\n");
                strbuilder(ipad + this.name  + " = this;\n");
            } else {
                if (item.xvala_id !== false) {
                    strbuilder(ipad + "_this." + item.xvala_id  + " = this;\n");
                   
                }
                
                
            }
            // initialize.. my vars..
            strbuilder("\n" + ipad + "// my vars\n");
            for (var k in item) {
                if (k[0] != '.') {
                    continue;
                }
                var kk = k.substring(1);
                var v = item[k];
                var vv = v.split(':');
                if (vv.length < 2) {
                    continue;
                }
                strbuilder(ipad + "this" + k + " = " +   vv[1] +";\n");
                
            }
           
           
            // what are the properties of this class???
            strbuilder("\n" + ipad + "// set gobject values\n");
            var props = this.palete.getPropertiesFor(item['|xns'] + '.' + item.xtype, 'props');
            
            
            
            props.forEach(function(p) {
               
                if (typeof(citems[p.name]) != 'undefined') {
                    return;
                }
                     
                if (typeof(item[p.name]) != 'undefined' && typeof(item[p.name]) != 'object' ) {
                    citems[p.name] = true;
                    
                    
                    strbuilder(ipad + "this.el." + p.name + " = " + JSON.stringify(item[p.name]) + ";\n");
                    return;
                }
                if (typeof(item['|' + p.name]) != 'undefined' && typeof(item['|' + p.name]) != 'object' ) {
                    citems['|' + p.name] = true;
                    //if (p.ctor_only ) {
                    //    strbuilder(ipad + "Object(" + p.name + " : " +  item['|' + p.name] + ");\n");
                    //} else {
                        strbuilder(ipad + "this.el." + p.name + " = " +  item['|' + p.name] + ";\n");
                    //}
                    return;
                }
               // got a property..
               
               
            });
                //code
            // add all the child items..
            if (typeof(item.items) != 'undefined') {
                for(var i =0;i<item.items.length;i++) {
                    var ci = item.items[i];
                    var packing = ci.pack ? ci.pack.split(',') : [ 'add' ];
                    var pack = packing.shift();
                    strbuilder(ipad + "var child_" + i + " = new " + ci.xvala_xcls + "();\n" )
                    
                    strbuilder(ipad + "this.el." + pack + " (  child_" + i + ".el " +
                               (packing.length ? ", " + packing.join(",") : "") + " );\n"
                            );
                               
                    
                }
            }
            if (typeof(item['|init']) != 'undefined') {
                
                
                    var v = item['|init'].split(/\/*--/);
                    if (v.length > 1) {
                        strbuilder("\n" + ipad + "// init method \n");            
                         var vv = v[1].replace('*/', "");
                         //print(JSON.stringify(vv));Seed.quit();
                         vv = vv.replace(/^\n+/,'');
                         vv = vv.replace(/\n+$/,'');
                         vv = vv.replace(/\n/g,"\n" + ipad);
                         strbuilder(ipad + vv  + "\n");
                    }
            }
            
            citems['|pack'] = true;
            citems['|items'] = true;
             citems['|init'] = true;
            
            if (item.listeners) {
            //    print(JSON.stringify(item.listeners));Seed.quit();
            
                strbuilder("\n" + ipad + "// listeners \n");  
                // add all the signal handlers..
                for (var k in item.listeners) {
                    
                    
                    var v = item.listeners[k].split(/\/*--/);
                    if (v.length < 2) {
                        var vv = v[0].replace(/^function/, '');
                        vv = vv.replace(/\) \{/, ') => {');
                        vv = vv.replace(/^\n+/,'');
                        vv = vv.replace(/\n+$/,'');
                        vv = vv.replace(/\n/g,"\n" + ipad);
                        
                        
                        
                        
                        
                        //continue;
                    } else { 
                        var vv = v[1].replace('*/', "");
                        //print(JSON.stringify(vv));Seed.quit();
                        vv = vv.replace(/^\n+/,'');
                        vv = vv.replace(/\n+$/,'');
                        vv = vv.replace(/\n/g,"\n" + ipad);
                    }
                    strbuilder(ipad + "this.el." + k + ".connect( " + vv  + " );\n");
                    
                }
            }    
                
            
            
            
            // end ctor..
            strbuilder(pad + "}\n");
            
            
            strbuilder("\n" + pad + "// userdefined functions \n");  
            
            // user defined functions...
            
            for (var k in item) {
                if (typeof(citems[k]) != 'undefined') {
                    strbuilder("\n" + pad + "// skip " + k + " - already used \n"); 
                    continue;
                }
                if (k[0] != '|') {
                      strbuilder("\n" + pad + "// skip " + k + " - not pipe \n"); 
                    continue;
                }
                // function in the format of {type} (args) { .... }
                
                var v = item[k].split(/\/*--/);
                if (v.length < 2) {
                      strbuilder("\n" + pad + "// skip " + k + " - could not find seperator\n"); 
                    continue;
                }
                var vv = v[1].replace('*/', "");
                //print(JSON.stringify(vv));Seed.quit();
                vv = vv.replace(/^\n+/,'');
                vv = vv.replace(/\n+$/,'');
                vv = vv.replace(/\n/g,"\n" + ipad);
                
                vva = vv.split(' ');
                var rtype = vva.shift();
                var body = vva.join(' ');
                
                
                strbuilder(pad + "public " + rtype + " " + k.substring(1) +body + "\n");
                
                
                
            }
            
            
            
            if (depth > 0) {
                strbuilder(inpad + "}\n");
            }
            
            
            // next loop throug children..
            if (typeof(item.items) != 'undefined') {
                for(var i =0;i<item.items.length;i++) {
                    this.toValaItem(item.items[i], 1, strbuilder);
                }
            }
            if (depth < 1) {
                strbuilder(inpad + "}\n");
            }
            
        }
        
        
        
    });
*/
    }
}