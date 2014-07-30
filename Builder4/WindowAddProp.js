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
WindowAddProp=new XObject({
    xtype: Gtk.ScrolledWindow,
    id : "WindowAddProp",
    init : this.el.set_policy (Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC);,
    shadow_type : Gtk.ShadowType.IN,
    'void:show' : (Palete.Palete pal, string etype, string xtype) {
        this.model.el.clear();
    
        Gtk.TreeIter iter;
        var elementList = pal.getPropertiesFor( xtype,etype);
        
        
        //print ("GOT " + elementList.length + " items for " + fullpath + "|" + type);
               // console.dump(elementList);
               
        var miter = elementList.map_iterator();
        while (miter.next()) {
           var p = miter.get_value();
            
            this.model.el.append(out iter);
    
            this.model.el.set(iter,
                    0,  p.name, 
                    1, p.type,
                    2, "<span size=\"small\"><b>" + p.name +"</b> <i>"+p.type+"</i></span>\n" + p.doctxt,
                    3, p.sig,
                    4, "<span size=\"small\"><b>" + p.name +"</b> <i>"+p.type+"</i></span>",
                    5, etype,
                    -1
            );
        }
                                 
    },
    items : [
        {
            xtype: Gtk.TreeView,
            listeners : {
                cursor_changed : () => {
                        Gtk.TreeIter iter;
                        Gtk.TreeModel mod;
                
                        var m = _this.model;
                        var s = this.el.get_selection();
                        if (!s.get_selected(out mod, out iter)) {
                		return; 
                	}
                        var tp = m.el.get_path(iter).to_string();
                        
                        
                        // var val = "";
                        
                        
                        var key = m.getValue(iter, 0);
                        
                        var type = m.getValue(iter, 1);
                        var skel = m.getValue(iter, 3);
                        var etype = m.getValue(iter, 5);
                        
                        
                        
                        _this.select(key,type,skel, etype);
                        
                }
            },
            pack : "add",
            tooltip_column : 2,
            enable_tree_lines : true,
            headers_visible : false,
            init : {  
                   var description = new Pango.FontDescription();
                 description.set_size(8000);
                this.el.modify_font(description);     
                                
                this.el.get_selection().set_mode( Gtk.SelectionMode.SINGLE);
             
            
                
              
                
            },
            items : [
                {
                    xtype: Gtk.ListStore,
                    id : "model",
                    n_columns : 6,
                    pack : "set_model",
                    columns : typeof(string),  // 0 real key
                    typeof(string), // 1 real type
                    typeof(string), // 2 docs ?
                    typeof(string), // 3 visable desc
                    typeof(string), // 4 function desc
                    typeof(string) // 5 element type (event|prop),
                    'string:getValue' : (Gtk.TreeIter iter, int col)
                    {
                    
                        GLib.Value value;
                        this.el.get_value(iter, col, out value);
                    
                        return (string)value;
                        
                    }
                },
                {
                    xtype: Gtk.TreeViewColumn,
                    id : "namecol",
                    pack : "append_column",
                    init : this.el.add_attribute(_this.namerender.el , "markup", 4  );,
                    items : [
                        {
                            xtype: Gtk.CellRendererText,
                            id : "namerender",
                            pack : "pack_start,true"
                        }
                    ]
                }
            ]
        }
    ]
});
WindowAddProp.init();
XObject.cache['/WindowAddProp'] = WindowAddProp;
