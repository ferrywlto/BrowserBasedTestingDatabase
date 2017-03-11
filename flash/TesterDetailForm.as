/*			C:\Inetpub\wwwroot\ATDB_WS\Flash_Client\TesterDetailForm.as
 * 
 * Class Name:	TesterDetailForm
 * Description: Form used to edit tester data
 * Created By:	Ferry To
 * Created At:	WThu Mar 23 17:28:39 2006
 * Version:		1.1.0
 * 
 * @usage   
 * @return  
 * 
 * Events:		None
 */
import mx.controls.*;
import mx.services.*;

class TesterDetailForm extends ATDB_DetailForm
{
	/* Listener objects*/ 
	private var updateBtnClick_lis:Object;

	/* Detail form specific variables */
	
	/*===	Init function and constructor	===*/	
	
	/* Detail_Form different from ATDB_Form in that Detail_Form constructor need to supply 
	 * the reference of their parent ATDB_Form */ 
	public function TesterDetailForm(_parentW:ATDB_Form,conID:String,conTable:String,conTester:String)
	{
		super(_parentW,conID,conTable,conTester);
		_winLink_str = "TesterForm_Detail";
		_winTitle_str = "Update Tester Data:";
	}
	
	public function init():Void
	{
		var self:Object = this;
		
		setFormUION(true);
		win_mc.content.err_lbl.setStyle("color",0xFF0000);
		centerWindow();
		
		updateBtnClick_lis = new Object();
		updateBtnClick_lis.click = function() { self.H_updateBtnClick(); };
		win_mc.content.update_btn.addEventListener("click",updateBtnClick_lis);
		
		/* This statement must be called */
		startLockRecord();
	}
	
	/* onEnterFrame initialization of forms */
	/*	None	*/
	
	/*===	Event dispatch functions 	===*/
	/*	None	*/	

	/*===	Callback and Handlers	===*/
	
	/*	Button Event Handlers	*/
	public function H_updateBtnClick():Void
	{
		var self:Object = this;
		var vaild:ATDB_Error = vaildateCreateForm();
		if(vaild.getCode() == 0)
		{	
			win_mc.content.err_lbl.text = ""; 
			win_mc.content.name_txt.enabled = false;
			win_mc.content.desc_txt.enabled = false;
			win_mc.content.update_btn.enabled = false;	
			win_mc.content.email_txt.enabled = false;
			_ws_call = _ws.Update_Tester(win_mc.content.name_txt.text,encodeText(win_mc.content.desc_txt.text),conID,win_mc.content.email_txt.text);			
			_ws_call.onResult = function(result) { self.H_WS_Update_Tester(result); };
		}
		else
		{
			win_mc.content.err_lbl.text = vaild.getMsg();
			win_mc.content.create_btn.enabled = true;
		}			
	}
	
	/*	Web Service result handlers	*/
	public function H_WS_Update_Tester(result):Void
	{
		var self:Object = this;
		if(result == true)
		{
			var alertClick_lis = function(evt_obj:Object) 
			{
				if(evt_obj.detail == Alert.OK)
				{
					self._parent_win.H_searchBtnClick();				
					self.killWindow();
				}
			};			
			Alert.show("Record updated successfully","Tester data:",Alert.OK,_root,alertClick_lis,"",Alert.OK);
		}
		else
		{
			Alert.show("Record updated failed, please try again.","Tester data:",Alert.OK,null,"",Alert.OK);			
		}

		trace(result);
	} 
	
	/* Function which must overrided in each class to wire-up the lock */
	public function H_WS_LockResult_Delegator(result):Void
	{
		var self:Object = this;
		_ws_call = _ws.Search_Tester("idTester",conID);			
		_ws_call.onResult = function(result) { self.H_WS_Search_Tester(result); };
	}
	
	public function H_WS_Search_Tester(result):Void
	{
		win_mc.content.id_txt.text = result.xmlNodes[0].childNodes[0].firstChild;
		win_mc.content.name_txt.text = result.xmlNodes[0].childNodes[1].firstChild;
		win_mc.content.desc_txt.text = decodeText(result.xmlNodes[0].childNodes[2].firstChild.toString());
		win_mc.content.email_txt.text = result.xmlNodes[0].childNodes[3].firstChild;
		if(!isEditable) setFormUION(false);
		_parent_win.setFormUION(true);
		win_mc.visible = true;
		
	}
	
	/*===	Independent functions	===*/	
	// Work with checkForInvaildChar, this function check for blank fields (overrided)
	public function vaildateCreateForm():ATDB_Error
	{
		win_mc.content.name_txt.text = trimString(win_mc.content.name_txt.text);	
		var tmpStr = win_mc.content.name_txt.text
		if(tmpStr == "" || !checkForInvaildChar(tmpStr))
			return new ATDB_Error(2,"Name field cannot blank or contain invaild characters");
			
		win_mc.content.desc_txt.text = trimString(win_mc.content.desc_txt.text);
		tmpStr = win_mc.content.desc_txt.text;
		if(tmpStr == "") // || !checkForInvaildChar(tmpStr))
			return new ATDB_Error(3,"Description field cannot blank or contain invaild characters");
			
		win_mc.content.email_txt.text = trimString(win_mc.content.email_txt.text);
		tmpStr = win_mc.content.email_txt.text;
		if(tmpStr == "" || !checkForInvaildChar(tmpStr))
			return new ATDB_Error(4,"Email field cannot blank or contain invaild characters");
						
		return new ATDB_Error(0,"");
	}
	// Only used to ease the UI control process of detail form (overrided)
	public function setFormUION(status:Boolean):Void
	{
		win_mc.content.id_txt.enabled = status;		
		win_mc.content.name_txt.enabled = status;
		win_mc.content.desc_txt.enabled = status;
		win_mc.content.update_btn.enabled = status;
		win_mc.content.email_txt.enabled = status;
	}	
	
	
}