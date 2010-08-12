//<Script type="text/javascript">
Gtk = imports.gi.Gtk;
GLib = imports.gi.GLib;
GObject = imports.gi.GObject;

XObject = imports.XObject.XObject;
console = imports.console;
 



LeftPanelPopup = new XObject({
    
        
    xtype : Gtk.Menu,
    
     
    items :  [
        {
            
            
            xtype : Gtk.MenuItem,
            pack : [ 'append' ],
            label : 'Delete Property / Event',
            listeners : {
                activate : function () {
                    imports.Builder.LeftPanel.LeftPanel.get('model').deleteSelected();
                }
            }
        },
        {
            
            
            xtype : Gtk.MenuItem,
            pack : [ 'append' ],
            label : 'Edit Property / Method Name',
            listeners : {
                activate : function () {
                   imports.Builder.LeftPanel.LeftPanel.get('model').startEditing(false, 0);
                }
            }
        },
        {
            
            
            xtype : Gtk.MenuItem,
            pack : [ 'append' ],
            label : 'Change Property to Javascript Value',
            listeners : {
                activate : function () {
                   imports.Builder.LeftPanel.LeftPanel.get('model').setSelectedToJS();
                }
            }
        },
        {
            
            
            xtype : Gtk.MenuItem,
            pack : [ 'append' ],
            label : 'Change Property to String (or native) Value',
            listeners : {
                activate : function () {
                    imports.Builder.LeftPanel.LeftPanel.get('model').setSelectedToNoJS();
                }
            }
            
        },
    ]
});
