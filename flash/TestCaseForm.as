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

class TestCaseForm extends ATDB_TabForm
{
	private var data_value:Array = new Array("idTestCase","tcVersionID","Testers.tName","scName","cName","tcScript","ttName","tcDescription","tcProcedure","tcExpectedResult","tcSanity","tcManTestCount","tcDate");
	private var data_label:Array = new Array("ID","Version","Creator","Sub-Category","Category","Script","Test Type","Description","Procedure","Expected Result","Sanity","Mandatory Test Count","Creation Date");
	
	/* Listener objects*/ 
	//private var deleteBtnClick_lis:Object;
	private var searchBtnClick_lis:Object;
	private var createBtnClick_lis:Object;
	private var editBtnClick_lis:Object;
	private var categoryChange_lis:Object;
	
	private var _detailForm:TestCaseDetailForm;
	
	/*	Init function and constructor	*/	
	public function TestCaseForm()
	{
		super();
		_winLink_str = "EmptyClip";
		_winTitle_str = "Test Case Data:";				
	}
	
	public function init():Void
	{
		var self:Object = this;
		
		// Instantiate tab pane component
		_tabPane = new TabPane(win_mc.content);
		_tabPane.addTab("Create:","TestCaseForm_Create");
		_tabPane.addTab("Search:","TestCaseForm_Search");
		_tabPane.drawTabPane();		
		
		// initialize tab pane
		_createForm = _tabPane._top_mc.TestCaseForm_Create;
		_createForm.onEnterFrame = function() {self.H_createForm_EnterFrame()};
		
		_searchForm = _tabPane._top_mc.TestCaseForm_Search;
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
		_createForm.sanity_cb.addItem({label:"Y",data:true});
		_createForm.sanity_cb.addItem({label:"N",data:false});

		// Submit button handler
		createBtnClick_lis = new Object();
		createBtnClick_lis.click = function() { self.H_createBtnClick(); }
		_createForm.create_btn.addEventListener("click",createBtnClick_lis);				

		categoryChange_lis = new Object();
		categoryChange_lis.change = function(){self.H_category_Change();};
		_createForm.category_cb.addEventListener("change",categoryChange_lis);
		
		// Calling web service to get Category
		_ws_call = _ws.Get_Category();			
		_ws_call.onResult = function(result) { self.H_WS_Get_Category(result); };

		// Calling web service to get SubCategory
		_ws_call = _ws.Get_SubCategory(1);			
		_ws_call.onResult = function(result) { self.H_WS_Get_SubCategory(result); };

		// Calling web service to get Test Type
		_ws_call = _ws.Get_TestType();			
		_ws_call.onResult = function(result) { self.H_WS_Get_TestType(result); };	
		
	}
	
	// Called when all UI of search form loaded
	public function H_searchForm_EnterFrame():Void
	{
		var self:Object = this;
		// the THIS used here refer to movieclip _searchForm

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
		_searchForm.search_grid.addColumn("Version");
		_searchForm.search_grid.addColumn("Creator");
		_searchForm.search_grid.addColumn("Sub_Category");
		_searchForm.search_grid.addColumn("Category");
		_searchForm.search_grid.addColumn("Script");
		_searchForm.search_grid.addColumn("Test_Type");
		_searchForm.search_grid.addColumn("Description");
		_searchForm.search_grid.addColumn("Procedure");
		_searchForm.search_grid.addColumn("Expected_Result");
		_searchForm.search_grid.addColumn("Sanity");		
		_searchForm.search_grid.addColumn("Mandatory_Test_Count");
		_searchForm.search_grid.addColumn("Creation_Date");

		_searchForm.search_grid.getColumnAt(0).width = 80;
		_searchForm.search_grid.getColumnAt(1).width = 80;
		_searchForm.search_grid.getColumnAt(2).width = 80;
		_searchForm.search_grid.getColumnAt(3).width = 80;
		_searchForm.search_grid.getColumnAt(4).width = 80;
		_searchForm.search_grid.getColumnAt(5).width = 80;
		_searchForm.search_grid.getColumnAt(6).width = 80;
		_searchForm.search_grid.getColumnAt(7).width = 80;
		_searchForm.search_grid.getColumnAt(8).width = 80;
		_searchForm.search_grid.getColumnAt(9).width = 80;
		_searchForm.search_grid.getColumnAt(10).width = 80;
		_searchForm.search_grid.getColumnAt(11).width = 80;
		_searchForm.search_grid.getColumnAt(12).width = 80;

		searchBtnClick_lis = new Object();
		searchBtnClick_lis.click = function() { self.H_searchBtnClick(); };
		_searchForm.search_btn.addEventListener("click",searchBtnClick_lis);
		
		editBtnClick_lis = new Object();
		editBtnClick_lis.click = function() { self.H_editBtnClick(); };
		_searchForm.edit_btn.addEventListener("click",editBtnClick_lis);
		
		/* Testcases were no longer deletable */
		/*
		deleteBtnClick_lis = new Object();
		deleteBtnClick_lis.click = function() { self.H_deleteBtnClick(); };
		_searchForm.delete_btn.addEventListener("click",deleteBtnClick_lis);	
		*/
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
			_ws_call = _ws.checkTestCaseID(_createForm.id_txt.text);			
			_ws_call.onResult = function(result) { self.H_WS_checkTestCaseID(result); };
		}
		else
		{
			_createForm.err_lbl.text = vaild.getMsg();
			_createForm.create_btn.enabled = true;
		}		
	}
	
	// Handle the click event of the delete button on search pane
	/* This function is now suspended due to testcases were no longer deletable */
	/*
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
					var call_obj:PendingCall = self._ws.Delete_TestCase(self._searchForm.search_grid.selectedItem.ID,self._searchForm.search_grid.selectedItem.Version);	
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
	*/
	// Handle the click event of the search button on search pane
	public function H_searchBtnClick():Void
	{
		var self:Object = this;
		trace("start calling web services");
		setFormUION(false);				
		_searchForm.search_lbl.text = "Searching... please wait.";
		_searchForm.search_grid.removeAll();
		trace("_searchForm.latest_ck.selected"+_searchForm.latest_ck.selected);
		if(_searchForm.latest_ck.selected)
		{
			trace("Search_TestCase_Latest");
			_ws_call = _ws.Search_TestCase_Latest(_searchForm.search_list.selectedItem.data,encodeText(_searchForm.search_txt.text));			
		}
		else
		{
			_ws_call = _ws.Search_TestCase(_searchForm.search_list.selectedItem.data,encodeText(_searchForm.search_txt.text));			
		}
		_ws_call.onResult = function(result) { self.H_WS_Search_TestCase(result); };
	}

	// Handle the click event of the edit button on search pane
	public function H_editBtnClick():Void
	{
		if(_searchForm.search_grid.selectedItem.ID != undefined)
		{
			var self:Object = this;
			trace("H_editBtnClick");
			var id:String =_searchForm.search_grid.selectedItem.ID;
			var ver:Number=_searchForm.search_grid.selectedItem.Version;
			var conID:String = id+""+ver;
			setFormUION(false);
			_detailForm = new TestCaseDetailForm(this,conID,"testcase",_global.GTID,id,ver);
			_detailForm.show(true);
		}
	}

	/* Other UIs event handler */
	public function H_category_Change():Void
	{
		var self:Object = this;
		trace("get subCat");
		// Calling web service to get SubCategory
		_ws_call = _ws.Get_SubCategory(_createForm.category_cb.selectedItem.data);			
		_ws_call.onResult = function(result) { self.H_WS_Get_SubCategory(result); };		
	}

	/* Web Service result handlers */
	public function H_WS_checkTestCaseID(result)
	{
		var self:Object = this;
		
		if(result == false)
		{
			_createForm.err_lbl.text = "Duplicated Test Case ID found.";
			_createForm.create_btn.enabled = true;		
		}
		else
		{
			if(_createForm.script_txt.text != "")
			{
				_ws_call = _ws.checkTestScriptID(_createForm.script_txt.text);			
				_ws_call.onResult = function(result) { self.H_WS_checkTestScriptID(result); };
			}
			else
			{
				var params:Array = new Array();
				params[0] = _createForm.id_txt.text;
				params[1] = _createForm.subCat_cb.selectedItem.data;
				params[2] = _createForm.category_cb.selectedItem.data;
				params[3] = _createForm.script_txt.text;
				params[4] = _createForm.testType_cb.selectedItem.data;
				params[5] = encodeText(_createForm.description_txt.text);
				params[6] = encodeText(_createForm.procedure_txt.text);
				params[7] = encodeText(_createForm.expect_txt.text);
				params[8] = _createForm.sanity_cb.selectedItem.data;
				params[9] = _createForm.count_ns.value;				
				_ws_call = _ws.Add_Testcase(params[0],params[1],params[2],params[3],params[4],params[5],params[6],params[7],params[8],params[9],_global.GTID,0);			
				_ws_call.onResult = function(result) { self.H_WS_Add_TestCase(result); };							
			}
		}
	}
	
	public function H_WS_checkTestScriptID(result):Void
	{
		var self:Object = this;
		
		if(result == false)
		{
			_createForm.err_lbl.text = "Test Script ID not found.";
			_createForm.create_btn.enabled = true;	
		}
		else
		{
			var params:Array = new Array();
			params[0] = _createForm.id_txt.text;
			params[1] = _createForm.subCat_cb.selectedItem.data;
			params[2] = _createForm.category_cb.selectedItem.data;
			params[3] = _createForm.script_txt.text;
			params[4] = _createForm.testType_cb.selectedItem.data;
			params[5] = encodeText(_createForm.description_txt.text);
			params[6] = encodeText(_createForm.procedure_txt.text);
			params[7] = encodeText(_createForm.expect_txt.text);
			params[8] = _createForm.sanity_cb.selectedItem.data;
			params[9] = _createForm.count_ns.value;
			trace("INSERT INTO TestCase VALUES ("+params[0]+","+params[1]+","+params[2]+","+params[3]+","+params[4]+","+params[5]+","+params[6]+","+params[7]+","+params[8]+","+params[9]+")");
			/* 28-03-2006 Continue the work here to make add test case web services */
			// Calling web service to insert a test case
			_ws_call = _ws.Add_Testcase(params[0],params[1],params[2],params[3],params[4],params[5],params[6],params[7],params[8],params[9],_global.GTID,0);			
			_ws_call.onResult = function(result) { self.H_WS_Add_TestCase(result); };			
		}
	}
	
	// Call when Add_TestCase web service has executed and returned result
	public function H_WS_Add_TestCase(result):Void
	{
		if(result == true)
		{
			Alert.show("Record created successfully","Tester data:",Alert.OK,null,"",Alert.OK);
			_createForm.id_txt.text = "";
			_createForm.description_txt.text = "";
			_createForm.procedure_txt.text = "";
			_createForm.expect_txt.text = "";
			_createForm.script_txt.text = "";
			_createForm.err_lbl.text = "";			
		}
		else
		{
			_createForm.err_lbl.text = "Record creation failed, please check fields and try again.";
		}
		_createForm.create_btn.enabled = true;
	}
	
	// Call when Get_Category web service has executed and returned result
	public function H_WS_Get_Category(result):Void
	{
		for(var i=0; i<result.xmlNodes.length; i++)
		{
			var tmpObj:Object = new Object();
			tmpObj.label = 	result.xmlNodes[i].childNodes[1].firstChild;
			tmpObj.data = 	result.xmlNodes[i].childNodes[0].firstChild;
			_createForm.category_cb.addItem(tmpObj);
		}
	}
	// Call when Get_SubCategory web service has executed and returned result
	public function H_WS_Get_SubCategory(result):Void
	{
		_createForm.subCat_cb.removeAll();
		for(var i=0; i<result.xmlNodes.length; i++)
		{
			var tmpObj:Object = new Object();
			tmpObj.label = 	result.xmlNodes[i].childNodes[1].firstChild;
			tmpObj.data = 	result.xmlNodes[i].childNodes[0].firstChild;
			_createForm.subCat_cb.addItem(tmpObj);
		}
	}
	
	// Call when Get_TestType web service has executed and returned result
	public function H_WS_Get_TestType(result):Void
	{
		for(var i=0; i<result.xmlNodes.length; i++)
		{
			var tmpObj:Object = new Object();
			tmpObj.label = 	result.xmlNodes[i].childNodes[1].firstChild;
			tmpObj.data = 	result.xmlNodes[i].childNodes[0].firstChild;
			_createForm.testType_cb.addItem(tmpObj);
		}
	}
	// Important for getting values from web service result
	public function H_WS_Search_TestCase(result):Void
	{
		for(var i=0; i<result.xmlNodes.length; i++)
		{
			var tmp:Object = new Object();
			var xnode:XMLNode = result.xmlNodes[i]
			tmp.ID 						= xnode.childNodes[0].firstChild;
			tmp.Version					= xnode.childNodes[1].firstChild;
			tmp.Creator					= xnode.childNodes[2].firstChild;
			tmp.Sub_Category 			= xnode.childNodes[3].firstChild;
			tmp.Category 				= xnode.childNodes[4].firstChild;
			tmp.Script 					= xnode.childNodes[5].firstChild;
			tmp.Test_Type 				= xnode.childNodes[6].firstChild;
			tmp.Description 			= decodeText(xnode.childNodes[7].firstChild.toString());
			tmp.Procedure 				= decodeText(xnode.childNodes[8].firstChild.toString());
			tmp.Expected_Result 		= decodeText(xnode.childNodes[9].firstChild.toString());
			tmp.Sanity 					= xnode.childNodes[10].firstChild;
			tmp.Mandatory_Test_Count 	= xnode.childNodes[11].firstChild;
			tmp.Creation_Date			= xnode.childNodes[12].firstChild;
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
	

	// Work with checkForInvaildChar, this function check for blank fields
	public function vaildateCreateForm():ATDB_Error
	{
		//trace("before:'"+_createForm.id_txt.text+"'");
		//trace("after:'"+trimString(_createForm.id_txt.text)+"'");
		var tmpStr:String = "";
		
		_createForm.id_txt.text = trimAllSpace(_createForm.id_txt.text);
		tmpStr = _createForm.id_txt.text;
		if(tmpStr == "" || !checkForInvaildChar(tmpStr))
			return new ATDB_Error(1,"ID Field cannot be blank or containing invaild characters.");
		
		_createForm.description_txt.text = trimString(_createForm.description_txt.text);
		tmpStr = _createForm.description_txt.text;
		if(tmpStr == "") // || !checkForInvaildChar(tmpStr))
			return new ATDB_Error(2,"Description field cannot be blank or contain invaild characters.");
		
		_createForm.procedure_txt.text = trimString(_createForm.procedure_txt.text);
		tmpStr = _createForm.procedure_txt.text;
		if(tmpStr == "") // || !checkForInvaildChar(tmpStr))
			return new ATDB_Error(3,"Procedure field cannot be blank or contain invaild characters.");
		
		_createForm.expect_txt.text = trimString(_createForm.expect_txt.text);
		tmpStr = _createForm.expect_txt.text;
		if(tmpStr == "") // || !checkForInvaildChar(tmpStr))
			return new ATDB_Error(4,"Expected result field cannot be blank or contain invaild characters.");
		
		_createForm.script_txt.text = trimString(_createForm.script_txt.text);
		tmpStr = _createForm.script_txt.text;
		if(!checkForInvaildChar(tmpStr))
			return new ATDB_Error(5,"Script field cannot contain invaild characters.");
			
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