//<Script type="text/javascript">

console = imports.console;
XObject = imports.XObject.XObject;

Lang = imports.Builder.Provider.File.Lang.Lang;

File = imports.File.File;
// File Provider..

Base = XObject.define(
    
    function(cfg) {
    
        XObject.extend(this, cfg);
    },
    Object,
    {
        
        id : false,
        name : false,   // is the JS name of the file.
        path : '',      // is the full path to the file.
        parent : false, // JS parent.
        
        title : false,  // a title.. ?? nickname.. ??? - 
        project: false, // name...
        //Project : false, // link to container project!
        
        items : false, // the tree of nodes.
        
        cn : false, // array used by project tree.
        
        
        save : function()
        {
            var write = { }; 
            var _this = this;
            var write = this.toJsonArray()
            print("WRITE: " + this.path);// + "\n" + JSON.stringify(write));
            File.write(this.path, JSON.stringify(write, null, 4));
        },
        
        /**
         * accepts:
         * { success : , failure : , scope : }
         * 
         * 
         * 
         */
         
        getTree : function( o ) {
            console.log("File.getTree tree called on base object?!?!");
        },
        toJsonArray : function()
        {
            var ret = { }; 
            var _this = this;
            ['id', 'name', 'parent', 'title', 'path', 'items', 'project'].forEach( function(k) {
                ret[k] = _this[k];
            });
            return ret;
        },
        getTitle : function()
        {
            if (this.title) {
                return this.title;
            }
            return this.path.split('/').pop();
            
        },
        getTitleTip: function()
        {
            if (this.title) {
                return '<b>' + this.title + '</b> ' + this.path;
            }
            return this.path;
        },
        sortCn: function()
        {
            this.cn.sort(function(a,b) {
                return a.path > b.path;// ? 1 : -1;
            });
        },
        // should be in palete provider really..
        
        guessName : function(ar) // turns the object into full name.
        {
             // eg. xns: Roo, xtype: XXX -> Roo.xxx
            if (typeof( ar['|xns'] ) == 'undefined' || typeof( ar['xtype'] ) == 'undefined') {
                return '';
               }
             
            return ar['|xns'] +'.' + ar['xtype'];
                            
                                 
        },
        
        /*
        Roo specific?
        toSourceStdClass: function()
        {
            var cfg = this.items[0]
            var fcfg = XObject.extend({ },  this.items[0]);
            delete fcfg['*class'];
            delete fcfg['*extends'];
            delete fcfg['*static'];
            delete fcfg['|constructor'];
            
            var hasExtends = (typeof(cfg['*extends']) != 'undefined') && cfg['*extends'].length;
            var hasConstructor = (typeof(cfg['|constructor']) != 'undefined');
            var isStatic = (typeof(cfg['*static']) == '*static');
            
            var newline = '';
            var endline = '';
            if (hasExtends) {
                newline =  hasConstructor ? 
                
                 
                    cfg['//constructor'] + "\n" + 
                    cfg['*class'] + " = " + cfg['|constructor'] + "\n\n"+ 
                    "Roo.extend(" + cfg['*class'] + ":, " + cfg['*extends'] + ", " :
                    
                    cfg['//*class'] + "\n" + 
                    cfg['*class'] + " = new " + cfg['*extends'] + "(" ;
                
                endline = ');';
            } else {
                
                
                
                newline  = hasConstructor ? 
                
                    cfg['//constructor'] + "\n" + 
                    cfg['*class'] + " = " + cfg['|constructor'] + "\n\n"+ 
                    'Roo.apply( ' +  cfg['*class'] + ".prototype , " :
                    
                    cfg['//*class'] + "\n" + 
                    cfg['*class'] + " = ";
                
                    
                endline = hasConstructor ? ');' : ';';
            }
                  
            return this.outputHeader() + 
                    newline + 
                    this.objectToJsString(fcfg,1) +
                    endline;
            
            
            
         
        },
        */
        
        copyTo: function(path, cb)
        {
            var _this = this;
            this.loadItems(function() {
                
                _this.path = path;
                cb();
            });
            
        },
        
        /**
         * 
         * munge JSON tree into Javascript code.
         * 
         * FIXME: + or / prefixes to properties hide it from renderer.
         * FIXME: '*props' - not supported by this.. ?? - upto rendering code..
         * FIXME: needs to understand what properties might be translatable (eg. double quotes)
         * 
         * @arg {object} obj the object or array to munge..
         * @arg {boolean} isListener - is the array being sent a listener..
         * @arg {string} pad - the padding to indent with. 
         */
        
        
        mungeToString:  function(obj, isListener, pad)
        {
            pad = pad || '    ';
            var keys = [];
            var isArray = false;
            isListener = isListener || false;
             
            // am I munging a object or array...
            if (obj.constructor.toString() === Array.toString()) {
                for (var i= 0; i < obj.length; i++) {
                    keys.push(i);
                }
                isArray = true;
            } else {
                for (var i in obj) {
                    keys.push(i);
                }
            }
            
            
            var els = []; 
            var skip = [];
            if (!isArray && 
                    typeof(obj['|xns']) != 'undefined' &&
                    typeof(obj['xtype']) != 'undefined'
                ) {
                    this.mungeXtype(obj['|xns'] + '.' + obj['xtype'], els);
                    //els.push('xtype: '+ obj['|xns'] + '.' + obj['xtype']);
                    skip.push('|xns','xtype');
                }
            
            
            if (!isArray && obj.items && obj.items.length) {
                // look for props..
                var newitems = [];
                obj.items.forEach(function(pl) {
                    if (typeof(pl['*prop']) == 'undefined') {
                        newitems.push(pl);
                        return;
                    }
                    // we have a prop...
                    var prop = pl['*prop'] + '';
                    delete pl['*prop'];
                    if (!prop.match(/\[\]$/)) {
                        // it's a standard prop..
                        obj[prop] = pl;
                        keys.push(prop);
                        return;
                    }
                    prop  = prop.substring(0, prop.length -2); //strip []
                    // it's an array type..
                    obj[prop] = obj[prop]  || [];
                    obj[prop].push(pl);
                    //print("ADDNG PROP:" + prop);
                    if (keys.indexOf(prop) < 0) {
                        keys.push(prop);
                    }
                    
                    
                    
                });
                obj.items = newitems;
                //if (!obj.items.length) {
                //    delete obj.items;
                //}
                
            }
            
            
            
            
            
            var _this = this;
            
            var left =  '';
            
            keys.forEach(function(i) {
                var el = obj[i];
                if (!isArray && skip.indexOf(i) > -1) { // things we do not write..
                    return;
                }
                if (!isArray) {
                    // set the key to be quoted with singel quotes..
                    var leftv = i[0] == '|' ? i.substring(1) : i;
                    if (Lang.isKeyword(leftv) || Lang.isBuiltin(leftv)) {
                        left = "'" + leftv + "'";
                    } else if (leftv.match(/[^A-Z_]+/i)) { // not plain a-z... - quoted.
                        var val = JSON.stringify(leftv);
                        left = "'" + val.substring(1, val.length-1).replace(/'/, "\\'") + "'";
                    } else {
                        left = '' + leftv;
                    }
                    left += ' : ';
                    
                }
                if (isListener) {
                    // change the lines...
                    var str= ('' + obj[i]).replace(/^\s+|\s+$/g,"");
                    var lines = str.split("\n");
                    if (lines.length > 1) {
                        str = lines.join("\n" + pad);
                    }
                    els.push(left  + str);
                    return;
                }
                 
                
                
                //var left = isArray ? '' : (JSON.stringify(i) + " : " )
                
                if (i[0] == '|') {
                    // does not hapepnd with arrays..
                    if (typeof(el) == 'string' && !obj[i].length) { //skip empty.
                        return;
                    }
                    // this needs to go...
                    //if (typeof(el) == 'string'  && obj[i].match(new RegExp("Gtk.main" + "_quit"))) { // we can not handle this very well..
                    //    return;
                    //}
                    
                    var str= ('' + obj[i]).replace(/^\s+|\s+$/g,"");;
                    var lines = str.split("\n");
                    if (lines.length > 1) {
                        str = lines.join("\n" + pad);
                    }
                    
                    els.push(left + str);
                    return;
                }
                
                
                
                
                if (typeof(el) == 'object') {
                    
                    // we can skip empty items lists and empty listeners..
                    //if (!isArray && i == 'items' && !el.length) {
                    //    return; 
                    //}
                   // 
                    
                    els.push(left + _this.mungeToString(el, i == 'listeners', pad + '    '));
                    return;
                }
                // standard. .
                
                els.push(left + JSON.stringify(obj[i]));
            });
            
            //output the thing.
            var spad = pad.substring(0, pad.length-4);
            return (isArray ? '[' : '{') + "\n" +
                pad  + els.join(",\n" + pad ) + 
                "\n" + spad + (isArray ? ']' : '}');
               
            
            
        } 
        
         
        
    }
);






