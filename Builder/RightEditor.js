//<Script type="text/javascript">
Gio = imports.gi.Gio;
Gtk = imports.gi.Gtk;
GObject = imports.gi.GObject;

Pango = imports.gi.Pango ;

GtkSource = imports.gi.GtkSource;

if (!GtkSource) {
    Seed.die("Failed to load SourceView");
}

XObject = imports.XObject.XObject;
console = imports.console;

LeftPanel = imports.Builder.LeftPanel.LeftPanel;


RightEditor = new XObject({
         
        xtype: GtkScrolledWindow,
        
        shadow_type :  Gtk.ShadowType.IN  ,
        
        items : [
            { 
                id : 'view',
                xtype : GtkSource.View,
                
                init : function() {
                    XObject.prototype.init.call(this); 
                    this.el.get_buffer().signal.changed.connect(function() {
                            var s = new Gtk.TextIter();
                            var e = new Gtk.TextIter();
                            _view.el.get_buffer().get_start_iter(s);
                            _view.el.get_buffer().get_end_iter(e);
                            var str = _view.el.get_buffer().get_text(s,e,true);
                            LeftPanel.get('model').changed(  str , false);
                    });
                   
                    var description = Pango.Font.description_from_string("monospace")
                    description.set_size(8000);
                    this.el.modify_font(description);
            
                    
                      
                   
                },
                
                load : function(str) {
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
                    
                    
                    
                    this.el.grab_focus();
                },
                // neeed???
                //buffer : new GtkSource.Buffer()
                
                
            }
        ]
    }
        
        
    
    
    
);
    
