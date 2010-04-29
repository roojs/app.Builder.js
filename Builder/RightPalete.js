//<Script type="text/javascript">
Gio = imports.gi.Gio;
Gtk = imports.gi.Gtk;
Gdk = imports.gi.Gdk;
GObject = imports.gi.GObject;
XN = imports.xnew;
console = imports.console;
Pango = imports.gi.Pango ;
Builder = imports['Builder.js'];
 
var _view = false;

// normally appears as a vbox with a expander button,
// when you put your mouse over though, it expands.


function create() // parent?
{
    
    return {
        
        xns : 'Gtk',
        xtype: 'VBox',
        packing : [ 'pack_start', false, false ],
        listeners : {
            _new : function() {
                _palete = this;
            }
        },
        hide : function() {
            _hidden.el.show();
            _visible.el.hide();
        },
        show : function() {
            _hidden.el.hide();
            _visible.el.show();
            
            _model.expanded();
            
        },
        
        items : [
            {
                    
                xns : 'Gtk',
                xtype: 'VBox',
                
                listeners : {
                    _new : function() {
                        _hidden = this;
                    }
                },
                
                items : [
                
                
                    {
                        xns : 'Gtk',
                        xtype: 'Button',
                        packing : [ 'pack_start', false, true ],
                        listeners : {
                            clicked : function() {
                                _palete.show();
                            }
                        },
                        items : [
                            {
                                xns : 'Gtk',
                                xtype: 'Image',
                                xtype : 'Image',
                                stock : Gtk.STOCK_GOTO_FIRST,
                                'icon-size' : Gtk.IconSize.MENU,
                                
                                packing : ['add']
                            }
                        ]
                    },
                    {
                        packing : [ 'pack_start', true, true ],
                        xns : 'Gtk',
                        xtype: 'Label',
                        label: 'Palete',
                        angle : 270,
                        set : {
                            add_events : [ Gdk.EventMask.BUTTON_MOTION_MASK ]
                        },
                        listeners : {
                            'enter-notify-event' : function (w,e)
                            {
                                _palete.show();
                                //console.log("enter!");
                                //this.el.expanded = !this.el.expanded;
                                //this.listeners.activate.call(this);
                                return true;
                            }
                        }
                    }
                ]
            },
            
            {
                    
                xns : 'Gtk',
                xtype: 'VBox',
                listeners : {
                    _new : function() {
                        _visible = this;
                    }
                },
                items : [         
                    {
                        
                        xns : 'Gtk',
                        xtype: 'HBox',
                        packing : [ 'pack_start', false, true ],
                        items : [
                            {
                                 
                                xns : 'Gtk',
                                xtype: 'Label',
                                label: 'Palete'
                             
                            },
                            {
                                xns : 'Gtk',
                                xtype: 'Button',
                                packing : [ 'pack_start', false, true ],
                                listeners : {
                                    clicked : function() {
                                        _palete.hide();
                                    }
                                },
                                items : [
                                    {
                                        xns : 'Gtk',
                                        xtype: 'Image',
                                        stock : Gtk.STOCK_GOTO_LAST,
                                        'icon-size' : Gtk.IconSize.MENU,
                                
                                        // open arrow...
                                    }
                                ]
                            }
                        ]
                    },
                    
                    // expandable here...( show all.. )
                    
                                // our pallete goes here...
            // two trees technically...
            
                    
                    {
                
                        xns : 'Gtk',
                        xtype: 'ScrolledWindow',
                        smooth_scroll : true,
                       // packing : ['pack_start', true , true ],
                        set : {
                            set_shadow_type : [ Gtk.ShadowType.IN ],
                            set_policy : [Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC],
                            set_size_request : [-1,200]
                        },
                        items : [        
                            {
                                
                                    
                                xns : 'Gtk',
                                xtype : 'TreeView',
                                set : {
                                    set_headers_visible : [ false],
                                    set_enable_tree_lines : [ true] ,
                                    set_tooltip_column : [1],
                                    set_size_request : [150,-1]
                                  //  set_reorderable: [1]
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
                                       // this.selection.signal['changed'].connect(function() {
                                        //    _view.listeners['cursor-changed'].apply(_view, [ _view, '']);
                                        //});
                                        // see: http://live.gnome.org/GnomeLove/DragNDropTutorial
                                        
                                        Gtk.drag_source_set (
                                                this.el,            /* widget will be drag-able */
                                                Gdk.ModifierType.BUTTON1_MASK,       /* modifier that will start a drag */
                                                null,            /* lists of target to support */
                                                0,              /* size of list */
                                                Gdk.DragAction.COPY         /* what to do with data after dropped */
                                        );
                                        
                                        
                                        targets = new Gtk.TargetList();
                                        targets.add( Builder.atoms["STRING"], 0, 0);
                                        Gtk.drag_source_set_target_list(this.el, targets);
                                        //if you want to allow text to be output elsewhere..
                                        //Gtk.drag_source_add_text_targets(this.el);
                                        return true;  
                                        
                                    }, 
                                    
                                    'drag-data-get' : function (w, ctx, selection_data, target_type,  time, ud) 
                                    {
                                        
                                        Seed.print('Palete: drag-data-get: ' + target_type);
                                        if (this.el.dragData && this.el.dragData.length ) {
                                            selection_data.set_text(this.el.dragData ,this.el.dragData.length);
                                        }
                                        
                                        
                                        //this.el.dragData = "TEST from source widget";
                                        
                                        
                                        
                                        return true;
                                    },
                                   
                                    'drag-begin' : function (w, ctx, ud) 
                                    {
                                        // we could fill this in now...
                                        Seed.print('SOURCE: drag-begin');
                                        
                                        
                                        
                                        var iter = new Gtk.TreeIter();
                                        var s = this.selection;
                                        s.get_selected(_model, iter);
                                        var path = _model.el.get_path(iter);
                                        
                                        var pix = this.el.create_row_drag_icon ( path);
                                            
                                                
                                        Gtk.drag_set_icon_pixmap (ctx,
                                            pix.get_colormap(),
                                            pix,
                                            null,
                                            -10,
                                            -10);
                                        
                                        var value = new GObject.Value('');
                                        _model.el.get_value(iter, 0, value);
                                        this.el.dropList = _model.provider.getDropList(value.value);
                                        this.el.dragData = value.value;
                                        
                                        
                                        
                                        
                                        return true;
                                    },
                                    'drag-end' : function () 
                                    {
                                        Seed.print('SOURCE: drag-end');
                                        this.el.dragData = false;
                                        this.el.dropList = false;
                                        Builder.LeftTree._view.highlight(false);
                                        return true;
                                    },
                                    
                                    /*
                                    'cursor-changed'  : function(tv, a) { 
                                        //select -- should save existing...
                                        var iter = new Gtk.TreeIter();
                                        
                                        if (this.selection.count_selected_rows() < 1) {
                                            
                                            Builder.LeftTree._model.load( false);
                                            
                                            return;
                                        }
                                        
                                        //console.log('changed');
                                        var s = this.selection;
                                        s.get_selected(_model, iter);
                                        value = new GObject.Value('');
                                        _model.el.get_value(iter, 2, value);
                                        
                                        console.log(value.value);
                                        var file = _model.project.get(value.value);
                                        
                                        
                                        console.log(file);
                                        _expander.el.set_expanded(false);

                                        Builder.LeftTree._model.loadFile(file);
                                        
                                        return true;
                                        
                                        
                                    
                                    }
                                    */
                                },
                                
                                items  : [
                                    {
                                        packing : ['set_model'],
                                        
                                        xns : 'Gtk',
                                        xtype : 'ListStore',
                                         
                                        listeners : {
                                            _rendered : function()
                                            {
                                                _model = this;
                                                
                                                
                                                
                                                
                                                
                                                
                                                this.el.set_column_types ( 2, [
                                                        GObject.TYPE_STRING, // title 
                                                        GObject.TYPE_STRING // tip
                                                        
                                                        ] );
                                
                                                this.provider = new Builder.Provider.Palete.Roo();
                                                this.provider.load();
                                                
                                            }
                                             
                                            
                                        },
                                        expanded : function() // event handler realy.
                                        {
                                            // should ask tree for list of current compeents.
                                            
                                            //console.dump(this.provider);
                                            //var li = this.provider.gatherList([]);
                                            //console.dump(li);
                                            //this.load( this.provider.gatherList([]));
                                            
                                            
                                            
                                            
                                        },
                                        
                                        load : function(tr,iter)
                                        {
                                            if (!iter) {
                                                this.el.clear();
                                            }
                                            //console.log('Project tree load: ' + tr.length);
                                            var citer = new Gtk.TreeIter();
                                            //this.insert(citer,iter,0);
                                            for(var i =0 ; i < tr.length; i++) {
                                                if (!iter) {
                                                    
                                                    this.el.append(citer);   
                                                } else {
                                                    this.el.insert(citer,iter,-1);
                                                }
                                                
                                                var r = tr[i];
                                                Seed.print(r);
                                                this.el.set_value(citer, 0,  '' +  r ); // title 
                                                
                                                //this.el.set_value(citer, 1,  new GObject.Value( r)); //id
                                                //if (r.cn && r.cn.length) {
                                                //    this.load(r.cn, citer);
                                                //}
                                            }
                                            
                                            
                                        },
                                        
                                        
                                        provider : false,
                                        
                                        getValue: function (iter, col) {
                                            var gval = new GObject.Value('');
                                             _model.el.get_value(iter, col ,gval);
                                            return  gval.value;
                                            
                                            
                                        }
                                        
                                        
                                        
                                      //  this.expand_all();
                                    },
                                    
                                      
                                    {
                                        packing : ['append_column'],
                                        xns : 'Gtk',
                                        xtype : 'TreeViewColumn',
                                        items : [
                                            {
                                                xns : 'Gtk',
                                                xtype : 'CellRendererText',
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
                    }
                ]

            }
        ]
            
    };
}