/* -- to compile
valac  --pkg gio-2.0  --pkg posix  --pkg gtk+-3.0  \
    menu.vala  -o /tmp/menutest
*/


/* -- to test class
static int main (string[] args) {
    Gtk.init (ref args);
    new Xcls_WindowLeftTree();
    WindowLeftTree.show_all();
     Gtk.main ();
    return 0;
}
*/
	
int main (string[] args) {
    Gtk.init (ref args);
    
	GLib.Log.set_always_fatal(LogLevelFlags.LEVEL_ERROR | LogLevelFlags.LEVEL_CRITICAL); 


	var w = new Gtk.Window(  );

	var b = new Gtk.Button.with_label ("Click me (0)");

	var leftmenu = new Gtk.Menu();
	
    this.el.button_press_event.connect(   ( ev) => {
        
        if (ev.type != Gdk.EventType.BUTTON_PRESS  || ev.button != 3) {
            return false;
        }

            
        //leftmenu.el.set_screen(Gdk.Screen.get_default());
         
        leftmenu.popup(null, null, null,  ev.button, ev.time);
	
          return true;
    } );


	var child_0 = new Xcls_MenuItem7();
	child_0.init();
	leftmenu.append (  child_0.el  );
	
	Gtk.main();
}
public class Xcls_MenuItem7 : Object  
{
    public Gtk.MenuItem el;
 
	public void init( ) {
 
	 
		this.el = new Gtk.MenuItem.with_label("Delete Element");
        print("add activate\n");
        this.el.activate.connect(   ( ) => {
            
            print("SELECT?");
            
			return  ;
        } );
    }

}
    
