//<Script type="Text/javascript">

XObject = imports.XObject.XObject
GtkClutter = imports.gi.GtkClutter;

//GtkClutter.Embed..
// children are not added at init / but at show stage..
// listener is added on show..
// we should really add a hock to destroy it..
WebKitWebView  = {
 
    pack : function(parent, item)
    {
        
        if (XObject.type(parent.xtype) == 'GtkScrolledWindow') {
            parent.el.add(this.el);
            return;
        }
        XObject.fatal("do not know how to pack webview to" +  XObject.type(parent.xtype));
        
    } 
     

};