import mx.controls.*;
import mx.services.*;

class TestForm extends ATDB_TabForm
{
	private var data_value:Array = new Array("idTest","svName","tName","tDateStart","tDateEnd","tDesc","tps_Name");
	private var data_label:Array = new Array("ID","Software Version","Creator","Start Date","End Date","Description","Status");
	
	/* Listener objects*/ 
	private var searchBtnClick_lis:Object;
	private var createBtnClick_lis:Object;
	private var editBtnClick_lis:Object;
	private var selectBtnClick_lis:Object;
	private var assignBtnClick_lis:Object;
	
	private var _detailFormM:TestDetailForm_M;
	private var _detailFormC:TestDetailForm_C;
	private var _detailFormA:TestDetailForm_A;
	
	/*	Init function and constructor	*/	
	public function TestForm()
	{
		super();
		_winLink_str = "EmptyClip";
		_winTitle_str = "Test Plan Data:";				
	}
	
	public function init():Void
	{
		var self:Object = this;
		
		// Instantiate tab pane component
		_tabPane = new TabPane(win_mc.content);
		_tabPane.addTab("Create:","TestForm_Create");
		_tabPane.addTab("Search:","TestForm_Search");
		_tabPane.drawTabPane();		
		
		// initialize tab pane
		_createForm = _tabPane._top_mc.TestForm_Create;
		_createForm.onEnterFrame = function() {self.H_createForm_EnterFrame()};
		
		_searchForm = _tabPane._top_mc.TestForm_Search;
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
		_createForm.id_txt.maxChars = 20;
		_createForm.err_lbl.setStyle("color",0xFF0000);	

		// Submit button handler
		createBtnClick_lis = new Object();
		createBtnClick_lis.click = function() { self.H_createBtnClick(); }
		_createForm.create_btn.addEventListener("click",createBtnClick_lis);				

		// Calling web service to check for test case ID duplication
		_ws_call = _ws.Get_SoftwareVersion(_createForm.id_txt.text);			
		_ws_call.onResult = function(result) { self.H_WS_Get_SoftwareVersion(result); };
	}
	
	// Called when all UI of search form loaded
	public function H_searchForm_EnterFrame():Void
	{
		var self:Object = this;
		// the THIS used here refer to movieclip _searchForm
		trace("search pane onEnterFrame:");
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
		_searchForm.search_grid.addColumn("Software_Version");
		_searchForm.search_grid.addColumn("Creator");
		_searchForm.search_grid.addColumn("Start_Date");
		_searchForm.search_grid.addColumn("End_Date");
		_searchForm.search_grid.addColumn("Description");
		_searchForm.search_grid.addColumn("Status");

		_searchForm.search_grid.getColumnAt(0).width = 80;
		_searchForm.search_grid.getColumnAt(1).width = 80;
		_searchForm.search_grid.getColumnAt(2).width = 80;
		_searchForm.search_grid.getColumnAt(3).width = 80;
		_searchForm.search_grid.getColumnAt(4).width = 80;
		_searchForm.search_grid.getColumnAt(5).width = 80;
		_searchForm.search_grid.getColumnAt(6).width = 80;
		
		searchBtnClick_lis = new Object();
		searchBtnClick_lis.click = function() { self.H_searchBtnClick(); };
		_searchForm.search_btn.addEventListener("click",searchBtnClick_lis);
		
		editBtnClick_lis = new Object();
		editBtnClick_lis.click = function() { self.H_editBtnClick(); };
		_searchForm.edit_btn.addEventListener("click",editBtnClick_lis);
		
		selectBtnClick_lis = new Object();
		selectBtnClick_lis.click = function() { self.H_selectBtnClick(); };
		_searchForm.select_btn.addEventListener("click",selectBtnClick_lis);
		
		assignBtnClick_lis = new Object();
		assignBtnClick_lis.click = function() { self.H_assignBtnClick(); };
		_searchForm.assign_btn.addEventListener("click",assignBtnClick_lis);
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
			
			// Calling web service to check for test case ID duplication
			_ws_call = _ws.checkTestID(_createForm.id_txt.text);			
			_ws_call.onResult = function(result) { self.H_WS_checkTestID(result); };
		}
		else
		{
			_createForm.err_lbl.text = vaild.getMsg();
			_createForm.create_btn.enabled = true;
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
		
		_ws_call = _ws.Search_Test(_searchForm.search_list.selectedItem.data,encodeText(_searchForm.search_txt.text));			
		_ws_call.onResult = function(result) { self.H_WS_Search_TestCase(result); };
	}

	// Handle the click event of the edit button on search pane
	public function H_editBtnClick():Void
	{
		trace("H_editBtnClick");
		var conID:String =_searchForm.search_grid.selectedItem.ID;
		if(conID != undefined)
		{
			var self:Object = this;
			setFormUION(false);
			_detailFormM = new TestDetailForm_M(this,conID,"test",_global.GTID,conID);
			_detailFormM.show(true);
		}
		else
			trace("nothing selected!");
	}
	// Handle the click event of the select button on search pane
	public function H_selectBtnClick():Void
	{
		trace("H_selectBtnClick");
		var conID:String =_searchForm.search_grid.selectedItem.ID;
		if(conID != undefined)
		{
			var self:Object = this;
			setFormUION(false);
			_detailFormC = new TestDetailForm_C(this,conID,"test",_global.GTID,conID);
			_detailFormC.show(true);
		}
		else
			trace("nothing selected!");		
	}
		// Handle the click event of the assign button on search pane
	public function H_assignBtnClick():Void
	{
		trace("H_assignBtnClick");		
		var conID:String =_searchForm.search_grid.selectedItem.ID;
		if(conID != undefined)
		{
			var self:Object = this;
			setFormUION(false);
			_detailFormA = new TestDetailForm_A(this,conID,"test",_global.GTID,conID);
			_detailFormA.show(true);
		}
		else
			trace("nothing selected!");		
	}
	/* Web Service result handlers */
	public function H_WS_checkTestID(result)
	{
		var self:Object = this;
		
		if(result == false)
		{
			_createForm.err_lbl.text = "Duplicated Test Case ID found.";
			_createForm.create_btn.enabled = true;		
		}
		else
		{
			var params:Array = new Array();
			params[0] = _createForm.id_txt.text;
			params[1] = _createForm.softVer_cb.selectedItem.data;
			params[2] = encodeText(_createForm.description_txt.text);
			_ws_call = _ws.Add_Test(params[0],params[1],_global.GTID,params[2]);			
			_ws_call.onResult = function(result) { self.H_WS_Add_Test(result); };
		}
	}
	
	// Call when Add_TestCase web service has executed and returned result
	public function H_WS_Add_Test(result):Void
	{
		if(result == true)
		{
			Alert.show("Record created successfully","Tester data:",Alert.OK,null,"",Alert.OK);
			_createForm.id_txt.text = "";
			_createForm.description_txt.text = "";
			_createForm.err_lbl.text = "";			
		}
		else
		{
			_createForm.err_lbl.text = "Record creation failed, please check fields and try again.";
		}
		_createForm.create_btn.enabled = true;
	}
	
	
	// Call when Get_TestType web service has executed and returned result
	public function H_WS_Get_SoftwareVersion(result):Void
	{
		for(var i=0; i<result.xmlNodes.length; i++)
		{
			var tmpObj:Object = new Object();
			tmpObj.label = result.xmlNodes[i].childNodes[1].firstChild;
			tmpObj.data = result.xmlNodes[i].childNodes[0].firstChild;
			_createForm.softVer_cb.addItem(tmpObj);
		}
	}
	// Important for getting values from web service result
	public function H_WS_Search_TestCase(result):Void
	{
		for(var i=0; i<result.xmlNodes.length; i++)
		{
			var tmp:Object = new Object();
			var xnode:XMLNode = result.xmlNodes[i]
			tmp.ID 				= xnode.childNodes[0].firstChild;
			tmp.Software_Version= xnode.childNodes[1].firstChild;
			tmp.Creator			= xnode.childNodes[2].firstChild;
			tmp.Start_Date 		= xnode.childNodes[3].firstChild;
			tmp.End_Date 		= xnode.childNodes[4].firstChild;
			tmp.Description 	= decodeText(xnode.childNodes[5].firstChild.toString());
			tmp.Status		 	= xnode.childNodes[6].firstChild;
			
			_searchForm.search_grid.addItem(tmp);
		}	
		_searchForm.search_lbl.text = result.xmlNodes.length+" records found.";
		setFormUION(true);		
	}	
	

	// Work with checkForInvaildChar, this function check for blank fields
	public function vaildateCreateForm():ATDB_Error
	{
		var tmpStr:String = "";
		
		_createForm.id_txt.text = trimAllSpace(_createForm.id_txt.text);
		tmpStr = _createForm.id_txt.text;
		if(tmpStr == "")
			return new ATDB_Error(1,"ID Field cannot be blank.");
		else if(!checkForInvaildChar(tmpStr))
			return new ATDB_Error(2,"ID Field cannot contain invaild characters.");
			
		_createForm.description_txt.text = trimString(_createForm.description_txt.text);
		tmpStr = _createForm.description_txt.text;
		if(tmpStr == "")
			return new ATDB_Error(3,"Description field cannot be blank.");
		//else if(!checkForInvaildChar(tmpStr))
		//	return new ATDB_Error(4,"Description field cannot contain invaild characters.");
			
		return new ATDB_Error(0,"");
	}
	
	// Only used to ease the UI control process of search form
	public function setFormUION(status:Boolean):Void
	{
		_searchForm.search_btn.enabled = status;
		_searchForm.search_list.enabled = status;
		_searchForm.search_txt.enabled = status;
		_searchForm.edit_btn.enabled = status;
		_searchForm.select_btn.enabled = status;
		_searchForm.assign_btn.enabled = status;
	}		
}