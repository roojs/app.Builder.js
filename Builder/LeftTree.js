//<Script type="text/javascript">
Gio = imports.gi.Gio;
Gtk = imports.gi.Gtk;
Gdk = imports.gi.Gdk;
GObject = imports.gi.GObject;
Pango = imports.gi.Pango ;



// http://www.google.com/codesearch/p?hl=en#EKZaOgYQHwo/unstable/sources/sylpheed-2.2.9.tar.bz2%7C1erxr_ilM1o/sylpheed-2.2.9/src/folderview.c&q=gtk_tree_view_get_drag_dest_row


 
LeftTree = new XObject({
{
    
   return {
        
        
        xtype: Gtk.ScrolledWindow',
        smooth_scroll : true,
        
        shadow_type :  Gtk.ShadowType.IN,
        init : function() {
            this.el.set_policy (Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC)
        },
        
        
                        
        
        items : [        
            {
                
                    
                
                xtype: Gtk.TreeView',
                set : {
                    set_headers_visible : [ false],
                    set_enable_tree_lines : [ true] ,
                    set_tooltip_column : [0] //,
                   // set_reorderable: [1]
                }, 
                highlight : function(treepath_ar) {
                    if (treepath_ar.length) {
                        this .el.set_drag_dest_row( new  Gtk.TreePath.from_string( treepath_ar[0] ),  treepath_ar[1]);
                    } else {
                        this.el.set_drag_dest_row(null, Gtk.TreeViewDropPosition.INTO_OR_AFTER);
                    }
                    
                    
                    
                },
                listeners : {
                    _new : function () {
                        _view = this;
                    },
                    _rendered: function()
                    {
                        
                        var description = new Pango.FontDescription.c_new();
                        description.set_size(8000);
                        this.el.modify_font(description);
                        
                        this.selection = this.el.get_selection();
                        this.selection.set_mode( Gtk.SelectionMode.SINGLE);
                        this.selection.signal['changed'].connect(function() {
                            _view.listeners['cursor-changed'].apply(_view, [ _view, '']);
                        });
                        
                        Gtk.drag_source_set (
                            this.el,            /* widget will be drag-able */
                            Gdk.ModifierType.BUTTON1_MASK,       /* modifier that will start a drag */
                            null,            /* lists of target to support */
                            0,              /* size of list */
                            Gdk.DragAction.COPY   | Gdk.DragAction.MOVE           /* what to do with data after dropped */
                        );
                        var targets = new Gtk.TargetList();
                        targets.add( Builder.atoms["STRING"], 0, 0);
                        Gtk.drag_source_set_target_list(this.el, targets);

                        Gtk.drag_source_add_text_targets(this.el); 
                        Gtk.drag_dest_set
                        (
                                this.el,              /* widget that will accept a drop */
                                Gtk.DestDefaults.MOTION  | Gtk.DestDefaults.HIGHLIGHT,
                                null,            /* lists of target to support */
                                0,              /* size of list */
                                Gdk.DragAction.COPY   | Gdk.DragAction.MOVE       /* what to do with data after dropped */
                        );
                         
                        Gtk.drag_dest_set_target_list(this.el, targets);
                        Gtk.drag_dest_add_text_targets(this.el);
                        
                        
                    },
                    
                    'button-press-event' : function(tv, ev) {
                        console.log("button press?");
                        if (ev.type != Gdk.EventType.BUTTON_PRESS  || ev.button.button != 3) {
                            Seed.print("click" + ev.type);
                            return false;
                        }
                      
                    
                        
                        var res = _view.el.get_path_at_pos(ev.button.x,ev.button.y);
                        
                        
                        Builder.LeftTreeMenu._menu.el.set_screen(Gdk.Screen.get_default());
                        Builder.LeftTreeMenu._menu.el.popup(null, null, null, null, 3, ev.button.time);
                        Seed.print("click:" + res.column.title);
                        return false;
                        
                    },
                    
                     'drag-begin' : function (w, ctx, ud) 
                    {
                           // we could fill this in now...
                        Seed.print('SOURCE: drag-begin');
                         this.targetData = false;
                        // find what is selected in our tree...
                        var iter = new Gtk.TreeIter();
                        var s = this.selection;
                        s.get_selected(_model.el, iter);

                        // set some properties of the tree for use by the dropped element.
                        var value = new GObject.Value('');
                        _model.el.get_value(iter, 2, value);
                        var data = JSON.parse(value.value);
                        var xname = Builder.Provider.Palete.Roo.guessName(data);
                        
                        this.el.dragData = xname;
                        this.el.dropList = _model.provider.getDropList(xname);


                        // make the drag icon a picture of the node that was selected
                        var path = _model.el.get_path(iter);
                        var pix = this.el.create_row_drag_icon ( path);
                        Gtk.drag_set_icon_pixmap (ctx,
                            pix.get_colormap(),
                            pix,
                            null,
                            -10,
                            -10);
                        
                        return true;
                      
                        
                    },
                    
                    'drag-end' : function ( w,  drag_context, x, y, time, user_data)   
                    {
                        // i'm not sure if this would work, without implementing the whole kaboodle.
                        Seed.print('SOURCE: drag-end');
                        this.el.dragData = false;
                        this.el.dropList = false;
                        this.targetData = false;
                        _view.highlight(false);
                        return true;
                      
                      
                    },
                    'drag-motion' : function (w, ctx,  x,   y,   time, ud) 
                    {
                        
                        
                        var src = Gtk.drag_get_source_widget(ctx);

                        // a drag from  elsewhere...- prevent drop..
                        if (!src.dragData) {
                            Gdk.drag_status(ctx, 0, time);
                            this.targetData = false;
                            return true;
                        }
                        var action = Gdk.DragAction.COPY;
                        if (src == this.el) {
                            // unless we are copying!!! ctl button..
                            action = Gdk.DragAction.MOVE;
                        }
                        var data = {};
                        _view.el.get_dest_row_at_pos(x,y, data);
                        // path, pos
                        
                        Seed.print(data.path.to_string() +' => '+  data.pos);
                        var tg = _model.findDropNodeByPath(data.path.to_string(), src.dropList, data.pos);
                        _view.highlight(tg);
                        if (!tg.length) {
                            this.targetData = false;
                            Gdk.drag_status(ctx, 0, time);
                            return true;
                        }
                        console.dump(tg);
                        this.targetData = tg;    
                        
                        
                        Gdk.drag_status(ctx, action ,time);
                         
                        return true;
                    },
                    
                    'drag-drop'  : function (w, ctx, x, y,time, ud) 
                    {
                                
                        Seed.print("TARGET: drag-drop");
                       
                        Gtk.drag_get_data
                        (
                                w,         /* will receive 'drag-data-received' signal */
                                ctx,        /* represents the current state of the DnD */
                                Builder.atoms["STRING"],    /* the target type we want */
                                time            /* time stamp */
                        );
                        
                         
                        /* No target offered by source => error */
                       

                        return  true;
                        

                    },
                   'drag-data-received' : function (w, ctx,  x,  y, sel_data,  target_type,  time, ud) 
                    {
                        Seed.print("Tree: drag-data-received");
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
 
                            if (this.targetData) {
                                if (source != this.el) {
                                    _model.dropNode(this.targetData,  source.dragData);
                                } else {
                                    // drag around.. - reorder..
                                    _model.moveNode(this.targetData);
                                    
                                    
                                }
                                Seed.print(this.targetData);
                              
                            }
                            
                            
                            
                            // we can send stuff to souce here...

                            dnd_success = true;

                        }

                        if (dnd_success == false)
                        {
                                Seed.print ("DnD data transfer failed!\n");
                        }

                        Gtk.drag_finish (ctx, dnd_success, delete_selection_data, time);
                        return true;
                    },
                    
                    'cursor-changed'  : function(tv, a) {
                        var iter = new Gtk.TreeIter();
                        
                        if (this.selection.count_selected_rows() < 1) {
                            Builder.LeftPanel._model.load( false);
                            Builder.MidPropTree._model.load(data);
                            Builder.MidPropTree._win.hideWin();
                            return;
                        }
                        
                        //console.log('changed');
                        var s = this.selection;
                        s.get_selected(_model.el, iter);
                        
                        
                        // var val = "";
                        value = new GObject.Value('');
                        _model.el.get_value(iter, 2, value);
                        _model.activeIter = iter;
                        
                        var data = JSON.parse(value.value);
                        Builder.MidPropTree._model.load(data);
                        Builder.MidPropTree._win.hideWin();
                        Builder.LeftPanel._model.load( data);
                        
                        console.log(value.value);
                       // _g.button.set_label(''+value.get_string());
                       
                        //Seed.print( value.get_string());
                        return true;
                        
                        
                    
                    }
                },
                
                items  : [
                    {
                        xid : 'model',
                        packing : ['set_model'],
                        
                        
                        xtype: Gtk.TreeStore',
                         
                        listeners : {
                            _rendered : function()
                            {
                                _model = this;
                                 
                                
                                this.el.set_column_types ( 3, [
                                                        GObject.TYPE_STRING, // title 
                                                        GObject.TYPE_STRING, // tip
                                                        GObject.TYPE_STRING // source..
                                                        ] );
                                
                                
                                this.provider = new Builder.Provider.Palete.Roo();
                                this.provider.load();
                                /*
                                var iter = new Gtk.TreeIter();
                                
                                var file = Gio.file_new_for_path("/home/alan/test.json");
                                
                                
                                
                                file.read_async(0, null, function(source,result) {
                                    var stream = source.read_finish(result);
                                    var dstream = new Gio.DataInputStream.c_new(stream);
                                  
                                    var data =  JSON.parse(dstream.read_until(""));
                                    _model.el.append(iter);
                                    _model.el.set_value(iter, 0, [GObject.TYPE_STRING, _model.nodeTitle(data.data[1])]);
                                    _model.el.set_value(iter, 1, [GObject.TYPE_STRING, _model.nodeTitle(data.data[1])]);
                                    
                                    _model.el.set_value(iter, 2, [GObject.TYPE_STRING, _model.nodeToJSON(data.data[1])]);
                                    
                                  
                                    
                                    var jstr =  JSON.parse(data.data[1].json);
                                    _model.loadTree(jstr.items,iter);
                                    
                                    _view.el.expand_all();
                                     imports['Builder/RightEditor.js']._win.el.hide();
                                    //Seed.quit();
                                   
                                });
                                */
                                //Builder.RightEditor._win.el.hide();
                                
                            },
                            'row-changed' : function(tm, path, iter, ud)
                            {
                                //Seed.print('row-changed');
                            },
                            'row-inserted' : function(tm, path, iter, ud)
                            {
                                //Seed.print('row-inserted');
                                // this is probalby where we record stuff and validate..
                                ///if we are in drag/drop, then we can flag it to restore if not valie..
                                
                                
                            },
                            'row-deleted' : function(tm, path, iter, ud)
                            {
                               // Seed.print('row-deleted');
                            }
                            
                        },
                        activeIter : false,
                        changed : function( n, refresh) {
                            if (!this.activeIter) {
                                return;
                            }
                            _model.el.set_value(this.activeIter, 0, [GObject.TYPE_STRING, _model.nodeTitle(n)]);
                            _model.el.set_value(this.activeIter, 1, [GObject.TYPE_STRING, _model.nodeTitle(n)]);
                            
                            _model.el.set_value(this.activeIter, 2, [GObject.TYPE_STRING, _model.nodeToJSON(n)]);
                            
                            //this.currentTree = this.toJS(false, true)[0];
                            this.file.items = this.toJS(false, true);
                            this.currentTree = this.file.items[0];
                            console.log(this.file.toSource());
                            
                            if (refresh) {
                                 
                                Builder.RightBrowser._view.renderJS(this.currentTree);
                                var pm = Builder.RightPalete._model;
                                pm.load( pm.provider.gatherList(this.listAllTypes()));
                                //imports['Builder/RightBrowser.js'].renderJS(this.toJS());
                            }
                             
                        },
                        
                        
                        loadFile : function(f)
                        {
                            //console.dump(f);
                            this.el.clear();
                            this.file = f;
                            
                            if (!f) {
                                console.log('missing file');
                                return;
                            }
                            
                            // load the file if not loaded..
                            if (!f.items.length ) {
                                var _this = this;
                                f.loadItems(function() {
                                    _this.loadFile(f);
                                });
                                return;
                                
                            }
                            if (typeof(f.items[0]) == 'string') {
                            
                                Builder.RightEditor._win.el.show();
                                Builder.RightEditor._view.load( f.items[0]);
                                return;
                            }
                            
                            this.load(f.items);
                            _view.el.expand_all();
                            if ((f.items.length == 1) && !f.items[0].items
                                && (typeof(f.items[0]['*class']) != 'undefined')) {
                                // single item..
                                Builder.Window._leftvpaned.el.set_position(80);
                                // select first...
                                _view.el.set_cursor( new  Gtk.TreePath.from_string('0'), null, false);
                                
                                
                            } else {
                                Builder.Window._leftvpaned.el.set_position(200);
                            }
                            
                            
                            
                            Builder.RightEditor._win.el.hide();
                            this.currentTree = this.toJS(false, true)[0];
                            Builder.RightBrowser._view.renderJS(this.currentTree);
                            console.dump(this.map);
                            var pm = Builder.RightPalete._model;
                            pm.load( pm.provider.gatherList(this.listAllTypes()));
                            
                            
                            
                            
                        },
                        
                        findDropNode : function (dropid, targets)
                        {
                            if (typeof(this.map[dropid]) == 'undefined') {
                                Seed.print("not found: " + dropid);
                                return [];
                            }
                            //Gtk.TreeViewDropPosition.INTO_OR_AFTER
                            //Gtk.TreeViewDropPosition.AFTER
                            //Seed.print('treepath : ' + this.map[dropid]);
                            var path = this.map[dropid];
                            return findDropNodeByPath(path,targets) 
                        },
                        findDropNodeByPath : function (path, targets, pref)
                        {
                            pref = typeof(pref) == 'undefined' ?  Gtk.TreeViewDropPosition.AFTER : pref;
                            var last = false;
                            while (path.length) {
                                if (typeof(this.treemap[path]) == 'undefined') {
                                    return [];
                                }
                                
                                var xname = Builder.Provider.Palete.Roo.guessName(this.treemap[path]);
                                if (targets.indexOf(xname) > -1) {
                                    if (last) { // pref is after/before..
                                        // then it's after last
                                        if (pref > 1) {
                                            return []; // do not allow..
                                        }
                                        return [ last, pref ];
                                        
                                    }
                                    return [ path , Gtk.TreeViewDropPosition.INTO_OR_AFTER ];
                                }
                                var par = path.split(':');
                                last = path;
                                par.pop();
                                path = par.join(':');
                            }
                            return [];
                            
                            
                        },
                        
                        dropNode: function(target_data, node) {
                            
                            console.dump(target_data);
                            var tp = new  Gtk.TreePath.from_string( target_data[0] );
                            
                            
                            var parent = tp;
                            var after = false;
                            if (target_data[1]  < 2) { // before or after..
                                var ar = target_data[0].split(':');
                                ar.pop();
                                parent  = new  Gtk.TreePath.from_string( ar.join(':') );
                                
                                after = tp;
                            }
                            var n_iter = new Gtk.TreeIter();
                            var iter_par = new Gtk.TreeIter();
                            var iter_after = after ? new Gtk.TreeIter() : false;
                            _model.el.get_iter(iter_par, parent);
                            
                            if (after) {
                                Seed.print(target_data[1]  > 0 ? 'insert_after' : 'insert_before');
                                _model.el.get_iter(iter_after, after);
                                _model.el[ target_data[1]  > 0 ? 'insert_after' : 'insert_before'](n_iter, iter_par, iter_after);
                                
                            } else {
                                _model.el.append(n_iter, iter_par);
                                
                            }
                            
                            if (typeof(node) == 'string') {
                                var ar = node.split('.');
                                var xtype = ar.pop();
                                
                                node = {
                                    '|xns' : ar.join('.'),
                                    'xtype' : xtype
                                };
                            }
                            var xitems = [];
                            if (node.items) {
                                xitems = node.items;
                                delete node.items;
                            }
                            if (xitems) {
                                this.load(xitems, n_iter);
                            }
                            if (xitems || after) {
                                _view.el.expand_row(_model.el.get_path(iter_par), true);
                            }
                            // wee need to get the empty proptypes from somewhere..
                            
                            //var olditer = this.activeIter;
                            this.activeIter = n_iter;
                            this.changed(node, true);
                            
                            
                            
                            _view.el.set_cursor(_model.el.get_path(n_iter), null, false);
                            
                            //Builder.MidPropTree._model.load(node);
                            //Builder.MidPropTree._win.hideWin();
                            //Builder.LeftPanel._model.load( node);
                            
                            
                            
                            
                        },
                        moveNode: function(target_data, type) {
                            
                            
                            
                            var old_iter = new Gtk.TreeIter();
                            var s = _view.selection;
                            s.get_selected(_model.el, old_iter);
                            var node = this.nodeToJS(old_iter,false);
                            _model.el.remove(old_iter);
                            this.dropNode(target_data, node);
                            
                            
                            
                        },
                        
                               
                        
                        
                        currentTree  : false,
                        map : false, // map of builder-ids=>treepaths.
                        treemap: false, // map of treepath to nodes.
                        
                        listAllTypes : function()
                        {
                            var ret = [ ];
                            
                            function addall(li)
                            {
                                Roo.each(li, function(el) {
                                    // this is specific to roo!!!?
                                    var fullpath = Builder.Provider.Palete.Roo.guessName(el);
                                    if (fullpath.length && ret.indexOf(fullpath) < 0) {
                                        ret.push(fullpath);
                                    }
                                    
                                    
                                    if (el.items && el.items.length) {
                                        addall(el.items);
                                    }
                                    
                                })
                                
                                
                            }
                            
                            addall([this.currentTree]);
                            
                            // only if we have nothing, should we add '*top'
                            if (!ret.length) {
                                ret = [ '*top' ];
                            }
                            console.log('all types in tree');
                            console.dump(ret);
                            
                            return ret;
                            
                            
                        },
                        
                        
                        /**
                         * convert tree into a javascript array
                         * 
                         */
                        nodeToJS: function (iter, with_id) 
                        {
                          
                            
                            var par = new Gtk.TreeIter(); 
                            
                            var k = JSON.parse(this.getValue(iter, 2));
                            if (k.json && !_model.el.iter_parent( par, iter  )) {
                                delete k.json;
                            }
                            
                            if (with_id) {
                                k.id = Roo.id(null,'builder-');
                                this.map[k.id] = _model.el.get_path(iter).to_string();
                                this.treemap[  this.map[k.id]  ] = k;
                                k.xtreepath = this.map[k.id];
                                
                            }
                            if (_model.el.iter_has_child(iter)) {
                                citer = new Gtk.TreeIter();
                                _model.el.iter_children(citer, iter);
                                k.items = this.toJS(citer,with_id);
                            }
                            return k;
                        },
                         /**
                          * iterates through child nodes (or top..)
                          * 
                          */
                        toJS: function(iter, with_id)
                        {
                            Seed.print("WITHID: "+ with_id);
                            
                            var first = false;
                            if (!iter) {
                                this.map = { }; 
                                this.treemap = { }; 
                                
                                iter = new Gtk.TreeIter();
                                _model.el.get_iter_first(iter);
                                first = true;
                            } 
                            
                            var ar = [];
                               
                            while (true) {
                                
                                var k = this.nodeToJS(iter, with_id); 
                                ar.push(k);
                                
                                
                                if (!_model.el.iter_next(iter)) {
                                    break;
                                }
                            }
                            
                            return ar;
                            // convert the list into a json string..
                        
                            
                        },
                        getValue: function (iter, col) {
                            var gval = new GObject.Value('');
                             _model.el.get_value(iter, col ,gval);
                            return  gval.value;
                            
                            
                        },
                        
                        nodeTitle: function(c)
                        {
                              
                            var txt = [];
                            c = c || {};
                            var sr = (typeof(c['+buildershow']) != 'undefined') &&  !c['+buildershow'] ? true : false;
                            if (sr) txt.push('<s>');
                            if (typeof(c['*prop']) != 'undefined')   { txt.push(c['*prop']+ ':'); }
                            if (c.xtype)      { txt.push(c.xtype); }
                            if (c.fieldLabel) { txt.push('[' + c.fieldLabel + ']'); }
                            if (c.boxLabel)   { txt.push('[' + c.boxLabel + ']'); }
                            
                            
                            if (c.layout)     { txt.push('<i>' + c.layout + '</i>'); }
                            if (c.title)      { txt.push('<b>' + c.title + '</b>'); }
                             if (c.label)      { txt.push('<b>' + c.label+ '</b>'); }
                            if (c.header)    { txt.push('<b>' + c.header + '</b>'); }
                            if (c.legend)      { txt.push('<b>' + c.legend + '</b>'); }
                            if (c.text)       { txt.push('<b>' + c.text + '</b>'); }
                            if (c.name)       { txt.push('<b>' + c.name+ '</b>'); }
                            if (c.region)     { txt.push('<i>(' + c.region + ')</i>'); }
                            if (c.dataIndex) { txt.push('[' + c.dataIndex+ ']'); }
                            
                            // for flat classes...
                            if (typeof(c['*class']) != 'undefined')  { txt.push('<b>' +  c['*class']+  '</b>'); }
                            if (typeof(c['*extends']) != 'undefined')  { txt.push(': <i>' +  c['*extends']+  '</i>'); }
                            
                            
                            if (sr) txt.push('</s>');
                            return (txt.length == 0 ? "Element" : txt.join(" "));
                        
                      //console.log(n.xtype);
                           // return n.xtype;
                        },
                        
                        nodeToJSON : function(c) {
                            var o  = {}
                            for (var i in c) {
                                if (i == 'items') {
                                     continue;
                                }
                                o[i] = c[i];
                            }
                            return JSON.stringify(o);
                        },
                        /**
                         * load javascript array onto an iter..
                         * @param tr = array of elements
                         * @param iter = iter of parent (or null if not..)
                         */
                        
                        
                         
                        
                        load : function(tr,iter)
                        {
                            var citer = new Gtk.TreeIter();
                            //this.insert(citer,iter,0);
                            for(var i =0 ; i < tr.length; i++) {
                                if (iter) {
                                    this.el.insert(citer,iter,-1);
                                } else {
                                    this.el.append(citer);
                                }
                                
                                this.el.set_value(citer, 0, [GObject.TYPE_STRING, this.nodeTitle(tr[i]) ]);
                                this.el.set_value(citer, 1, [GObject.TYPE_STRING, this.nodeTitle(tr[i]) ]);
                                this.el.set_value(citer, 2, [GObject.TYPE_STRING, this.nodeToJSON(tr[i])]);
                                if (tr[i].items && tr[i].items.length) {
                                    this.load(tr[i].items, citer);
                                }
                            }
                            
                            
                            
                            
                        },
                        
                        
                        
                      //  this.expand_all();
                    },
                    
                      
                    {
                        packing : ['append_column'],
                        
                        xtype: Gtk.TreeViewColumn',
                        items : [
                            {
                                
                                xtype: Gtk.CellRendererText',
                                packing: [ 'pack_start']
                                  
                            } 
                        ],
                        listeners : {
                            _rendered : function ()
                            {
                                this.el.add_attribute(this.items[0].el , 'markup', 0 );
                            }
                        }
                      
                    }
                    
               ]
            }
        ]
                
         
    };
}
    
