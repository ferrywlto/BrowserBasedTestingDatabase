import mx.controls.*;

class TestRecordSearchDetailForm extends ATDB_DetailForm
{
	var rec:Object;
	var timeInter;
	var startBtnClick_lis:Object;
	var resetBtnClick_lis:Object;
	var submitBtnClick_lis:Object;
	var tester:String;
	var change_lis:Object;
	var mc:MovieClip;
	var timeCount:Number = 1;
	
	public function TestRecordSearchDetailForm(_parentW:ATDB_Form,rec:Object,tester:String)
	{
		super(_parentW);
		_winLink_str = "TestRecordSearch_Detail";
		_winTitle_str = "Details:";	
		this.rec = rec;
		this.tester = tester;
	}
	public function init()
	{
		var self:Object = this;
		mc = win_mc.content;
		mc.tpid_txt.text = rec.TID;
		mc.tcid_txt.text = rec.ID;
		mc.tv_txt.text = rec.Version;
		mc.tc_txt.text = rec.Creator;
		mc.cat_txt.text = rec.Category;
		mc.subcat_txt.text = rec.Sub_Category;
		mc.tt_txt.text = rec.Test_Type;
		mc.san_txt.text = rec.Sanity;
		mc.mtc_txt.text = rec.Mandatory_Test_Count;
		mc.date_txt.text = rec.Creation_Date;
		mc.desc_txt.text = rec.Description;
		mc.proc_txt.text = rec.Procedure;
		mc.expt_txt.text = rec.Expected_Result;
		
		mc.reset_btn.enabled = false;
		mc.submit_btn.enabled = false;
		/*
		tpid_txt
		tcid_txt
		tv_txt
		tc_txt
		cat_txt
		subcat_txt
		tt_txt
		san_txt
		mtc_txt
		date_txt
		time_txt
		desc_txt
		proc_txt
		expt_txt
		phone_cb
		sim_cb
		result_cb
		severe_cb
		ddts_txt
		succ_num
		com_txt
		start_btn
		reset_btn
		submit_btn
		*/
		trace("!!!rec.TID:"+rec.TID);
		trace("!!!rec.TCID:"+rec.ID);
		trace("!!!rec,Version"+rec.Version);
		trace("!!!this.tester"+this.tester);
		
		_ws_call = _ws.Get_TestRecord(rec.TID,rec.ID,rec.Version,this.tester);
		_ws_call.onResult = function (result){ self.H_WS_Get_TestRecord(result);};
	}
	
	public function H_WS_Get_TestRecord(result):Void
	{
		mc.phone_txt.text = result.xmlNodes[0].childNodes[0].firstChild;
		mc.severe_txt.text = result.xmlNodes[0].childNodes[1].firstChild;
		mc.sim_txt.text = result.xmlNodes[0].childNodes[2].firstChild;
		mc.tester_txt.text = result.xmlNodes[0].childNodes[3].firstChild;
		mc.result_txt.text = result.xmlNodes[0].childNodes[4].firstChild;
		
		if(result.xmlNodes[0].childNodes[5].firstChild == null)
			mc.com_txt.text = "";
		else
			mc.com_txt.text = result.xmlNodes[0].childNodes[5].firstChild;
			
		if(result.xmlNodes[0].childNodes[6].firstChild == null)
			mc.ddts_txt.text = "";
		else
			mc.ddts_txt.text = result.xmlNodes[0].childNodes[6].firstChild;
			
		mc.time_txt.text = result.xmlNodes[0].childNodes[7].firstChild + " mins";
		mc.succ_txt.text = result.xmlNodes[0].childNodes[8].firstChild;
		
		centerWindow();
		win_mc.visible = true; 	
	}
}
