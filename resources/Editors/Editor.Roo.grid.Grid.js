//<script type="text/javascript">

// Auto generated file - created by app.Builder.js- do not edit directly (at present!)

Roo.namespace('Editor.Roo.grid');

Editor.Roo.grid.Grid = new Roo.XComponent({

 _strings : {
  '4ce58cbe362a5d7b156992a496d55bf3' :"Database Column",
  'b78a3223503896721cca1303f776159b' :"Title",
  '2f616612593df62aeed112de4f03110e' :"Edit a Grid",
  '0ccc2bf3fb98387c23b6ca5500244d6e' :"Use ",
  'c671c787b49f50a3ace9fdc5bd597825' :"core_enum",
  '32954654ac8fe66a1d09be19001de2d4' :"Width",
  'a1fa27779242b4902f7ae3bdd5c6d508' :"Type",
  '6e7376dca68a2386a8737944196ab491' :"Create / Edit Grid"
 },

  part     :  ["Editors", "Grid" ],
  order    : '001-Editor.Roo.grid.Grid',
  region   : 'center',
  parent   : false,
  name     : "unnamed module",
  disabled : false, 
  permname : '', 
  _tree : function()
  {
   var _this = this;
   var MODULE = this;
   return {
   grid : {
    ds : {
     '|xns' : 'Roo.data',
     data : [
       [ 1, 'test', 'test', 110 ]
       
     
     ],
     fields : [ 'active', 'dataIndex', 'type','title', 'width' ],
     id : 'dataindex',
     xns : Roo.data,
     xtype : 'SimpleStore'
    },
    toolbar : {
     '|xns' : 'Roo',
     xns : Roo,
     xtype : 'Toolbar',
     items : [
      {
       '|xns' : 'Roo.Toolbar',
       text : _this._strings['2f616612593df62aeed112de4f03110e'],
       xns : Roo.Toolbar,
       xtype : 'TextItem'
      }
     ]

    },
    '|xns' : 'Roo.grid',
    autoExpandColumn : 'title',
    clicksToEdit : 1,
    loadMask : true,
    xns : Roo.grid,
    xtype : 'EditorGrid',
    cm : [
      {
       '|xns' : 'Roo.grid',
       dataIndex : 'active',
       header : _this._strings['0ccc2bf3fb98387c23b6ca5500244d6e'],
       renderer : function(v) {  
           var state = v *1 > 0 ?  '-checked' : '';
       
           return '<img class="x-grid-check-icon' + state + '" src="' + Roo.BLANK_IMAGE_URL + '"/>';
                       
        },
       width : 75,
       xns : Roo.grid,
       xtype : 'ColumnModel'
      },
{
       '|xns' : 'Roo.grid',
       dataIndex : 'dataIndex',
       header : _this._strings['4ce58cbe362a5d7b156992a496d55bf3'],
       renderer : function(v) { return String.format('{0}', v); },
       width : 150,
       xns : Roo.grid,
       xtype : 'ColumnModel'
      },
{
       '|xns' : 'Roo.grid',
       dataIndex : 'type',
       header : _this._strings['a1fa27779242b4902f7ae3bdd5c6d508'],
       renderer : function(v) { return String.format('{0}', v); },
       width : 100,
       xns : Roo.grid,
       xtype : 'ColumnModel'
      },
{
       editor : {
        field : {
         '|xns' : 'Roo.form',
         xns : Roo.form,
         xtype : 'TextField'
        },
        '|xns' : 'Roo.grid',
        xns : Roo.grid,
        xtype : 'GridEditor',
        items : [

        ]

       },
       '|xns' : 'Roo.grid',
       dataIndex : 'title',
       header : _this._strings['b78a3223503896721cca1303f776159b'],
       renderer : function(v) { return String.format('{0}', v); },
       width : 75,
       xns : Roo.grid,
       xtype : 'ColumnModel',
       items : [

       ]

      },
{
       editor : {
        field : {
         '|xns' : 'Roo.form',
         decimalPrecision : 0,
         xns : Roo.form,
         xtype : 'NumberField'
        },
        '|xns' : 'Roo.grid',
        xns : Roo.grid,
        xtype : 'GridEditor',
        items : [

        ]

       },
       '|xns' : 'Roo.grid',
       dataIndex : 'width',
       header : _this._strings['32954654ac8fe66a1d09be19001de2d4'],
       renderer : function(v) { return String.format('{0}', v); },
       width : 75,
       xns : Roo.grid,
       xtype : 'ColumnModel',
       items : [

       ]

      }
    ],
    listeners : {
     cellclick : function (_self, rowIndex, columnIndex, e)
      {
      
              var di = this.colModel.getDataIndex(columnIndex);
              if (di != 'active') {
                  return;
              }
               
              var rec = _this.grid.ds.getAt(rowIndex);
              
              rec.set('active', rec.data.active * 1 ? 0 : 1);
              rec.commit();
               
              
      },
     render : function() 
      {
          _this.grid = this; 
          //_this.dialog = Pman.Dialog.FILL_IN
      
      }
    },
    items : [

    ]

   },
   '|xns' : 'Roo',
   background : false,
   fitContainer : true,
   fitToframe : true,
   loadData : function(data) { 
   
        alert("IPC:TEST:" + JSON.stringify(data,null,4));
       var ar = [];
       for (var k in data) { 
           var r = data[k];
           ar.push([ false, r.Field, r.Type,  r.Field, 100] );
       }
       
       alert("IPC:TEST:" + JSON.stringify(ar));
       this.grid.dataSource.loadData(ar);
   },
   region : 'center',
   tableName : 'core_enum',
   title : _this._strings['c671c787b49f50a3ace9fdc5bd597825'],
   title : _this._strings['c671c787b49f50a3ace9fdc5bd597825'],
   xns : Roo,
   xtype : 'GridPanel',
   listeners : {
    activate : function() {
         _this.panel = this;
         if (_this.grid) {
             _this.grid.footer.onClick('first');
         }
     }
   },
   items : [

   ]

  };  }
});
