Gtk = imports.gi.Gtk;
Gdk = imports.gi.Gdk;
Pango = imports.gi.Pango;
XObject = imports.XObject.XObject;
Gtk.init(null,null);


_top=new XObject({xtype: Gtk.Window, "type":Gtk.WindowType.TOPLEVEL, "title":"Application Builder", "border_width":2, "id":"builder-0", "xtreepath":"0"})

;_top.init();
_top.el.show_all();
Gtk.main();
