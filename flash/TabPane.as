/*			C:\Inetpub\wwwroot\ATDB_WS\Flash_Client\TabPane.as
 * 
 * Class Name:	TabPane
 * Description: A custom UI component that serve the tab pane like function
 * Created By:	Ferry To
 * Created At:	Tue Mar 14 14:33:18 2006
 * Version:		1.1.0
 * Events:	  	None
 */
class TabPane
{
	public  var _maxWidth:Number;
	public  var _maxHeight:Number;	
	public  var _tab_mc:MovieClip;
	public  var _top_mc:MovieClip;
	
	private var _btnNames:Array;
	private var _lnkNames:Array;
	private var _panes:Array;
	private var _tabbgs:Array;
	private var _selectedIndex:Number;

/*
	err_lbl
	id_txt
	pw_txt
	ac_txt
	desc_txt
	create_btn
	"TesterForm_New"
*/	

	/*===	Init function and constructor	===*/
	public function TabPane(_parent_mc:MovieClip)
	{
		_top_mc = _parent_mc;
		_tab_mc = _top_mc.createEmptyMovieClip("tab",nDepth());
		_btnNames = new Array();
		_lnkNames = new Array();
		_panes = new Array();
		_tabbgs = new Array();
		_selectedIndex = 0;
		_maxWidth = 0;
		_maxHeight = 0;
	}
	/*===	Event dispatch functions	===*/
	/*	None	*/
	
	/*===	Callback and Handlers	===*/
	/*	None	*/
	
	/*===	Independent functions	===*/
	
	// Just a handy function to get the highest depth of current movie clip
	public function nDepth():Number { return _top_mc.getNextHighestDepth();}
	
	// Call this method to add a new tab
	public function addTab(btnName:String,lnkName:String):Void
	{
		_btnNames.push(btnName);
		_lnkNames.push(lnkName);
	}
	
	// This is the render function of the tab pane. This function should only be called at the time that 
	// the parent window had finished loading and UI initializaion
	public function drawTabPane():Void
	{
		var currentX:Number = 0;
		
		for(var i:Number=0; i<_btnNames.length; i++)
		{
			var txtWidth:Number = _btnNames[i].length*7;
			var txtHeight:Number = 22;
			var tabWidth:Number = txtWidth*1.5;
			var tabHeight:Number = txtHeight+2;
			
			var _child:MovieClip = _tab_mc.createEmptyMovieClip("child"+i,_tab_mc.getNextHighestDepth());

			
			var bgObj:Object = new Object();
			bgObj._left_mc = _child.attachMovie("tabBG_L","_left_mc",_child.getNextHighestDepth());
			bgObj._center_mc = _child.attachMovie("tabBG_C","_center_mc",_child.getNextHighestDepth());
			bgObj._right_mc = _child.attachMovie("tabBG_R","_right_mc",_child.getNextHighestDepth());
			
			bgObj._center_mc._width = tabWidth - bgObj._left_mc._width - bgObj._right_mc._width;
			
			bgObj._left_mc._x = bgObj._left_mc._width/2;
			bgObj._left_mc._y = bgObj._left_mc._height/2;
			
			bgObj._center_mc._x = bgObj._left_mc._width + bgObj._center_mc._width/2; 
			bgObj._center_mc._y = bgObj._center_mc._height/2;
			
			bgObj._right_mc._x = bgObj._left_mc._width + bgObj._center_mc._width + bgObj._right_mc._width/2;
			bgObj._right_mc._y = bgObj._right_mc._height/2;
			
			_tabbgs.push(bgObj);
			trace(bgObj._left_mc._width+bgObj._center_mc._width+bgObj._right_mc._width+" "+tabWidth);
			
			var tmf:TextFormat= new TextFormat();
			tmf.bold = true;
			tmf.font = "Arial";
			_child.createTextField("_tf",_child.getNextHighestDepth(),3,3,txtWidth,txtHeight);
			_child._tf.autoSize = "center";
			_child._tf.text = _btnNames[i];
			_child._tf.selectable = false;
			_child._tf._x = (_child._width - _child._tf._width)/2;
			_child._tf._y = (_child._height - _child._tf._height)/2;
			_child._tf.setTextFormat(tmf);
			_child._x = currentX;
			_child._y = 0;
			
			var self = this;
			var tmpLinkName:String = _lnkNames[i];
			
			// Make all tab cell to non-active mode, then re-active the current tab cell
			_child.onRelease = function()
			{
				var tmp:Number = parseInt(this._name.substr(this._name.length-1,1),10);
				trace(this._name);
				for(var i:Number=0; i<self._panes.length; i++)
				{
					self._tabbgs[i]._left_mc.gotoAndStop(1);
					self._tabbgs[i]._center_mc.gotoAndStop(1);
					self._tabbgs[i]._right_mc.gotoAndStop(1);
					self._panes[i]._visible = false;
				}
				self._panes[tmp]._visible = true;
				self._tabbgs[tmp]._left_mc.gotoAndStop(2);
				self._tabbgs[tmp]._center_mc.gotoAndStop(2);
				self._tabbgs[tmp]._right_mc.gotoAndStop(2);				
			}
			currentX+= tabWidth;
		}

		_maxWidth = currentX;
		
		for(var i:Number=0; i<_lnkNames.length; i++)
		{
			_panes.push(_top_mc.attachMovie(_lnkNames[i],_lnkNames[i],nDepth()));
			_panes[i]._x;
			_panes[i]._y = _tab_mc._y+_tab_mc._height;
			_panes[i]._visible = false;
			if(_panes[i]._width > _maxWidth)
				_maxWidth = _panes[i]._width;
			if(_panes[i]._height > _maxHeight)
				_maxHeight = _panes[i]._height;
		}
		
		_maxHeight += _tab_mc._height;

		_tab_mc._x = 0;
		_tab_mc._y = 0;
		_panes[0]._visible = true;
		self._tabbgs[0]._left_mc.gotoAndStop(2);
		self._tabbgs[0]._center_mc.gotoAndStop(2);
		self._tabbgs[0]._right_mc.gotoAndStop(2);	
		trace("drawPane end");
	}
}
