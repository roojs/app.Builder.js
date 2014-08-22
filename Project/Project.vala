//<Script type="text/javascript">

/**
 * Project Object
 * 
 * Projects can only contain one directory... - it can import other projects..(later)
 * 
 * we need to sort out that - paths is currently a key/value array..
 * 
 * 
 * 
 */
namespace Project {
	 public errordomain Error {
		    INVALID_TYPE,
		    NEED_IMPLEMENTING,
			MISSING_FILE,
			INVALID_VALUE
		}

	// static array of all projects.
	public Gee.HashMap<string,Project>  projects;
    public bool  projects_loaded = false;

	
	public class Project : Object {
		
		public signal void on_changed (); 
	
		public string id;
		public string fn = ""; // just a md5...
		public string name = "";
		public string runhtml = "";
		public Gee.HashMap<string,string> paths;
		public Gee.HashMap<string,JsRender.JsRender> files ;
		//tree : false,
		public  string xtype;
		 
		bool is_scanned; 
	   
		
		public Project (string path) {
		    
		    //this.name = name;
		    
		    this.is_scanned = false;
		    this.paths = new Gee.HashMap<string,string>();
		    this.files = new Gee.HashMap<string,JsRender.JsRender>();
		    //XObject.extend(this, cfg);
		    //this.files = { }; 
		    if (path.length > 0) {
				this.paths.set(path, "dir");
		    }
		    
		    
		}

        
        
        
		
		public static void loadAll(bool force = false)
		{
			if (projects_loaded && !force) {
				return;
			}

			var dirname = GLib.Environment.get_home_dir() + "/.Builder";
			var dir = File.new_for_path(dirname);
		        if (!dir.query_exists()) {
				dir.make_directory();
				return;
			}
			projects = new  Gee.HashMap<string,Project>();
			  
		   
			try {
				var file_enum = dir.enumerate_children(
                     			GLib.FileAttribute.STANDARD_DISPLAY_NAME, 
					GLib.FileQueryInfoFlags.NONE, 
					null
				);
		        
		         
				FileInfo next_file; 
				while ((next_file = file_enum.next_file(null)) != null) {
		     		var fn = next_file.get_display_name();
				if (!Regex.match_simple("\\.json$", fn)) {
					continue;
				}
            			factoryFromFile(dirname + "/" + fn);
				}
   			} catch(Error e) {
				print("oops - something went wrong scanning the projects\n");
			}
		    

		}

		public static Gee.ArrayList<Project> allProjectsByName()
		{
		    var ret = new Gee.ArrayList<Project>();
		    var iter = projects.map_iterator();
			    while (iter.next()) {
				ret.add(iter.get_value());
			    }
		    // fixme -- sort...
		    return ret;
		
		}

		public static Project?  getProject(string name) 
		{
			if (projects.has_key(name)) {
				return projects.get(name);
			}
			return null;

		}
		// load project data from project file.
		public static void   factoryFromFile(string jsonfile)
		{
			 
			print("parse %s\n", jsonfile);

			var pa = new Json.Parser();
			pa.load_from_file(jsonfile);
			var node = pa.get_root();

			
			if (node == null || node.get_node_type () != Json.NodeType.OBJECT) {
				print("SKIP " + jsonfile + " - invalid format?\n");
				return;
			}
			
    			var obj = node.get_object ();
			var xtype =  obj.get_string_member("xtype");

			var proj = factory(xtype, "");

			proj.fn =  Path.get_basename(jsonfile).split(".")[0];


			if (obj.has_member("runhtml")) {
        			proj.runhtml  = obj.get_string_member("runhtml"); // might not exist?
			}
			proj.name = obj.get_string_member("name");

			var paths = obj.get_object_member("paths");
			paths.foreach_member((sobj, key, val) => {
				proj.paths.set(key, "dir");
			});
			projects.set(proj.name,proj);
		}
		
		
		public static Project factory(string xtype, string path)
		{
			switch(xtype) {
				case "Gtk":
					return new Gtk(path);
				case "Roo":
					return new Roo(path);
			}
			throw new Error.INVALID_TYPE("invalid project type");
				
		}
		 
		/*
		public load
		 
		    
		    load : function (o)  // is this used??
		    {
		        if (!this.fetchTree) {
		            console.log("Project.getTree tree called on base object?!?!");
		            return false;
		        }
		        
		        if (this.files) {
		            return o.success.apply(o.scope || this, [this]);
		        }
		        return this.fetchTree(o);
		        
		    },
		*/
	   // public Palete  getPalete ()
		//{
		        //print("Project.Base: GET PROVIDER FOR " + this.xtype);
	   //         return  ProjectManager.getPalete(this.xtype);
	   // }

		public void save()
		{
				// fixme..
            
			if (this.fn.length < 1) {
				// make the filename..
				var t = new DateTime.now_local ();
				TimeVal tv;
				t.to_timeval(out tv);
				var str = "%l:%l".printf(tv.tv_sec,tv.tv_usec);
				
        			this.fn = GLib.Checksum.compute_for_string(GLib.ChecksumType.MD5, str, str.length);
			}

    			var dirname = GLib.Environment.get_home_dir() + "/.Builder";
    			var  s =  this.toJSON(false);
			FileUtils.set_contents(dirname + "/" + this.fn + ".json", s, s.length);  
			
			
		}

		
		
		public string toJSON(bool show_all)
		{
		    
			var builder = new Json.Builder ();

			builder.begin_object ();

			builder.set_member_name ("name");
			builder.add_string_value (this.name);


			builder.set_member_name ("fn");
			builder.add_string_value (this.fn);

			builder.set_member_name ("xtype");
			builder.add_string_value (this.xtype);

			builder.set_member_name ("runhtml");
			builder.add_string_value (this.runhtml);

			// file ??? try/false?
			builder.set_member_name ("paths");


			builder.begin_object ();


			var iter = this.paths.map_iterator();
			while (iter.next()) {
				builder.set_member_name (iter.get_key());
				builder.add_string_value("path");
			}
			builder.end_object ();
			
			if (show_all) {
				builder.set_member_name ("files");
				builder.begin_array ();
				var fiter = this.files.map_iterator();
				while (fiter.next()) {
				    builder.add_string_value (fiter.get_key());
				}
				
				
				builder.end_array ();
			}

		
			builder.end_object ();

			var  generator = new Json.Generator ();
			var  root = builder.get_root ();
			generator.set_root (root);
			if (show_all) {
				generator.pretty = true;
				generator.indent = 4;
			}

			return  generator.to_data (null);
			  
		      
		}
		public string firstPath()
		{
		    var iter = this.paths.map_iterator();
		    while (iter.next()) {
		        return iter.get_key();
		    }
		  
		    return "";
		}
		
		// returns the first path
		public string getName()
		{
		    var iter = this.paths.map_iterator();
		    while (iter.next()) {
		        return GLib.Path.get_basename(iter.get_key());
		    }
		  
		    return "";
		}

		
		
		/**
		 *
		 * to tree - > is this needed anymore???
		 */
/*

		public GLib.List<JsRender.JsRender> toTree ()
		{
		        
		     
		     
		    var files = new Gee.HashMap<string,JsRender.JsRender>();

		    var fiter = this.files.map_iterator();
		    while(fiter.next()) {
		        var fo = fiter.get_value();
		        
		        fo.hasParent = false;
		        fo.cn = new GLib.List<JsRender.JsRender>();
		        
		        if (fo.fullname.length > 0) {
		            files.set(fo.fullname, fo);
		        }
		    }
		    
		    var iter = files.map_iterator();
		    while (iter.next()) {
		        var f = iter.get_value();
		        
		        var par = f.parent;
		        if (par.length < 1) {
		            continue;
		        }
		        if (!files.has_key(par)) {
		            continue;
		        }
		        files.get(par).cn.append(f);
		        f.hasParent = true;
		         
		    };
		        
		    var ret = new GLib.List<JsRender.JsRender>();
		    iter = files.map_iterator();
		    while (iter.next()) {
		        var f = iter.get_value();
		            
		        //   f.sortCn();
		        if (f.hasParent) {
		            continue;
		        }
		        if (files.has_key(f.fullname)) {
		        
		            ret.append(f);
		        }
		    }
		    ret.sort( (a,b) => {
		        return a.path > b.path ? 1 : -1;
		    });
		    
		    
		    //print(JSON.stringify(ret,null,4));
		        
		    return ret;  
		         
		        
		}
*/		
		public JsRender.JsRender? getByName(string name)
		{
		    
			var fiter = files.map_iterator();
		    while(fiter.next()) {
		     
		        var f = fiter.get_value();
		        
		        
		        //console.log(f.id + '?=' + id);
		        if (f.name == name) {
		            return f;
		        }
		    };
		    return null;
		}
		
		public JsRender.JsRender? getById(string id)
		{
		    
			var fiter = files.map_iterator();
		    while(fiter.next()) {
		     
		        var f = fiter.get_value();
		        
		        
		        //console.log(f.id + '?=' + id);
		        if (f.id == id) {
		            return f;
		        }
		    };
		    return null;
		}
		    
		public JsRender.JsRender loadFileOnly (string path)
		{
		    var xt = this.xtype;
		    return JsRender.JsRender.factory(xt, this, path);
		    
		}
		
		public JsRender.JsRender create(string filename)
		{
		    var ret = this.loadFileOnly(filename);
		    ret.save();
		    this.addFile(ret);
		    return ret;
		    
		}
		    
		     
		public void addFile(JsRender.JsRender pfile) { // add a single file, and trigger changed.
		
		
		    this.files.set(pfile.path, pfile); // duplicate check?
		    this.on_changed();
		}
		
		public void add(string path, string type)
		{
		    this.paths.set(path,type);
		    //Seed.print(" type is '" + type + "'");
		    if (type == "dir") {
		        this.scanDir(path);
		    //    console.dump(this.files);
		    }
		    if (type == "file" ) {
			
		        this.files.set(path,this.loadFileOnly( path ));
		    }
		    this.on_changed();
		    
		}
		public void  scanDirs() // cached version
		{
		    if (this.is_scanned) {
				return;
			}
			this.scanDirsForce();
		    //console.dump(this.files);
		    
		}
		
		public void  scanDirsForce()
		{
			this.is_scanned = true;	 
			var iter = this.paths.map_iterator();
		    while (iter.next()) {
				//print("path: " + iter.get_key() + " : " + iter.get_value() +"\n");
		        if (iter.get_value() != "dir") {
		            continue;
		        }
		        this.scanDir(iter.get_key());
		    }
		    //console.dump(this.files);
		    
		}
		    // list files.
		public void scanDir(string dir, int dp =0 ) 
		{
		    //dp = dp || 0;
		    //print("Project.Base: Running scandir on " + dir +"\n");
		    if (dp > 5) { // no more than 5 deep?
		        return;
		    }
		    // this should be done async -- but since we are getting the proto up ...
		    
		    var subs = new GLib.List<string>();;            
		    var f = File.new_for_path(dir);
		    try {
		        var file_enum = f.enumerate_children(GLib.FileAttribute.STANDARD_DISPLAY_NAME, GLib.FileQueryInfoFlags.NONE, null);
		        
		         
		        FileInfo next_file; 
		        while ((next_file = file_enum.next_file(null)) != null) {
		            var fn = next_file.get_display_name();
		    
		             
		            //print("trying"  + dir + "/" + fn +"\n");
		            
		            if (fn[0] == '.') { // skip hidden
		                continue;
		            }
		            
		            if (FileUtils.test(dir  + "/" + fn, GLib.FileTest.IS_DIR)) {
		                subs.append(dir  + "/" + fn);
		                continue;
		            }
		            
		            if (!Regex.match_simple("\\.bjs$", fn)) {
						//print("no a bjs\n");
		                continue;
		            }
		            /*
		            var parent = "";
		            //if (dp > 0 ) {
		            
		            var sp = dir.split("/");
		            var parent = "";
		            for (var i = 0; i < sp.length; i++) {
		                
		            }
		            
		            /*
		            sp = sp.splice(sp.length - (dp +1), (dp +1));
		            parent = sp.join('.');
		            
		            
		            if (typeof(_this.files[dir  + '/' + fn]) != 'undefined') {
		                // we already have it..
		                _this.files[dir  + '/' + fn].parent = parent;
		                return;
		            }
		            */
		            var xt = this.xtype;
					var el = JsRender.JsRender.factory(xt,this, dir + "/" + fn);
		            this.files.set( dir + "/" + fn, el);
		            // parent ?? 
		            
		             
		        }
		    } catch (Error e) {
		        print("Project::scanDirs failed : " + e.message + "\n");
		    } catch (GLib.Error e) {
				print("Project::scanDirs failed : " + e.message + "\n");
			}
			for (var i = 0; i < subs.length(); i++) {
		        
		         this.scanDir(subs.nth_data(i), dp+1);
		    }
		    
		}
		  
	}
}
 