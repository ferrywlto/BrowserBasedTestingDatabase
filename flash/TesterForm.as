/*			C:\Inetpub\wwwroot\ATDB_WS\Flash_Client\TesterForm.as
 * 
 * Class Name:	TesterForm
 * Description: Form used to input tester data
 * Created By:	Ferry To
 * Created At:	Wed Mar 15 15:13:08 2006
 * Version:		1.0.1
 * 
 * @usage   
 * @return  
 * 
 * Events:		None
 */
import mx.controls.*;
import mx.services.*;

class TesterForm extends ATDB_TabForm
{
	private var data_value:Array = new Array("idTester","tName","tDesc","tEmail");
	private var data_label:Array = new Array("ID","Name","Description","Email");
	
	/* Listener objects*/ 
	private var deleteBtnClick_lis:Object;
	private var searchBtnClick_lis:Object;
	private var createBtnClick_lis:Object;
	private var editBtnClick_lis:Object;

	private var _detailForm:TesterDetailForm;
	
	/*	Init function and constructor	*/	
	public function TesterForm()
	{
		super();
		_winLink_str = "EmptyClip";
		_winTitle_str = "Tester data:";		
	}
	
	public function init():Void
	{
		var self:Object = this;
		
		// Instantiate tab pane component
		_tabPane = new TabPane(win_mc.content);
		_tabPane.addTab("Create:","TesterForm_Create");
		_tabPane.addTab("Search:","TesterForm_Search");
		_tabPane.drawTabPane();		
		
		// initialize tab pane
		_createForm = _tabPane._top_mc.TesterForm_Create;
		_createForm.onEnterFrame = function() {self.H_createForm_EnterFrame()};
		
		_searchForm = _tabPane._top_mc.TesterForm_Search;
		_searchForm.onEnterFrame = function() {self.H_searchForm_EnterFrame()};
		
		// Initialize tab bar of tab pane
		_tabPane._tab_mc.onEnterFrame = function()
		{
			this.onEnterFrame = null;
			self.win_mc.setSize(self._tabPane._maxWidth+6,self._tabPane._maxHeight+34);
			self.win_mc.move((Stage.width-self.win_mc._width)/2,(Stage.height-self.win_mc._height)/2);
			self.win_mc.visible = true;
		}
	}
	/*===	Event dispatch functions 	===*/	
	/*===	Callback and Handlers	===*/
	
	/* onEnterFrame initialization of forms */

	// Called when all UI of create form loaded
	public function H_createForm_EnterFrame():Void
	{
		var self:Object = this;
		
		// Initialize UI settings
		_createForm.onEnterFrame = null;
		_createForm.id_txt.maxChars = 5;
		_createForm.pw_txt.maxChars = 10;
		_createForm.pw_txt.password = true;
		_createForm.name_txt.maxChars = 50;
		_createForm.desc_txt.maxChars = 255;
		_createForm.email_txt.maxChars = 100;
		_createForm.err_lbl.setStyle("color",0xFF0000);	

		// Submit button handler
		createBtnClick_lis = new Object();
		createBtnClick_lis.click = function() { self.H_createBtnClick(); }
		_createForm.create_btn.addEventListener("click",createBtnClick_lis);						
	}
	
	// Called when all UI of search form loaded
	public function H_searchForm_EnterFrame():Void
	{
		var self:Object = this;
		// the THIS used here refer to movieclip _searchForm
		trace("search pane onEnterFrame:");
		self.onEnterFrame = null;
		_searchForm.onEnterFrame = null;
		_searchForm.search_list.editable = false;

		// Load data into combo box
		for(var i:Number=0; i<this.data_value.length; i++)
		{
			var tmp:Object = new Object();
			tmp.data = this.data_value[i];
			tmp.label = this.data_label[i];
			_searchForm.search_list.addItem(tmp);
		}
		
		_searchForm.search_grid.editable = false;
		_searchForm.search_grid.selectable = true;
		_searchForm.search_grid.hScrollPolicy = "auto";
		_searchForm.search_grid.addColumn("ID");
		_searchForm.search_grid.addColumn("Name");
		_searchForm.search_grid.addColumn("Description");
		_searchForm.search_grid.addColumn("Email");
		_searchForm.search_grid.getColumnAt(0).width = 80;
		_searchForm.search_grid.getColumnAt(1).width = 100;
		_searchForm.search_grid.getColumnAt(2).width = 200;
		_searchForm.search_grid.getColumnAt(3).width = 150;
		
		searchBtnClick_lis = new Object();
		searchBtnClick_lis.click = function() { self.H_searchBtnClick(); };
		_searchForm.search_btn.addEventListener("click",searchBtnClick_lis);
		
		deleteBtnClick_lis = new Object();
		deleteBtnClick_lis.click = function() { self.H_deleteBtnClick(); };
		_searchForm.delete_btn.addEventListener("click",deleteBtnClick_lis);	
		
		editBtnClick_lis = new Object();
		editBtnClick_lis.click = function() { self.H_editBtnClick(); };
		_searchForm.edit_btn.addEventListener("click",editBtnClick_lis);
	}
	
	/* Button Event Handlers  */
	
	// Handle the click event of the create button on create pane
	public function H_createBtnClick():Void
	{
		var self:Object = this;
		var vaild:ATDB_Error = vaildateCreateForm();
		trace("vaild:"+vaild);
		if(vaild.getCode() == 0)
		{
			_createForm.lbl_txt.text = "";
			_createForm.create_btn.enabled = false;
			
			// Calling web service to insert a tester record
			_ws_call = _ws.Add_Testers(_createForm.id_txt.text,_createForm.name_txt.text,encodeText(_createForm.desc_txt.text),_createForm.pw_txt.text,_createForm.email_txt.text);			
			_ws_call.onResult = function(result) { self.H_WS_Add_Tester(result); };
			
			trace("INSERT INTO Testers Values('"+_createForm.id_txt.text+"','"+_createForm.name_txt.text+"','"+_createForm.desc_txt.text+"','"+_createForm.pw_txt.text+"','"+_createForm.email_txt.text+"')");
		}
		else
		{
			_createForm.err_lbl.text = vaild.getMsg();
			_createForm.create_btn.enabled = true;
		}		
	}
	
	// Handle the click event of the delete button on search pane
	public function H_deleteBtnClick():Void
	{
		var self:Object = this;
		// This shows how to get the value from a DataGrid
		trace(_searchForm.search_grid.selectedIndex);
		trace(_searchForm.search_grid.selectedItem.ID);
		if(_searchForm.search_grid.selectedIndex != undefined)
		{
			var alertClick_lis = function(evt_obj:Object) 
			{
				if(evt_obj.detail == Alert.OK)
				{
					var call_obj:PendingCall = self._ws.Delete_Tester(self._searchForm.search_grid.selectedItem.ID);	
					call_obj.onResult = function (result) 
					{
						trace(result);
						self.H_searchBtnClick();
					};
				}
			};
			Alert.show("Are you sure to delete?","Warning!",Alert.OK|Alert.CANCEL,_root,alertClick_lis,"",Alert.CANCEL);
		}		
	}	

	// Handle the click event of the search button on search pane
	public function H_searchBtnClick():Void
	{
		var self:Object = this;
		trace("start calling web services");
		setFormUION(false);				
		_searchForm.search_lbl.text = "Searching... please wait.";
		_searchForm.search_grid.removeAll();
		
		_ws_call = _ws.Search_Tester(_searchForm.search_list.selectedItem.data,encodeText(_searchForm.search_txt.text));			
		_ws_call.onResult = function(result) { self.H_WS_Search_Tester(result); };
	}

	// Handle the click event of the edit button on search pane
	public function H_editBtnClick():Void	{
		if(_searchForm.search_grid.selectedItem.ID != undefined)
		{
			var self:Object = this;
			trace("H_editBtnClick");
			setFormUION(false);
			_detailForm = new TesterDetailForm(this,_searchForm.search_grid.selectedItem.ID,"tester",_global.GTID);
			_detailForm.show(true);
		}
	}
	
	/* Web Service result handlers */
	
	// Call when Add Tester web service has executed and returned result
	public function H_WS_Add_Tester(result):Void
	{
		if(result == true)
		{
			Alert.show("Record created successfully","Tester data:",Alert.OK,null,"",Alert.OK);
			// Reset fields
			_createForm.id_txt.text = "";
			_createForm.pw_txt.text = "";
			_createForm.name_txt.text = "";
			_createForm.desc_txt.text = "";
			_createForm.err_lbl.text = "";
			_createForm.email_txt.text ="";
		}
		else
		{
			_createForm.err_lbl.text = "Process failed. Please check the fields and try again.";
		}
		_createForm.create_btn.enabled = true;						
		trace("result:"+result);		
	}
	
	// Important for getting values from web service result
	public function H_WS_Search_Tester(result):Void
	{
		for(var i=0; i<result.xmlNodes.length; i++)
		{
			var tmp:Object = new Object();
			tmp.ID = 			result.xmlNodes[i].childNodes[0].firstChild;
			tmp.Name = 			result.xmlNodes[i].childNodes[1].firstChild;
			trace("damn<>:"+result.xmlNodes[i].childNodes[2].firstChild.toString().charCodeAt(0));
			tmp.Description = 	decodeText(result.xmlNodes[i].childNodes[2].firstChild.toString());
			tmp.Email =  		result.xmlNodes[i].childNodes[3].firstChild;
			_searchForm.search_grid.addItem(tmp);
		}	
		_searchForm.search_lbl.text = result.xmlNodes.length+" records found.";
		setFormUION(true);		
		/*
		// For 2 Dimensional Array of String
		for(var i=0; i<result.xmlNodes.length; i++)
			for(var j=0; j<result.xmlNodes[i].childNodes.length; j++)
				trace("nodeX["+i+"]["+j+"]:"+result.xmlNodes[i].childNodes[j].firstChild);

		// For Array of String
		for(var i=0; i<result.xmlNodes.length; i++)
			trace("node["+i+"]:"+result.xmlNodes[i].firstChild);
		
		// For single object
		for(var str in result)
			trace("pros:"+str);			
			
		trace("X:"+result.X);
		trace("Y:"+result.Y);
		trace("Z:"+result.Z);	
		
		trace("onResult");
		trace("result==undefined:"+result==undefined);
		trace("result==null:"+result==null);
		trace("result:"+result);
		
		for(var str in result.xmlNodes)
			trace("pros2:"+str);	
			*/
			
	}	
	
	/*===	Independent functions	===*/	
	
	// Work with checkForInvaildChar, this function check for blank fields
	public function vaildateCreateForm():ATDB_Error
	{
		_createForm.id_txt.text = trimAllSpace(_createForm.id_txt.text);
		var tmpStr:String = _createForm.id_txt.text;
		if(tmpStr == "" || !checkForInvaildChar(tmpStr))
			return new ATDB_Error(1,"ID field cannot blank or contain invaild characters or spaces");
			
		_createForm.name_txt.text = trimString(_createForm.name_txt.text);	
		var tmpStr = _createForm.name_txt.text
		if(tmpStr == "" || !checkForInvaildChar(tmpStr))
			return new ATDB_Error(2,"Name field cannot blank or contain invaild characters");
			
		_createForm.pw_txt.text = trimString(_createForm.pw_txt.text);
		tmpStr = _createForm.pw_txt.text;
		if(tmpStr == "" || !checkForInvaildChar(tmpStr))
			return new ATDB_Error(3,"Password field cannot blank or contain invaild characters");
		
		_createForm.desc_txt.text = trimString(_createForm.desc_txt.text);
		tmpStr = _createForm.desc_txt.text;
		if(tmpStr == "") // || !checkForInvaildChar(tmpStr))
			return new ATDB_Error(4,"Description field cannot blank or contain invaild characters");
			
		_createForm.email_txt.text = trimString(_createForm.email_txt.text);
		tmpStr = _createForm.email_txt.text;
		if(tmpStr == "" || !checkForInvaildChar(tmpStr))
			return new ATDB_Error(5,"Email field cannot blank or contain invaild characters");
			
		return new ATDB_Error(0,"");
	}
	
	// Only used to ease the UI control process of search form
	public function setFormUION(status:Boolean):Void
	{
		_searchForm.search_btn.enabled = status;
		_searchForm.search_list.enabled = status;
		_searchForm.search_txt.enabled = status;
		_searchForm.delete_btn.enabled = status;
		_searchForm.edit_btn.enabled = status;		
	}	
}