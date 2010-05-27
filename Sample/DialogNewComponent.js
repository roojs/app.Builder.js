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
        delete_event : function (self, event) {
            this.el.hide();
            return true;
        },
        response : function (self, response_id) {
        	if (response_id < 1) { // cancel!
                    this.el.hide();
                    return;
                }
        
                if (!this.get('name').el.get_text().length ) {
                    this.get('/StandardErrorDialog').show(
                        "You have to set Project name "
                    );
                     
                    return;
                }
                var isNew = this.file.name.length ? false : true;
                
                if (this.file.name.length && this.file.name != this.get('name').el.get_text().length ) {
                    this.get('/StandardErrorDialog').show(
                        "Sorry changing names does not work yet. "
                    );
                     
                    return;
                }
                for (var i in this.def) {
                    this.file[i] =  this.get(i).el.get_text();
                }
               
                if (!isNew) {
                    file.save();
                    this.el.hide();
                    return;
                }
               
            
        	var dir ='';
                for (var i in this.project.paths) {
         		dir = i;
        		break;
        	}
        
         
                
                // what about .js ?
                 if (GLib.file_test (GLib.dir + '/' + this.file.name + '.bjs', GLib.FileTest.EXISTS)) {
                    StandardErrorDialog.show(
                        "That file already exists"
                    ); 
                    return;
                }
                this.el.hide();
                
                
                //var tmpl = this.project.loadFileOnly(DialogNewComponent.get('template').getValue());
                
                var _this = this;
                var nf = _this.project.create(dir + '/' + this.file.name + '.bjs');
                for (var i in this.file) {
                    nf[i] = this.file[i];
                }
                if (this.get('/DialogNewComponent').success) {
                    this.get('/DialogNewComponent').success(_this.project, nf);
                }
        },
        show : function (self) {
          this.el.show_all();
        }
    },
    default_height : 200,
    default_width : 500,
    id : "DialogNewComponent",
    title : "New Component",
    deletable : false,
    modal : true,
    show : function (c) 
    {
    
        if (!this.el) {
            this.init();
        }
        this.def =  { 
            name : '' , 
            title : '' ,
            region : '' ,
            parent: '',
            disable: '',
            modOrder : '0'
        };
        for (var i in this.def) {
            c[i] = c[i] || this.def[i];
            this.get(i).el.set_text(c[i]);
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
                            label : "Disable method",
                            pack : "add",
                            x_options : 4,
                            xalign : 0.9,
                            justify : Gtk.Justification.RIGHT,
                            visible : true
                        },
                        {
                            xtype: Gtk.Entry,
                            id : "disable",
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
