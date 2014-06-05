

namespace JsRender {


 
    int gid = 1;

  
    public  class Gtk : JsRender
    {
       

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
                return "";
            }
            
            // var data = JSON.parse(JSON.stringify(this.items[0]));
            // we should base this on the objects in the tree really..
            string[]  inc = { "Gtk", "Gdk", "Pango", "GLib", "Gio", "GObject", 
                "GtkSource", "WebKit", "Vte" }; //, "GtkClutter" , "Gdl"];
            var src = "";
			 
            for (var i=0; i< inc.length; i++) {
				var e = inc[i];
                src += e+" = imports.gi." + e +";\n";
            }
            
            src += "console = imports.console;\n"; // path?!!?
            src += "XObject = imports.XObject.XObject;\n"; // path?!!?
            
            
            src += this.name + "=new XObject("+ this.mungeToString("    ") + ");\n";
            src += this.name + ".init();\n";
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
            FileUtils.set_contents(fn, this.toSource());
            
        }
        
       void  saveVala()
        {
             
            var fn = GLib.Path.get_dirname(this.path) + "/" + this.name + ".vala";
            print("WRITE : " + fn);
			FileUtils.set_contents(fn, this.toVala(false));
            
            
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
        }
        
        int vcnt = 0;

		Palete.Gtk palete;
		GLib.List<Node> vitems;
		string xvala_xcls;
		
        string toVala(bool testcompile)
        {
            var ret = "";
            
            
            this.vcnt = 0;
            //print(JSON.stringify(this.items[0],null,4));
            //print(JSON.stringify(this.items[0],null,4));Seed.quit();

            
            this.palete  =  (Palete.Gtk) Palete.factory("Gtk");
            
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
        
        string toValaNS(Node item)
        {
            var ns = item.get("|xns") ;
            if (ns == "GtkSource") {
                return "Gtk.Source.";
            }
            return ns + ".";
        }
        
        void  toValaName(Node item) {
            this.vcnt++;

			var cls = this.toValaNS(item) + item.get("xtype");

			string id = item.get("id").length > 0 ? item.get("id") :  "%s%d".printf(item.get("xtype"), this.vcnt);

			var props = this.palete.getPropertiesFor(cls,  "props");
             
            
            
            item.xvala_cls = cls;
            item.xvala_xcls = "Xcls_" + id;
            item.xvala_id = item.get("id").length > 0  ? item.get("id") : "";
			                                                       
            this.vitems.append(item);  
            // loop children..
			                                                       
            if (item.items.length() < 1) {
                return;
            }
            for(var i =0;i<item.items.length();i++) {
                this.toValaName(item.items.nth_data(i));
            }
			          
        }
        
        string toValaItem(Node item, int depth)
        {
        // print(JSON.stringify(item,null,4));
            var ret = "";
            var inpad = string.nfill((depth+1) *4 , ' ');
            
            var pad = string.nfill((depth+2) * 4, ' ');
            var ipad = string.nfill((depth+3) *4, ' ');
            
            var cls = item.xvala_cls;
            
            var xcls = item.xvala_xcls;
            
            var citems = new Gee.HashMap<string,bool>();
            
            if (depth < 1) {
                // Global Vars..
                ret+= inpad + "public static " + xcls + "  " + this.name + ";\n\n";
                 
            }
            
            // class header..
            // class xxx {   WrappedGtk  el; }
            ret += inpad + "public class " + xcls + "\n" + inpad + "{\n";
            ret += pad + "public " + cls + " el;\n";

			if (depth < 1) {
                
                ret += pad + "private static " + xcls + "  _this;\n\n";
            }
            
            
            // properties??
                
                //public bool paused = false;
                //public static StatusIconA statusicon;
            if (depth < 1) {
                //strbuilder(pad + "public static " + xcls + "  _this;\n");
                for(var i=1;i < this.vitems.length(); i++) {
                    if (this.vitems.nth_data(i).xvala_id.length > 0) {
                        ret += pad + "public " + this.vitems.nth_data(i).xvala_xcls + " " + this.vitems.nth_data(i).xvala_id + ";\n";
                    }
                }
                
            }
            
            ret +="\n" + ipad + "// my vars\n";
            var iter = item.props.map_iterator();
    		while (iter.next()) {
        		var k = iter.get_key();
        		var v = iter.get_value();
            
                if (k[0] != '.') {
                    continue;
                }
                if (k == "ctor") {
                    continue; 
                }
                
                var kk = k.substring(1);
                
                var vv = v.split(":");
                ret += pad + "public " + vv[0] + " " + kk + ";\n";
                citems.set(k, true); 
                
            }
            // .vala props.. 
             
            // ctor..
            ret+="\n" + ipad + "// ctor \n";
            ret+= pad + "public " + xcls + "()\n" + pad + "{\n";
            
            // wrapped ctor..
            // this may need to look up properties to fill in the arguments..
            // introspection does not workk..... - as things like gtkmessagedialog
            
            var ctors =  this.palete.getPropertiesFor(cls, "ctors");
			
			// ctors is going to return 'new' or ... ??
			string ctor = item.get("ctor").length > 0 ? item.get("ctor") : "new";

			var ctor_def = ctors.get(ctor);
			

			if (ctor_def.paramset != null)  {

				var argid = 1;
                var args = new GLib.List<string>();
				var piter = ctor_def.paramset.params.map_iterator();
    			while (piter.next()) {

					// need piter.get_key(); -- string..
					string pv = item.get(piter.get_key());
					if (pv.length < 1) {
						// try and find the 'item'....
						Node pvi = item.findProp(piter.get_key());
						if (pvi == null) {
							args.append("null"); // hopefully...
							continue;
						}
						var var_id = "xxx%d".printf( argid++ );
						ret+= pad + "var "+ var_id + " = new "  + this.nodeToValaNew(pvi) +"\n";
						args.append(var_id);
						continue;
					} 
					// got a string value..
					args.append(this.valueTypeToString(pv, piter.getValue().type));
					
                }
                ret += ipad + "this.el = new " + cls + "( "+ string.join(", ", args) + " );\n" ;

            } else {
                ret += ipad + "this.el = new " + cls + "();\n" ;

            }
            //var meths = this.palete.getPropertiesFor(item['|xns'] + '.' + item.xtype, 'methods');
            //print(JSON.stringify(meths,null,4));Seed.quit();
            
             
            
            // public static?
            if ( depth < 1) {
                ret += ipad + "_this = this;\n";
                ret += ipad + this.name  + " = this;\n";
            } else {
                if (item.xvala_id.length > 0) {
                    ret += ipad + "_this." + item.xvala_id  + " = this;\n";
                    
                }
                
                
            }
            // initialize.. my vars..
            ret += "\n" + ipad + "// my vars\n";

			// look for ".****"
			iter = item.props.map_iterator();
    		while (iter.next()) {
				var k = iter.get_key();
        	    if (k[0] != '.') {
                    continue;
                }
                var kk = k.substring(1);
                var v = item.get(k);
                var vv = v.split(":");
                if (vv.length < 2) {
                    continue;
                }
                ret+= ipad + "this" + k + " = " +   vv[1] +";\n";
                
            }
           
           
            // what are the properties of this class???
            ret += "\n" + ipad + "// set gobject values\n";
            var props = this.palete.getPropertiesFor(cls, "props");
            
            

			var pviter = props.map_iterator();
			while (pviter.next()) {
        		// skip items we have already handled..
        		if  (!(citems.get(pviter.get_key()) == false)) {
                    continue;
                }
				if (item.get(pviter.get_key()).length < 1) {
					continue;
				}
				
                var type =  pviter.get_value().type;

				
				    
                ret +=  ipad + "this.el." + pviter.get_key() + " = " + 
							this.valueTypeToString(item.get(pviter.get_key()), type) + ";\n";
                    
               
            }
                //code
            // add all the child items..


            for(var i =0;i<item.items.length();i++) {
        		var ci = item.items.nth_data(i);
				var pk = ci.get("pack");
				string[] packing = { "add" };
				if (ci.get("pack").length > 0) {
					packing = ci.get("pack").split(",");
				}
                
                
                ret += ipad + "var child_" + "%d".printf(i) + " = new " + ci.xvala_xcls + "();\n";
                    
                ret+= ipad + "this.el." + packing[0] + " (  child_" + "%d".printf(i) + ".el ";
				for (var ii=1;ii<packing.length; ii++) {
					ret+= ii > 1 ? ", " : "";
					ret+= packing[i];
				}	   
				ret+=  ");\n";
                        
            }

            if (item.get("init").length > 0) {
                var vv = item.get("init").split("\n");
				ret+= ipad + string.join("\n" + ipad, vv);
				
            }
            
            //citems['|pack'] = true;
            //citems['|items'] = true;
            //citems['|init'] = true;
            
            if (item.listeners.size > 0) {
            //    print(JSON.stringify(item.listeners));Seed.quit();
            /*
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
                        
                        //print(JSON.stringify(vv));Seed.quit();
                        vv = vv.replace(/^\n+/,'');
                        vv = vv.replace(/\n+$/,'');
                        vv = vv.replace(/\n/g,"\n" + ipad);
                    }
                    strbuilder(ipad + "this.el." + k + ".connect( " + vv  + " );\n");
                    
                }
			*/
            }    
                
            
            
            
            // end ctor..
            ret+=pad + "}\n";
            
            
            ret+= "\n" + pad + "// userdefined functions \n";  
            
            // user defined functions...
            /*
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
                var vv = v[1].replace('* /', "");
                //print(JSON.stringify(vv));Seed.quit();
                vv = vv.replace(/^\n+/,'');
                vv = vv.replace(/\n+$/,'');
                vv = vv.replace(/\n/g,"\n" + ipad);
                
                vva = vv.split(' ');
                var rtype = vva.shift();
                var body = vva.join(' ');
                
                
                strbuilder(pad + "public " + rtype + " " + k.substring(1) +body + "\n");
                
                
                
            }
            */
            
            
            if (depth > 0) {
                ret+=inpad + "}\n";
            }
            for (var i = 0;i < item.items.length();i++) {
				ret+= this.toValaItem(item.items.nth_data(i), 1); 
			}
            
            if (depth < 1) {
                ret+=inpad + "}\n";
            }
            return ret;
        }
        
         
    }
	string nodeToValaNew(Node node)
	{
		var ret = "new ";
		ret += node.fqn() "(";
		// what are the args required for this type of ctor...
		var ctors = this.palete.getPropertiesFor(node.fqn(),  "ctor");
		var m = node.get("ctor")
		
		
            



		

	}
}



