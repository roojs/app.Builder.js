static PopoverFileDetails  _PopoverFileDetails;

public class PopoverFileDetails : Object 
{
    public Gtk.Popover el;
    private PopoverFileDetails  _this;

    public static PopoverFileDetails singleton()
    {
        if (_PopoverFileDetails == null) {
            _PopoverFileDetails= new PopoverFileDetails();
        }
        return _PopoverFileDetails;
    }
    public Xcls_name name;
    public Xcls_title title;
    public Xcls_region region;
    public Xcls_parent parent;
    public Xcls_permname permname;
    public Xcls_modOrder modOrder;
    public Xcls_build_module build_module;
    public Xcls_dbcellrenderer dbcellrenderer;
    public Xcls_dbmodel dbmodel;

        // my vars (def)

    // ctor 
    public PopoverFileDetails()
    {
        _this = this;
        this.el = new Gtk.Popover( null );

        // my vars (dec)

        // set gobject values
        var child_0 = new Xcls_VBox2( _this );
        child_0.ref();
        this.el.get_content_area().add (  child_0.el  );
    }

    // user defined functions 
    public class Xcls_VBox2 : Object 
    {
        public Gtk.VBox el;
        private PopoverFileDetails  _this;


            // my vars (def)

        // ctor 
        public Xcls_VBox2(PopoverFileDetails _owner )
        {
            _this = _owner;
            this.el = new Gtk.VBox( true, 0 );

            // my vars (dec)

            // set gobject values
            var child_0 = new Xcls_Table3( _this );
            child_0.ref();
            this.el.pack_start (  child_0.el , false,false,0 );
        }

        // user defined functions 
    }
    public class Xcls_Table3 : Object 
    {
        public Gtk.Table el;
        private PopoverFileDetails  _this;


            // my vars (def)

        // ctor 
        public Xcls_Table3(PopoverFileDetails _owner )
        {
            _this = _owner;
            this.el = new Gtk.Table( 3, 2, true );

            // my vars (dec)

            // set gobject values
            var child_0 = new Xcls_Label4( _this );
            child_0.ref();
            this.el.attach_defaults (  child_0.el , 0,1,0,1 );
            var child_1 = new Xcls_name( _this );
            child_1.ref();
            this.el.attach_defaults (  child_1.el , 1,2,0,1 );
            var child_2 = new Xcls_Label6( _this );
            child_2.ref();
            this.el.attach_defaults (  child_2.el , 0,1,1,2 );
            var child_3 = new Xcls_title( _this );
            child_3.ref();
            this.el.attach_defaults (  child_3.el , 1,2,1,2 );
            var child_4 = new Xcls_Label8( _this );
            child_4.ref();
            this.el.attach_defaults (  child_4.el , 0,1,2,3 );
            var child_5 = new Xcls_region( _this );
            child_5.ref();
            this.el.attach_defaults (  child_5.el , 1,2,2,3 );
            var child_6 = new Xcls_Label10( _this );
            child_6.ref();
            this.el.attach_defaults (  child_6.el , 0,1,3,4 );
            var child_7 = new Xcls_parent( _this );
            child_7.ref();
            this.el.attach_defaults (  child_7.el , 1,2,3,4 );
            var child_8 = new Xcls_Label12( _this );
            child_8.ref();
            this.el.attach_defaults (  child_8.el , 0,1,4,5 );
            var child_9 = new Xcls_permname( _this );
            child_9.ref();
            this.el.attach_defaults (  child_9.el , 1,2,4,5 );
            var child_10 = new Xcls_Label14( _this );
            child_10.ref();
            this.el.attach_defaults (  child_10.el , 0,1,5,6 );
            var child_11 = new Xcls_modOrder( _this );
            child_11.ref();
            this.el.attach_defaults (  child_11.el , 1,2,5,6 );
            var child_12 = new Xcls_Label16( _this );
            child_12.ref();
            this.el.attach_defaults (  child_12.el , 0,1,6,7 );
            var child_13 = new Xcls_build_module( _this );
            child_13.ref();
            this.el.attach_defaults (  child_13.el , 1,2,6,7 );
        }

        // user defined functions 
    }
    public class Xcls_Label4 : Object 
    {
        public Gtk.Label el;
        private PopoverFileDetails  _this;


            // my vars (def)

        // ctor 
        public Xcls_Label4(PopoverFileDetails _owner )
        {
            _this = _owner;
            this.el = new Gtk.Label( "Component Name" );

            // my vars (dec)

            // set gobject values
            this.el.justify = Gtk.Justification.RIGHT;
            this.el.xalign = 0.900000f;
        }

        // user defined functions 
    }
    public class Xcls_name : Object 
    {
        public Gtk.Entry el;
        private PopoverFileDetails  _this;


            // my vars (def)

        // ctor 
        public Xcls_name(PopoverFileDetails _owner )
        {
            _this = _owner;
            _this.name = this;
            this.el = new Gtk.Entry();

            // my vars (dec)

            // set gobject values
            this.el.visible = true;
        }

        // user defined functions 
    }
    public class Xcls_Label6 : Object 
    {
        public Gtk.Label el;
        private PopoverFileDetails  _this;


            // my vars (def)

        // ctor 
        public Xcls_Label6(PopoverFileDetails _owner )
        {
            _this = _owner;
            this.el = new Gtk.Label( "Title" );

            // my vars (dec)

            // set gobject values
            this.el.justify = Gtk.Justification.RIGHT;
            this.el.xalign = 0.900000f;
            this.el.visible = true;
        }

        // user defined functions 
    }
    public class Xcls_title : Object 
    {
        public Gtk.Entry el;
        private PopoverFileDetails  _this;


            // my vars (def)

        // ctor 
        public Xcls_title(PopoverFileDetails _owner )
        {
            _this = _owner;
            _this.title = this;
            this.el = new Gtk.Entry();

            // my vars (dec)

            // set gobject values
            this.el.visible = true;
        }

        // user defined functions 
    }
    public class Xcls_Label8 : Object 
    {
        public Gtk.Label el;
        private PopoverFileDetails  _this;


            // my vars (def)

        // ctor 
        public Xcls_Label8(PopoverFileDetails _owner )
        {
            _this = _owner;
            this.el = new Gtk.Label( "Region" );

            // my vars (dec)

            // set gobject values
            this.el.justify = Gtk.Justification.RIGHT;
            this.el.xalign = 0.900000f;
            this.el.tooltip_text = "center, north, south, east, west";
            this.el.visible = true;
        }

        // user defined functions 
    }
    public class Xcls_region : Object 
    {
        public Gtk.Entry el;
        private PopoverFileDetails  _this;


            // my vars (def)

        // ctor 
        public Xcls_region(PopoverFileDetails _owner )
        {
            _this = _owner;
            _this.region = this;
            this.el = new Gtk.Entry();

            // my vars (dec)

            // set gobject values
            this.el.visible = true;
        }

        // user defined functions 
    }
    public class Xcls_Label10 : Object 
    {
        public Gtk.Label el;
        private PopoverFileDetails  _this;


            // my vars (def)

        // ctor 
        public Xcls_Label10(PopoverFileDetails _owner )
        {
            _this = _owner;
            this.el = new Gtk.Label( "Parent Name" );

            // my vars (dec)

            // set gobject values
            this.el.justify = Gtk.Justification.RIGHT;
            this.el.xalign = 0.900000f;
            this.el.visible = true;
        }

        // user defined functions 
    }
    public class Xcls_parent : Object 
    {
        public Gtk.Entry el;
        private PopoverFileDetails  _this;


            // my vars (def)

        // ctor 
        public Xcls_parent(PopoverFileDetails _owner )
        {
            _this = _owner;
            _this.parent = this;
            this.el = new Gtk.Entry();

            // my vars (dec)

            // set gobject values
            this.el.visible = true;
        }

        // user defined functions 
    }
    public class Xcls_Label12 : Object 
    {
        public Gtk.Label el;
        private PopoverFileDetails  _this;


            // my vars (def)

        // ctor 
        public Xcls_Label12(PopoverFileDetails _owner )
        {
            _this = _owner;
            this.el = new Gtk.Label( "Permission Name" );

            // my vars (dec)

            // set gobject values
            this.el.justify = Gtk.Justification.RIGHT;
            this.el.xalign = 0.900000f;
            this.el.visible = true;
        }

        // user defined functions 
    }
    public class Xcls_permname : Object 
    {
        public Gtk.Entry el;
        private PopoverFileDetails  _this;


            // my vars (def)

        // ctor 
        public Xcls_permname(PopoverFileDetails _owner )
        {
            _this = _owner;
            _this.permname = this;
            this.el = new Gtk.Entry();

            // my vars (dec)

            // set gobject values
            this.el.visible = true;
        }

        // user defined functions 
    }
    public class Xcls_Label14 : Object 
    {
        public Gtk.Label el;
        private PopoverFileDetails  _this;


            // my vars (def)

        // ctor 
        public Xcls_Label14(PopoverFileDetails _owner )
        {
            _this = _owner;
            this.el = new Gtk.Label( "Order (for tabs)" );

            // my vars (dec)

            // set gobject values
            this.el.justify = Gtk.Justification.RIGHT;
            this.el.xalign = 0.900000f;
            this.el.visible = true;
        }

        // user defined functions 
    }
    public class Xcls_modOrder : Object 
    {
        public Gtk.Entry el;
        private PopoverFileDetails  _this;


            // my vars (def)

        // ctor 
        public Xcls_modOrder(PopoverFileDetails _owner )
        {
            _this = _owner;
            _this.modOrder = this;
            this.el = new Gtk.Entry();

            // my vars (dec)

            // set gobject values
            this.el.visible = true;
        }

        // user defined functions 
    }
    public class Xcls_Label16 : Object 
    {
        public Gtk.Label el;
        private PopoverFileDetails  _this;


            // my vars (def)

        // ctor 
        public Xcls_Label16(PopoverFileDetails _owner )
        {
            _this = _owner;
            this.el = new Gtk.Label( "Module to build (Vala only)" );

            // my vars (dec)

            // set gobject values
            this.el.justify = Gtk.Justification.RIGHT;
            this.el.xalign = 0.900000f;
            this.el.visible = true;
        }

        // user defined functions 
    }
    public class Xcls_build_module : Object 
    {
        public Gtk.ComboBox el;
        private PopoverFileDetails  _this;


            // my vars (def)

        // ctor 
        public Xcls_build_module(PopoverFileDetails _owner )
        {
            _this = _owner;
            _this.build_module = this;
            this.el = new Gtk.ComboBox();

            // my vars (dec)

            // set gobject values
            var child_0 = new Xcls_dbcellrenderer( _this );
            child_0.ref();
            this.el.pack_start (  child_0.el , true );
            var child_1 = new Xcls_dbmodel( _this );
            child_1.ref();
            this.el.set_model (  child_1.el  );

            // init method 

            this.el.add_attribute(_this.dbcellrenderer.el , "markup", 1 );
        }

        // user defined functions 
    }
    public class Xcls_dbcellrenderer : Object 
    {
        public Gtk.CellRendererText el;
        private PopoverFileDetails  _this;


            // my vars (def)

        // ctor 
        public Xcls_dbcellrenderer(PopoverFileDetails _owner )
        {
            _this = _owner;
            _this.dbcellrenderer = this;
            this.el = new Gtk.CellRendererText();

            // my vars (dec)

            // set gobject values
        }

        // user defined functions 
    }
    public class Xcls_dbmodel : Object 
    {
        public Gtk.ListStore el;
        private PopoverFileDetails  _this;


            // my vars (def)

        // ctor 
        public Xcls_dbmodel(PopoverFileDetails _owner )
        {
            _this = _owner;
            _this.dbmodel = this;
            this.el = new Gtk.ListStore( 2, typeof(string),typeof(string) );

            // my vars (dec)

            // set gobject values
        }

        // user defined functions 
        public void loadData (Gee.ArrayList<string> data, string cur) {
            this.el.clear();                                    
            Gtk.TreeIter iter;
            var el = this.el;
            
           /// el.append(out iter);
            
             
           // el.set_value(iter, 0, "");
           // el.set_value(iter, 1, "aaa  - Just add Element - aaa");
        
            el.append(out iter);
        
            
            el.set_value(iter, 0, "");
            el.set_value(iter, 1, "-- select a module --");
            _this.build_module.el.set_active_iter(iter);
            
            for (var i = 0; i < data.size;i++) {
            
        
                el.append(out iter);
                
                el.set_value(iter, 0, data.get(i));
                el.set_value(iter, 1, data.get(i));
                
                if (data.get(i) == cur) {
                    _this.build_module.el.set_active_iter(iter);
                }
                
            }
             this.el.set_sort_column_id(0, Gtk.SortType.ASCENDING);          
                                             
        }
    }
}
