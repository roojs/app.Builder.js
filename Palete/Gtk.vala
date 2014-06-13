namespace Palete {

	
	
	
	
    public class Introspect.El : Object
    {
        public enum eltype { 
            NS,
            CLASS,
            METHOD,
            PROP
        }
                
            
        public eltype type;
    }


    public class Gtk : Palete {
		
		
        public Gtk()
        {


            
            base();
            this.name = "Gtk";
			this.load();
            // various loader methods..
              //this.map = [];
            //this.load();
            //this.proplist = {};
            //this.comments = { }; 
            // no parent...
        }
      
        void load () {
                
         
    		string raw;
			if (!FileUtils.test ("/usr/share/appBuilder/GtkUsage.txt", FileTest.EXISTS)) {
				throw new Error.MISSING_FILE("/usr/share/appBuilder/GtkUsage.txt not found");
				
			}
			
            FileUtils.get_contents("/usr/share/appBuilder/GtkUsage.txt", out raw);
          // print(data);
            var data  = raw.split("\n");
            var state = 0;
            var cfg = new GLib.List<Usage>();
            var left = new GLib.List<string>();
            var right = new GLib.List<string>();

			for (var i = 0; i < data.length; i++) {
				var d = data[0];
				if (
					d.length < 1
				    ||
				     Regex.match_simple ("^\\s+$", d)
				    ||
					Regex.match_simple ("^\\s*/", d)
			     ){
                    continue;
                }
				
                if (Regex.match_simple ("^left:", d)) { 
                    state = 1;
                    if (left.length() > 0 ){
                        
                        cfg.append(new Usage( left, right));
					}
                    left = new GLib.List<string>();
        			right = new GLib.List<string>();
                    continue;
                }
                 if (Regex.match_simple ("^right:", d)) { 
                    state = 2;
                    continue;
                }
                if (state == 1) {
                    left.append(d.strip());
                    return;
                }
                right.append(d.strip());
                //Seed.quit();
               
            }
            if (left.length() > 0 ){
                  cfg.append(new Usage( left, right));
            }
            this.map = cfg.copy();
             
        }
        
        public string doc(string what) {
            var ns = what.split(".")[0];
            var gir =  Gir.factory(ns);
			return   gir.doc(what);
			
            //return typeof(this.comments[ns][what]) == 'undefined' ?  '' : this.comments[ns][what];
        }

		// does not handle implements...
		
        public Gee.HashMap<string,GirObject>? getPropertiesFor(string ename, string type)
        {
            //print("Loading for " + ename);
            


			// if (typeof(this.proplist[ename]) != 'undefined') {
                //print("using cache");
             //   return this.proplist[ename][type];
            //}
            // use introspection to get lists..
 
            var es = ename.split(".");
			var gir = Gir.factory(es[0]);
			
			var cls = gir.classes.get(es[1]);
			if (cls == null) {
				var ret = new Gee.HashMap<string,GirObject>();
				return ret;
				//throw new Error.INVALID_VALUE( "Could not find class: " + ename);
				
			}

			//cls.parseProps();
			//cls.parseSignals(); // ?? needed for add handler..
			//cls.parseMethods(); // ?? needed for ??..
			//cls.parseConstructors(); // ?? needed for ??..

			cls.overlayParent();

			switch  (type) {
				case "props":
					return cls.props;
				case "signals":
					return cls.signals;
				case "methods":
					return cls.methods;
				case "ctors":
					return cls.ctors;
				default:
					var ret = new Gee.HashMap<string,GirObject>();
					return ret;
					
			}
					
				
			//cls.overlayInterfaces(gir);
            
            
             
        }
		public string[] getInheritsFor(string ename)
		{
			string[] = {};
			var es = ename.split(".");
			var gir = Gir.factory(es[0]);
			
			var cls = gir.classes.get(es[1]);
			if (cls == null) {
				return ret;
			}
			return cls.inheritsToStringArray();
			

		}
        /*
        genParams: function(sig, meth)
        {
            var args = ['self'];
            var ret = "\n";
            meth.ret_type = this.typeToName(GIRepository.callable_info_get_return_type(sig));
            // might be a numbeR??
            meth.params = [];
            for(var a_i  =0; a_i   < GIRepository.callable_info_get_n_args(sig); a_i++) {
                var arg = GIRepository.callable_info_get_arg(sig, a_i);
                 
                meth.params.push({
                    name  : arg.get_name(),
                    type : this.typeToName(arg.get_type(), true)
                });
            }
            
                
            
            
        },
        genSkel: function(sig) // should really use genParams...
        {
            var args = ['self'];
            var ret = "\n";
            var ret_type = this.typeToName(GIRepository.callable_info_get_return_type(sig));
            // might be a numbeR??
            if (ret_type == 'boolean') {
                ret = "    return false;\n";
            }
            for(var a_i  =0; a_i   < GIRepository.callable_info_get_n_args(sig); a_i++) {
                var arg = GIRepository.callable_info_get_arg(sig, a_i);
                
                args.push(arg.get_name());
            }
            return 'function (' + args.join(', ') + ") {\n" + ret + "}"; 
                
            
            
        },
        typeToName  : function (type_info, allow_iface) // find type for properties or arguments.
        {
           var ty = GIRepository.type_tag_to_string( GIRepository.type_info_get_tag(type_info));
           
            if ((ty == 'void') && GIRepository.type_info_is_pointer(type_info)) {
                return false;
            }
            if (ty == 'array') {
                return false; // unspported   
            }
            if (ty != 'interface') {
                return ty;
            }
            // we can accept enum types here..
            var interface_info = GIRepository.type_info_get_interface(type_info);
            var interface_type = interface_info.get_type();
            
            if (!allow_iface && interface_type != GIRepository.InfoType.ENUM) {
                return false;
            }
            return interface_info.get_namespace() + '.' + interface_info.get_name();
            
        },
        /**
         * merge two proprety arrays' ignoring what's overrriden.
         * 
         * /
        
        
        overrides : function (top, bottom)
        {
            function inTop(b)
            {
                return !top.every(function(t) {
                    if (t.name == b.name) {
                        return false;
                    }
                    return true;
                });
            }
            bottom.forEach(function(e) {
                if (!inTop(e)) {
                    top.push(e);
                }
            });
            
        },
        
        /**
         * guess type..
         * 
         * /
        findType : function (data, prop, value)
        {
            // specials??
            if ((prop == '|xns') || (prop == 'xtype'))  {
                return 'string';
            }
            
            var qname = this.guessName(data);
            if (prop[0] == '|') {
                prop= prop.substring(1);
            }
            
            var prs = this.getPropertiesFor(qname, 'props');
            var ret = false;
            prs.forEach(function(e) {
                if (ret !== false) {
                    return; // got it.
                }
                if (e.name == prop) {
                    ret = e;
                }
                
            });
            if (!ret) {
                return Base.prototype.findType(data, prop,value);
            }
             
            // got the type
            return ret.type;
        },
        
        findOptions : function(ename)
        {
            
            var es = ename.split('.');
            if (es.length !=2) {
                return Base.prototype.findOptions(ename);
            }
            var gi = GIRepository.Repository.get_default();
            var bi = gi.find_by_name(es[0], es[1]);
            var etype = GIRepository.object_info_get_type(bi);
            if (etype != GIRepository.InfoType.ENUM) {
                console.log("Options not handled yet!!!");
                return false;
            }
            var ret = [];
            // got an enum.. let's return the values..
            for(var i =0; i < bi.get_n_values(); i++) {
                 
                  var prop = bi.get_value(i);
                   
                
                  ret.push( ename + '.' + prop.get_name().toUpperCase() ) 
            }
            return ret;
        },
        /**
         * determine the packing types..
         * /
        getDefaultPack: function(pname, cname) {
            var list = this.getPackingList(pname,cname);
           // console.dump(list);
            
            
            if (!list.every(function(e) { return e.name != 'add'; })) {
                return 'add'; // add is in our list..?? what about args..?!?
            }
            function toRet(e) {
                var ret = [e.name];
                e.params.forEach(function(p,i) {
                    if (ret === false) { return; } // skip broken..
                    if (i==0) { return; } // skip first..
                    if (p.type == 'boolean') {
                        ret.push('false');
                        return;
                    }
                    if (p.type == 'number') {
                        ret.push('0');
                        return;
                    }
                    if (p.type == 'uint') {
                        ret.push('0');
                        return;
                    }
                    ret = false; // invalid!
                });
                return ret === false ? false : ret.join(',');
            };
            var packret = false;
            list.every(function(e) {
                
                packret = toRet(e);
                //print("DEFAULT PACK TEST : " + e.name + " : " +packret);
                if (packret !== false) {
                    return false;
                }
                return true; // continue
            });
            //print("DEFAULT PACK: " + packret);
            // should we do best match..?
            return packret;
        },
        /**
         * get packing list..
         * /
        getPackingList :function (pname, cname)
        {
            var funcs = this.getPropertiesFor(pname,'methods');
            //print("getPackingList : ALL FUNCS");
            //console.dump(funcs);
            var ret = [];
            var _this = this;
            // let's assume top down...
            var inherits = [ cname ];
            inherits.push.apply(inherits, this.getPropertiesFor(cname,'inherits'));
            funcs.forEach(function(m) {
                if (m.params.length && (typeof(m.params[0].type) == 'string') &&
                    inherits.indexOf(m.params[0].type) > -1) {
                    ret.push(m);
                }
            });
            return ret; 
        }
      */

		public override void fillPack(JsRender.Node node,JsRender.Node parent)
		{   
			
			// parent.fqn() method ( node.fqn()
			
			var cls = gir.classes.get(node.fqn());
			if (cls == null) {
				print("oops can not find class " + es
				return;
			}

			
		}
	
    }
}
 
