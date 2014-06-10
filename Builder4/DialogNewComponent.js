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
DialogNewComponent=new XObject({
    xtype: Gtk.Dialog,
    listeners : {
        delete_event : (self, event) => {
            this.el.hide();
            return true;
        },
        response : (self, response_id) =>  {
          
        	if (response_id < 1) { // cancel!
                    this.el.hide();
                    return;
                }
        
                if (DialogNewComponent.name.el.get_text().length  < 1) {
                    StandardErrorDialog.show(
                        "You have to set Project name "
                    );
                     
                    return;
                }
                // what does this do?
                /*
                var isNew = _this.file.name.length  > 0 ? false : true;
                
                if (this.file.name.length > 0 && this.file.name != _this.name.el.get_text()) {
                    StandardErrorDialog.show(
                        "Sorry changing names does not work yet. "
                    );
                     
                    return;
                }
                */
                // FIXME - this may be more complicated...
                //for (var i in this.def) {
                //    this.file[i] =  this.get(i).el.get_text();
                //}
               /*
                if (!isNew) {
                    this.file.save();
                    this.el.hide();
                    return;
                }
               */
            
        	//var dir ='';
        	//FIXME...
                //for (var i in this.project.paths) {
         	//	dir = i;
        	//	break;
        	//}
        
         
                
                // what about .js ?
                if (GLib.file_test (GLib.dir + "/" + this.file.name + ".bjs", GLib.FileTest.EXISTS)) {
                    StandardErrorDialog.show(
                        "That file already exists"
                    ); 
                    return;
                }
                this.el.hide();
                
                
                //var tmpl = this.project.loadFileOnly(DialogNewComponent.get('template').getValue());
                 
                var nf = _this.project.create(dir + "/" + this.file.name + ".bjs");
                //for (var i in this.file) {
                //    nf[i] = this.file[i];
                //}
                
                if (DialogNewComponent.success != null) {
                    DialogNewComponent.success(_this.project, nf);
                }
        },
        show : (self)  => {
          this.el.show_all();
        }
    },
    default_height : 200,
    default_width : 500,
    id : "DialogNewComponent",
    title : "New Component",
    deletable : false,
    modal : true,
    'void:show' : (JsRender.JsRender c) 
    {
        this.project = c.project;
        if (!this.el) {
            //this.init();
        }
        this.def =  { 
            name : '' , 
            title : '' ,
            region : '' ,
            parent: '',
          //  disable: '',
            modOrder : '0',
            permname : ''
        };
        for (var i in this.def) {
            c[i] = c[i] || this.def[i];
            this.get(i).el.set_text(c[i]);
        }
        if (c.name) {
            this.el.set_title("Edit File Details - " + c.name);
        } else {
            this.el.set_title("Create New File");
        }
         
        this.file = c;
        console.log('show all');
        this.el.show_all();
        this.success = c.success;
        
        
    },
    items : [
        {
            xtype: Gtk.VBox,
            pack : function(p,e) {
                                p.el.get_content_area().add(e.el)
                            },
            items : [
                {
                    xtype: Gtk.Table,
                    n_columns : 2,
                    n_rows : 3,
                    pack : "pack_start,false,false,0",
                    homogeneous : false,
                    items : [
                        {
                            xtype: Gtk.Label,
                            label : "Component Name",
                            pack : "add",
                            x_options : 4,
                            xalign : 0.9,
                            justify : Gtk.Justification.RIGHT
                        },
                        {
                            xtype: Gtk.Entry,
                            id : "name",
                            pack : "add",
                            visible : true
                        },
                        {
                            xtype: Gtk.Label,
                            label : "Title",
                            pack : "add",
                            x_options : 4,
                            xalign : 0.9,
                            justify : Gtk.Justification.RIGHT,
                            visible : true
                        },
                        {
                            xtype: Gtk.Entry,
                            id : "title",
                            pack : "add",
                            visible : true
                        },
                        {
                            xtype: Gtk.Label,
                            label : "Region",
                            pack : "add",
                            tooltip_text : "center, north, south, east, west",
                            x_options : 4,
                            xalign : 0.9,
                            justify : Gtk.Justification.RIGHT,
                            visible : true
                        },
                        {
                            xtype: Gtk.Entry,
                            id : "region",
                            pack : "add",
                            visible : true
                        },
                        {
                            xtype: Gtk.Label,
                            label : "Parent Name",
                            pack : "add",
                            x_options : 4,
                            xalign : 0.9,
                            justify : Gtk.Justification.RIGHT,
                            visible : true
                        },
                        {
                            xtype: Gtk.Entry,
                            id : "parent",
                            pack : "add",
                            visible : true
                        },
                        {
                            xtype: Gtk.Label,
                            label : "Permission Name",
                            pack : "add",
                            x_options : 4,
                            xalign : 0.9,
                            justify : Gtk.Justification.RIGHT,
                            visible : true
                        },
                        {
                            xtype: Gtk.Entry,
                            id : "permname",
                            pack : "add",
                            visible : true
                        },
                        {
                            xtype: Gtk.Label,
                            label : "Order (for tabs)",
                            pack : "add",
                            x_options : 4,
                            xalign : 0.9,
                            justify : Gtk.Justification.RIGHT,
                            visible : true
                        },
                        {
                            xtype: Gtk.Entry,
                            id : "modOrder",
                            pack : "add",
                            visible : true
                        }
                    ]
                }
            ]
        },
        {
            xtype: Gtk.Button,
            pack : "add_action_widget,0",
            label : "Cancel"
        },
        {
            xtype: Gtk.Button,
            pack : "add_action_widget,1",
            label : "OK"
        }
    ]
});
DialogNewComponent.init();
XObject.cache['/DialogNewComponent'] = DialogNewComponent;
