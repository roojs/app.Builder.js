//<Script type="text/javascript">
Gio = imports.gi.Gio;
Gtk = imports.gi.Gtk;
Gdk = imports.gi.Gdk;
GLib = imports.gi.GLib;
GObject = imports.gi.GObject;
Pango = imports.gi.Pango ;

XObject = imports.XObject.XObject;
console = imports.console;


LeftPanelPopup  = imports.Builder.LeftPanelPopup.LeftPanelPopup;
RightEditor     = imports.Builder.RightEditor.RightEditor;
/**
 * 
 * really the properties..
 */


LeftPanel = new XObject({
        
        xtype: Gtk.ScrolledWindow,
        smooth_scroll : true,
        pack : [ 'pack_end', true, true, 0 ],
        shadow_type : Gtk.ShadowType.IN,
        
        init : function () {
            XObject.prototype.init.call(this); 
            this.el.set_policy (Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC);
        },
        items : [
            {
                id : 'view',
                
                xtype : Gtk.TreeView,
                
                tooltip_column : 1,
                headers_visible :   false ,
                enable_tree_lines :  true ,
                     
                init : function () {
                    XObject.prototype.init.call(this); 
                       
                    this.selection = this.el.get_selection();
                    this.selection.set_mode( Gtk.SelectionMode.SINGLE);
                 
                    
                    var description = new Pango.FontDescription.c_new();
                    description.set_size(8000);
                    this.el.modify_font(description);
                },     
                listeners : {
                    
                  
                    'button-press-event' : function(tv, ev) {
                        if (ev.type != Gdk.EventType.BUTTON_PRESS  || ev.button.button != 3) {
                            Seed.print("click" + ev.type);
                            return false;
                        }
                      
                    
                        var res = { }; 
                        this.el.get_path_at_pos(ev.button.x,ev.button.y, res);
                        
                        if (res.column.title == 'value') {
                            return false;
                        }
                        if (!LeftPanelPopup.el) LeftPanelPopup.init();
                        LeftPanelPopup.el.set_screen(Gdk.Screen.get_default());
                        LeftPanelPopup.el.show_all();
                        LeftPanelPopup.el.popup(null, null, null, null, 3, ev.button.time);
                        Seed.print("click:" + res.column.title);
                        return false;
                        
                    }
                },
                items : [
                
                    {
                        id : 'model',
                        pack : [ 'set_model' ],
                        xtype : Gtk.ListStore,
                        
                        init : function ()
                        {
                            XObject.prototype.init.call(this); 
                            this.el.set_column_types ( 5, [
                                GObject.TYPE_STRING,  // 0 real key
                                GObject.TYPE_STRING, // 1 real value 
                                 GObject.TYPE_STRING,  // 2 visable key
                                 GObject.TYPE_STRING, // 3 visable value
                                 GObject.TYPE_STRING, // 4 need to store type of!!!
                              
                            ]);
                                    
                            
                         
                        },
                        toShort: function(str) {
                            var a = typeof(str) == 'string' ? str.split("\n") : [];
                            return a.length > 1 ? a[0] + '....' : '' + str;
                        },
                        load : function (ar)
                        {
                            this.el.clear();
                            
                            RightEditor.el.hide();
                            if (ar === false) {
                                return ;
                            }
                            
                            // sort!!!?
                            var iter = new Gtk.TreeIter();
                            for (var i in ar) {
                                if (typeof(ar[i]) == 'object') {
                                    continue;
                                }
                                this.el.append(iter);
                                this.el.set_value(iter, 0, i);
                                this.el.set_value(iter, 1, '' + ar[i]);
                                this.el.set_value(iter, 2, i);
                                this.el.set_value(iter, 3, this.toShort(ar[i]));
                                this.el.set_value(iter, 4, typeof(ar[i]));
                            }
                            ar.listeners = ar.listeners || {};
                            for (var i in ar.listeners ) {
                                this.el.append(iter);
                                this.el.set_value(iter, 0, '!'+  i  );
                                this.el.set_value(iter, 1, '' + ar.listeners[i]);
                                this.el.set_value(iter, 2, '<b>'+ i + '</b>');
                                
                                this.el.set_value(iter, 3, '' + this.toShort(ar.listeners[i]));
                                this.el.set_value(iter, 4, typeof(ar[i]));
                            }
                            
                        },
                        
                        
                        
                        add : function( info ) {
                            // info includes key, val, skel, etype..
                             console.dump(info);
                            type = info.type.toLowerCase();
                            var data = this.toJS();
                            if ((typeof(data[info.key]) != 'undefined') && 
                                (typeof(info.val) == 'undefined') ) {
                                return;
                            }
                            if (typeof(info.val) == 'undefined') {
                                    
                                info.val = '';
                                if (info.type == 'boolean') {
                                    info.val = true;
                                }
                                if (type == 'number') {
                                    info.val = 0;
                                }
                                // utf8 == string..
                                
                                
                            }
                            if (info.etype == 'events') {
                                 
                                data['!' + info.key] = info.val;
                            } else {
                                data[info.key] = info.val;
                            }
                            
                            
                            this.load(data);
                            var LeftTree        = imports.Builder.LeftTree.LeftTree;
                            LeftTree.get('model').changed(data, true); 
                            
                            
                        },
                        deleteSelected : function()
                        {
                            var data = this.toJS();
                            var iter = new Gtk.TreeIter();
                            var s = LeftPanel.get('view').selection;
                            s.get_selected(this.el, iter);
                                 
                               
                            var gval = new GObject.Value('');
                            LeftPanel.get('model').el.get_value(iter, 0 ,gval);
                            
                            var val = gval.value;
                            if (val[0] == '!') {
                                // listener..
                                if (!data.listeners || typeof(data.listeners[val.substring(1)]) == 'undefined') {
                                    return;
                                }
                                delete data.listeners[val.substring(1)];
                                if (!XObject.keys(data.listeners).length) {
                                    delete data.listeners;
                                }
                                
                            } else {
                                if (typeof(data[val]) == 'undefined') {
                                    return;
                                }
                                delete data[val];
                            }
                            
                            
                            this.load(data);
                            var LeftTree        = imports.Builder.LeftTree.LeftTree;
                            LeftTree.get('model').changed(data, true);
                            
                        },
                        
                        
                        
                        activeIter : false,
                        changed : function(str, doRefresh)
                        {
                            if (!this.activeIter) {
                                return;
                            }
                            this.el.set_value(this.activeIter, 1, str);
                            this.el.set_value(this.activeIter, 3, '' + this.toShort(str));
                            // update the tree...
                            var LeftTree        = imports.Builder.LeftTree.LeftTree;
                            LeftTree.get('model').changed(this.toJS(), doRefresh); 
                        },
                        toJS: function()
                        {
                            var iter = new Gtk.TreeIter();
                            LeftPanel.get('model').el.get_iter_first(iter);
                            var ar = {};
                               
                            while (true) {
                                
                                var k = this.getValue(iter, 0);
                                Seed.print(k);
                                if (k[0] == '!') {
                                    ar.listeners = ar.listeners || {};
                                    ar.listeners[k.substring(1)] = this.getValue(iter, 1);
                                    
                                } else {
                                    ar[ k ] = this.getValue(iter, 1);
                                }
                                
                                if (! LeftPanel.get('model').el.iter_next(iter)) {
                                    break;
                                }
                            }
                                Seed.print(JSON.stringify(ar));
                            return ar;
                            // convert the list into a json string..
                        
                            
                        },
                        getValue: function (iter, col) {
                            var gval = new GObject.Value('');
                            LeftPanel.get('model').el.get_value(iter, col ,gval);
                            var val = '' + gval.value;
                            if (col != 1) {
                                return val;
                            }
                            gval = new GObject.Value('');
                            LeftPanel.get('model').el.get_value(iter,4  ,gval);
                            switch(gval.value) {
                                case 'number':
                                    return parseFloat(val);
                                case 'boolean':
                                    return val == 'true' ? true : false;
                                default: 
                                    return val;
                            }
                            
                        } 
                          
                        
                    },

                    {
                        
                        xtype: Gtk.TreeViewColumn,
                        pack : ['append_column'],
                        title : 'key',
                        init : function ()
                        {
                            XObject.prototype.init.call(this); 
                            this.el.add_attribute(this.items[0].el , 'markup', 2 );
                        },
                        items : [
                            {
                                xtype : Gtk.CellRendererText,
                                pack : ['pack_start'],
                            }
                        ]
                    },
                            
                    {
                        
                        xtype: Gtk.TreeViewColumn,
                        pack : ['append_column'],
                        title : 'value',
                        init : function ()
                        {
                            XObject.prototype.init.call(this); 
                            this.el.add_attribute(this.items[0].el , 'text', 3 );
                             
                        },
                        items : [
                        
                         
                            {
                                
                                xtype : Gtk.CellRendererText,
                                pack : ['pack_start'],
                                editable : true,
                                
                                
                                
                                listeners : {
 
                                    edited : function(r,p, t) {
                                        LeftPanel.get('model').changed(t, true);
                                        LeftPanel.get('model').activeIter = false;
                                        
                                    },
                                   
                                    'editing-started' : function(r, e, p) {
                                        
                                        var iter = new Gtk.TreeIter();
                                        var s = LeftPanel.get('view').selection;
                                        s.get_selected(LeftPanel.get('model').el, iter);
                                         
                                       
                                        var gval = new GObject.Value('');
                                        LeftPanel.get('model').el.get_value(iter, 0 ,gval);
                                        var val = '' + gval.value;
                                        
                                        gval = new GObject.Value('');
                                        LeftPanel.get('model').el.get_value(iter, 1 ,gval);
                                        var rval = gval.value;
                                         
                                        LeftPanel.get('model').activeIter = iter;
                                        //  not listener...
                                        
                                        var showEditor = false;
                                        
                                        if (val[0] == '!') {
                                            showEditor = true;
                                        }
                                        if (val[0] == '|') {
                                            if (rval.match(/function/g) || rval.match(/\n/g)) {
                                                showEditor = true;
                                            }
                                        }
                                        
                                        if (!showEditor) {
                                            RightEditor.el.hide();

                                            var type = LeftPanel.get('model').getValue(iter,4);
                                            
                                            // toggle boolean
                                            if (type == 'boolean') {
                                                val = ! LeftPanel.get('model').getValue(iter,1);
                                                
                                                
                                                LeftPanel.get('model').activeIter = false;
                                                GLib.timeout_add(0, 1, function() {
                                                    //   Gdk.threads_enter();
                                                     
                                                    e.editing_done();
                                                    e.remove_widget();
                                                    LeftPanel.get('model').activeIter = iter;
                                                    LeftPanel.get('model').changed(''+val,true);
                                                    
                                             
                                                    return false;
                                                });
                                            }
                                            
                                            return;
                                        }
                                        LeftPanel.get('model').activeIter = false;
                                        GLib.timeout_add(0, 1, function() {
                                            //   Gdk.threads_enter();
                                            RightEditor.el.show();
                                            RightEditor.get('view').load( rval );
                                            
                                            e.editing_done();
                                            e.remove_widget();
                                            LeftPanel.get('model').activeIter = iter;
                                            
                                     //       Gdk.threads_leave();
                                            return false;
                                        });
                                        //r.stop_editing(true);
                                    }
                                },
                                
                            }
                        ]
                    }
                
                ]
            }
        ]    
            
    }
);
    
     
    
