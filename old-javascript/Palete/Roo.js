//<Script type="text/javascript">
 
Gio       = imports.gi.Gio;

console   = imports.console;
XObject   = imports.XObject.XObject;

Base      = imports.Palete.Base.Base;
File      = imports.File.File;
//----------------------- our roo verison


// single instance controlled by projectmanager.

Roo = XObject.define(
    function(cfg) {
        
       
        // various loader methods..
         this.map = [];
        this.load();
       
        // no parent...
        
       
    },
    Base,
    {
    
        name : 'Roo',
        
        load: function ( o ) {
            
             
            var data = File.read(__script_path__ +'/RooUsage.txt');
            //print(data);
            data  = data.split(/\n/g);
            var state = 0;
            var cfg = [];
            var left = [];
            var right = [];
            
            data.forEach( function(d) {
                if (!d.length || d.match(/^\s+$/) || d.match(/^\//)) { //empty
                    return;
                }
                if (d.match(/^left:/)) { 
                    state = 1;
                    if (left.length ){
                        
                        cfg.push({
                            left : left,
                            right: right
                        });
                        }
                    left = [];
                    right = [];
                    return;
                }
                if (d.match(/^right:/)) { 
                    state = 2;
                    return;
                }
                if (state == 1) {
                    left.push(d.replace(/\s+/g, ''));
                    return;
                }
                right.push(d.replace(/\s+/g, ''));
                //Seed.quit();
               
            }); 
            if (left.length ){
                        
                cfg.push({
                    left : left,
                    right: right
                });
            }
            this.map = cfg;
            
        },
        loadProps: function()
        {
             

            if (this.proplist) {
                return;
            }
            
           
            
            var data =  File.read(__script_path__ +'/rooprops.json');
            this.proplist = JSON.parse(data).data;
        },
        getPropertiesFor: function(ename, type)
        {
            this.loadProps();
            if (typeof(this.proplist[ename]) == 'undefined' || 
                typeof(this.proplist[ename][type]) == 'undefined' ) {
                    return [];
            }
            return this.proplist[ename][type];
        },
        guessName: function(ar)
        {
            var name = ar;
            if (typeof(name) !== 'string') {
                name = Base.prototype.guessName(ar);
            }
            
            this.loadProps();
            if (typeof(this.proplist[name]) != 'undefined') {
                return name;
            }
            // roo toolbar is not in our DB!
            if (name.match(/^Roo\.Toolbar\..*/)) {
                return name;
            }
            
            var match = name.split('.').pop();
            for (var i in this.proplist) {
                var last = i.split('.').pop();
                if (last == match) {
                    return i;
                }
                
            }
            return name;
            
            
        }
        
        
        
    }
);

   
