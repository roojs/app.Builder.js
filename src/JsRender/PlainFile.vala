
/**
 * 
 *  this is the code represents a File when using the Gtk view..
 *   
 *  It ues NodeToGtk
 * 
 * 
 */

namespace JsRender {


 
    int plid = 1;

  
    public  class PlainFile : JsRender
    {
		string contents;

        public PlainFile(Project.Project project, string path) {
        
            base( project, path);
            this.xtype = "PlainFile";
            
            var f = File.new_for_path (path) ;
            var info = f.query_info ("standard::*", 0);
            var ct = info.get_content_type();
            this.content_type = ct;
       
            this.language = "";
             
            // fixme...

            
            this.contents = "";
            
            // super?!?!
            this.id = "file-plain-%d".printf(plid++);
            //console.dump(this);
            // various loader methods..

            // Class = list of arguments ... and which property to use as a value.
       

            
            
        }
          

        /*
        setNSID : function(id)
        {
            
            this.items[0]['*class'] = id;
            
            
        },
        getType: function() {
            return 'Gtk';
        },
        */

	public   override void	 removeFiles() {
		if (FileUtils.test(this.path, FileTest.EXISTS)) {
			GLib.FileUtils.remove(this.path);
		}
		 
	}
    
	public   override void  loadItems() throws GLib.Error // : function(cb, sync) == original was async.
	{
	   
	       GLib.FileUtils.get_contents(this.path, out this.contents);
	       this.loaded = true;
	}
     
        
		
        public override string toSourcePreview()
        {
			 return "";
		}
		public override void setSource(string str) {
			this.contents = str;
		}
        public override string toSource()
        {
			return this.contents;
            
             
            
        }
		
        public override void save() {
    		if (!this.loaded) {
    			print("Ignoring Save  - as file was never loaded?\n");
	    		return;
    		}
    		try { 
	            this.writeFile(this.path, this.contents);
            } catch (GLib.Error e) {
	            // error ???
    		}
            
        }
	    // ignore these calls.
        public override void saveHTML ( string html ) {}
	    
		    
        /** 
         *  saveJS
         * 
         * save as a javascript file.
         * why is this not save...???
         * 
         */ 
         
   
        string getHelpUrl(string cls)
        {
            return ""; 
        }
        public override void  findTransStrings(Node? node )
		{
			// not yet..
		}
	
        
	  

		

	}
}



