// compile
// valac   --pkg  gtk+-3.0  enum.vala --pkg libvala-0.26  -o /tmp/enum
// ??--pkg javascriptcore \


int main (string[] args) {
	
	var max = (int)Vala.TokenType.YIELD +1;
	for (var i =0; i < max;i++) {
		var m = (Vala.TokenType)i;
		var s = m.to_string();
		var ss = s.slice(1,-1);
		if (s[0] == '`' && GLib.Regex.match_simple("^[a-z]+$", ss)) {
			print("%s\n",ss);
		}
	}
	
	
	Gtk.init(ref args);
	var type = typeof(Gtk.Box);
	var  ocl = (ObjectClass) type.class_ref ();
	var ps = ocl.find_property("orientation");
	var vt = ps.value_type;
    EnumClass ec = (EnumClass) vt.class_ref ();
	for (var i =0;i< ec.n_values; i++) {
		var ev = ec.values[i];
		print("%s : %d\n", ev.value_name,ev.value);
	}
	 
	return 0;
}
	 
