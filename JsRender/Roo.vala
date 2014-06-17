

namespace JsRender {

    static int rid = 0; 
 
    class Roo : JsRender 
    {
       string region;
        bool disabled;
        
        public Roo(Project.Project project, string path) {
            base( project, path);
            this.xtype = "Roo";
             
            
            
            //this.items = false;
            //if (cfg.json) {
            //    var jstr =  JSON.parse(cfg.json);
            //    this.items = [ jstr ];
            //    //console.log(cfg.items.length);
            //    delete cfg.json; // not needed!
            // }
            this.modOrder = "001"; /// sequence id that this uses.
            this.region = "center";
            this.disabled = false;
            
            // super?!?!
            this.id = "file-roo-%d".printf(rid++);
            //console.dump(this);
            // various loader methods..

            string[]  dsp = { "title",
                "legend",
                "loadingText",
                "emptyText",
                "qtip",
                "value",
                "text",
                "emptyMsg",
                "displayMsg" };
            for (var i=0;i<dsp.length;i++) {
                this.doubleStringProps.add(dsp[i]);
            }

            
        }
    
    /*    
        setNSID : function(id)
        {
            
            this.items[0]['|module'] = id;
       
            
        },
        
        
        getType: function() {
            return 'Roo';
        },

    */
      
        public  override void  loadItems() throws Error // : function(cb, sync) == original was async.
        {
            
             
            print("load Items!");
            if (this.tree != null) {
                return;
            }


            var pa = new Json.Parser();
            pa.load_from_file(this.path);
            var node = pa.get_root();
            
            if (node.get_node_type () != Json.NodeType.OBJECT) {
		        throw new Error.INVALID_FORMAT ("Unexpected element type %s", node.type_name ());
	        }
            var obj = node.get_object ();
            this.modOrder = obj.get_string_member("modOrder");
            this.name = obj.get_string_member("name");
            this.parent = obj.get_string_member("parent");
            this.permname = obj.get_string_member("permname");
            this.title = obj.get_string_member("title");
            this.modOrder = obj.get_string_member("modOrder");
             
            // load items[0] ??? into tree...

            var ar = obj.get_array_member("items");
            var tree_base = ar.get_object_element(1);
            this.tree = new Node();
            this.tree.loadFromJson(tree_base);

            
        }
        /**
         * old code had broken xtypes and used arrays differently,
         * this code should try and clean it up..
         * 
         * 
         * /
        fixItems : function(node, fixthis)
        {
            if (fixthis) {
                // fix xtype.
                var fn = this.guessName(node);
                //print("guessname got " + fn);
                if (fn) {
                    var bits = fn.split('.');
                    node.xtype = bits.pop();
                    node['|xns'] = bits.join('.');
                    
                }
                // fix array???
                 
                
            }
            if (!node.items || !node.items.length) {
                return;
            }
            var _this = this;
            var aitems = [];
            var nitems = [];
            node.items.forEach(function(i) {
                
                
                
                _this.fixItems(i, true);
                if (i.xtype == 'Array') {
                    aitems.push(i);
                    return;
                }    
                nitems.push(i);
            });
            node.items = nitems; 
            
            if (!aitems.length) {
                return;
            }
            
            aitems.forEach(function(i) {
                
                if (!i.items || !i.items.length) {
                    return;
                }
                var prop = i['*prop'] + '[]';
                // colModel to cm?
                i.items.forEach(function(c) {
                    c['*prop']  = prop;
                    node.items.push(c);
                    
                });
                
                
            });
            
            
            // array handling.. 
            
            
            
            
            
        },
    */
        
       public  override  void save()
        {
            
            print("--- JsRender.Roo.save");
            base.save();
            
            // now write the js file..
            string js;
            try {
                Regex regex = new Regex("\\.(bjs|js)$");

                js = regex.replace(this.path,this.path.length , 0 , "");
            } catch (RegexError e) {
                this.name = "???";
                print("count not make filename from path");
                return;
            }
            
            //var d = new Date();
            var js_src = this.toSource();            
            //print("TO SOURCE in " + ((new Date()) - d) + "ms");
            try {
                FileUtils.set_contents(js, js_src, js_src.length);            
            } catch (FileError e ) {
                print("Save failed\n");
            }
            // for bootstrap - we can write the HTML to the templates directory..
            
            //var top = this.guessName(this.items[0]);
            //print ("TOP = " + top)
             
            
            
            
        }

        /*
        saveHTML : function(frame) {
            var top = this.guessName(this.items[0]);
            print ("TOP = " + top)
            if (top != 'Roo.bootstrap.Body') {
                return;
            }
            print("SAVE HTML -- ");
            print(frame);
            var _this = this;
            // wait a second.
            
            GLib.timeout_add_seconds(0, 1, function() {
                //    print("run refresh?");
                var html = _this.traversedom(frame);
                //print(html);
                
                //print(_this.path);
                var dir = File.dirname(_this.path) +  File.SEPARATOR + 'templates';
                //print(dir);
                if (!File.isDirectory(dir)) {
                    print("Skip no template sub-directory");
                    return false;
                }
                var fn = dir + File.SEPARATOR + File.basename(_this.path).replace(/\.bjs$/, '.html');
                //print(fn);
                File.write(fn, html);
                
                
                 return false; // only once..
                
                
                
            });
            
            
            
            
        },
        
        
        traversedom :  function(web_frame) {
            print("TRAVERSE DOM?");
            
            var dom = web_frame.get_dom_document().body;
            print(dom);
            var ret = '';
            //Roo.select('body > div',true).each(function(el) {
            this.traverseDOMTree(function(s) { ret+=s; }, dom, 1);
            return ret;
        },
        
        
        traverseDOMTree : function(cb, currentElement, depth) {
            if (!currentElement) {
                
                return;
            }
            if (currentElement.class_name.match(/roo-dynamic/)) {
                return;
            }
            
            //Roo.log(currentElement);
            var j;
            var nodeName = currentElement.node_name;
            var tagName = currentElement.tag_name;
            
            if  (nodeName == '#text') {
                cb(currentElement.node_value);
                return;
            
            }
             
            
            
            if(nodeName == 'BR'){
                cb("<BR/>");
                return;
            }
            if (nodeName != 'BODY') {
                
            
            
                var i = 0;
              // Prints the node tagName, such as <A>, <IMG>, etc
                if (tagName) {
                    var attr = [];
                    for(i = 0; i < currentElement.attributes.length;i++) {
                        var aname = currentElement.attributes.item(i).name;
                        if (aname=='id') {
                            aname= 'xbuilderid';
                        }
                        // skip
                        if (currentElement.attributes.item(i).value == 'builderel') {
                            return;
                        }
                        attr.push(aname + '="' + currentElement.attributes.item(i).value + '"' );
                    }
                    
                    
                    cb("<"+currentElement.tag_name+ ( attr.length ? (' ' + attr.join(' ') ) : '') + ">");
                } 
                else {
                  cb("[unknown tag]");
                }
            } else {
                tagName = false;
            }
            // Traverse the tree
            i = 0;
            var currentElementChild = currentElement.child_nodes.item(i);
            var allText = true;
            while (currentElementChild) {
                // Formatting code (indent the tree so it looks nice on the screen)
                
                if  (currentElementChild.node_name == '#text') {
                    cb(currentElementChild.node_value);
                    i++;
                    currentElementChild=currentElement.child_nodes.item(i);
                    continue;
                }   
                allText = false;
                cb("\n");
                for (j = 0; j < depth; j++) {
                  // &#166 is just a vertical line
                  cb("  ");
                }               
                
                    
                // Recursively traverse the tree structure of the child node
                this.traverseDOMTree(cb, currentElementChild, depth+1);
                i++;
                currentElementChild=currentElement.child_nodes.item(i);
            }
            if (!allText) {
                    // The remaining code is mostly for formatting the tree
                cb("\n");
                for (j = 0; j < depth - 1; j++) {
                  cb("  ");
                }     
            }
            if (tagName) {
                cb("</"+tagName+">");
            }
            
        }
        */
        
        
        
         /**
         * convert xtype for munged output..
         * 
         */
        /*
        mungeXtype : function(xtype, els)
        {
            var bits = xtype.split('.');
            // assume it has lenght!
            
            els.push("xtype: '"+ bits.pop()+"'");
            els.push('xns: '+ bits.join('.'));
            if (xtype.match(/bootstrap/)) {
                els.push("'xtype-bootstrap' : '"+ xtype +"'");
            }
                //code
            
            
            
        },
        */
        
        string? toSourcePreview()
        {
            
            var top = this.guessName(this.tree);
            //print(JSON.stringify(this.items, null,4));
                       
            if (top == null) {
                return null;
            }
            
            
            if (top.contains("Dialog")) {
                return this.toSourceDialog(true);
            }
            
            if (top.contains("Modal")) {
                return this.toSourceModal(true);
            }
            
            return this.toSourceLayout(true);
            
            
            
        }
        
        /**
         * This needs to use some options on the project
         * to determine how the file is output..
         * 
         * At present we are hard coding it..
         * 
         * 
         */
        public override string toSource()
        {
            // dump the file tree back out to a string.
            
            // we have 2 types = dialogs and components
            // 
            var top = this.guessName(this.tree);
            if (top != null) {
                return "";
            }
            if (top.contains("Dialog")) {
                return this.toSourceDialog(false);
            }
            
            if (top.contains("Modal")) {
                return this.toSourceModal(true);
            }
            return this.toSourceLayout(false);
            
            /*
            eventually support 'classes??'
             return this.toSourceStdClass();
            */
              
        }
       
        public string outputHeader()
        {
            string[] s = {
                "//<script type=\"text/javascript\">",
                "",
                "// Auto generated file - created by app.Builder.js- do not edit directly (at present!)",
                ""
            };
            return string.joinv("\n",s);
            
       
        }
        // a standard dialog module.
        // fixme - this could be alot neater..
        public string toSourceDialog(bool isPreview) 
        {
            
            //var items = JSON.parse(JSON.stringify(this.items[0]));
            
            
            var o = this.mungeToString("            ");   
            
            string[] adda = { " = {",
                "",
                "    dialog : false,",
                "    callback:  false,",
                "",   
                "    show : function(data, cb)",
                "    {",
                "        if (!this.dialog) {",
                "            this.create();",
                "        }",
                "",
                "        this.callback = cb;",
                "        this.data = data;",
                "        this.dialog.show(this.data._el);",
                "        if (this.form) {",
                "           this.form.reset();",
                "           this.form.setValues(data);",
                "           this.form.fireEvent('actioncomplete', this.form,  { type: 'setdata', data: data });",
                "        }",
                "",   
                "    },",
                "",
                "    create : function()",
                "    {",
                "        var _this = this;",
                "        this.dialog = Roo.factory(" 
            };
            string[] addb = {  
                        ");",
                "    }",
                "};",
                ""
            };
            return  this.outputHeader() + "\n" +
                this.name + string.joinv("\n", adda) + o + string.joinv("\n", addb);
            
             
             
             
        }
        
        public string toSourceModal(bool isPreview) 
        {
            
            
            //var items = JSON.parse(JSON.stringify(this.items[0]));
            var o = this.mungeToString("            ");   
            
            string[] adda = { " = {",
                "",
                "    dialog : false,",
                "    callback:  false,",
                "",   
                "    show : function(data, cb)",
                "    {",
                "        if (!this.dialog) {",
                "            this.create();",
                "        }",
                "",
                "        this.callback = cb;",
                "        this.data = data;",
                "        this.dialog.show(this.data._el);",
                "        if (this.form) {",
                "           this.form.reset();",
                "           this.form.setValues(data);",
                "           this.form.fireEvent('actioncomplete', this.form,  { type: 'setdata', data: data });",
                "        }",
                "",   
                "    },",
                "",
                "    create : function()",
                "    {",
                "        var _this = this;",
                "        this.dialog = Roo.factory("
            };
            string[] addb =  {
                ");",
                "    }",
                "};",
                ""
            };
            return this.outputHeader() + "\n" + 
                this.name + string.joinv("\n", adda) + o + string.joinv("\n", addb);
             
             
             
        }
        
        
        public string   pathToPart()
        {
            var dir = Path.get_basename(Path.get_dirname(this.path));
            var ar = dir.split(".");
            var modname = ar[ar.length-1];
            
            // now we have the 'module name'..
            var fbits = Path.get_basename(this.path).split(".");
            
             
            var npart = fbits[fbits.length - 2]; // this should be 'AdminProjectManager' for example...
            if (npart.substring(0, modname.length) == modname) {
                npart = npart.substring(modname.length);
            }
            return "[" + this.tree.quoteString(modname) + ", " + this.tree.quoteString(npart) + " ]";
            //return ret;
            
            
            
            
        }
        
        // a layout compoent 
        public string toSourceLayout(bool isPreview) 
        {
          
            
            if (isPreview) {
            //       topItem.region = 'center';
            //    topItem.background = false;
            }
            
            var o = this.mungeToString("            ");   
            var reg = new Regex("[^A-Za-z.]+");
            
            string modkey = this.modOrder + "-" + reg.replace(this.name, this.name.length, 0 , "-");
            
            string  parent =   (this.parent.length > 0 ?  "'" + this.parent + "'" :  "false");

            if (isPreview) {
                parent = "false"; 
            }
            
          
            return 
                this.outputHeader() + "\n" +
                
                this.name  +  " = new Roo.XComponent({\n" +
                "    part     :  "+ this.pathToPart() + ",\n" +
                        /// critical used by builder to associate modules/parts/persm
                "    order    : '" +modkey+"',\n" +
                "    region   : '" + this.region   +"',\n" +
                "    parent   : "+ parent + ",\n" +
                "    name     : " + this.tree.quoteString(this.title.length > 0 ? this.title : "unnamed module") + ",\n" +
                "    disabled : " + (this.disabled ? "true" : "false") +", \n" +
                "    permname : '" + (this.permname.length > 0 ? this.permname : "") +"', \n" +
                    
               // "    tree : function() { return this._tree(); },\n" +   //BC
                "    _tree : function()\n" +
                "    {\n" +
                "        var _this = this;\n" + // bc
                "        var MODULE = this;\n" + /// this looks like a better name.
                "        return " + o + ";" +
                "    }\n" +
                "});\n";
                 
             
            
        }
            
        public new string? guessName (Node? ar) // turns the object into full name.
        {
             // eg. xns: Roo, xtype: XXX -> Roo.xxx
            if (ar == null) {
                return null;
            }
            
            string[] ret = {} ;
            ret += (ar.get("|xns").length < 1 ? "Roo": ar.get("|xns"));
             
            
            if ( ar.get("xtype").length < 1) {
                return null;
            }
                    
            var xtype = ar.get("xtype");

            if (xtype[0] == '*') { // prefixes????
                xtype  = xtype.substring(1);
            }
            if (! Regex.match_simple("^Roo", xtype)) {
                
                // already starts with roo...
                ret = {};
            }
            ret += xtype;
            var str =  string.joinv(".", ret);
            
            return str;
           // 
            //Palete.Palete.factory("Roo").guessName(str);
            
                            
                                 
        }
        
        string getHelpUrl(string cls)
        {
            return "http://www.roojs.com/roojs1/docs/symbols/" + cls + ".html";
        }
		public override  string toValaSource(bool testcompile) { 
			return ""; // never called as roo does not output vala.. yet...
		}
     
    }
}