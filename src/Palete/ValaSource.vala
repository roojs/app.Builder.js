
// valac TreeBuilder.vala --pkg libvala-0.24 --pkg posix -o /tmp/treebuilder

/**
 * 
 *  This just deals with spawning the compiler and getting the results.
 * 
 *  each window should have one of these...
 * 
 *  x = new ValaSource();
 *  x.connect.compiled(... do something with results... );
 *  
 * x.
 * 
 */

namespace Palete {
	
	public errordomain ValaSourceError {
		INVALID_FORMAT 
	}
	
	//public delegate  void ValaSourceResult(Json.Object res);
	
	 

	public class ValaSource : Object {
 
		
		public signal void compiled(Json.Object res);

		
		JsRender.JsRender file;
  		public int line_offset = 0;
		
 		public ValaSource( ) 
 		{
			base();
			this.compiler = null;
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

		public bool checkFileWithNodePropChange(
		  
					JsRender.JsRender file,
					JsRender.Node node, 
					string prop,
					string ptype,
					string val
				 )
		{
			this.file = file;
 			
 			if (this.compiler != null) {
				return false;
			}
			
			 
			var hash = ptype == "listener" ? node.listeners : node.props;
			
			// untill we get a smarter renderer..
			// we have some scenarios where changing the value does not work
			if (prop == "* xns" || prop == "xtype") {
				return  false;
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
			
			this.line_offset = offset;
			
			//this.dumpCode(tmpstring);
			//print("offset %d\n", offset);
 			return this.checkStringSpawn(tmpstring );
			
			// modify report
			
			
			
		}
		Spawn compiler;
		 
		public bool checkStringSpawn(
				string contents 
			)
		{
 			
 			if (this.compiler != null) {
				return false;
			}
 			
			FileIOStream iostream;
			var tmpfile = File.new_tmp ("test-XXXXXX.vala", out iostream);
			tmpfile.ref();

			OutputStream ostream = iostream.output_stream;
			DataOutputStream dostream = new DataOutputStream (ostream);
			dostream.put_string (contents);
			
			var valafn = "";
			try {             
			   var  regex = new Regex("\\.bjs$");
			
				valafn = regex.replace(this.file.path,this.file.path.length , 0 , ".vala");
			 } catch (GLib.RegexError e) {
				 
			    return false;
			}   
			
			string[] args = {};
			args += BuilderApplication._self;
			args += "--project";
			args += this.file.project.fn;
			args += "--target";
			args += this.file.build_module;
			args += "--add-file";
			args +=  tmpfile.get_path();
			args += "--skip-file";
			args += valafn;
			
			 
			
			this.compiler = new Spawn("/tmp", args);
			this.compiler.complete.connect(spawnResult);
			
			try {
				this.compiler.run(); 
			} catch (GLib.SpawnError e) {
			        GLib.debug(e.message);
         			this.compiler = null;
			        return false;

			}
			return true;
			 
		}
		
		public bool checkFileSpawn(JsRender.JsRender file )
		{
 			// race condition..
 			if (this.compiler != null) { 
				return false;
			}
 			
 			this.file = file;
			this.line_offset = 0;
			  
			string[] args = {};
			args += BuilderApplication._self;
			args += "--project";
			args += this.file.project.fn;
			args += "--target";
			args += this.file.build_module;
			 
			 
			
			this.compiler = new Spawn("/tmp", args);
			this.compiler.complete.connect(spawnResult);
			
			try {
				this.compiler.run(); 
			} catch (GLib.SpawnError e) {
			    GLib.debug(e.message);
			    return false;
			}
			 
		}
		/**
		* Used to compile a non builder file..
		*/
		 
		public void checkPlainFileSpawn(  JsRender.JsRender file, string contents )
		{
 			// race condition..
 			if (this.compiler != null) { 
				return;
			}
			var pr = (Project.Gtk)(file.project);
 			
			var m = pr.firstBuildModule();
			var cg = pr.compilegroups.get(m);
			var foundit = false;
			for (var i = 0; i < cg.sources.size; i++) {
			    var path = pr.resolve_path(
				    pr.resolve_path_combine_path(pr.firstPath(),cg.sources.get(i)));
		            if (path == file.path) {
		                foundit = true;
		                break;
	                    }
			
			}
			if (!foundit) {
    			    var ret = new Json.Object();
			    ret.set_boolean_member("success", true);
			    ret.set_string_member("message", "no need to compile");
			    this.compiled(ret);
			    this.compiler = null;
			
			    return; // do not run the compile..
			}
			// is the file in the module?
			
 			
 			FileIOStream iostream;
			var tmpfile = File.new_tmp ("test-XXXXXX.vala", out iostream);
			tmpfile.ref();

			OutputStream ostream = iostream.output_stream;
			DataOutputStream dostream = new DataOutputStream (ostream);
			dostream.put_string (contents);
			
 			
 			this.file = null;
			this.line_offset = 0;
			  
			string[] args = {};
			args += BuilderApplication._self;
			args += "--project";
			args +=  file.project.fn;
			args += "--target";
			args += pr.firstBuildModule();
			args += "--add-file";
			args +=  tmpfile.get_path();
			args += "--skip-file";
			args += file.path;
			 
			
			this.compiler = new Spawn("/tmp", args);
			this.compiler.complete.connect(spawnResult);
			
			try {
			    this.compiler.run(); 
			} catch (GLib.SpawnError e) {
			    var ret = new Json.Object();
			    ret.set_boolean_member("success", false);
			    ret.set_string_member("message", e.message);
			    this.compiled(ret);
			    this.compiler = null;
			}
			 
		}
		
		
		public void spawnResult(int res, string output, string stderr)
		{
			 
				
			try { 
				//GLib.debug("GOT output %s", output);
				
				var pa = new Json.Parser();
				pa.load_from_data(output);
				var node = pa.get_root();

				if (node.get_node_type () != Json.NodeType.OBJECT) {
					var ret = new Json.Object();
					ret.set_boolean_member("success", false);
					ret.set_string_member("message", 
						"Compiler returned Unexpected element type %s".printf( 
							node.type_name ()
						)
					);
					this.compiled(ret);
					this.compiler = null;
				}
				var ret = node.get_object ();
				ret.set_int_member("line_offset", this.line_offset);
				
				this.compiled(ret);
				
				
			} catch (Error e) {
				var ret = new Json.Object();
				ret.set_boolean_member("success", false);
				ret.set_string_member("message", e.message);
				this.compiled(ret);
			}
			this.compiler = null;
			//compiler.unref();
			//tmpfile.unref();
			 
			
			
		}
	}
		 
}
/*
int main (string[] args) {

	var a = new ValaSource(file);
	a.create_valac_tree();
	return 0;
}
*/


