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
    listeners : {
        response : function (self, response_id) {
           this.el.hide();
        print("RESPOSE: " + response_id);
            if (response_id == -8) { //yes!
           print("CALL SUCCES?")
            this.success(); //  fixme a delegate
            }
        }
        /*--
         ( response_id) =>  {
           this.el.hide();
            //print("RESPOSE: " + response_id);
            if (response_id == -8) { //yes!
                   print("CALL SUCCES?");
              // this.success();
            }
        
        }
        */,
        delete_event : function (self, event) {
            this.el.hide();
            return true;
        }
        /*--
        (event) => {
            this.hide();
            return true;
        }
        */
    },
    text : "Test",
    title : "Please Confirm",
    buttons : Gtk.ButtonsType.YES_NO,
    message_type : Gtk.MessageType.QUESTION,
    modal : true,
    show : function(msg, success) {
         if (!this.el) {
                this.init();
            }
         this.success = success;
            this.el.text =  msg;
            this.el.show_all();
    
    }
    /*--
    void (string msg) {
         //if (!this.el) { this.init(); } 
         //this.success = success;
        this.text =  msg;
        this.show_all();
    
    }
    
    */,
    use_markup : true
});
DialogConfirm.init();
XObject.cache['/DialogConfirm'] = DialogConfirm;
