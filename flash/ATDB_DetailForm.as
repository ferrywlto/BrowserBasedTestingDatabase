class ATDB_DetailForm extends ATDB_Form
{
	/* For general pupose */
	private var _parent_win:ATDB_Form;
	
	/* For concurrent access control */
	private var isEditable:Boolean;
	private var conID:String;
	private var conTable:String;
	private var conTester:String;
	
	/* For timeout control */
	private static var warnTime:Number = 1000*60*10;
	private static var stopTime:Number = 1000*60*5;
	private var warnInterID:Number;
	private var stopInterID:Number;
	
	public function ATDB_DetailForm(_parent:ATDB_Form,_conID:String,_conTable:String,_conTester:String)
	{
		super();
		_parent_win = _parent;
		warnInterID = setInterval(this,"H_IN_Warning",warnTime);
		
		/* Concurrent access control */
		conID = _conID;
		conTable = _conTable;
		conTester = _conTester;
		
	}
	
	public function startLockRecord()
	{
		var self:Object = this;
		//Check for target is locked 
		_ws_call = _ws.lockRecord(conID,conTable,conTester);			
		_ws_call.onResult = function(result) { self.H_WS_lockRecord(result); };		
	}
	
		
	/* Web Service resulf for check record locking */
	/* Result returned will have the following properties:
	*  msg:String
	*  code:Number */
	public function H_WS_lockRecord(result)
	{
		trace("------------ H_WS_lockRecord (Start) ---------------");
		trace("result.msg:"+typeof(result.msg)+" = "+result.msg);
		trace("result.code:"+typeof(result.code)+" = "+result.code);
		trace("------------ H_WS_lockRecord ( End ) ---------------");
		
		if(result.code == 0) {
			isEditable = true;
		}
		else{
			isEditable = false;
			win_mc.content.err_lbl.text = result.msg;
		}
	
		H_WS_LockResult_Delegator(result);
	}

	/* Function which must overrided in each class to wire-up the lock */
	public function H_WS_LockResult_Delegator(result):Void
	{
	}	
	
	/* All subclass of ATDB_Form can override this function to provide
	* other process before window close */
	private function killWindow():Void
	{
		var self:Object = this;
		/* Just remember to call destory() even this function is overrided */
		if(isEditable)
		{
			trace(conID);
			trace(_global.GTID);
			_ws_call = _ws.unlockRecord(conID,conTable,conTester);			
			_ws_call.onResult = function(result) { self.H_WS_unlockRecord(result); };
		}
		else
		{
			destory();
		}
	}
	/* Concurrent access control */
	public function H_WS_unlockRecord(result)
	{
		trace("------------ H_WS_unlockRecord (Start) ---------------");
		trace("result.msg:"+typeof(result.msg)+" = "+result.msg);
		trace("result.code:"+typeof(result.code)+" = "+result.code);
		trace("------------ H_WS_unlockRecord ( End ) ---------------");
		
		if(result.code == 0)
			destory();
		else{
			win_mc.content.err_lbl.text = result.msg;
			destory();}
	}
	
	/* Note: Subclass of DetailForm should have err_lbl (Label) */
	/* For concurrent access control and time-out control */
	public function H_IN_Warning():Void
	{
		clearInterval(warnInterID);
		win_mc.content.err_lbl.text = "You must submit your changes within 5 mins or it will expire.";
		stopInterID = setInterval(this,"H_IN_Stop",stopTime);
	}
	public function H_IN_Stop():Void
	{
		clearInterval(stopInterID);
		win_mc.content.err_lbl.text = "Sorry, your session expired. Plesae start again.";
		win_mc.content.update_btn.enabled = false;
	}
}