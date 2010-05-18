//<script type="text/javascript">
Gio = imports.gi.Gio;
Gtk = imports.gi.Gtk;
Gdk = imports.gi.Gdk;
GObject = imports.gi.GObject;
 

/**
* we use a hidden window to render the created dialog...
* then use snapshot to render it to an image...
* 
*/
 

XObject = imports.XObject.XObject;
File = imports.File.File;
console = imports.console;

LeftTree = imports.Builder.LeftTree.LeftTree ;
LeftPanel = imports.Builder.LeftPanel.LeftPanel;
 //console.dump(imports.Builder.LeftTree);
 //Seed.quit();

RightGtkView = new XObject({
        xtype : Gtk.VBox,
        lastSrc : '',
        pack : [ 'append_page', new Gtk.Label({ label : "Gtk View" })  ],
        items : [
        
            {
                xtype: Gtk.HBox,
                pack : [ 'pack_start', false, true, 0 ],
                items : [       
                    {
                        
                        
                        xtype: Gtk.Button,
                        label : 'Show in New Window',
                        pack : [ 'pack_start', false, false, 0 ],
                        listeners : {
                            // pressed...
                            'button-press-event' : function(w, ev ){
                                /// dump..
                                RightGtkView.showInWindow();
                                return true;
                                // show the MidPropTree..
                            }
                          
                        }
                    }
                ]
            }, 
            {
            
                     
                renderedData : false, 
                xtype: Gtk.ScrolledWindow,
                id: 'view-sw',
                smooth_scroll : true,
                shadow_type : Gtk.ShadowType.IN ,
                init : function() {
                    XObject.prototype.init.call(this); 
                     
                    this.el.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC);
                },
                
                items : [
                    {
                        
                        id : 'view-vbox',
                        xtype : Gtk.Viewport,
                        init : function () {
                            XObject.prototype.init.call(this); 
                            this.el.set_hadjustment(this.parent.el.get_hadjustment());
                            this.el.set_vadjustment(this.parent.el.get_vadjustment());
                                
                        },
                        packing : ['add' ],
                        items: [
                            {
                                id : 'view',
                                xtype : function() {
                                    return new Gtk.Image.from_stock (Gtk.STOCK_HOME, 100) 

                                },
                                packing : ['add' ],
                                ready : false,
                                init : function() {
                                    XObject.prototype.init.call(this); 
                                    // fixme!
                                   
                                    Gtk.drag_dest_set
                                    (
                                            this.el,              /* widget that will accept a drop */
                                            Gtk.DestDefaults.MOTION  | Gtk.DestDefaults.HIGHLIGHT,
                                            null,            /* lists of target to support */
                                            0,              /* size of list */
                                            Gdk.DragAction.COPY         /* what to do with data after dropped */
                                    );
                                    
                                   // print("RB: TARGETS : " + LeftTree.atoms["STRING"]);
                                    Gtk.drag_dest_set_target_list(this.el, LeftTree.targetList);
                                    //Gtk.drag_dest_add_text_targets(this.el);
                                },   
                                listeners : {
                                    
                                      
                                    
                                    "drag-leave" : function () {
                                        Seed.print("TARGET: drag-leave");
                                        // stop monitoring of mouse montion in rendering..
                                        return true;
                                    },
                                    'drag-motion' : function (w, ctx,  x,   y,   time, ud) 
                                    {
                                        
                                    
                                       // console.log('DRAG MOTION'); 
                                        // status:
                                        // if lastCurrentNode == this.currentNode.. -- don't change anything..
                                         
                                        
                                        // A) find out from drag all the places that node could be dropped.
                                        var src = Gtk.drag_get_source_widget(ctx);
                                        if (!src.dropList) {
                                            Gdk.drag_status(ctx, 0, time);
                                            return true;
                                        }
                                        // b) get what we are over.. (from activeNode)
                                        // tree is empty.. - list should be correct..
                                        if (!LeftTree.get('model').currentTree) {
                                            Gdk.drag_status(ctx, Gdk.DragAction.COPY,time);
                                            return true;
                                            
                                        }
                                        // c) ask tree where it should be dropped... - eg. parent.. (after node ontop)
                                        var activeNode = this.getActiveNode(x, y);
                                        
                                        
                                        var tg = LeftTree.get('model').findDropNode(activeNode, src.dropList);
                                        console.dump(tg);
                                        if (!tg.length) {
                                            Gdk.drag_status(ctx, 0,time);
                                            LeftTree.get('view').highlight(false);
                                            return true;
                                        }
                                         
                                        // if we have a target..
                                        // -> highlight it! (in browser)
                                        // -> highlight it! (in tree)
                                        
                                        Gdk.drag_status(ctx, Gdk.DragAction.COPY,time);
                                        LeftTree.get('view').highlight(tg);
                                        this.targetData = tg;
                                        // for tree we should handle this...
                                        return true;
                                        
                                    },
                                    "drag-drop"  : function (w, ctx,x,y,time, ud) 
                                    {
                                                
                                        Seed.print("TARGET: drag-drop");
                                        is_valid_drop_site = true;
                                        
                                         
                                        Gtk.drag_get_data
                                        (
                                                w,         /* will receive 'drag-data-received' signal */
                                                ctx,        /* represents the current state of the DnD */
                                                LeftTree.atoms["STRING"],    /* the target type we want */
                                                time            /* time stamp */
                                        );
                                        
                                        
                                        /* No target offered by source => error */
                                       

                                        return  is_valid_drop_site;
                                        

                                    },
                                    "drag-data-received" : function (w, ctx,  x,  y, sel_data,  target_type,  time, ud) 
                                    {
                                        Seed.print("GtkView: drag-data-received");
                                        delete_selection_data = false;
                                        dnd_success = false;
                                        /* Deal with what we are given from source */
                                        if( sel_data && sel_data.length ) {
                                            
                                            if (ctx.action == Gdk.DragAction.ASK)  {
                                                /* Ask the user to move or copy, then set the ctx action. */
                                            }

                                            if (ctx.action == Gdk.DragAction.MOVE) {
                                                delete_selection_data = true;
                                            }
                                            var source = Gtk.drag_get_source_widget(ctx);

                                            Seed.print("Browser: source.DRAGDATA? " + source.dragData);
                                            if (this.targetData) {
                                                Seed.print(this.targetData);
                                                LeftTree.get('model').dropNode(this.targetData,  source.dragData);
                                            }
                                            
                                            
                                            
                                            dnd_success = true;
                 
                                        }

                                        if (dnd_success == false)
                                        {
                                                Seed.print ("DnD data transfer failed!\n");
                                        }
                                        
                                        Gtk.drag_finish (ctx, dnd_success, delete_selection_data, time);
                                        return true;
                                    }
                                    
                                   //'line-mark-activated' : line_mark_activated,
                                   
                                    
                                },
                                 
                                getActiveNode : function(x,y)
                                {
                                   // workout what node is here..
                                    return '0'; // top..
                                }
                            }
                        ]
                    }
                ]
            }
                
        ],
        
        showInWindow: function ()
        {
            var src= this.lastSrc;
            if (!this.lastSrc.length) {
                return;
            }
            var x = new imports.sandbox.Context();
            x.add_globals();
            //print(src);
            try {
                Seed.check_syntax('var e = ' + src);
                x.eval(src);
            } catch( e) {
                print(e.message || e.toString());
                console.dump(e);
                if (e.line) {
                    var lines = src.split("\n");
                    var start = Math.max(0, e.line - 10);
                    var end = Math.min(lines.length, e.line + 10);
                    for (var i =start ; i < end; i++) {
                        if (i == e.line) {
                            print(">>>>>" + lines[i]);
                            continue;
                        }
                        print(lines[i]);
                    }
                    
                }
                
                return;
            }
             
            var _top = x.get_global_object()._top;
            
            _top.el.set_screen(Gdk.Screen.get_default()); // just in case..
            _top.el.show_all();
            if (_top.el.popup) {
                _top.el.popup(null, null, null, null, 3, null);
            }
        },
        
        buildJS: function(data,withDebug) {
            var i = [ 'Gtk', 'Gdk', 'Pango', 'GLib', 'Gio', 'GObject' ];
            var src = "";
            i.forEach(function(e) {
                src += e+" = imports.gi." + e +";\n";
            });
            src += "console = imports.console;\n"; // path?!!?
            src += "XObject = imports.XObject.XObject;\n"; // path?!!?
            //if (withDebug) {
                src += "XObject.debug=true;\n"; 
            //}
            
            
            src += '_top=new XObject('+ this.mungeToString(data) + ')\n;';
            src += '_top.init();\n';
            File.write('/tmp/BuilderGtkView.js', src);
            print("Test code  in /tmp/BuilderGtkView.js");
            this.lastSrc = src;
            return src;
        },
        
        renderJS : function(data, withDebug)
        {
            // can we mess with data?!?!?
            
            /**
             * first effort..
             * sandbox it? - nope then will have dificulting passing. stuff aruond..
             * 
             */
            if (!data) {
                 return; 
            }
            var src = this.buildJS(data,withDebug);
            var x = new imports.sandbox.Context();
            x.add_globals();
            //x.get_global_object().a = "hello world";
            
            try {
                Seed.check_syntax('var e = ' + src);
                x.eval(src);
            } catch( e) {
                if (!withDebug) {
                   return this.renderJS(data,true);
                }
                print(e.message || e.toString());
                console.dump(e);
                return;
            }
            
            var r = new Gdk.Rectangle();
            var _top = x.get_global_object()._top;
            
            _top.el.set_screen(Gdk.Screen.get_default()); // just in case..
            _top.el.show_all();
            if (_top.el.popup) {
                _top.el.popup(null, null, null, null, 3, null);
            }
            
            
            
            var pb = _top.el.get_snapshot(r);
            if (!pb) {
                return;
            }
            _top.el.hide();
            _top.el.destroy();
            x._top = false;
            var Window = imports.Builder.Window.Window;
            var gc = new Gdk.GC.c_new(Window.el.window);
                
                // 10 points all round..
            var full = new Gdk.Pixmap.c_new (Window.el.window, r.width+20, r.height+20, pb.get_depth());
            // draw a white background..
           // gc.set_rgb_fg_color({ red: 0, white: 0, black : 0 });
            Gdk.draw_rectangle(full, gc, true, 0, 0, r.width+20, r.height+20);
            // paint image..
            Gdk.draw_drawable (full, gc, pb, 0, 0, 10, 10, r.width, r.height);
            // boxes..
            //gc.set_rgb_fg_color({ red: 255, white: 255, black : 255 });
            Gdk.draw_rectangle(full, gc, true, 0, 0, 10, 10);
            this.get('view').el.set_from_pixmap(full, null);
            //this.get('view-vbox').el.set_size_request( r.width+20, r.height+20);
            //var img = new Gtk.Image.from_file("/home/alan/solarpanels.jpeg");
            
            
            
        },
        mungeToString:  function(obj, isListener)
        {
            var keys = [];
            var isArray = false;
            isListener = isListener || false;
            
            if (obj.constructor.toString() === Array.toString()) {
                for (var i= 0; i < obj.length; i++) {
                    keys.push(i);
                }
                isArray = true;
            } else {
                for (var i in obj) {
                    keys.push(i);
                }
            }
            var els = [];
            var skip = [];
            if (!isArray && 
                    typeof(obj['|xns']) != 'undefined' &&
                    typeof(obj['xtype']) != 'undefined'
                ) {
                    els.push('xtype: '+ obj['|xns'] + '.' + obj['xtype']);
                    skip.push('|xns','xtype');
                }
            
            var _this = this;
            
            keys.forEach(function(i) {
                var el = obj[i];
                if (!isArray && skip.indexOf(i) > -1) {
                    return;
                }
                if (isListener) {
                    if (obj[i].match(/Gtk.main_quit/)) { // we can not handle this very well..
                        return;
                    }
                    els.push(JSON.stringify(i) + ":" + obj[i]);
                    return;
                }
                if (i[0] == '|') {
                    // does not hapepnd with arrays..
                    if (typeof(el) == 'string' && !obj[i].length) { //skip empty.
                        return;
                    }
                    if (typeof(el) == 'string'  && obj[i].match(/Gtk.main_quit/)) { // we can not handle this very well..
                        return;
                    }
                    els.push(JSON.stringify(i.substring(1)) + ":" + obj[i]);
                    return;
                }
                var left = isArray ? '' : (JSON.stringify(i) + " : " )
                if (typeof(el) == 'object') {
                    els.push(left + _this.mungeToString(el, i == 'listeners'));
                    return;
                }
                els.push(JSON.stringify(i) + ":" + JSON.stringify(obj[i]));
            });
            return (isArray ? '[' : '{') + 
                els.join(', ') +
                (isArray ? ']' : '}');
               
                
             
            
            
        }
        
    }
    
    
);
    
