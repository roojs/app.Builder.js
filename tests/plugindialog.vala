

// compile
// valac plugindialog.vala ../src/Builder4/DialogPluginWebkit.vala ../src/Builder4/FakeServer --pkg  gtk+-3.0  --pkg webkit2gtk-3.0 -o /tmp/plugtest
// ??--pkg javascriptcore \


int main (string[] args) {
	Gtk.init (ref args);
	var c  = new Xcls_DialogPluginWebkit();
	c.show(null, "hello");


	Gtk.main();
    
	
	return 0;
}
