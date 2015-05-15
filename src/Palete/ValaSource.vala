
// valac TreeBuilder.vala --pkg libvala-0.24 --pkg posix -o /tmp/treebuilder

namespace Palete {
	
	delegate ValaSourceResult void (Json.Object res);
	
	public class ValaSourceReport  : Vala.Report {

		public string filepath;
		
		public string tmpname;
		
		//public Gee.ArrayList<ValaSourceNotice> notices;
		public Json.Object result;
		 
		//public Gee.HashMap<int,string> line_errors;
		
		public void  compile_notice(string type, string filename, int line, string message) {
			 if (!this.result.has_member(type)) {
				 this.result.set_object_member(type, new Json.Object());
			 }
			 var t = this.get_object_member(type);
			 if (!t.has_member(filename)) {
				 t.set_object_member(filename, new Json.Object());
			 }
			 var tt = t.get_object_member(filename);
			 if (!tt.has_member(line.to_string())) {
				 tt.set_object_member(line.to_string(), new Json.Array());
			 }
			 var tl = tt.get_array_member(line.to_string());
			 tl.add_string_element(message);
			 
		}
		
		
	 
		public ValaSourceReport(string filepath, string tmpname)
		{
			base();
			this.filepath = filepath;
			this.tmpname = tmpname;
			this.result = new Json.Object();
			this.result.set_boolean_member("success", "true");
			this.result.set_string_member("message", "");
			
			
			
			//this.line_errors = new Gee.HashMap<int,string> ();
			//this.notices = new Gee.ArrayList<ValaSourceNotice>();
		}
		
		public override void warn (Vala.SourceReference? source, string message) {
			 
			if (source == null) {
				return;
				//stderr.printf ("My error: %s\n", message);
			}
			
			if (source.file.filename != this.tmpname) {
				this.compile_notice("WARN", source.file.filename , source.begin.line, message);
				return;
			}
			this.compile_notice("WARN", this.filepath, source.begin.line, message);
			
		}
		public override void depr (Vala.SourceReference? source, string message) {
			 
			if (source == null) {
				return;
				//stderr.printf ("My error: %s\n", message);
			}
			
			if (source.file.filename != this.tmpname) {
				this.compile_notice("DEPR", source.file.filename, source.begin.line, message);
				return;
			}
			this.compile_notice("DEPR",  this.filepath, source.begin.line, message);
			
		}
		
		public override void err (Vala.SourceReference? source, string message) {
			errors++;
			if (source == null) {
				return;
				//stderr.printf ("My error: %s\n", message);
			}
			if (source.file.filename != this.tmpname) {
				this.compile_notice("ERR", source.file.filename, source.begin.line, message);
				print ("Other file: Got error error: %d:  %s\n", source.begin.line, message);
				return;
			}
			 
			 
			this.compile_notice("ERR", this.filepath, source.begin.line, message);
			print ("Test file: Got error error: %d: %s\n", source.begin.line, message);
		}
		/*
		public void dump()
		{
			var iter = this.line_errors.map_iterator();
			while (iter.next()) {
				print ("%d : %s\n\n", iter.get_key(), iter.get_value());
			}
		}
		*/

	}

	public class ValaSource : Vala.CodeVisitor {

		public static void jerr(string str)
		{
			var ret = new Json.Object(); 
			ret.set_boolean_member("success", false);
			ret.set_string_member("message", str);
			
			var  generator = new Json.Generator ();
			var  root = new Json.Node(Json.NodeType.OBJECT);
			root.init_object(ret);
			generator.set_root (root);
			 
			generator.pretty = true;
			generator.indent = 4;
		 

			print("%s\n",  generator.to_data (null));
			GLib.Process.exit(Posix.EXIT_FAILURE);
			
		}

		public static void buildApplication()
		{
			//print("build based on Application settings\n");
			
			if (BuilderApplication.opt_compile_target == null) {
				jerr("missing compile target --target");
			}
			
			Project.Project.loadAll();
			var proj = Project.Project.getProjectByHash(BuilderApplication.opt_compile_project);
			
			if (proj == null) {
				jerr("could not load test project %s".printf( BuilderApplication.opt_compile_project));
			}
			
			if (proj.xtype != "Gtk") {
				jerr("%s is not a Gtk Project".printf( BuilderApplication.opt_compile_project));
			}
			var gproj = (Project.Gtk)proj;
			
			
			if (!gproj.compilegroups.has_key(BuilderApplication.opt_compile_target)) {
				jerr("missing compile target %s".printf(BuilderApplication.opt_compile_target));
			}
			
			
			
			jerr("NOT DONE");
			
		}

		Vala.CodeContext context;
		ValaSourceReport report;
		JsRender.JsRender file; 
		Project.Gtk project;
		public string build_module;
		public string filepath;
		public string original_filepath;
		
		// file.project , file.path, file.build_module, ""
		public ValaSource(Project.Gtk project, string filepath, string build_module, string original_filepath) {
			base();
			//this.file = file;
			this.filepath = filepath;
			this.build_module = build_module;
			this.original_filepath = original_filepath;
			this.project =  project;
			
		}
		public void dumpCode(string str) 
		{
			var ls = str.split("\n");
			for (var i=0;i < ls.length; i++) {
				print("%d : %s\n", i+1, ls[i]);
			}
		}
		
		//public Gee.HashMap<int,string> checkFile()
		//{
		//	return this.checkString(JsRender.NodeToVala.mungeFile(this.file));
		//}

		public Gee.HashMap<int,string> checkFileWithNodePropChange(
					File file,
					JsRender.Node node, 
					string prop,
					string ptype,
					string val,
					ValaSourceResult result_callback)
		{
			
			
			
			Gee.HashMap<int,string> ret = new Gee.HashMap<int,string> ();
			var hash = ptype == "listener" ? node.listeners : node.props;
			
			// untill we get a smarter renderer..
			// we have some scenarios where changing the value does not work
			if (prop == "* xns" || prop == "xtype") {
				return ret;
			}
				
			
			var old = hash.get(prop);
			var newval = "/*--VALACHECK-START--*/ " + val ;
			
			hash.set(prop, newval);
			var tmpstring = JsRender.NodeToVala.mungeFile(file);
			hash.set(prop, old);
			//print("%s\n", tmpstring);
			var bits = tmpstring.split("/*--VALACHECK-START--*/");
			var offset =0;
			if (bits.length > 0) {
				offset = bits[0].split("\n").length +1;
			}
			//this.dumpCode(tmpstring);
			//print("offset %d\n", offset);
			this.checkStringSpawn(tmpstring,  result_callback );
			
			// modify report
			
			
			
		}
		
		string tmpfile;
		public void checkStringSpawn(
					string contents,
					ValaSourceResult result_callback
				)
		{
			FileIOStream iostream;
			this.tmpfile = File.new_tmp ("test-XXXXXX.vala", out iostream);
			

			OutputStream ostream = iostream.output_stream;
			DataOutputStream dostream = new DataOutputStream (ostream);
			dostream.put_string (contents);
			
			
			string[] args = {};
			args += FileUtils.read_link("/proc/self/exe");
			args += "--project";
			args += this.project.fn;
			args += "--target";
			args += this.build_module;
			args += "--add-file";
			args += this.tmpfile;
			args += "--skip-file";
			args += this.filepath;
			
			
			
			this.compiler = new Spawn("/tmp", args);
			this.compiler.run((res, output, stderr) => {
				try { 
					var pa = new Json.Parser();
					pa.load_from_file(this.path);
					var node = pa.get_root();

					if (node.get_node_type () != Json.NodeType.OBJECT) {
						throw new Error.INVALID_FORMAT ("Unexpected element type %s", node.type_name ());
					}
					result_callback(node.get_object ())
					
					
				} catch (Error e) {
					var ret = new Json.Object();
					ret.set_boolean_member("success", false);
					ret.set_string_member("message", e.message);
					result_callback(ret);
				}
				
			});
			
			 
		}
		
		
		public void compile( )
		{
			// init context:
			var valac = "valac " ;
			
			context = new Vala.CodeContext ();
			Vala.CodeContext.push (context);
		
			context.experimental = false;
			context.experimental_non_null = false;
			
#if VALA_0_28
			var ver=28;
#elif VALA_0_26	
			var ver=26;
#elif VALA_0_24
			var ver=24;
#elif VALA_0_22	
			var ver=22;
#endif
			
			for (int i = 2; i <= ver; i += 2) {
				context.add_define ("VALA_0_%d".printf (i));
			}
			
			
			
			
			
			
			
			var vapidirs = this.project.vapidirs();
			// what's the current version of vala???
			
 			
			vapidirs +=  Path.get_dirname (context.get_vapi_path("glib-2.0")) ;
			
			for(var i =0 ; i < vapidirs.length; i++) {
				valac += " --vapidir=" + vapidirs[i];
			}
				
			
			// or context.get_vapi_path("glib-2.0"); // should return path..
			context.vapi_directories = vapidirs;
			context.report.enable_warnings = true;
			context.metadata_directories = { };
			context.gir_directories = {};
			context.thread = true;
			
			
			this.report = new ValaSourceReport(this.filepath, this.tmpname);
			context.report = this.report;
			
			
			context.basedir = "/tmp"; //Posix.realpath (".");
		
			context.directory = context.basedir;
		

			// add default packages:
			//if (settings.profile == "gobject-2.0" || settings.profile == "gobject" || settings.profile == null) {
			context.profile = Vala.Profile.GOBJECT;
 			 
			var ns_ref = new Vala.UsingDirective (new Vala.UnresolvedSymbol (null, "GLib", null));
			context.root.add_using_directive (ns_ref);

			var source_file = new Vala.SourceFile (
		    		context, 
		    		Vala.SourceFileType.SOURCE, 
					this.filepath,
					contents
	    		);
			source_file.add_using_directive (ns_ref);
			context.add_source_file (source_file);
			
	    	// add all the files (except the current one) - this.file.path
	    	var pr = this.project;
	    	if (this.file.build_module.length > 0) {
				var cg =  pr.compilegroups.get(this.build_module);
				for (var i = 0; i < cg.sources.size; i++) {
					var path = pr.resolve_path(
							pr.resolve_path_combine_path(pr.firstPath(),cg.sources.get(i)));
							
					if (!FileUtils.test(path, FileTest.EXISTS)) {
						continue;
					}       
	                // skip thie original
					if (path == this.original_filepath.replace(".bjs", ".vala")) {
						valac += " " + path;
						continue;
					}
					if (FileUtils.test(path, FileTest.IS_DIR)) {
						continue;
					}
					//print("Add source file %s\n", path);
					
					valac += " " + path;
					
					if (Regex.match_simple("\\.c$", path)) {
						context.add_c_source_file(path);
						continue;
					}
					
					
					var xsf = new Vala.SourceFile (
						context,
						Vala.SourceFileType.SOURCE, 
						path
					);
					xsf.add_using_directive (ns_ref);
					context.add_source_file(xsf);
					
				}
			}
			// default.. packages..
			context.add_external_package ("glib-2.0"); 
			context.add_external_package ("gobject-2.0");
			// user defined ones..
			
	    	var dcg = pr.compilegroups.get("_default_");
	    	for (var i = 0; i < dcg.packages.size; i++) {
				valac += " --pkg " + dcg.packages.get(i);
				context.add_external_package (dcg.packages.get(i));
			}
	    	
			 //Vala.Config.PACKAGE_SUFFIX.substring (1)
			
			// add the modules...
			
			
			
			//context.add_external_package ("libvala-0.24");
			
 
		
			//add_documented_files (context, settings.source_files);
		
			Vala.Parser parser = new Vala.Parser ();
			parser.parse (context);
			//gir_parser.parse (context);
			if (context.report.get_errors () > 0) {
				Vala.CodeContext.pop ();
				Glib.debug("parse got errors");
				//((ValaSourceReport)context.report).dump();
				this.report.result.set_boolean_member("success", false);
				this.report.result.set_string_member("message", "Parse failed");
				
				this.outputReport();
				return;
			}


			
			// check context:
			context.check ();
			if (context.report.get_errors () > 0) {
				Vala.CodeContext.pop ();
				Glib.debug("check got errors");
				//((ValaSourceReport)context.report).dump();
				this.report.result.set_boolean_member("success", false);
				this.report.result.set_string_member("message", "Check failed");
				
				this.outputReport();
				return;
			}
			
			//context.codegen = new Vala.GDBusServerModule ();
			
			 
			context.output = "/tmp/testbuild";
			valac += " -o " +context.output;
			//context.codegen.emit (context);
			/*
			var ccompiler = new Vala.CCodeCompiler ();
			var cc_command = Environment.get_variable ("CC");
			var pkg_config_command = Environment.get_variable ("PKG_CONFIG");
#if VALA_0_28
			ccompiler.compile (context, cc_command, new string[] { }, pkg_config_command);
#else
			ccompiler.compile (context, cc_command, new string[] { });
#endif
			*/
 
			Vala.CodeContext.pop ();
			this.outputReport();
		
		}
		public void outputResult()
		{
			var generator = new Json.Generator ();
		    generator.indent = 1;
		    generator.pretty = true;
		    var node = new Json.Node(Json.NodeType.OBJECT);
		    node.set_object(this.report.result);
		    
		    generator.set_root(node);
		    	 
			generator.pretty = true;
			generator.indent = 4;
		 

			print("%s\n",  generator.to_data (null));
			GLib.Process.exit(Posix.EXIT_SUCCESS);
			
			 
		}
/*		
		
		
		public Gee.HashMap<int,string> checkString(string contents)
		{
			// init context:
			var valac = "valac " ;
			
			context = new Vala.CodeContext ();
			Vala.CodeContext.push (context);
		
			context.experimental = false;
			context.experimental_non_null = false;
			
#if VALA_0_28
			var ver=28;
#elif VALA_0_26	
			var ver=26;
#elif VALA_0_24
			var ver=24;
#elif VALA_0_22	
			var ver=22;
#endif
			
			for (int i = 2; i <= ver; i += 2) {
				context.add_define ("VALA_0_%d".printf (i));
			}
			
			
			
			
			
			
			
			var vapidirs = ((Project.Gtk)this.file.project).vapidirs();
			// what's the current version of vala???
			
 			
			vapidirs +=  Path.get_dirname (context.get_vapi_path("glib-2.0")) ;
			
			for(var i =0 ; i < vapidirs.length; i++) {
				valac += " --vapidir=" + vapidirs[i];
			}
				
			
			// or context.get_vapi_path("glib-2.0"); // should return path..
			context.vapi_directories = vapidirs;
			context.report.enable_warnings = true;
			context.metadata_directories = { };
			context.gir_directories = {};
			context.thread = true;
			
			
			this.report = new ValaSourceReport(this.file.path);
			context.report = this.report;
			
			
			context.basedir = "/tmp"; //Posix.realpath (".");
		
			context.directory = context.basedir;
		

			// add default packages:
			//if (settings.profile == "gobject-2.0" || settings.profile == "gobject" || settings.profile == null) {
			context.profile = Vala.Profile.GOBJECT;
 			 
			var ns_ref = new Vala.UsingDirective (new Vala.UnresolvedSymbol (null, "GLib", null));
			context.root.add_using_directive (ns_ref);

			var source_file = new Vala.SourceFile (
		    		context, 
		    		Vala.SourceFileType.SOURCE, 
					"~~~~~testfile.vala",
					contents
	    		);
			source_file.add_using_directive (ns_ref);
			context.add_source_file (source_file);
			
	    	// add all the files (except the current one) - this.file.path
	    	var pr = ((Project.Gtk)this.file.project);
	    	if (this.file.build_module.length > 0) {
				var cg =  pr.compilegroups.get(this.file.build_module);
				for (var i = 0; i < cg.sources.size; i++) {
					var path = pr.resolve_path(
							pr.resolve_path_combine_path(pr.firstPath(),cg.sources.get(i)));
							
					if (!FileUtils.test(path, FileTest.EXISTS)) {
						continue;
					}       
	                 
					if (path == this.file.path.replace(".bjs", ".vala")) {
						valac += " " + path;
						continue;
					}
					if (FileUtils.test(path, FileTest.IS_DIR)) {
						continue;
					}
					//print("Add source file %s\n", path);
					
					valac += " " + path;
					
					if (Regex.match_simple("\\.c$", path)) {
						context.add_c_source_file(path);
						continue;
					}
					
					
					var xsf = new Vala.SourceFile (
						context,
						Vala.SourceFileType.SOURCE, 
						path
					);
					xsf.add_using_directive (ns_ref);
					context.add_source_file(xsf);
					
				}
			}
			// default.. packages..
			context.add_external_package ("glib-2.0"); 
			context.add_external_package ("gobject-2.0");
			// user defined ones..
			
	    	var dcg = pr.compilegroups.get("_default_");
	    	for (var i = 0; i < dcg.packages.size; i++) {
				valac += " --pkg " + dcg.packages.get(i);
				context.add_external_package (dcg.packages.get(i));
			}
	    	
			 //Vala.Config.PACKAGE_SUFFIX.substring (1)
			
			// add the modules...
			
			
			
			//context.add_external_package ("libvala-0.24");
			
			this.report.compile_notice("START", "", 0, "");

		
			//add_documented_files (context, settings.source_files);
		
			Vala.Parser parser = new Vala.Parser ();
			parser.parse (context);
			//gir_parser.parse (context);
			if (context.report.get_errors () > 0) {
				print("parse got errors");
				((ValaSourceReport)context.report).dump();
				
				Vala.CodeContext.pop ();
				this.report.compile_notice("END", "", 0, "");
				return this.report.line_errors;
			}


			
			// check context:
			context.check ();
			if (context.report.get_errors () > 0) {
				print("check got errors");
				((ValaSourceReport)context.report).dump();
				Vala.CodeContext.pop ();
				this.report.compile_notice("END", "", 0, "");
				return this.report.line_errors;
				
			}
			
			//context.codegen = new Vala.GDBusServerModule ();
			
			 
			context.output = "/tmp/testbuild";
			valac += " -o " +context.output;
			//context.codegen.emit (context);
			 odeContext.pop ();
			//(new Vala.CodeNode()).get_error_types().clear();
			//(new Vala.NullType()).get_type_arguments().clear();
			(new Vala.NullType(null)).get_type_arguments().clear();
			parser = null;
 			this.report.compile_notice("END", "", 0, "");
			print("%s\n", valac);
			print("ALL OK?\n");
			return this.report.line_errors;
		}
	//
		// startpoint:
		//
	 */
	}
}
/*
int main (string[] args) {

	var a = new ValaSource(file);
	a.create_valac_tree();
	return 0;
}
*/


