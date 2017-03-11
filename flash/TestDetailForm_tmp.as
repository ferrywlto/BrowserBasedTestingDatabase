
	/* Listener objects*/ 
	private var categoryChange_lis:Object;
	
	/* Listener objects*/ 
	private var searchBtnClick_lis:Object;
	private var addBtnClick_lis:Object;
	private var removeBtnClick_lis:Object;
	private var submitBtnClick_lis:Object;
	
	
	//private var addBtnClick_lis:Object;
	/* Used to store web service result */
	private var _nodes:XML;
	
	/* TestCaseDetailForm specific variables */
	private var tID_str:String;
		
	/*===	Init function and constructor	===*/	
	
	/* Detail_Form different from ATDB_Form in that Detail_Form constructor need to supply 
	 * the reference of their parent ATDB_Form */ 
	public function TestDetailForm(_parentW:ATDB_Form,conID:String,conTable:String,conTester:String,tID:String)
	{
		super(_parentW,conID,conTable,conTester);
			
		_winLink_str = "TestForm_Detail_M";
		_winTitle_str = "Update Test Data:";
		tID_str = tID;
		trace("Construtor->conID:"+conID);
	}	
	public function init():Void
	{
		//id_txt , softVer_cb, description_txt, search_list, search_txt, search_btn,search_lbl , search_grid,
		//submit_btn, add_btn, remove_btn , dateStart_txt, dateEnd_txt,
		
		var self:Object = this;
		win_mc.content.id_txt.enabled = false;		
		setFormUION(true);

		win_mc.content.err_lbl.setStyle("color",0xFF0000);
		centerWindow();
		
		//setFormUION(false);
		
		submitBtnClick_lis = new Object();
		submitBtnClick_lis.click = function() { self.H_submitBtnClick(); };
		win_mc.content.submit_btn.addEventListener("click",submitBtnClick_lis);
		
		searchBtnClick_lis = new Object();
		searchBtnClick_lis.click = function(){self.H_searchBtnClick();};
		win_mc.content.search_btn.addEventListener("click",searchBtnClick_lis);

		addBtnClick_lis = new Object();
		addBtnClick_lis.click = function(){self.H_addBtnClick();};
		win_mc.content.add_btn.addEventListener("click",addBtnClick_lis);
		
		/* This statement must be called */
		startLockRecord();
	}
	
	public function H_addBtnClick():Void
	{
		trace("H_addBtnClick:");
		
	}
	
	public function getTest()
	{
		var self:Object = this;
		// Calling web service to get Test Type
		_ws_call = _ws.Get_Test_By_ID(conID);			
		_ws_call.onResult = function(result) { self.H_WS_Get_Test_By_ID(result); };					
	}	
	public function getSoftwareVersion()
	{
		var self:Object = this;
		// Calling web service to get Category
		_ws_call = _ws.Get_Category();			
		_ws_call.onResult = function(result) { self.H_WS_Get_Category(result); };		
	}
	
	/* onEnterFrame initialization of forms */
	/*	None	*/
	
	/*===	Event dispatch functions 	===*/
	/*	None	*/	

	/*===	Callback and Handlers	===*/
	
	public function H_WS_Get_Test_By_ID(result):Void
	{
		trace("::undefined?::"+result);
		trace("xmlNodes:"+result.xmlNodes);
		trace("result.xmlNodes.length:"+result.xmlNodes.length);
		for(var i = 0; i<result.xmlNodes.length; i++)
		{
			trace("result.xmlNodes["+i+"].length"+result.xmlNodes[i].childNodes.length);
			for(var j = 0; j<result.xmlNodes[i].childNodes.length; j++)
			{
				trace("H_WS_Get_Test_By_ID:"+result.xmlNodes[i].childNodes[j].firstChild);
			}
		}
		win_mc.visible = true;
	}
	
	/* Function which must overrided in each class to wire-up the lock */
	public function H_WS_LockResult_Delegator(result):Void
	{
		getTest();
	}	
	/* UIs event handler */
	public function H_searchBtnClick():Void
	{
		/*
		var self:Object = this;
		var vaild:ATDB_Error = vaildateCreateForm();
		
		if(vaild.getCode() == 0)
		{	
			setFormUION(false);
			if(win_mc.content.script_txt.text == "")
			{
				//H_WS_checkTestScriptID(true);
			}
			else
			{
				//_ws_call = _ws.checkTestScriptID(win_mc.content.script_txt.text);			
				//_ws_call.onResult = function(result) { self.H_WS_checkTestScriptID(result); };			
			}
		}
		else
		{
			setFormUION(true);
			win_mc.content.err_lbl.text = vaild.getMsg();
		}
		*/
		trace("search btn pressed");
		var tg:DataGrid = win_mc.content.testcase_grid;
		var sg:DataGrid = win_mc.content.search_grid;
		var dup:Boolean = false;
		var add:Boolean = true;
		trace(sg.selectedIndices.length);
		for(var i=0; i<sg.selectedIndices.length; i++)
		{
			//trace("selectedIDs:"+win_mc.content.search_grid.selectedItems[i].ID);
			trace(tg.length);
			dup = false;
			for(var j=0; j<tg.length; j++)
			{
				trace("tg.getItemAt(j).ID:"+tg.getItemAt(j).ID);
				trace("sg.getItemAt(sg.selectedIndices[i]).ID:"+sg.getItemAt(sg.selectedIndices[i]).ID);
				dup = (tg.getItemAt(j).ID == sg.getItemAt(sg.selectedIndices[i]).ID);
				trace("dup:"+dup);
				if(dup)
				{	
					break;
				}
				//else
				//{
				///	continue;
				//}
			}
			if(!dup) tg.addItem(sg.getItemAt(sg.selectedIndices[i]));
				
		}
		for(var i=0; i<win_mc.content.search_grid.selectedIndices.length; i++)
		{
		//	win_mc.content.search_grid.removeItemAt(win_mc.content.search_grid.selectedIndices[i]);
		}
	}	
	public function H_submitBtnClick():Void
	{
		/*
		var self:Object = this;
		var vaild:ATDB_Error = vaildateCreateForm();
		
		if(vaild.getCode() == 0)
		{	
			setFormUION(false);
			if(win_mc.content.script_txt.text == "")
			{
				//H_WS_checkTestScriptID(true);
			}
			else
			{
				//_ws_call = _ws.checkTestScriptID(win_mc.content.script_txt.text);			
				_ws_call.onResult = function(result) { self.H_WS_checkTestScriptID(result); };			
			}
		}
		else
		{
			setFormUION(true);
			win_mc.content.err_lbl.text = vaild.getMsg();
		}	
		*/
		win_mc.content.testcase_grid.addColumn("ID");
		win_mc.content.testcase_grid.addColumn("Software_Version");
		win_mc.content.testcase_grid.addColumn("Creator");
		win_mc.content.testcase_grid.addColumn("Start_Date");
		win_mc.content.testcase_grid.addColumn("End_Date");
		win_mc.content.testcase_grid.addColumn("Description");
		win_mc.content.testcase_grid.addColumn("Status");
		
		win_mc.content.search_grid.addColumn("ID");
		win_mc.content.search_grid.addColumn("Software_Version");
		win_mc.content.search_grid.addColumn("Creator");
		win_mc.content.search_grid.addColumn("Start_Date");
		win_mc.content.search_grid.addColumn("End_Date");
		win_mc.content.search_grid.addColumn("Description");
		win_mc.content.search_grid.addColumn("Status");

		win_mc.content.search_grid.getColumnAt(0).width = 80;
		win_mc.content.search_grid.getColumnAt(1).width = 80;
		win_mc.content.search_grid.getColumnAt(2).width = 80;
		win_mc.content.search_grid.getColumnAt(3).width = 80;
		win_mc.content.search_grid.getColumnAt(4).width = 80;
		win_mc.content.search_grid.getColumnAt(5).width = 80;
		win_mc.content.search_grid.getColumnAt(6).width = 80;		
		
		for(var i=0; i<500; i++)
		{
			var tmp:Object = new Object();
			tmp.ID = i;
			tmp.Software_Version = i;
			tmp.Creator = i;
			tmp.Start_Date = i;
			tmp.End_Date = i;
			tmp.Description = i;
			tmp.Status = i;
			win_mc.content.search_grid.addItem(tmp);
		}
		
		win_mc.content.search_grid.multipleSelection = true;
		/* For testing array to web service only 
		trace("SUBMIT BTN CLICK:");
		var self:Object = this;
		var arr:Array = new Array();
		var tobj:Object = new Object();
		tobj.a= "tesr";
		tobj.b= 1;
		arr.push(tobj);
		
		//_ws_call = _ws.testArray(new Array("idTestCase","tcVersionID","tcTester","scName","cName","tcScript","ttName","tcDescription","tcProcedure","tcExpectedResult","tcSanity","tcManTestCount","tcDate"));			
		_ws_call = _ws.testArray2(arr);
		_ws_call.onResult = function(result) { self.H_WS_testArray(result); };			
		*/
	}
	
	public function H_WS_testArray(result):Void
	{
		trace("TEST ARRAY RESULT:"+result);
	}

	/* Web Service result handlers */
	
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
		win_mc.content.description_txt.text = encodeText(trimString(win_mc.content.description_txt.text));
		tmpStr = win_mc.content.description_txt.text;
		if(tmpStr == "" || !checkForInvaildChar(tmpStr))
			return new ATDB_Error(2,"Description field cannot be blank or contain invaild characters.");
			
		win_mc.content.procedure_txt.text = encodeText(trimString(win_mc.content.procedure_txt.text));
		tmpStr = win_mc.content.procedure_txt.text;	
		if(tmpStr == "" || !checkForInvaildChar(tmpStr))
			return new ATDB_Error(3,"Procedure field cannot be blank or contain invaild characters.");
		
		win_mc.content.expect_txt.text = encodeText(trimString(win_mc.content.expect_txt.text));
		tmpStr = win_mc.content.expect_txt.text;
		if(tmpStr == "" || !checkForInvaildChar(tmpStr))
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
		win_mc.content.id_txt.enabled = status;//id_txt
		win_mc.content.description_txt.enabled = status;//description_txt,
		win_mc.content.search_txt.enabled = status;// search_txt
		
		win_mc.content.search_list.enabled = status;//search_list
		
		win_mc.content.search_grid.enabled = status;//search_grid,
		win_mc.content.testcase_grid.enabled = status;
		
		win_mc.content.softVer_cb.enabled = status;//softVer_cb
		
		win_mc.content.add_btn.enabled = status;//add_btn
		win_mc.content.remove_btn.enabled = status;	//remove_btn		
		win_mc.content.search_btn.enabled = status;//search_btn
		win_mc.content.submit_btn.enabled = status;//submit_btn
		
		// Labels dont need to editable
		//win_mc.content.search_lbl.enabled = status;//search_lbl
		//win_mc.content.err_lbl.enabled = status;//err_lbl
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
		win_mc.visible = true;
	}	