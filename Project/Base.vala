//<Script type="text/javascript">

/**
 * Project Object
 * 
 * Projects can only contain one directory... - it can import other projects..(later)
 * 
 * we need to sort out that - paths is currently a key/value array..
 * 
 * 
 * 
 */
namespace Project {


public class Base {
    
    
    int id = 0;
    string fn = "";
    string name = "";
    Gee.Map<string,string> paths;
    Array<JsRender.Base> files ;
    //tree : false,
    string xtype = "";
    
    
    void Base (string path) {
        
        this.name = name;
        
        
        this.paths = new Gee.Map<string,string> <string>();
        this.files = new Array<JsRender.Base>();
        //XObject.extend(this, cfg);
        //this.files = { }; 
        
        
        this.scanDirs();
        
    },
    
    public void onChanged() {
        ProjectManager.fireEvent('changed');
        
    }
    /*
    public load
     
        
        load : function (o)  // is this used??
        {
            if (!this.fetchTree) {
                console.log("Project.getTree tree called on base object?!?!");
                return false;
            }
            
            if (this.files) {
                return o.success.apply(o.scope || this, [this]);
            }
            return this.fetchTree(o);
            
        },
    */
    public Palete  getPalete ()
    {
            //print("Project.Base: GET PROVIDER FOR " + this.xtype);
            return  ProjectManager.getPalete(this.xtype);
    },
    
    public string toJSON()
    {
        
        var builder = new Json.Builder ();
        
        builder.begin_object ();
        
        builder.set_member_name ("name");
        builder.add_string_value (this.name);

        
        builder.set_member_name ("fn");
        builder.add_string_value (this.fn);

        builder.set_member_name ("xtype");
        builder.add_string_value (this.xtype);
        
        // file ??? try/false?
        builder.set_member_name ("paths");
        
        
        builder.begin_array ();
        
        
        var iter = this.paths.map_iterator();
        while (null != iter.next()) {
            builder.add_string_value (iter.get_key());
        }
        builder.end_array ();
        
        
        var  generator = new Json.Generator ();
        var  root = builder.get_root ();
        generator.set_root (root);

        return  generator.to_data (null);
	      
          
    }
    // returns the first path
    public string getName()
    {
        var iter = this.paths.map_iterator();
        while (null != iter.next()) {
            return GLib.basename(iter.get_key());
        }
      
        return "";
    }
    /**
     *
     * to tree - > should
     */
 
    public Array<JsRender.Base> toTree ()
    {
            
         
         
        var files = new Gee.Map<string,Json.Object>();
        
        
        for(var i = 0; i < this.files.length; i++) {
            var fo = this.files.index(i);
            
            fo.hasParent = false;
            fo.cn = new Array<JsRender.Base>();
            
            if (this.files.index(i).fullname.length > 0) {
                files.set(fo.fullname, f);
            }
        }
        
        var iter = files.map_iterator();
        while (null != iter.next()) {
            var f = iter.get_value();
            
            var par = f.parent;
            if (par.length < 1) {
                return;
            }
            if (!files.has_key(par)) {
                return;
            }
            files.get(par).cn.add(f);
            f.hasParent = true;
             
        };
            
        var ret = new Array<JsRender.Base>();
        iter = files.map_iterator();
        while (null != iter.next()) {
            var f = iter.get_value();
                
            //   f.sortCn();
            if (f.hasParent) {
                continue;
            }
            if (files.has_key(f.fullname))) {
            
                ret.add(f);
            }
        }
        ret.sort( (a,b) => {
            return a.path > b.path ? 1 : -1;
        });
        
        
        //print(JSON.stringify(ret,null,4));
            
        return ret;  
             
            
    }
    
    
    
    public ?JsRender.Base getById(string id)
    {
        
       for(var i = 0; i < this.files.length; i++) {
            var fo = this.files.index(i);
            
            
            //console.log(f.id + '?=' + id);
            if (f.id == id) {
                return f;
            }
        };
        return null;
    },
        
    public JsRender.Base loadFileOnly (string path)
    {
        var xt = this.xtype;
        return JsRender.Base.factory(xt, this, path);
        
    },
    
    public JsRender.Base create(string filename)
    {
        var ret = this.loadFileOnly(filename);
        ret.save();
        this.addFile(ret);
        return ret;
        
    }
        
         
    public void addFile(JsRender.Base pfile) { // add a single file, and trigger changed.
        this.files.append_val(pfile); // duplicate check?
        this.onChanged();
    }
    
    public void add(string path, string type)
    {
        this.paths.set(path,type);
        //Seed.print(" type is '" + type + "'");
        if (type == 'dir') {
            this.scanDir(path);
        //    console.dump(this.files);
        }
        if (type == 'file' ) {
            this.files.append_val(this.loadFileOnly( path ));
        }
        this.onChanged();
        
    },
    public void  scanDirs()
    {
        var iter = files.map_iterator();
        while (null != iter.next()) {
            if (iter.get_value() != "dir") {
                continue;
            }
            this.scanDir(iter.get_key());
        }
        //console.dump(this.files);
        
    },
        // list files.
    public void scanDir(string dir, int dp =0 ) 
        {
            //dp = dp || 0;
            //Seed.print("Project.Base: Running scandir on " + dir);
            if (dp > 5) { // no more than 5 deep?
                return;
            }
            // this should be done async -- but since we are getting the proto up ...
            
            
            var dirs = File.list(dir);
            
            ///print(dirs); Seed.exit();
            
            var subs = [];
            var _this = this;
            dirs.forEach(function( fn ){ 
                 
                //console.log('trying ' + dir + '/' + fn);
                if (!fn) {
                    subs.forEach( function(s) {
                        _this.scanDir(s, dp+1);
                    });
                    return;
                }
                if (fn[0] == '.') { // skip hidden
                    return;
                }
                
                if (GLib.file_test(dir  + '/' + fn, GLib.FileTest.IS_DIR)) {
                    subs.push(dir  + '/' + fn);
                    return;
                }
                
                if (!fn.match(/\.bjs$/)) {
                    return;
                }
                var parent = '';
                //if (dp > 0 ) {
                var sp = dir.split('/');
                sp = sp.splice(sp.length - (dp +1), (dp +1));
                parent = sp.join('.');
                
                
                if (typeof(_this.files[dir  + '/' + fn]) != 'undefined') {
                    // we already have it..
                    _this.files[dir  + '/' + fn].parent = parent;
                    return;
                }
                var xt = _this.xtype;
                var cls = imports.JsRender[xt][xt];
                
                //Seed.print("Adding file " + dir  + '/' + fn);
                _this.files[dir  + '/' + fn] = new cls({
                    path : dir  + '/' + fn,
                    parent : parent,
                    project : _this
                });
                //console.log(this.files[dir  + '/' + fn] );
                /*
                var f = Gio.file_new_for_path(dir + '/' + fn);
                var inf = f.query_info('standard::*');
                var tv = new GLib.TimeVal();
                inf.get_modification_time(tv);
                
                // should it do something about this information..
                // fixme... time data is busted..
                this.files[dir  + '/' + fn] = '' + tv.tv_sec + '.' + tv.tv_usec;
                */
            });
             
            
        }
        
        
        
        
        

    }
); 


     
 