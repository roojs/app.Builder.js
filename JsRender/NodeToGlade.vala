/*

<?xml version="1.0" encoding="UTF-8"?>
<!-- Generated with glade 3.18.3 -->
<interface>
  <requires lib="gtk+" version="3.12"/>
  <object class="GtkBox" id="box1">
    <property name="visible">True</property>
    <property name="can_focus">False</property>
    <property name="orientation">vertical</property>
    <child>
      <object class="GtkButton" id="button1">
        <property name="label" translatable="yes">button</property>
        <property name="visible">True</property>
        <property name="can_focus">True</property>
        <property name="receives_default">True</property>
      </object>
      <packing>
        <property name="expand">False</property>
        <property name="fill">True</property>
        <property name="position">0</property>
      </packing>
    </child>
    <child>
      <placeholder/>
    </child>
    <child>
      <object class="GtkToggleButton" id="togglebutton1">
        <property name="label" translatable="yes">togglebutton</property>
        <property name="visible">True</property>
        <property name="can_focus">True</property>
        <property name="receives_default">True</property>
      </object>
      <packing>
        <property name="expand">False</property>
        <property name="fill">True</property>
        <property name="position">2</property>
      </packing>
    </child>
  </object>
</interface>
*/
public class JsRender.NodeToGlade : Object {

	Node node;
 	string pad;
	Gee.ArrayList<string> els;
        //Gee.ArrayList<string> skip;
	Gee.HashMap<string,string> ar_props;


	public NodeToGlade( Node node,   string pad) 
	{
		this.node = node;
 		this.pad = pad;
		this.els = new Gee.ArrayList<string>(); 
		//this.skip = new Gee.ArrayList<string>();
		this.ar_props = new Gee.HashMap<string,string>();

	}
	
	public string munge ( )
	{
	 
		 
        return "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
        <!-- Generated with glade 3.18.3 -->
        <interface>
          <requires lib=\"gtk+\" version="3.12\"/>" +
          this.mungeNode() +
          "</interface>";
          
		     
	}
	public string mungeChild(string pad ,  Node cnode)
	{
		var x = new  NodeToGlade(cnode,  pad);
		return x.mungeNode();
	}
	
	public string mungeNode()
	{
		var cls = this.node.item.xvala_cls.replace(".", "");
		var id = this.node.uid();
		var ret = @"$pad<object class=\"$cls\" id=\"$id\">\n";
		// properties..
		var props = Palate.factory("Gtk").getPropertiesFor(this.node.item.xvala_cls, "props");
            
    		var pviter = props.map_iterator();
		while (pviter.next()) {
			
				// print("Check: " +cls + "::(" + pviter.get_value().propertyof + ")" + pviter.get_key() + " " );
				
        		// skip items we have already handled..
        		if  (!(this.node.props.get(pviter.get_key()) == null)) {
				continue;
			}
			var k = pviter.get_key();
			var val = GLib.Markup.escape_text(this.node.props.get(pviter.get_key()));
			ret += @"$pad    <property name="$k">$val</property>\n"; // es

                }
		// packing???
		
		ret += @"$pad    <packing>
$pad    <property name=\"expand\">False</property>
$pad    <property name=\"fill\">True</property>
$pad    <property name=\"position\">0</property>
$pad</packing>\n";

			
		// children..

		if (!this.node.items.length) {
			return ret;
		}
		
		for (var i = 0; i < this.node.items.length; i++ ) {
			ret += "<child>\n" + this.mungeChild(
			
		}
		
		

		


	}
    
    
    
}