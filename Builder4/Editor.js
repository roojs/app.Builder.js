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
Editor=new XObject({
    xtype: Gtk.Window,
    listeners : {
        delete_event : function (self, event) {
            if (!this.get('/Editor.RightEditor').save()) {
                // no hiding with errors.
                return true;
            }
            this.el.hide();
            this.get('/Editor').activePath = false;
            return true;
        }
        /*--
        
        (event) => {
            if (!Editor.RightEditor.save()) {
                // no hiding with errors.
                return true;
            }
            _this.hide();
            _this.activePath = '';
            return true;
        }
        
        */,
        configure_event : function (self, object) {
            this.pos = this.el.get_position();
        
            return false;
        }
        /*--
         (object) {
            _this.pos = true;
            this.get_position(out _this.pos_root_x, out _this.pos_root_y);
        
        
            return false;
        }
        */,
        show : function (self) {
            if (this.pos) {
                this.el.set_uposition(this.pos.root_x,this.pos.root_y);
            }
        }
        /*--
         () => {
            if (this.pos) {
                this.set_uposition(this.pos_root_x,this.pos_root_y);
            }
        }
        
        */
    },
    height_request : 300,
    id : "EditorWindow",
    title : "Application Builder - Editor",
    width_request : 500,
    init : function() {
        XObject.prototype.init.call(this);
       // this.show_all();
    },
    save : function (self, event) {
        if (!this.get('/Editor.RightEditor').save()) {
            // no hiding with errors.
            return true;
        }
        this.get('/Editor').activePath = false;
        this.el.hide();
        return true;
    }
    /*--
    
    (event) => {
    
        if (!Editor.RightEditor/save()) {
            // no hiding with errors.
            return true;
        }
        _this.activePath = false;
        _this.hide();
        return true;
    
    }
    */,
    items : [
        {
            xtype: Gtk.VBox,
            pack : "add",
            items : [
                {
                    xtype: Gtk.Toolbar,
                    pack : "pack_start,false,true",
                    items : [
                        {
                            xtype: Gtk.ToolButton,
                            listeners : {
                                clicked : function (self) {
                                
                                  this.get('/Editor.RightEditor').save();
                                }
                            },
                            id : "save_button",
                            label : "Save"
                        }
                    ]
                },
                {
                    xtype: Gtk.ScrolledWindow,
                    id : "RightEditor",
                    pack : "add",
                    save : function() {
                        // make sure we have an active path..
                         if (!this.get('/Editor').activePath) {
                            return true;
                         }
                         
                         var str = this.get('/Editor.buffer').toString();
                         if (!this.get('/Editor.buffer').checkSyntax()) {
                             this.get('/StandardErrorDialog').show("Fix errors in code and save.."); 
                             return false;
                         }
                         
                         this.get('/LeftPanel.model').changed(  str , false);
                         this.get('/Editor').dirty = false;
                         this.get('/Editor.save_button').el.sensitive = false;
                         return true;
                    },
                    items : [
                        {
                            xtype: GtkSource.View,
                            listeners : {
                                key_release_event : function (self, event) {
                                    
                                    if (event.key.keyval == 115 && (event.key.state & Gdk.ModifierType.CONTROL_MASK ) ) {
                                        print("SAVE: ctrl-S  pressed");
                                        this.save();
                                        return false;
                                    }
                                   // print(event.key.keyval)
                                    
                                    return false;
                                }
                            },
                            id : "view",
                            indent_width : 4,
                            pack : "add",
                            auto_indent : true,
                            init : function() {
                                XObject.prototype.init.call(this);
                                 var description = Pango.Font.description_from_string("monospace")
                                description.set_size(8000);
                                this.el.modify_font(description);
                            
                            },
                            insert_spaces_instead_of_tabs : true,
                            load : function(str) {
                            
                            // show the help page for the active node..
                               //this.get('/Help').show();
                            
                            
                              // this.get('/BottomPane').el.set_current_page(0);
                                this.el.get_buffer().set_text(str, str.length);
                                var lm = GtkSource.LanguageManager.get_default();
                                
                                this.el.get_buffer().set_language(lm.get_language('js'));
                                var buf = this.el.get_buffer();
                                var cursor = buf.get_mark("insert");
                                var iter= new Gtk.TextIter;
                                buf.get_iter_at_mark(iter, cursor);
                                iter.set_line(1);
                                iter.set_line_offset(4);
                                buf.move_mark(cursor, iter);
                                
                                
                                cursor = buf.get_mark("selection_bound");
                                iter= new Gtk.TextIter;
                                buf.get_iter_at_mark(iter, cursor);
                                iter.set_line(1);
                                iter.set_line_offset(4);
                                buf.move_mark(cursor, iter);
                                this.get('/Editor').dirty = false;
                                this.el.grab_focus();
                                 this.get('/Editor.save_button').el.sensitive = false;
                            },
                            save : function() {
                                
                                return this.get('/Editor.RightEditor').save();
                            },
                            show_line_numbers : true,
                            items : [
                                {
                                    xtype: GtkSource.Buffer,
                                    listeners : {
                                        changed : function (self) {
                                        
                                            if(this.checkSyntax()) {
                                                this.get('/Editor.save_button').el.sensitive = true;
                                            }
                                           // print("EDITOR CHANGED");
                                            this.get('/Editor').dirty = true;
                                        
                                            // this.get('/LeftPanel.model').changed(  str , false);
                                            return false;
                                        }
                                    },
                                    id : "buffer",
                                    pack : "set_buffer",
                                    checkSyntax : function() {
                                        var str = this.toString();
                                        var res = '';
                                        try {
                                          //  print('var res = ' + str);
                                            Seed.check_syntax('var res = ' + str);
                                            
                                           
                                        } catch (e) {
                                            
                                            this.get('/RightEditor.view').el.modify_base(Gtk.StateType.NORMAL, new Gdk.Color({
                                                red: 0xFFFF, green: 0xCCCC , blue : 0xCCCC
                                               }));
                                            print("SYNTAX ERROR IN EDITOR");   
                                            print(e);
                                            // print(str);
                                            //console.dump(e);
                                            return false;
                                        }
                                         this.get('/RightEditor.view').el.modify_base(Gtk.StateType.NORMAL, new Gdk.Color({
                                            red: 0xFFFF, green: 0xFFFF , blue : 0xFFFF
                                           }));
                                        
                                        return true;
                                    },
                                    toString : function() {
                                        
                                        var s = new Gtk.TextIter();
                                        var e = new Gtk.TextIter();
                                        this.el.get_start_iter(s);
                                        this.el.get_end_iter(e);
                                        var ret = this.el.get_text(s,e,true);
                                        //print("TO STRING? " + ret);
                                        return ret;
                                    }
                                }
                            ]
                        }
                    ]
                }
            ]
        }
    ]
});
Editor.init();
XObject.cache['/Editor'] = Editor;
