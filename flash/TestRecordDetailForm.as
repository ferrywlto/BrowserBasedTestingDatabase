import mx.controls.*;

class TestRecordDetailForm extends ATDB_DetailForm
{
	var rec:Object;
	var timeInter;
	var startBtnClick_lis:Object;
	var resetBtnClick_lis:Object;
	var submitBtnClick_lis:Object;
	
	var change_lis:Object;
	var mc:MovieClip;
	var timeCount:Number = 1;
	
	public function TestRecordDetailForm(_parentW:ATDB_Form,rec:Object)
	{
		super(_parentW);
		_winLink_str = "TestRecord_Detail";
		_winTitle_str = "Details:";	
		this.rec = rec;
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
		
		startBtnClick_lis = new Object();
		startBtnClick_lis.click = function () {self.H_startBtnClick(); };
		mc.start_btn.addEventListener("click",startBtnClick_lis);
		
		resetBtnClick_lis = new Object();
		resetBtnClick_lis.click = function () {self.H_resetBtnClick(); };
		mc.reset_btn.addEventListener("click",resetBtnClick_lis);
		
		submitBtnClick_lis = new Object();
		submitBtnClick_lis.click = function () {self.H_submitBtnClick(); };
		mc.submit_btn.addEventListener("click",submitBtnClick_lis);
				
		change_lis = new Object();
		change_lis.change = function () { self.H_change();};
		mc.result_cb.addEventListener("change",change_lis);
				
		loadPhone();
	}
	public function H_change()
	{
		trace(mc.result_cb.selectedItem.data);
	}
	
	
	public function loadPhone():Void
	{
		var self:Object = this;
		_ws_call = _ws.Get_Phone();
		_ws_call.onResult = function (result) { self.H_WS_Get_Phone(result);};
	}
	
	public function H_WS_Get_Phone(result):Void
	{
		trace("H_WS_Get_Phone");
		for(var i=0; i<result.xmlNodes.length; i++)
		{
			var tmpObj:Object = new Object();
			tmpObj.label = result.xmlNodes[i].childNodes[1].firstChild;
			tmpObj.data = result.xmlNodes[i].childNodes[0].firstChild;
			mc.phone_cb.addItem(tmpObj);
		}
		loadSIM();
	}

	public function loadSIM():Void
	{
		var self:Object = this;
		_ws_call = _ws.Get_SIMCard();
		_ws_call.onResult = function (result) { self.H_WS_Get_SIMCard(result);};
	}

	public function H_WS_Get_SIMCard(result):Void
	{
		trace("H_WS_Get_SIMCard");
		for(var i=0; i<result.xmlNodes.length; i++)
		{
			var tmpObj:Object = new Object();
			tmpObj.label = result.xmlNodes[i].childNodes[1].firstChild;
			tmpObj.data = result.xmlNodes[i].childNodes[0].firstChild;
			mc.sim_cb.addItem(tmpObj);
		}
		loadResultType();
	}

	public function loadResultType():Void
	{
		var self:Object = this;
		_ws_call = _ws.Get_ResultType();
		_ws_call.onResult = function (result) { self.H_WS_Get_ResultType(result);};
	}

	public function H_WS_Get_ResultType(result):Void
	{
		trace("H_WS_Get_ResultType");
		for(var i=0; i<result.xmlNodes.length; i++)
		{
			var tmpObj:Object = new Object();
			tmpObj.label = result.xmlNodes[i].childNodes[1].firstChild;
			tmpObj.data = result.xmlNodes[i].childNodes[0].firstChild;
			mc.result_cb.addItem(tmpObj);
		}
		loadSeverity();
	}

	public function loadSeverity():Void
	{
		var self:Object = this;
		_ws_call = _ws.Get_Severity();
		_ws_call.onResult = function (result) { self.H_WS_Get_Severity(result);};
	}
	
	public function H_WS_Get_Severity(result):Void
	{
		trace("H_WS_Get_Severity");
		for(var i=0; i<result.xmlNodes.length; i++)
		{
			var tmpObj:Object = new Object();
			tmpObj.label = result.xmlNodes[i].childNodes[1].firstChild;
			tmpObj.data = result.xmlNodes[i].childNodes[0].firstChild;
			mc.severe_cb.addItem(tmpObj);
		}
		loadTestRecordData();
	}

	public function loadTestRecordData()
	{
		var self:Object = this;
		trace("!!!rec.TID:"+rec.TID);
		trace("!!!rec.ID:"+rec.ID);
		trace("!!!rec.Version:"+rec.Version);
		trace("!!!_global.GTID:"+_global.GTID);
		_ws_call = _ws.Get_TestRecord_IndexOnly(rec.TID,rec.ID,rec.Version,_global.GTID);
		_ws_call.onResult = function (result){ self.H_WS_Get_TestRecord(result);};
	}
	
	public function H_WS_Get_TestRecord(result):Void
	{
		getComboBoxIndexByValue(mc.phone_cb,result.xmlNodes[0].childNodes[0].firstChild);
		getComboBoxIndexByValue(mc.severe_cb,result.xmlNodes[0].childNodes[1].firstChild);
		getComboBoxIndexByValue(mc.sim_cb,result.xmlNodes[0].childNodes[2].firstChild);
		getComboBoxIndexByValue(mc.result_cb,result.xmlNodes[0].childNodes[3].firstChild);
		
		if(result.xmlNodes[0].childNodes[4].firstChild == null)
			mc.com_txt.text = "";
		else
			mc.com_txt.text = result.xmlNodes[0].childNodes[4].firstChild;
			
		if(result.xmlNodes[0].childNodes[5].firstChild == null)
			mc.ddts_txt.text = "";
		else
			mc.ddts_txt.text = result.xmlNodes[0].childNodes[5].firstChild;
			
		if(result.xmlNodes[0].childNodes[6].firstChild == null)
			mc.time_txt.text = "N/A";
		else
			mc.time_txt.text = result.xmlNodes[0].childNodes[6].firstChild + " mins";
			
		mc.succ_num.value = parseInt(result.xmlNodes[0].childNodes[7].firstChild.toString());
		
		setFormUIOn(false);
		mc.start_btn.enabled = true;
		centerWindow();
		win_mc.visible = true;	
		//mc.tester_txt.text = result.xmlNodes[0].childNodes[3].firstChild;		
	}		
	
	public function H_startBtnClick():Void
	{
		setFormUIOn(true);
		mc.start_btn.enabled = false;
		mc.time_txt.text = timeCount+" mins";
		timeInter = setInterval(this,"H_timeInter_tick",60*1000);
	}
	
	public function H_timeInter_tick():Void
	{
		timeCount++;
		mc.time_txt.text = timeCount+" mins";
	}
	
	public function H_resetBtnClick():Void
	{
		resetFields();
	}
	
	public function H_submitBtnClick():Void
	{

		var self:Object = this;
		var alertClick_lis = function(evt_obj:Object) 
		{
			if(evt_obj.detail == Alert.OK)
			{
				setFormUIOn(false);
				self.updateTestRecord();
			}
		};			
		Alert.show("Are you sure to submit?","Warning",Alert.OK|Alert.CANCEL,_root,alertClick_lis,"",Alert.CANCEL);
	}
	
	public function updateTestRecord()
	{
		mc.ddts_txt.text = trimString(mc.ddts_txt.text);

		if(!checkForInvaildChar(mc.ddts_txt.text))
		{
			Alert.show("DDTS field cannot contain invaild characters");
		}
		else
		{
			var self:Object = this;
			var rec:Object = new Object();
	
			rec.Tester=_global.GTID;		
			rec.SuccCount = mc.succ_num.value;
			rec.Time = timeCount;
			
			rec.TID = mc.tpid_txt.text;
			rec.TCID = mc.tcid_txt.text;
			rec.TCVID = mc.tv_txt.text;
			rec.Comment = encodeText(mc.com_txt.text);
			rec.DDTS = mc.ddts_txt.text;
	
			rec.Phone = mc.phone_cb.selectedItem.data;
			rec.Severity = mc.severe_cb.selectedItem.data;
			rec.SimCard = mc.sim_cb.selectedItem.data;
			rec.ResultType = mc.result_cb.selectedItem.data;
			
			
			trace("rec.Tester"+":"+typeof(rec.Tester));
			trace("rec.SuccCount"+":"+typeof(rec.SuccCount));
			trace("rec.Time"+":"+typeof(rec.Time));
			
			trace("rec.Phone"+":"+typeof(rec.Phone)+":"+rec.Phone);
			trace("rec.Severity"+":"+typeof(rec.Severity)+":"+rec.Severity);
			trace("rec.ResultType"+":"+typeof(rec.ResultType)+":"+rec.ResultType);
			trace("rec.SimCard"+":"+typeof(rec.SimCard)+":"+rec.SimCard);
			
			_ws_call = _ws.Update_TestRecord(rec);
			_ws_call.onResult = function(result) { self.H_WS_Update_TestRecord(result); };
		}
	}
	
	public function H_WS_Update_TestRecord(result):Void
	{
		if(result.code == 0)
		{
			Alert.show("Record updated successfully.","Notice",Alert.OK,_root,null,"",Alert.OK);
			clearInterval(timeInter);
			killWindow();
		}
		else
		{
			Alert.show("Record update fail.","Notice",Alert.OK,_root,null,"",Alert.OK);
			setFormUIOn(true);
			mc.start_btn.enabled = false;
		}
	}
	
	public function setFormUIOn(status:Boolean):Void
	{
		mc.start_btn.enabled= status;
		mc.reset_btn.enabled=status;
		mc.submit_btn.enabled=status;
		mc.phone_cb.enabled = status;
		mc.severe_cb.enabled = status;
		mc.sim_cb.enabled = status;
		mc.result_cb.enabled = status;
		mc.ddts_txt.enabled = status;
		mc.succ_num.enabled = status;
		mc.com_txt.enabled = status;
	}
	public function resetFields():Void
	{
		mc.phone_cb.selectedIndex = 0;
		mc.sim_cb.selectedIndex = 0;
		mc.result_cb.selectedIndex = 0;
		mc.severe_cb.selectedIndex = 0;
		mc.ddts_txt.text = "";
		mc.succ_num.value = 0;
		mc.com_txt.text = "";	
	}
}
