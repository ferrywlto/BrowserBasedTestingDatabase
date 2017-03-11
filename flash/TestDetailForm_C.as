
class TestDetailForm_C extends ATDB_DetailForm
{
	public var searchBtnClick_lis:Object;
	public var delBtnClick_lis:Object;
	public var addBtnClick_lis:Object;
	public var detABtnClick_lis:Object;
	public var detDBtnClick_lis:Object;
	public var _detailForm:Testcase_tmpForm;
	//Search Test Plan
	//private var data_value:Array = new Array("idTest","svName","tCreator","tDateStart","tDateEnd","tDesc","tps_Name");
	//private var data_label:Array = new Array("ID","Software Version","Creator","Start Date","End Date","Description","Status");

	//Search Test Case
	private var data_value:Array = new Array("idTestCase","tcVersionID","Testers.tName","scName","cName","tcScript","ttName","tcDescription","tcProcedure","tcExpectedResult","tcSanity","tcManTestCount","tcDate");
	private var data_label:Array = new Array("ID","Version","Creator","Sub-Category","Category","Script","Test Type","Description","Procedure","Expected Result","Sanity","Mandatory Test Count","Creation Date");
	
	public var mc:MovieClip;
	public var tID:String;
	
	public function TestDetailForm_C(_parentW:ATDB_Form,conID:String,conTable:String,conTester:String,tID:String)
	{
		super(_parentW,conID,conTable,conTester);
			
		_winLink_str = "TestForm_Detail_C";
		_winTitle_str = "Add Test Cases to Test Plan:";
		this.tID = tID;
		
		// No timer needed in this form
		clearInterval(warnInterID);
	}
	
	public function init():Void
	{
		var self:Object = this;
		
		centerWindow();
		
		initUI();
		/* This statement must be called */
		startLockRecord();
	}
	
	public function initUI():Void
	{
		var self:Object = this;
		mc = win_mc.content;
		setFormUION(true);
		mc.err_lbl.setStyle("color",0xFF0000);		
		// Load data into combo box
		for(var i:Number=0; i<this.data_value.length; i++)
		{
			var tmp:Object = new Object();
			tmp.data = this.data_value[i];
			tmp.label = this.data_label[i];
			mc.search_cb.addItem(tmp);
		}	
		mc.search_grid.editable = false;
		mc.search_grid.selectable = true;
		mc.search_grid.hScrollPolicy = "auto";
		
		mc.search_grid.addColumn("ID");
		mc.search_grid.addColumn("Version");
		mc.search_grid.addColumn("Creator");
		mc.search_grid.addColumn("Sub_Category");
		mc.search_grid.addColumn("Category");
		mc.search_grid.addColumn("Script");
		mc.search_grid.addColumn("Test_Type");
		mc.search_grid.addColumn("Description");
		mc.search_grid.addColumn("Procedure");
		mc.search_grid.addColumn("Expected_Result");
		mc.search_grid.addColumn("Sanity");		
		mc.search_grid.addColumn("Mandatory_Test_Count");
		mc.search_grid.addColumn("Creation_Date");

		mc.search_grid.getColumnAt(0).width = 80;
		mc.search_grid.getColumnAt(1).width = 80;
		mc.search_grid.getColumnAt(2).width = 80;
		mc.search_grid.getColumnAt(3).width = 80;
		mc.search_grid.getColumnAt(4).width = 80;
		mc.search_grid.getColumnAt(5).width = 80;
		mc.search_grid.getColumnAt(6).width = 80;
		mc.search_grid.getColumnAt(7).width = 80;
		mc.search_grid.getColumnAt(8).width = 80;
		mc.search_grid.getColumnAt(9).width = 80;
		mc.search_grid.getColumnAt(10).width = 80;
		mc.search_grid.getColumnAt(11).width = 80;
		mc.search_grid.getColumnAt(12).width = 80;
		
		mc.testcase_grid.editable = false;
		mc.testcase_grid.selectable = true;
		mc.testcase_grid.hScrollPolicy = "auto";
		
		mc.testcase_grid.addColumn("ID");
		mc.testcase_grid.addColumn("Version");
		mc.testcase_grid.addColumn("Creator");
		mc.testcase_grid.addColumn("Sub_Category");
		mc.testcase_grid.addColumn("Category");
		mc.testcase_grid.addColumn("Script");
		mc.testcase_grid.addColumn("Test_Type");
		mc.testcase_grid.addColumn("Description");
		mc.testcase_grid.addColumn("Procedure");
		mc.testcase_grid.addColumn("Expected_Result");
		mc.testcase_grid.addColumn("Sanity");		
		mc.testcase_grid.addColumn("Mandatory_Test_Count");
		mc.testcase_grid.addColumn("Creation_Date");

		mc.testcase_grid.getColumnAt(0).width = 80;
		mc.testcase_grid.getColumnAt(1).width = 80;
		mc.testcase_grid.getColumnAt(2).width = 80;
		mc.testcase_grid.getColumnAt(3).width = 80;
		mc.testcase_grid.getColumnAt(4).width = 80;
		mc.testcase_grid.getColumnAt(5).width = 80;
		mc.testcase_grid.getColumnAt(6).width = 80;
		mc.testcase_grid.getColumnAt(7).width = 80;
		mc.testcase_grid.getColumnAt(8).width = 80;
		mc.testcase_grid.getColumnAt(9).width = 80;
		mc.testcase_grid.getColumnAt(10).width = 80;
		mc.testcase_grid.getColumnAt(11).width = 80;
		mc.testcase_grid.getColumnAt(12).width = 80;
		
		searchBtnClick_lis = new Object();
		searchBtnClick_lis.click = function() {self.H_searchBtnClick();};
		mc.search_btn.addEventListener("click",searchBtnClick_lis);
		
		delBtnClick_lis = new Object();
		delBtnClick_lis.click = function() {self.H_delBtnClick();};
		mc.del_btn.addEventListener("click",delBtnClick_lis);
		
		addBtnClick_lis = new Object();
		addBtnClick_lis.click = function() {self.H_addBtnClick();};
		mc.add_btn.addEventListener("click",addBtnClick_lis);
		
		detABtnClick_lis = new Object();
		detABtnClick_lis.click = function() {self.H_detABtnClick();};
		mc.detA_btn.addEventListener("click",detABtnClick_lis);
		
		detDBtnClick_lis = new Object();
		detDBtnClick_lis.click = function() {self.H_detDBtnClick();};
		mc.detD_btn.addEventListener("click",detDBtnClick_lis);
	}
	
	public function H_detABtnClick():Void
	{
		if(mc.search_grid.selectedItems.length != 0 && mc.search_grid.selectedItems.length != undefined)
		{
			trace(":::::::::::::::::");
			_detailForm = new Testcase_tmpForm(mc.search_grid.selectedItems[0]);
			_detailForm.show(true);
		}
	}
	
	public function H_detDBtnClick():Void
	{
		if(mc.testcase_grid.selectedItems.length != 0 && mc.testcase_grid.selectedItems.length != undefined)
		{
			_detailForm = new Testcase_tmpForm(mc.testcase_grid.selectedItems[0]);
			_detailForm.show(true);
		}
	}
	
	/* Function which must overrided in each class to wire-up the lock */
	public function H_WS_LockResult_Delegator(result):Void
	{
		getTestPlanInfo();
	}
	public function getTestPlanInfo():Void
	{
		var self:Object = this;
		_ws_call = _ws.Get_Test_By_ID(this.tID);
		_ws_call.onResult = function (result) { self.H_WS_Get_Test_By_ID(result); };
	}
	public function H_WS_Get_Test_By_ID(result):Void
	{
		for(var j = 0; j<result.xmlNodes[0].childNodes.length; j++)
			trace("H_WS_Get_TestPlanInfo:"+result.xmlNodes[0].childNodes[j].firstChild);

		var arr:Array = result.xmlNodes[0].childNodes;
		
		mc.id_lbl.text = arr[0].firstChild;
		mc.sv_lbl.text = arr[1].firstChild;
		mc.st_lbl.text = arr[6].firstChild;
		trace("arr[6].firstChild"+arr[6].firstChild);

		
		getAddedTestCases();
	}
	
	public function getAddedTestCases():Void
	{
		var self:Object = this;
		setFormUION(false);
		_ws_call = _ws.Search_AddedTestCases(this.tID);
		_ws_call.onResult = function (result) { self.H_WS_Search_AddedTestCases(result); };		
	}
	
	public function H_WS_Search_AddedTestCases(result):Void
	{
		setFormUION(true);			
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
			
			mc.testcase_grid.addItem(tmp);
		}
		if(isEditable)
		{
			setFormUION(true);
			if(mc.st_lbl.text != "Open")
			{
				mc.add_btn.visible = false;
				mc.del_btn.visible = false;
			}
		}
		else setFormUION(false);
		
		_parent_win.setFormUION(true);
		win_mc.visible = true; 	
	}
	
	public function H_searchBtnClick():Void
	{
		var self:Object = this;
		trace("start calling web services");
		setFormUION(false);				
		mc.err_lbl.text = "Searching... please wait.";
		mc.search_grid.removeAll();
		if(mc.latest_ck.selected)
		{
			trace("Search_TestCase_Latest");
			_ws_call = _ws.Search_AvailableTestCases_Latest(mc.search_cb.selectedItem.data,encodeText(mc.search_txt.text),this.tID);			
		}
		else
		{
			_ws_call = _ws.Search_AvailableTestCases(mc.search_cb.selectedItem.data,encodeText(mc.search_txt.text),this.tID);			
		}
		_ws_call.onResult = function(result) { self.H_WS_Search_AvailableTestCases(result); };
	}
	public function H_WS_Search_AvailableTestCases(result):Void
	{
		setFormUION(true);	
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
			
			mc.search_grid.addItem(tmp);
		}	
		mc.err_lbl.text = result.xmlNodes.length+" records found.";
	}
	public function H_delBtnClick():Void
	{
		var self:Object = this;
		if(mc.testcase_grid.selectedItems.length == 0 || mc.testcase_grid.selectedItems.length == undefined)
		{
			mc.err_lbl.text = "Nothing Selected!";
		}
		else
		{
			var arr:Array = new Array();
			for(var i=0; i<mc.testcase_grid.selectedItems.length; i++)
			{
				var tmp:Object = new Object();
				tmp.TCVID = mc.testcase_grid.selectedItems[i].Version;
				tmp.TCID = mc.testcase_grid.selectedItems[i].ID;
				tmp.TID = this.tID;
				arr.push(tmp);
			}
			setFormUION(false);
			_ws_call = _ws.Delete_TestCaseFromTestPlan(arr);
			_ws_call.onResult = function (result) {self.H_WS_Delete_TestCaseFromTestPlan(result);};
		}
	}
	public function H_WS_Delete_TestCaseFromTestPlan(result):Void
	{
		trace("H_WS_Delete_TestCaseFromTestPlan");
		if(result.code == 0)
			refreshUIGrids_Phase1();
		else
			mc.err_lbl.text = result.msg;
	}
	
	public function refreshUIGrids_Phase1():Void
	{
		var self:Object = this;
		mc.search_grid.removeAll();
		mc.testcase_grid.removeAll();
		if(mc.latest_ck.selected)
		{
			trace("Search_TestCase_Latest");
			_ws_call = _ws.Search_AvailableTestCases_Latest(mc.search_cb.selectedItem.data,encodeText(mc.search_txt.text),this.tID);			
		}
		else
		{
			_ws_call = _ws.Search_AvailableTestCases(mc.search_cb.selectedItem.data,encodeText(mc.search_txt.text),this.tID);			
		}		
		_ws_call.onResult = function(result) { self.refreshUIGrids_Phase2(result); };				
	}
	
	public function refreshUIGrids_Phase2(result):Void
	{
		var self:Object = this;
		mc.search_grid.enabled = true;
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
			
			mc.search_grid.addItem(tmp);
		}	
		mc.err_lbl.text = result.xmlNodes.length+" records found.";
		
		_ws_call = _ws.Search_AddedTestCases(this.tID);
		_ws_call.onResult = function (result) { self.refreshUIGrids_Phase3(result); };			
	}
	
	public function refreshUIGrids_Phase3(result):Void
	{
		mc.testcase_grid.enabled = true;
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
			
			mc.testcase_grid.addItem(tmp);
		}
		setFormUION(true);
	}
	
	public function H_addBtnClick():Void
	{
		var self:Object = this;
		if(mc.search_grid.selectedItems.length == 0 || mc.search_grid.selectedItems.length == undefined)
		{
			mc.err_lbl.text = "Nothing Selected!";
		}
		else
		{
			var arr:Array = new Array();
			for(var i=0; i<mc.search_grid.selectedItems.length; i++)
			{
				var tmp:Object = new Object();
				tmp.TCVID = mc.search_grid.selectedItems[i].Version;
				tmp.TCID = mc.search_grid.selectedItems[i].ID;
				tmp.TID = this.tID;
				arr.push(tmp);
			}
			setFormUION(false);
			_ws_call = _ws.Add_TestCaseToTestPlan(arr);
			_ws_call.onResult = function (result) {self.H_WS_Add_TestCaseToTestPlan(result);};
		}		
	}
	public function H_WS_Add_TestCaseToTestPlan(result):Void
	{
		if(result.code == 0)
			refreshUIGrids_Phase1();
		else
			mc.err_lbl.text = result.msg;
	}
	//
	// Only used to ease the UI control process of detail form
	public function setFormUION(status:Boolean):Void
	{
		//id_lbl,sv_lbl,err_lbl,
		//search_btn,del_btn,add_btn,
		//search_grid,testcase_grid,
		//search_cb,search_txt,
		with(mc)
		{
			search_cb.enabled = status;// search_txt
			search_txt.enabled = status;
			search_btn.enabled = status;
			add_btn.enabled = status;
			del_btn.enabled = status;
			search_grid.enabled = status;
			testcase_grid.enabled = status;
			detA_btn.enabled = status;
			detD_btn.enabled = status;
		}
	}	
}