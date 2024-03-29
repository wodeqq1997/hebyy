/**
 */
var ProsortTree = function(options){
	this.el = options.el;
	this.target = options.target;
	this.targetName = options.targetName; // 文档类别名称
	this.url = options.url;
	this.defValue = options.defValue;
	this.comboxWidth = options.comboxWidth;
	this.treeWidth = options.treeWidth;
};

ProsortTree.prototype = {
	el : '',
	target : '',
	targetName : '',
    url : '',
    comboxWidth : 150,
    treeWidth : 130,
	defValue : {},
	//emptyText : '',
	comboxTree : {},
	tree : {},
	init : function(){
		var _this = this;
		_this.comboxTree = new Ext.form.ComboBox({
			store: new Ext.data.SimpleStore({
	        	fields : [],
	        	data : [[]]
	        }),
	        editable:false,
	        width : _this.comboxWidth,
	        maxHeight : 600,
	        mode: 'local',
	        triggerAction: 'all',
	        emptyText: '选择文档类别',
	        tpl : '<div id="inner-tree"></div>',
			selectedClass : '',
			onSelect : Ext.emptyFn
	    });
		_this.tree = new Ext.tree.TreePanel({
	        border : false,
	    	useArrows:true,
	        autoScroll:true,
	        animate:true,
	        frame : false,   
	        width : _this.treeWidth,   
	        height : 300, 
	        containerScroll: true,
	        root : new Ext.tree.AsyncTreeNode({
				text : '所有文档类别',
				id : '0'
			}),
	        loader: new Ext.tree.TreeLoader({
	            dataUrl : _this.url
	        }),
	        listeners : {
	        	click : function(node, e){
	        		if (node.id != 0){
	        			_this.comboxTree.setValue(node.text); 
	        		} else {
	        			_this.comboxTree.setValue('选择文档类别'); 
	        		}
	        		Ext.get(_this.target).dom.value=node.id;
	        		if(_this.targetName && _this.targetName != ''){
	        			Ext.get(_this.targetName).dom.value=node.text;
	        		}
	        		_this.comboxTree.collapse(); 
	        	}
	        }
	    });  
		_this.comboxTree.on('expand',function(){   
			_this.tree.render('inner-tree');   
	    	_this.tree.root.reload();     
	    });
		if (_this.defValue) {
			if (_this.defValue.text){
				_this.comboxTree.setValue(_this.defValue.text);
			}
			if (_this.defValue.id){
				Ext.get(_this.target).dom.value=_this.defValue.id;
			}
		}
		_this.comboxTree.render(_this.el);   
	}
		
};