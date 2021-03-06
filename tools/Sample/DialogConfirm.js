Gtk = imports.gi.Gtk;
Gdk = imports.gi.Gdk;
Pango = imports.gi.Pango;
GLib = imports.gi.GLib;
Gio = imports.gi.Gio;
GObject = imports.gi.GObject;
GtkSource = imports.gi.GtkSource;
WebKit = imports.gi.WebKit;
Vte = imports.gi.Vte;
console = imports.console;
XObject = imports.XObject.XObject;
DialogConfirm=new XObject({
    xtype: Gtk.MessageDialog,
    show : function(msg, success) {
         if (!this.el) {
                this.init();
            }
         this.success = success;
            this.el.text =  msg;
            this.el.show_all();
    
    },
    buttons : Gtk.ButtonsType.YES_NO,
    title : "Please Confirm",
    message_type : Gtk.MessageType.QUESTION,
    use_markup : true,
    text : "-",
    modal : true,
    listeners : {
        response : function (self, response_id) {
           this.el.hide();
        print("RESPOSE: " + response_id);
            if (response_id == -8) { //yes!
           print("CALL SUCCES?")
              this.success();
            }
        },
        delete_event : function (self, event) {
            this.el.hide();
            return true;
        }
    }
});
DialogConfirm.init();
XObject.cache['/DialogConfirm'] = DialogConfirm;
