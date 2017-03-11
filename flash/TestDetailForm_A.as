class TestDetailForm_A extends ATDB_DetailForm
{
	public var testerCBChange_lis:Object;
	public var addBtnClick_lis:Object;
	public var delBtnClick_lis:Object;
	
	public var mc:MovieClip;
	public var tID:String;
	
	public var detABtnClick_lis:Object;
	public var detDBtnClick_lis:Object;
	public var _detailForm:Testcase_tmpForm;
	
	
	public function TestDetailForm_A(_parentW:ATDB_Form,conID:String,conTable:String,conTester:String,tID:String)
	{
		super(_parentW,conID,conTable,conTester);
			
		_winLink_str = "TestForm_Detail_A";
		_winTitle_str = "Assign Test Cases to Tester:";
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

		mc.avail_grid.editable = false;
		mc.avail_grid.selectable = true;
		mc.avail_grid.hScrollPolicy = "auto";
		mc.avail_grid.multipleSelection = true;
		
		mc.avail_grid.addColumn("ID");
		mc.avail_grid.addColumn("Version");
		mc.avail_grid.addColumn("Creator");
		mc.avail_grid.addColumn("Sub_Category");
		mc.avail_grid.addColumn("Category");
		mc.avail_grid.addColumn("Script");
		mc.avail_grid.addColumn("Test_Type");
		mc.avail_grid.addColumn("Description");
		mc.avail_grid.addColumn("Procedure");
		mc.avail_grid.addColumn("Expected_Result");
		mc.avail_grid.addColumn("Sanity");		
		mc.avail_grid.addColumn("Mandatory_Test_Count");
		mc.avail_grid.addColumn("Creation_Date");

		mc.avail_grid.getColumnAt(0).width = 80;
		mc.avail_grid.getColumnAt(1).width = 80;
		mc.avail_grid.getColumnAt(2).width = 80;
		mc.avail_grid.getColumnAt(3).width = 80;
		mc.avail_grid.getColumnAt(4).width = 80;
		mc.avail_grid.getColumnAt(5).width = 80;
		mc.avail_grid.getColumnAt(6).width = 80;
		mc.avail_grid.getColumnAt(7).width = 80;
		mc.avail_grid.getColumnAt(8).width = 80;
		mc.avail_grid.getColumnAt(9).width = 80;
		mc.avail_grid.getColumnAt(10).width = 80;
		mc.avail_grid.getColumnAt(11).width = 80;
		mc.avail_grid.getColumnAt(12).width = 80;
		
		mc.assign_grid.editable = false;
		mc.assign_grid.selectable = true;
		mc.assign_grid.hScrollPolicy = "auto";
		mc.assign_grid.multipleSelection = true;
		
		mc.assign_grid.addColumn("ID");
		mc.assign_grid.addColumn("Version");
		mc.assign_grid.addColumn("Creator");
		mc.assign_grid.addColumn("Sub_Category");
		mc.assign_grid.addColumn("Category");
		mc.assign_grid.addColumn("Script");
		mc.assign_grid.addColumn("Test_Type");
		mc.assign_grid.addColumn("Description");
		mc.assign_grid.addColumn("Procedure");
		mc.assign_grid.addColumn("Expected_Result");
		mc.assign_grid.addColumn("Sanity");		
		mc.assign_grid.addColumn("Mandatory_Test_Count");
		mc.assign_grid.addColumn("Creation_Date");

		mc.assign_grid.getColumnAt(0).width = 80;
		mc.assign_grid.getColumnAt(1).width = 80;
		mc.assign_grid.getColumnAt(2).width = 80;
		mc.assign_grid.getColumnAt(3).width = 80;
		mc.assign_grid.getColumnAt(4).width = 80;
		mc.assign_grid.getColumnAt(5).width = 80;
		mc.assign_grid.getColumnAt(6).width = 80;
		mc.assign_grid.getColumnAt(7).width = 80;
		mc.assign_grid.getColumnAt(8).width = 80;
		mc.assign_grid.getColumnAt(9).width = 80;
		mc.assign_grid.getColumnAt(10).width = 80;
		mc.assign_grid.getColumnAt(11).width = 80;
		mc.assign_grid.getColumnAt(12).width = 80;

		testerCBChange_lis = new Object();
		testerCBChange_lis.change = function() {self.H_TesterCBChange();};
		win_mc.content.tester_cb.addEventListener("change",testerCBChange_lis);
		
		addBtnClick_lis = new Object();
		addBtnClick_lis.click = function() {self.H_addBtnClick();};
		win_mc.content.add_btn.addEventListener("click",addBtnClick_lis);
		
		delBtnClick_lis = new Object();
		delBtnClick_lis.click = function() {self.H_delBtnClick();};
		win_mc.content.del_btn.addEventListener("click",delBtnClick_lis);
		
		detABtnClick_lis = new Object();
		detABtnClick_lis.click = function() {self.H_detABtnClick();};
		mc.detA_btn.addEventListener("click",detABtnClick_lis);
		
		detDBtnClick_lis = new Object();
		detDBtnClick_lis.click = function() {self.H_detDBtnClick();};
		mc.detD_btn.addEventListener("click",detDBtnClick_lis);
	}

	public function H_detABtnClick():Void
	{
		if(mc.avail_grid.selectedItems.length != 0 && mc.avail_grid.selectedItems.length != undefined)
		{
			_detailForm = new Testcase_tmpForm(mc.avail_grid.selectedItems[0]);
			_detailForm.show(true);
		}
	}
	
	public function H_detDBtnClick():Void
	{
		if(mc.assign_grid.selectedItems.length != 0 && mc.assign_grid.selectedItems.length != undefined)
		{
			_detailForm = new Testcase_tmpForm(mc.assign_grid.selectedItems[0]);
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
		
		if(!isEditable)
		{
			setFormUION(false);
			_parent_win.setFormUION(true);
			win_mc.visible = true;		
		}
		else
		{
			if(mc.st_lbl.text != "Open")
			{
				mc.add_btn.visible = false;
				mc.del_btn.visible = false;
			}
			getTesterName();
		}
	}	
	public function getTesterName():Void
	{
		var self:Object = this;
		setFormUION(false);
		_ws_call = _ws.Get_TestersName();
		_ws_call.onResult = function (result) {self.H_WS_Get_TestersName(result);};
	}
	
	public function H_WS_Get_TestersName(result):Void
	{
		setFormUION(true);
		for(var i=0; i<result.xmlNodes.length; i++)
		{
			var tmp:Object = new Object();
			tmp.data = result.xmlNodes[i].childNodes[0].firstChild;
			tmp.label = result.xmlNodes[i].childNodes[1].firstChild;
			mc.tester_cb.addItem(tmp);
		}
		getAssignableTestcases();
	}
	
	public function getAssignableTestcases():Void
	{
		var self:Object = this;
		setFormUION(false);
		_ws_call = _ws.Get_AssignableTestCase(this.tID);
		_ws_call.onResult = function (result) {self.H_WS_Get_AssignableTestCase(result);};
	}
	
	public function H_WS_Get_AssignableTestCase(result):Void
	{
		setFormUION(true);
		mc.avail_grid.removeAll();
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
			tmp.Description 			= xnode.childNodes[7].firstChild;
			tmp.Procedure 				= xnode.childNodes[8].firstChild;
			tmp.Expected_Result 		= xnode.childNodes[9].firstChild;
			tmp.Sanity 					= xnode.childNodes[10].firstChild;
			tmp.Mandatory_Test_Count 	= xnode.childNodes[11].firstChild;
			tmp.Creation_Date			= xnode.childNodes[12].firstChild;
			
			mc.avail_grid.addItem(tmp);
		}		
		mc.err_lbl.text = result.xmlNodes.length+" records found."
		H_TesterCBChange();

		_parent_win.setFormUION(true);
		win_mc.visible = true;	
	}
	
	public function H_TesterCBChange():Void
	{
		var self:Object = this;
		setFormUION(false);
		_ws_call = _ws.Get_AssignedTestCase(this.tID,mc.tester_cb.selectedItem.data);
		_ws_call.onResult = function (result) {self.H_WS_Get_AssignedTestCase(result);};
	}
	
	public function H_WS_Get_AssignedTestCase(result)
	{
		setFormUION(true);
		mc.assign_grid.removeAll();
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
			
			mc.assign_grid.addItem(tmp);
		}
	}
	
	public function H_addBtnClick():Void 
	{
		var self:Object = this;
		if(mc.avail_grid.selectedItems.length == 0 || mc.avail_grid.selectedItems.length == undefined)
		{
			mc.err_lbl.text = "Nothing Selected!";
		}
		else
		{
			var arr:Array = new Array();
			for(var i=0; i<mc.avail_grid.selectedItems.length; i++)
			{
				var tmp:Object = new Object();
				tmp.TCVID = mc.avail_grid.selectedItems[i].Version;
				tmp.TCID = mc.avail_grid.selectedItems[i].ID;
				tmp.TID = this.tID;
				arr.push(tmp);
			}
			setFormUION(false);
			
			_ws_call = _ws.Add_TestCaseToTester(arr,mc.tester_cb.selectedItem.data);
			_ws_call.onResult = function (result) {self.H_WS_Add_TestCaseToTester(result);};			
		}			
	}
	
	public function H_WS_Add_TestCaseToTester(result)
	{
		trace("H_WS_Add_TestCaseToTester:"+result);
		if(result.code == 0)
			refreshUIGrids_Phase1();
		else
			mc.err_lbl.text = result.msg;
	}
	public function refreshUIGrids_Phase1(result):Void
	{
		trace("refreshUIGrids_Phase1");
		setFormUION(false);
		mc.avail_grid.enabled = true;
		mc.assign_grid.enabled = true;
		mc.assign_grid.removeAll();
		mc.avail_grid.removeAll();
		
		var self:Object = this;
		_ws_call = _ws.Get_AssignableTestCase(this.tID);
		_ws_call.onResult = function (result) {self.refreshUIGrids_Phase2(result);};		
	}
	public function refreshUIGrids_Phase2(result):Void
	{
		trace("refreshUIGrids_Phase2");
		for(var i=0; i<result.xmlNodes.length; i++)
		{
			var tmp:Object = new Object();
			var xnode:XMLNode = result.xmlNodes[i];
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
			
			mc.avail_grid.addItem(tmp);
		}		
		mc.err_lbl.text = result.xmlNodes.length+" records found."
		
		var self:Object = this;
		_ws_call = _ws.Get_AssignedTestCase(this.tID,mc.tester_cb.selectedItem.data);
		_ws_call.onResult = function (result) {self.refreshUIGrids_Phase3(result);};		
	}
	public function refreshUIGrids_Phase3(result):Void
	{
		trace("refreshUIGrids_Phase3");
		for(var i=0; i<result.xmlNodes.length; i++)
		{
			var tmp:Object = new Object();
			var xnode:XMLNode = result.xmlNodes[i];
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
			
			mc.assign_grid.addItem(tmp);
		}
		setFormUION(true);
	}
	
	public function H_delBtnClick():Void 
	{
		var self:Object = this;
		if(mc.assign_grid.selectedItems.length == 0 || mc.assign_grid.selectedItems.length == undefined)
		{
			mc.err_lbl.text = "Nothing Selected!";
		}
		else
		{
			var arr:Array = new Array();
			for(var i=0; i<mc.assign_grid.selectedItems.length; i++)
			{
				var tmp:Object = new Object();
				tmp.TCVID = mc.assign_grid.selectedItems[i].Version;
				tmp.TCID = mc.assign_grid.selectedItems[i].ID;
				tmp.TID = this.tID;
				arr.push(tmp);
			}
			setFormUION(false);
			_ws_call = _ws.Delete_TestCaseFromTester(arr,mc.tester_cb.selectedItem.data);
			_ws_call.onResult = function (result) {self.H_WS_Delete_TestCaseFromTester(result);};
		}		
	}
	
	public function H_WS_Delete_TestCaseFromTester(result)
	{
		trace("H_WS_Delete_TestCaseFromTester:"+result);
		if(result.code == 0)
			refreshUIGrids_Phase1();
		else
			mc.err_lbl.text = result.msg;
	}
	
	// Only used to ease the UI control process of detail form
	public function setFormUION(status:Boolean):Void
	{
		//id_lbl, sv_lbl, err_lbl
		//show_btn, add_btn, del_btn
		//tester_cb, avail_grid, assign_grid		
		with(mc){
			show_btn.enabled = status;
			del_btn.enabled = status;
			add_btn.enabled = status;
			tester_cb.enabled = status;	
			avail_grid.enabled = status;
			assign_grid.enabled = status;
		}
	}	
}