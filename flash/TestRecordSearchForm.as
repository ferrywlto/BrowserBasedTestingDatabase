class TestRecordSearchForm extends ATDB_Form
{
	var rec:Object;
	var mc:MovieClip;
	var showBtnClick_lis:Object;
	var detailBtnClick_lis:Object;
	var tester:String;
	private var data_value:Array = new Array("idTestCase","tcVersionID","Testers.tName","scName","cName","tcScript","ttName","tcDescription","tcProcedure","tcExpectedResult","tcSanity","tcManTestCount","tcDate");
	private var data_label:Array = new Array("ID","Version","Creator","Sub-Category","Category","Script","Test Type","Description","Procedure","Expected Result","Sanity","Mandatory Test Count","Creation Date");
	
	public function TestRecordSearchForm(rec:Object)
	{
		super();
		_winLink_str = "TestRecordSearch_Form";
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
		
		// Load data into combo box
		for(var i:Number=0; i<this.data_value.length; i++)
		{
			var tmp:Object = new Object();
			tmp.data = this.data_value[i];
			tmp.label = this.data_label[i];
			mc.search_cb.addItem(tmp);
		}
		
		showBtnClick_lis = new Object();
		showBtnClick_lis.click = function () { self.H_showBtnClick(); };
		mc.show_btn.addEventListener("click",showBtnClick_lis);
		
		detailBtnClick_lis = new Object();
		detailBtnClick_lis.click = function () { self.H_detailBtnClick(); }; 
		mc.detail_btn.addEventListener("click",detailBtnClick_lis);
		
		getAllTester();
	}
	
	public function getAllTester():Void
	{
		var self:Object = this;
		_ws_call = _ws.Get_TestersName();
		_ws_call.onResult = function (result) {self.H_WS_Get_TestersName(result);};
	}
	
	public function H_WS_Get_TestersName(result):Void
	{
		for(var i=0; i<result.xmlNodes.length; i++)
		{
			var tmp:Object = new Object();
			tmp.data = result.xmlNodes[i].childNodes[0].firstChild;
			tmp.label = result.xmlNodes[i].childNodes[1].firstChild;
			mc.tester_cb.addItem(tmp);
		}
		getAllTest();
	}
	
	public function getAllTest()
	{
		var self:Object = this;
		_ws_call = _ws.Get_All_Test();
		_ws_call.onResult = function (result) { self.H_WS_Get_All_Test(result); };
	}
	
	public function H_WS_Get_All_Test(result):Void
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
		tester = mc.tester_cb.selectedItem.data;
		_ws_call = _ws.Get_TestCase_By_Test_Tester_Field_Value2(mc.test_cb.selectedItem.data, tester, mc.search_cb.selectedItem.data, mc.search_txt.text);	
		_ws_call.onResult = function (result) {self.H_WS_Get_TestCase_By_Test_Tester_Field_Value(result);};
	}
	
	public function H_WS_Get_TestCase_By_Test_Tester_Field_Value(result):Void
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
			var detail_form:TestRecordSearchDetailForm = new TestRecordSearchDetailForm(this,mc.test_grid.selectedItem,tester);
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
