class TestRecordForm extends ATDB_Form
{
	var rec:Object;
	var mc:MovieClip;
	var showBtnClick_lis:Object;
	var detailBtnClick_lis:Object;
	var tester:String;
	
	public function TestRecordForm(rec:Object)
	{
		super();
		_winLink_str = "TestRecord_Form";
		_winTitle_str = "Test Records:";	
		this.rec = rec;
	}
	public function init()
	{
		var self:Object = this;
		mc = win_mc.content;
		mc.tester_txt.text = _global.GTID;

		mc.test_grid.addColumn("TID");
		mc.test_grid.addColumn("ID");
		mc.test_grid.addColumn("Version");
		mc.test_grid.addColumn("Creator");
		mc.test_grid.addColumn("Sub_Category");
		mc.test_grid.addColumn("Category");
		mc.test_grid.addColumn("Script");
		mc.test_grid.addColumn("Test_Type");
		mc.test_grid.addColumn("Description");
		mc.test_grid.addColumn("Procedure");
		mc.test_grid.addColumn("Expected_Result");
		mc.test_grid.addColumn("Sanity");		
		mc.test_grid.addColumn("Mandatory_Test_Count");
		mc.test_grid.addColumn("Creation_Date");
		mc.test_grid.addColumn("Status");

		mc.test_grid.getColumnAt(0).width = 40;
		mc.test_grid.getColumnAt(1).width = 60;
		mc.test_grid.getColumnAt(2).width = 40;
		mc.test_grid.getColumnAt(3).width = 60;
		mc.test_grid.getColumnAt(4).width = 80;
		mc.test_grid.getColumnAt(5).width = 80;
		mc.test_grid.getColumnAt(6).width = 10;
		mc.test_grid.getColumnAt(7).width = 80;
		mc.test_grid.getColumnAt(8).width = 100;
		mc.test_grid.getColumnAt(9).width = 100;
		mc.test_grid.getColumnAt(10).width = 100;
		mc.test_grid.getColumnAt(11).width = 40;
		mc.test_grid.getColumnAt(12).width = 40;		
		mc.test_grid.getColumnAt(13).width = 80;
		mc.test_grid.getColumnAt(14).width = 80;
		mc.test_grid.hScrollPolicy = "auto";
		
		loadTestCB();
		
		showBtnClick_lis = new Object();
		showBtnClick_lis.click = function () { self.H_showBtnClick(); };
		mc.show_btn.addEventListener("click",showBtnClick_lis);
		
		detailBtnClick_lis = new Object();
		detailBtnClick_lis.click = function () { self.H_detailBtnClick(); }; 
		mc.detail_btn.addEventListener("click",detailBtnClick_lis);
		
	}
	public function loadTestCB()
	{
		var self:Object = this;
		_ws_call = _ws.Get_Test_By_Tester(_global.GTID);
		_ws_call.onResult = function (result) { self.H_WS_Get_Test_By_Tester(result); };
	}
	
	public function H_WS_Get_Test_By_Tester(result):Void
	{
		for(var i=0; i<result.xmlNodes.length; i++)
		{
			var tmpObj:Object = new Object();
			tmpObj.label = result.xmlNodes[i].childNodes[0].firstChild;
			tmpObj.data = result.xmlNodes[i].childNodes[0].firstChild;
			
			mc.test_cb.addItem(tmpObj);
		}
		centerWindow();
		win_mc.visible = true;		
	}
	
	public function H_showBtnClick():Void
	{
		trace("H_showBtnClick");
		var self:Object = this;
		if(mc.filter_ck.selected)
			_ws_call = _ws.Get_TestCase_By_Test_Tester_Filter(mc.test_cb.selectedItem.data,_global.GTID);
		else
			_ws_call = _ws.Get_TestCase_By_Test_Tester(mc.test_cb.selectedItem.data,_global.GTID);
			
		_ws_call.onResult = function (result) {self.H_WS_Get_TestCase_By_Test_Tester(result);};
	}
	
	public function H_WS_Get_TestCase_By_Test_Tester(result):Void
	{
		trace("H_WS_Get_TestCase_By_Test_Tester");
		setFormUION(true);
		mc.test_grid.removeAll();
		for(var i=0; i<result.xmlNodes.length; i++)
		{
			var tmp:Object = new Object();
			var xnode:XMLNode = result.xmlNodes[i]
			tmp.TID						= mc.test_cb.selectedItem.data;
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
			tmp.Status					= xnode.childNodes[13].firstChild;
			
			mc.test_grid.addItem(tmp);
		}		
		mc.err_lbl.text = result.xmlNodes.length+" records found."		
	}
	
	public function H_detailBtnClick():Void
	{
		if(mc.test_grid.selectedItem != undefined)
		{
			var self:Object = this;
			var record:Object = new Object();
			var detail_form:TestRecordDetailForm = new TestRecordDetailForm(this,mc.test_grid.selectedItem);
			detail_form.show(true);
		}
	}
	
	// Only used to ease the UI control process of detail form
	public function setFormUION(status:Boolean):Void
	{
		//id_lbl, sv_lbl, err_lbl
		//show_btn, add_btn, del_btn
		//tester_cb, avail_grid, assign_grid		
		with(mc){
			tester_txt.enabled = status;
			test_cb.enabled = status;
			test_grid.enabled = status;
			show_btn.enabled = status;
			detail_btn.enabled = status;
		}
	}
}
