/*			C:\Inetpub\wwwroot\ATDB_WS\Flash_Client\TestCaseDetailForm.as
 * 
 * Class Name:	TesterDetailForm
 * Description: Form used to edit testcase
 * Created By:	Ferry To
 * Modified At:	Wed Apr 19 10:05:35 2006
 * Version:		1.2.0
 * 
 * @usage   
 * @return  
 * 
 * Events:		None
 */
import mx.controls.*;
import mx.services.*;

class TestCaseDetailForm extends ATDB_DetailForm
{
	/* Listener objects*/ 
	private var categoryChange_lis:Object;
	
	/* Listener objects*/ 
	private var updateBtnClick_lis:Object;
	
	/* Used to store web service result */
	private var _nodes:XML;
	
	/* TestCaseDetailForm specific variables */
	private var tID_str:String;
	private var tVer_int:Number;
	
	/*===	Init function and constructor	===*/	
	
	/* Detail_Form different from ATDB_Form in that Detail_Form constructor need to supply 
	 * the reference of their parent ATDB_Form */ 
	public function TestCaseDetailForm(_parentW:ATDB_Form,conID:String,conTable:String,conTester:String,tID:String,tVer:Number)
	{
		super(_parentW,conID,conTable,conTester);
			
		_winLink_str = "TestCaseForm_Detail";
		_winTitle_str = "Update Testcase Data:";
		tID_str = tID;
		tVer_int = tVer;
		trace("TestCaseDetailForm Construtor->conID:"+conID);
	}	
	public function init():Void
	{
		var self:Object = this;
		win_mc.content.id_txt.enabled = false;		
		setFormUION(true);
		trace("TestCaseDetailForm Construtor->conID:"+conID);
		win_mc.content.sanity_cb.addItem({label:"Y",data:1});
		win_mc.content.sanity_cb.addItem({label:"N",data:0});
		win_mc.content.count_ns.maximum = 5;
		win_mc.content.count_ns.minimum = 1;
		win_mc.content.count_ns.stepSize = 1;
		win_mc.content.count_ns.value = 1;
		win_mc.content.err_lbl.setStyle("color",0xFF0000);
		centerWindow();
		
		setFormUION(false);
		
		updateBtnClick_lis = new Object();
		updateBtnClick_lis.click = function() { self.H_updateBtnClick(); };
		win_mc.content.create_btn.addEventListener("click",updateBtnClick_lis);
		
		categoryChange_lis = new Object();
		categoryChange_lis.change = function(){self.H_category_Change();};
		win_mc.content.category_cb.addEventListener("change",categoryChange_lis);
		
		/* This statement must be called */
		startLockRecord();
	}
	public function getTestType()
	{
		var self:Object = this;
		// Calling web service to get Test Type
		_ws_call = _ws.Get_TestType();			
		_ws_call.onResult = function(result) { self.H_WS_Get_TestType(result); };					
	}	
	public function getCategory()
	{
		var self:Object = this;
		// Calling web service to get Category
		_ws_call = _ws.Get_Category();			
		_ws_call.onResult = function(result) { self.H_WS_Get_Category(result); };		
	}
	public function getSubCategory(index:Number)
	{
		var self:Object = this;
		// Calling web service to get SubCategory
		trace("getSubCategory:"+index);
		_ws_call = _ws.Get_SubCategory(index);			
		_ws_call.onResult = function(result) { self.H_WS_Get_SubCategory(result); };		
	}
	public function getTestCase()
	{
		var self:Object = this;
		// Calling web service to get TestCase
		_ws_call = _ws.Get_TestCase_By_ID_VERSION(tID_str,tVer_int);					
		_ws_call.onResult = function(result) { self.H_WS_Get_TestCase_By_ID(result); };		
	}
	/* onEnterFrame initialization of forms */
	/*	None	*/
	
	/*===	Event dispatch functions 	===*/
	/*	None	*/	

	/*===	Callback and Handlers	===*/
	/* Function which must overrided in each class to wire-up the lock */
	public function H_WS_LockResult_Delegator(result):Void
	{
		getTestCase();
	}	
	/* UIs event handler */
	public function H_updateBtnClick():Void
	{
		var self:Object = this;
		var vaild:ATDB_Error = vaildateCreateForm();
		
		if(vaild.getCode() == 0)
		{	
			setFormUION(false);
			if(win_mc.content.script_txt.text == "")
			{
				H_WS_checkTestScriptID(true);
			}
			else
			{
				_ws_call = _ws.checkTestScriptID(encodeText(win_mc.content.script_txt.text));			
				_ws_call.onResult = function(result) { self.H_WS_checkTestScriptID(result); };			
			}
		}
		else
		{
			setFormUION(true);
			win_mc.content.err_lbl.text = vaild.getMsg();
		}	
	}
	public function H_category_Change():Void
	{
		var self:Object = this;
		
		// Calling web service to get SubCategory
		_ws_call = _ws.Get_SubCategory(win_mc.content.category_cb.selectedItem.data);			
		_ws_call.onResult = function(result) { self.H_WS_Get_SubCategory_Change(result); };		
	}	

	/* Web Service result handlers */
	
	// Caution!!
	// Duplicated function for handle the category change event from H_category_Change
	public function H_WS_Get_SubCategory_Change(result):Void
	{
		var self:Object = this;
		win_mc.content.subCat_cb.removeAll();
		for(var i=0; i<result.xmlNodes.length; i++)
		{
			var tmpObj:Object = new Object();
			tmpObj.label = result.xmlNodes[i].childNodes[1].firstChild;
			tmpObj.data = result.xmlNodes[i].childNodes[0].firstChild;
			win_mc.content.subCat_cb.addItem(tmpObj);
		}
	}	
	public function H_WS_checkTestScriptID(result):Void
	{
		var self:Object = this;
		
		if(result == false)
		{
			setFormUION(true);
			win_mc.content.err_lbl.text = "Test Script ID not found.";
		}
		else
		{
			win_mc.content.err_lbl.text = "";
			
			var params:Array = new Array();
			
			params[0] = win_mc.content.subCat_cb.selectedItem.data;
			params[1] = win_mc.content.category_cb.selectedItem.data;
			params[2] = encodeText(win_mc.content.script_txt.text);
			params[3] = win_mc.content.testType_cb.selectedItem.data;
			params[4] = encodeText(win_mc.content.description_txt.text);
			params[5] = encodeText(win_mc.content.procedure_txt.text);
			params[6] = encodeText(win_mc.content.expect_txt.text);
			params[7] = win_mc.content.sanity_cb.selectedItem.data;
			params[8] = win_mc.content.count_ns.value;	
			params[9] = win_mc.content.id_txt.text;
			
			//For debugging purpose
			for(var i=0; i<10; i++)
				trace(params[i]);
			//(int subCategory, int category, string script, int type, string desc, string proc, string result, int sanity, int count, string id)			
		
			_ws_call = _ws.Update_Testcase(params[0],params[1],params[2],params[3],params[4],params[5],params[6],params[7],params[8],params[9],_global.GTID);						
			_ws_call.onResult = function(result) { self.H_WS_Update_Testcase(result); };
			_ws_call.onFault = function(fault) 
			{
				trace("Fault Code:"+fault.faultcode);
				trace("Fault Msg:"+fault.faultstring);
				trace("Fault Cause:"+fault.faultactor);
				trace("Detail:"+fault.detail);
			};
		}
	}
	public function H_WS_Update_Testcase(result):Void
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
			setFormUION(true);
			Alert.show("Record updated failed, please try again.","Tester data:",Alert.OK,null,"",Alert.OK);			
		}
		//trace("H_WS_Update_Testcase:"+result);
	}	
	public function H_WS_Get_TestCase_By_ID(result):Void
	{
	//	For debugging purpose only
		for(var i=0; i<10; i++)
			trace(":"+i+":"+result.xmlNodes[0].childNodes[i].firstChild);
		
		_nodes = result.xmlNodes[0].childNodes;
		setFormUION(true);
		getTestType();
	}
	// Call when Get_TestType web service has executed and returned result
	public function H_WS_Get_TestType(result):Void
	{
		var self:Object = this;
		for(var i=0; i<result.xmlNodes.length; i++)
		{
			var tmpObj:Object = new Object();
			tmpObj.label = result.xmlNodes[i].childNodes[1].firstChild;
			tmpObj.data = result.xmlNodes[i].childNodes[0].firstChild;
			win_mc.content.testType_cb.addItem(tmpObj);
		}
		self.getCategory();
	}	
	// Call when Get_Category web service has executed and returned result
	public function H_WS_Get_Category(result):Void
	{
		var self:Object = this;
		for(var i=0; i<result.xmlNodes.length; i++)
		{
			var tmpObj:Object = new Object();
			tmpObj.label = result.xmlNodes[i].childNodes[1].firstChild;
			tmpObj.data = result.xmlNodes[i].childNodes[0].firstChild;
			win_mc.content.category_cb.addItem(tmpObj);
			trace("H_WS_Get_Category ->["+i+"] label:"+tmpObj.label+" data:"+tmpObj.data);
		}
		// _nodes[2].firstChild <- main category of the test case, its a string from result XML
		// getTestCase should be called already to ensure _nodes filled with required data
		self.getSubCategory(parseInt(_nodes[4].firstChild));
	}
	// Call when Get_SubCategory web service has executed and returned result
	public function H_WS_Get_SubCategory(result):Void
	{
		var self:Object = this;
		win_mc.content.subCat_cb.removeAll();
		for(var i=0; i<result.xmlNodes.length; i++)
		{
			var tmpObj:Object = new Object();
			tmpObj.label = result.xmlNodes[i].childNodes[1].firstChild;
			tmpObj.data = result.xmlNodes[i].childNodes[0].firstChild;
			win_mc.content.subCat_cb.addItem(tmpObj);
		}
		// The statement inserted here was just for special arrangement for this specific form.
		// In general framework, this statement should not exist
		self.loadDataBackToUI();
	}

	/*===	Independent functions	===*/	
	
	// Work with checkForInvaildChar, this function check for blank fields
	public function vaildateCreateForm():ATDB_Error
	{
		var tmpStr:String = "";
		/*		no need for detail form as ID cannot be changed
		win_mc.content.id_txt.text = trimAllSpace(win_mc.content.id_txt.text);
		tmpStr = win_mc.content.id_txt.text;
		if(tmpStr == "" || !checkForInvaildChar(tmpStr))
			return new ATDB_Error(1,"ID Field cannot be blank or containing invaild characters.");
		*/
		win_mc.content.description_txt.text = trimString(win_mc.content.description_txt.text);
		tmpStr = win_mc.content.description_txt.text;
		if(tmpStr == "") // || !checkForInvaildChar(tmpStr))
			return new ATDB_Error(2,"Description field cannot be blank or contain invaild characters.");
			
		win_mc.content.procedure_txt.text = trimString(win_mc.content.procedure_txt.text);
		tmpStr = win_mc.content.procedure_txt.text;	
		if(tmpStr == "") // || !checkForInvaildChar(tmpStr))
			return new ATDB_Error(3,"Procedure field cannot be blank or contain invaild characters.");
		
		win_mc.content.expect_txt.text = trimString(win_mc.content.expect_txt.text);
		tmpStr = win_mc.content.expect_txt.text;
		if(tmpStr == "") // || !checkForInvaildChar(tmpStr))
			return new ATDB_Error(4,"Expected result field cannot be blank or contain invaild characters.");
		
		win_mc.content.script_txt.text = trimString(win_mc.content.script_txt.text);
		tmpStr = win_mc.content.script_txt.text;
		if(!checkForInvaildChar(tmpStr))
			return new ATDB_Error(5,"Script field cannot contain invaild characters.");
					
		return new ATDB_Error(0,"");
	}
	// Only used to ease the UI control process of detail form
	public function setFormUION(status:Boolean):Void
	{
		win_mc.content.script_txt.enabled = status;
		win_mc.content.description_txt.enabled = status;
		win_mc.content.expect_txt.enabled = status;
		win_mc.content.procedure_txt.enabled = status;
		win_mc.content.sanity_cb.enabled = status;
		win_mc.content.category_cb.enabled = status;
		win_mc.content.subCat_cb.enabled = status;
		win_mc.content.testType_cb.enabled = status;
		win_mc.content.create_btn.enabled = status;			
		win_mc.content.count_ns.enabled = status;
	}
	
	// As named, load the data received from web service call back to UIs
	// Should be called after data received from web service call
	public function loadDataBackToUI():Void
	{
		for(var i = 0; i<12; i++)
			trace("LoadDataBackToUI->_nodes["+i+"]:"+_nodes[i].firstChild);
			
		var _mc:MovieClip = win_mc.content;
		
		// Script
		if(_nodes[5].firstChild == null)
			_mc.script_txt.text = "";
		else
			_mc.script_txt.text = _nodes[5].firstChild;
		// ID	
		_mc.id_txt.text 		= _nodes[0].firstChild;	
		// Description
		if(_nodes[7].firstChild == null)
			_mc.description_txt.text= "";
		else
			_mc.description_txt.text= decodeText(_nodes[7].firstChild.toString());
		// Procedure
		if(_nodes[8].firstChild == null)
			_mc.procedure_txt.text 	= "";
		else
			_mc.procedure_txt.text= decodeText(_nodes[8].firstChild.toString());
		// Expected Result	
		if(_nodes[9].firstChild == null)
			_mc.expect_txt.text 	= "";
		else
			_mc.expect_txt.text= decodeText(_nodes[9].firstChild.toString());
		// Count	
		_mc.count_ns.value 		= parseInt(_nodes[11].firstChild);
		
		getComboBoxIndexByValue(_mc.testType_cb	,_nodes[6].firstChild);
		getComboBoxIndexByValue(_mc.sanity_cb	,_nodes[10].firstChild);
		
		// Need more care on these two function call
		getComboBoxIndexByValue(_mc.category_cb	,_nodes[4].firstChild);
		getComboBoxIndexByValue(_mc.subCat_cb	,_nodes[3].firstChild);
		
		if(isEditable)
			setFormUION(true);
		else
			setFormUION(false);
		_parent_win.setFormUION(true);	
		win_mc.visible = true;
	}
}
