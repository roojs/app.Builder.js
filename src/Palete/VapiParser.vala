

// valac VapiParser.vala --pkg libvala-0.24 --pkg posix -o /tmp/treebuilder

namespace Palete {
	 
	 
	 

	public class VapiParser : Vala.CodeVisitor {
		
		
		
		
		
 		Vala.CodeContext context;
 		public VapiParser() {
			base();
			if (Gir.cache == null) {
				Gir.cache =  new Gee.HashMap<string,Gir>();
			}
		}
		
		
		
		public override void visit_namespace (Vala.Namespace element) 
		{
			if (element == null) {
				
				return;
			}
			print("parsing namespace %s\n", element.name);
			if (element.name == null) {
				element.accept_children(this); // catch sub namespaces..
				return;
			}
			
			var g = new Gir.new_empty(element.name);
			Gir.cache.set(element.name, g);
			
			
			foreach(var c in element.get_classes()) {
				this.add_class(g, c);
			}
			
			element.accept_children(this); // catch sub namespaces..
			
			
		}
		
		public void add_class(GirObject parent, Vala.Class cls)
		{
		
			var c = new GirObject("Class", parent.name + "." + cls.name);
			parent.classes.set(cls.name, c);
			c.ns = parent.name;
			c.parent = cls.base_class == null ? "" : cls.base_class.get_full_name() ;  // extends...
			c.gparent = parent;
			
			foreach(var p in cls.get_properties()) {
				this.add_property(c, p);
			}
			// methods...
			foreach(var p in cls.get_signals()) {
				this.add_signal(c, p);
			}
			
			foreach(var p in cls.get_methods()) {
				// skip static methods..
				if (p.binding != Vala.MemberBinding.INSTANCE &&
					!(p is Vala.CreationMethod)
				) {
					continue;
				}
				
				this.add_method(c, p);
			}
			
			if (cls.base_class != null) {
				c.inherits.add(cls.base_class.get_full_name());
			}
			foreach(var p in cls.get_base_types()) {
				if (p.data_type != null) {
					c.implements.add(p.data_type.get_full_name());
				}
			}
			  
			
			
			 
		}
		public void add_property(GirObject parent, Vala.Property prop)
		{
			var c = new GirObject("Prop",prop.name);
			c.gparent = parent;
			c.ns = parent.ns;
			c.propertyof = parent.name;
			c.type  = prop.property_type.data_type == null ? "" : prop.property_type.data_type.get_full_name();
			parent.props.set(prop.name,c);
			
		}
		public void add_signal(GirObject parent, Vala.Signal sig)
		{
			var c = new GirObject("Signal",sig.name);
			c.gparent = parent;
			c.ns = parent.ns;
			
			if (sig.return_type.data_type != null) {
				//print("creating return type on signal %s\n", sig.name);
				var cc = new GirObject("Return", "return-value");
				cc.gparent = c;
				cc.ns = c.ns;
				cc.type  =  sig.return_type.data_type.get_full_name();
				c.return_value = cc;
			}
			parent.signals.set(sig.name,c);
			
			var params =  sig.get_parameters() ;
			if (params.size < 1) {
				return;
			}
			var cc = new GirObject("Paramset",sig.name); // what's the name on this?
			cc.gparent = c;
			cc.ns = c.ns;
			c.paramset = cc;
			
			
			foreach(var p in params) {
				this.add_param(cc, p);
			}
			
		}	
		
		public void add_method(GirObject parent, Vala.Method met)
		{
			var n = met.name == null ? parent.name : "";
			var ty  = "Method";
			if (met is Vala.CreationMethod && n == "") {
				n = ".new";
				ty = "Ctor";
			}
			
			var c = new GirObject(ty,n);
			c.gparent = parent;
			c.ns = parent.ns;
			
			if (met.return_type.data_type != null) {
				//print("creating return type on method %s\n", met.name);
				var cc = new GirObject("Return", "return-value");
				cc.gparent = c;
				cc.ns = c.ns;
				cc.type  =  met.return_type.data_type.get_full_name();
				c.return_value = cc;
			}
			if (met is Vala.CreationMethod) {
				parent.ctors.set(c.name,c);
			} else {
				parent.methods.set(met.name,c);
			}
			
			var params =  met.get_parameters() ;
			if (params.size < 1) {
				return;
			}
			var cc = new GirObject("Paramset",met.name); // what's the name on this?
			cc.gparent = c;
			cc.ns = c.ns;
			c.paramset = cc;
			
			
			foreach(var p in params) {
				if (p.name == null) {
					continue;
				}
				this.add_param(cc, p);
			}
			
		}
		
		public void add_param(GirObject parent, Vala.Parameter pam)
		{
			var c = new GirObject("Param",pam.name);
			c.gparent = parent;
			c.ns = parent.ns;
			parent.params.add(c);
			c.type = pam.variable_type.data_type == null ? "" : pam.variable_type.data_type.get_full_name();
			// this.checkParamOverride(c);   - this is an old kludge for Gir files..
			
		}
		
		public void create_valac_tree( )
		{
			// init context:
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
			
			 
			//var vapidirs = ((Project.Gtk)this.file.project).vapidirs();
			// what's the current version of vala???
			
 			
			//vapidirs +=  Path.get_dirname (context.get_vapi_path("glib-2.0")) ;
			 
				
			
			// or context.get_vapi_path("glib-2.0"); // should return path..
			//context.vapi_directories = vapidirs;
			context.report.enable_warnings = true;
			context.metadata_directories = { };
			context.gir_directories = {};
			context.thread = true;
			
			
			//this.report = new ValaSourceReport(this.file);
			//context.report = this.report;
			
			
			context.basedir = "/tmp"; //Posix.realpath (".");
		
			context.directory = context.basedir;
		

			// add default packages:
			//if (settings.profile == "gobject-2.0" || settings.profile == "gobject" || settings.profile == null) {
			context.profile = Vala.Profile.GOBJECT;
 			 
			var ns_ref = new Vala.UsingDirective (new Vala.UnresolvedSymbol (null, "GLib", null));
			context.root.add_using_directive (ns_ref);
 
			// default.. packages..
			context.add_external_package ("glib-2.0"); 
			context.add_external_package ("gobject-2.0");
			context.add_external_package ("gdk-3.0");
			context.add_external_package ("atk");
			context.add_external_package ("gdk-x11-3.0");
			context.add_external_package ("x11");
			
			// user defined ones..
			//context.add_package ("Gtk");
	    	  
			var vfile = new Vala.SourceFile (context, Vala.SourceFileType.PACKAGE, "/usr/share/vala-0.26/vapi/gtk+-3.0.vapi");
			context.add_source_file (vfile);
			 
			//context.add_external_package ("libvala-0.24");
			
			 
		
			//add_documented_files (context, settings.source_files);
		
			Vala.Parser parser = new Vala.Parser ();
			parser.parse (context);
			//gir_parser.parse (context);
			if (context.report.get_errors () > 0) {
				print("parse got errors");
				 
				
				Vala.CodeContext.pop ();
 				return ;
			}


			
			// check context:
			context.check ();
			if (context.report.get_errors () > 0) {
				print("check got errors");
				 
				Vala.CodeContext.pop ();
				 
				return;
				
			}
			 
			Vala.CodeContext.pop ();
			 
			context.accept(this);
			
			// dump the tree for Gtk?
			
			
			print("%s\n", Gir.cache.get("Gtk").asJSONString());
			print("ALL OK?\n");
		 
		}
	//
		// startpoint:
		//
	 
	}
}
 
int main (string[] args) {

	var a = new Palete.VapiParser( );
	a.create_valac_tree();
	return 0;
}
 


