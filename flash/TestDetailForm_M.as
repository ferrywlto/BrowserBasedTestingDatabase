import mx.controls.*;
import mx.services.*;

class TestDetailForm_M extends ATDB_DetailForm
{
	public var submitBtnClick_lis:Object;
	public var startBtnClick_lis:Object;
	public var closeBtnClick_lis:Object;
	public var statsBtnClick_lis:Object;
	public var mc:MovieClip;
	public var tID:String;
	
	public function TestDetailForm_M(_parentW:ATDB_Form,conID:String,conTable:String,conTester:String,tID:String)
	{
		super(_parentW,conID,conTable,conTester);
			
		_winLink_str = "TestForm_Detail_M";
		_winTitle_str = "Modify Test Plan Information:";
		this.tID = tID;
	}
	
	public function init():Void
	{
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
		
		closeBtnClick_lis = new Object();
		closeBtnClick_lis.click = function(){self.H_closeBtnClick();};
		mc.close_btn.addEventListener("click",closeBtnClick_lis);

		statsBtnClick_lis = new Object();
		statsBtnClick_lis.click = function(){self.H_statsBtnClick();};
		mc.stats_btn.addEventListener("click",statsBtnClick_lis);	

		startBtnClick_lis = new Object();
		startBtnClick_lis.click = function(){self.H_startBtnClick();};
		mc.startX_btn.addEventListener("click",startBtnClick_lis);
		
		submitBtnClick_lis = new Object();
		submitBtnClick_lis.click = function(){self.H_submitBtnClick();};
		mc.submit_btn.addEventListener("click",submitBtnClick_lis);		
	}
	
	public function H_closeBtnClick():Void
	{
		var self:Object = this;
		setFormUION(false);

		var click_lis:Object = new Object();

		click_lis.click = function(evt_obj:Object)
		{
			self.setFormUION(false);
			switch (evt_obj.detail) 
			{
				case Alert.OK :
					_ws_call = _ws.Close_TestPlan(self.tID,_global.GTID);
					_ws_call.onResult = function (result) {self.H_WS_Close_TestPlan(result);};
				break;
				case Alert.CANCEL:
					self.setFormUION(true);
					self.mc.startX_btn.enabled = false;
				break;
			}
		}		
		var dialog_win:Object = Alert.show("Are you sure to close the test?", "Notice:", Alert.OK|Alert.CANCEL, null, click_lis, "", Alert.OK);
		dialog_win.addEventListener("click",click_lis);			
	}
	
	public function H_WS_Close_TestPlan(result):Void
	{
		var self:Object = this;
		if(result.code == 0)
		{
			var click_lis:Object = new Object();
			click_lis.click = function(evt_obj:Object)
			{
				self.killWindow();
			}
			var dialog_win:Object = Alert.show("Test plan closed successfully.", "Notice:", Alert.OK, mc, null, "", Alert.OK);
			dialog_win.addEventListener("click",click_lis);		
			trace("H_WS_Start_TestPlan");
		}
		else
		{
			mc.err_lbl.text = result.msg;
		}
	}
	
	public function getTestPlanInfo():Void
	{
		var self:Object = this;
		_ws_call = _ws.Get_TestPlanInfo(this.tID);
		_ws_call.onResult = function (result) { self.H_WS_Get_TestPlanInfo(result); };
	}
	
	public function getSoftwareVersion():Void
	{
		var self:Object = this;
		_ws_call = _ws.Get_SoftwareVersion();
		_ws_call.onResult = function (result) { self.H_WS_Get_SoftwareVersion(result); };
	}
	
	public function H_WS_Get_TestPlanInfo(result):Void
	{
		for(var j = 0; j<result.xmlNodes[0].childNodes.length; j++)
			trace("H_WS_Get_TestPlanInfo:"+result.xmlNodes[0].childNodes[j].firstChild);

		var arr:Array = result.xmlNodes[0].childNodes;
		
		mc.id_lbl.text = arr[0].firstChild;
		mc.creator_lbl.text = arr[2].firstChild;
		mc.desc_txt.text = decodeText(arr[5].firstChild.toString());
		mc.status_lbl.text = arr[6].firstChild;
		
		getComboBoxIndexByValue(mc.sv_cb,arr[1].firstChild);
		
		if(arr[3].firstChild == null)
			mc.dateStart_lbl.text = "N/A";
		else 
			mc.dateStart_lbl.text = arr[3].firstChild;
		
		if(arr[4].firstChild == null)
			mc.dateEnd_lbl.text = "N/A";
		else
			mc.dateEnd_lbl.text = arr[4].firstChild;
		
		if(isEditable)
		{
			if(mc.status_lbl.text == "Open")
			{
				mc.close_btn.enabled = false;
				mc.stats_btn.enabled = false;
			}
			else if(mc.status_lbl.text == "Started")
			{
				mc.submit_btn.enabled = false;
				mc.startX_btn.enabled = false;
			}
			else if(mc.status_lbl.text == "Closed")
			{
				mc.submit_btn.enabled = false;
				mc.startX_btn.enabled = false;
				mc.close_btn.enabled = false;
			}
		}
		else
			setFormUION(false);
		
		_parent_win.setFormUION(true);
		win_mc.visible = true; 	
	}
	
	public function H_WS_Get_SoftwareVersion(result):Void
	{
		for(var i=0; i<result.xmlNodes.length; i++)
		{
			var tmpObj:Object = new Object();
			tmpObj.label = result.xmlNodes[i].childNodes[1].firstChild;
			tmpObj.data = result.xmlNodes[i].childNodes[0].firstChild;
			mc.sv_cb.addItem(tmpObj);
		}
		getTestPlanInfo();
	}
	
	/* Function which must overrided in each class to wire-up the lock */
	public function H_WS_LockResult_Delegator(result):Void
	{
		getSoftwareVersion();
	}	
	
	public function H_submitBtnClick():Void
	{
		var self:Object = this;
		_ws_call = _ws.Update_TestPlan_SV_DESC(this.tID,mc.sv_cb.selectedItem.data,encodeText(mc.desc_txt.text));
		_ws_call.onResult = function (result) { self.H_WS_Update_TestPlan_SV_DESC(result); };
		
	}
	
	public function H_WS_Update_TestPlan_SV_DESC(result):Void
	{
		trace("H_WS_Update_TestPlan_SV_DESC!");
		var self:Object = this;
		if(result.code == 0)
		{
			trace("ALERT!");
			var alertClick_lis = function(evt_obj:Object) 
			{
				if(evt_obj.detail == Alert.OK)
				{
					self._parent_win.H_searchBtnClick();
					self.killWindow();							
				}
			};			
			Alert.show("Record updated successfully","Test Plan Data:",Alert.OK,_root,alertClick_lis,"",Alert.OK);		
		}
		else
			mc.err_lbl.text = result.msg;
	}
	
	public function H_startBtnClick():Void
	{
		var self:Object = this;
		var click_lis:Object = new Object();

		click_lis.click = function(evt_obj:Object)
		{
			self.setFormUION(false);
			switch (evt_obj.detail) 
			{
				case Alert.OK :
					trace("self.tID:"+self.tID);
					_ws_call = _ws.Start_TestPlan(self.tID,_global.GTID);
					_ws_call.onResult = function(result) { self.H_WS_Start_TestPlan(result); };
				break;
				case Alert.CANCEL:
					self.setFormUION(true);
					self.mc.close_btn.enabled = false;
					self.mc.stats_btn.enabled = false;
				break;
			}
		}
		trace("H_startBtnClick()");
		var dialog_win:Object = Alert.show("No more modifications can be made on test plan once it started. Are you sure?", "Notice:", Alert.OK|Alert.CANCEL, null, click_lis, "", Alert.OK);
		dialog_win.addEventListener("click",click_lis);			
	}
	public function H_WS_Start_TestPlan(result):Void
	{
		var self:Object = this;
		if(result.code == 0)
		{
			var click_lis:Object = new Object();
			click_lis.click = function(evt_obj:Object)
			{
				self.killWindow();
				//self.win_mc.deletePopUp();
			}
			var dialog_win:Object = Alert.show("Test plan started successfully.", "Notice:", Alert.OK, mc, null, "", Alert.OK);
			dialog_win.addEventListener("click",click_lis);		
			trace("H_WS_Start_TestPlan");
		}
		else
		{
			mc.err_lbl.text = result.msg;
			setFormUION(true);
			mc.close_btn.enabled = false;
			mc.stats_btn.enabled = false;			
		}
		
		// For user features pirority and concurrent edit control
		//_global.GTID = self.win_mc.content.ac_txt.text.toLowerCase();
		//trace("clicked");
		//self.win_mc.deletePopUp();
		//self.notifyComplete();		
	}
	
	public function H_statsBtnClick():Void
	{
		trace("H_statsBtnClick");
	}
	
	// Only used to ease the UI control process of detail form
	public function setFormUION(status:Boolean):Void
	{
		//id_lbl,dataStart_lbl,dateEnd_lbl,err_lbl,status_lbl
		//desc_txt,sv_cb,
		//submit_btn,start_btn,close_btn,stats_btn		
		with(mc)
		{
			desc_txt.enabled = status;	//description_txt,
			sv_cb.enabled = status;		//search_txt
			stats_btn.enabled = status;	//add_btn
			close_btn.enabled = status;	//remove_btn		
			startX_btn.enabled = status;//search_btn
			submit_btn.enabled = status;//submit_btn
		}
	}	
}