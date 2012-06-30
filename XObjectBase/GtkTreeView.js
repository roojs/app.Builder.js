
//<Script type="Text/javascript">

XObject = imports.XObject.XObject
 
GObject = imports.gi.GObject;

// tree view column.. should really have a better way to determin stuff..

GtkTreeView = XObject.define(
    function(cfg)
    {
        this.xconfig = {
            selection   : cfg.selection || {},
            font         : cfg.font || false,
            drag_source : cfg.drag_source || false,
            drag_dest   : cfg.drag_dest || false
        };
        for (var i in this.xconfig) {
            if (typeof(cfg[i]) != 'undefined') {
                delete cfg[i];
            }
        }
        
        
        
        XObject.call(this, cfg);
        // this is an example...
        
        
    }, 
    XObject,
    {
        xconfig : false,
        selection : false,
        
        init : function() 
        {
            
            XObject.prototype.init.call(this);
            
            
            if (this.xconfig.font) {
                var description = new Pango.FontDescription.c_new();
                description.set_size(this.xconfig.font.size);
                this.el.modify_font(description);
            }
            var gtks = XObject.baseXObject({ xtype : 'GtkTreeSelection']);
            
            this.xconfig.selection.el = this.el.get_selection();
            
            this.selection = new gtks( this.xconfig.selection );
            
            
            if (this.xconfig.selection) {
                
                
                // posibly move to it's own ctor?
                var xsel = this.xconfig.selection;
                var selection = this.el.get_selection();
                this.selection = selection;
                if (xsel.mode) {
                    selection.set_mode( xsel.mode );
                }
                if (xsel.listeners) {
                    for (var signal in xsel.listeners) {
                        
                        selection.signal[signal].connect(xsel.listeners[signal]);
                    }
                }
                
            }
            if (this.xconfig.drag_source) {
                var ds = this.xconfig.drag_source;
                
                this.el.drag_source_set(             /* widget will be drag-able */
                    ds.modifier, //Gdk.ModifierType.BUTTON1_MASK,       /* modifier that will start a drag */
                    null,            /* lists of target to support */
                    0,              /* size of list */
                    ds.action   ////Gdk.DragAction.COPY   | Gdk.DragAction.MOVE
                                /* what to do with data after dropped */
                );
                
                this.el.drag_source_set_target_list(
                        ds.targetList // probably imports.Window.targetList;
                        //this.get('/Window').targetList
                );
                this.el.drag_source_add_text_targets();
            }
            
            if (this.xconfig.drag_dest) {
                
                var ds = this.xconfig.drag_dest;
                
                this.el.drag_dest_set
                (
                    ds.modifier, // Gtk.DestDefaults.MOTION  | Gtk.DestDefaults.HIGHLIGHT,
                    null,            /* lists of target to support */
                    0,              /* size of list */
                    ds.action //Gdk.DragAction.COPY   | Gdk.DragAction.MOVE       /* what to do with data after dropped */
                );
                
                this.el.drag_source_add_text_targets();
                this.el.drag_dest_set_target_list(
                    ds.targetList
                            //this.get('/Window').targetList
                );
                this.el.drag_dest_add_text_targets();
            }
        }
             
 
         
    }
); 

GtkTreeView.xconfig = {
    selection   : {
        type : 'Gtk.TreeSelection'
        
    }
    font         : cfg.font || false,
    drag_source : cfg.drag_source || false,
    drag_dest   : cfg.drag_dest || false
    
    
    
}


