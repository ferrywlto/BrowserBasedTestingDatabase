/*			C:\Inetpub\wwwroot\ATDB_WS\Flash_Client\ATDB_Form.as
 * 
 * Class Name:	ATDB_Form
 * Description: Base class of all form used in ATDB System
 * Created By:	Ferry To
 * Created At:	Mon Mar 13 10:55:52 2006
 * Version:		1.1.0
 * Events:		None
 */
import mx.containers.Window;
import mx.managers.PopUpManager;
import mx.events.EventDispatcher; //Must  include this package in order to generate events
import mx.services.*;

class ATDB_Form
{
	// Port 1295 is used for debug purpose
	private static var _ws_str:String = "http://localhost:3220/ATDB_WS/ATDB_WebServices.asmx?WSDL";
	// Deployment Connection String to Web Services
	//private static var _ws_str:String = "http://server08:8080/ATDB_WebServices.asmx?WSDL";
	/* For attach movie */
	private static var _winLink_str:String;
	private static var _winTitle_str:String;
	
	/* For web services */
	private static var _ws:WebService;
	private static var _ws_log:Log;
	private static var _ws_call:PendingCall;
	
	/* Static variables */
	public static var winXOffset:Number = 10;
	public static var winYOffset:Number = 30;
	
	/* Instance variables */
	public var win_mc:MovieClip;
	public var winComplete_lis:Object;
	
	// 3 functions that link up to EventDispatcher class, all class that can throw custom event must declare these.
 	public function dispatchEvent() {};
 	public function addEventListener() {};
 	public function removeEventListener() {};
	
	// Constructor must call initialize to link up this class with EventDispatcher class
	public function ATDB_Form()
	{
		// Setup web services and its log
		_ws_log = new Log();
		_ws_log.onLog = function(msg : String) : Void {trace(msg);}		
		_ws = new WebService(_ws_str,_ws_log);			
		
		mx.events.EventDispatcher.initialize(this);
	}

	/* 
	Therefore, all subclass of this class can dispatch custom event by calling super() to invoke the constructor
	of this base class and with the following statements: 
	
	You must specify a target property and then name of the event or the event “type” property in the event object
	var eventObject:Object = {target:this, type:'drawn'};  
	dispatchEvent(eventObject);
	*/

	/*===	Init function and constructor	===*/
	public function createWindow(mcLink_str:String, winTitle_str:String, isModal:Boolean):Void
	{
		win_mc = PopUpManager.createPopUp(_root,Window,isModal);
		win_mc.visible = false; 
		win_mc.title = winTitle_str;
		win_mc.closeButton = true;
		win_mc.contentPath = mcLink_str;

		var self:Object = this;
		winComplete_lis = new Object();
		winComplete_lis.complete = function(evt_obj:Object)
		{
			self.win_mc.content.onEnterFrame = function ()
			{	
				//trace("content onEnterFrame:");
				self.win_mc.content.onEnterFrame = null;
				self.init();
			}
		}
		winComplete_lis.click = function()
		{
			self.killWindow();
		}
		win_mc.addEventListener("complete",winComplete_lis);
		win_mc.addEventListener("click",winComplete_lis);
	}
	
	private function destory():Void
	{
		win_mc.deletePopUp();
		delete this;
	}
	
	/* All subclass of ATDB_Form can override this function to provide
	* other process before window close */
	private function killWindow():Void
	{
		/* Just remember to call this even this function is overrided */
		destory();
	}
	public function init():Void
	{
		trace("atdb_init");
	}
	
	/*===	Event dispatch functions	===*/
	/*	None	*/
	
	/*===	Callback and Handlers	===*/
	/*	None	*/
	
	/*===	Independent functions	===*/
	
	public function show(isModal:Boolean):Void
	{
		createWindow(_winLink_str,_winTitle_str,isModal);		
	}
	
	public function centerWindow():Void
	{
		trace(arguments.caller+":centerWindow");
		win_mc.setSize(winXOffset+win_mc.content._width,winYOffset+win_mc.content._height);
		win_mc.move((Stage.width-win_mc.width)/2,(Stage.height-win_mc.height)/2);		
	}
	
	// Make the combo box selected index to the one equal to inputted value
	public function getComboBoxIndexByValue(_cb:mx.controls.ComboBox,_value:Object):Void
	{
		// trace("============== getComboBoxIndexByValue ================");
		for(var i:Number = 0; i<_cb.length; i++)
		{
			/* For debugging purpose */
			
			var tmpStr:String = "index:"+i;
			tmpStr += " cbValue:" + _cb.getItemAt(i).data;
			tmpStr += " input:" + _value;
			tmpStr += " equal:" + (_cb.getItemAt(i).data.toString() == _value.toString()); // Notice this statement!
			tmpStr += " typeof:" + typeof(_cb.getItemAt(i).data) + " " + typeof(_value);
			trace(tmpStr);
			
			/* have to convert to string in order to compare each other, otherwise they're both objects and can't compare them */
			if(_cb.getItemAt(i).data.toString() == _value.toString())
			{
				_cb.selectedIndex = i;
			//	trace("============== getComboBoxIndexByValue(END) ===========");
				return;
			}
		}
		// trace("============== getComboBoxIndexByValue(END) ===========");
	}		
	// No characters that may cause database error allowed
	public function checkForInvaildChar(str:String):Boolean
	{
		var invaildChars:Array = new Array("\"","'","\'","\\","<",">","&");
		for(var i:Number=0; i<invaildChars.length; i++)
		{
			var index = str.indexOf(invaildChars[i]);
			//trace(invaildChars[i]+":"+index);
			if(index != -1)
				return false;
		}
		return true;
	}
	/*===	Independent functions	===*/	
	public function trimString(_str:String):String
	{
		var _resultStr:String = _str;
		// kill tailing spaces
		var idx:Number = _resultStr.length;
		for(var i:Number=_resultStr.length-1; i>=0; i--)
		{
			if(_resultStr.charAt(i) == " ")
				idx--;
			else
				break;
		}
		if(idx != 0)
			_resultStr = _resultStr.substring(0,idx);
			
		//trace("kill tail:'"+_resultStr+"'");
		
		// kill leading spaces
		idx = 0;
		for(var j:Number=0; j<_resultStr.length; j++)
		{
			if(_resultStr.charAt(j) == " ")
				idx++;
			else
				break;
		}
		_resultStr = _resultStr.substring(idx,_resultStr.length);
		
		if(_resultStr == " ") _resultStr = "";
		
		trace("return string:'"+_resultStr+"'");
		return _resultStr;
	}

	public function convertChars(input:String,from:String,to:String):String
	{
		trace(input);
		
		var head_str:String;
		var tail_str:String;
		var index:Number = input.indexOf(from);
		while(index != -1)
		{
			head_str = input.substring(0,index);
			tail_str = input.substring(index+from.length,input.length);
			input = head_str + to + tail_str;
			index = input.indexOf(from);
		}
		return input;
	}
	
	public function convertDoubleQuote_Forward(_str:String):String
	{
		return convertChars(_str,"\"","[dq]");
	}
	
	public function convertDoubleQuote_Backward(_str:String):String
	{
		return convertChars(_str,"[dq]","\"");		
	}

	public function convertSingleQuote_Forward(_str:String):String
	{
		return convertChars(_str,"\'","[sq]");		
	}

	public function convertSingleQuote_Backward(_str:String):String
	{
		return convertChars(_str,"[sq]","\'");		
	}
	
	public function convertBackSlash_Forward(_str:String):String
	{
		return convertChars(_str,"\\","[bs]");		
	}	

	public function convertBackSlash_Backward(_str:String):String
	{
		return convertChars(_str,"[bs]","\\");		
	}

	public function convertAmpersand_Forward(_str:String):String
	{
		return convertChars(_str,"&","[am]");		
	}	

	public function convertAmpersand_Backward(_str:String):String
	{
		return convertChars(_str,"[am]","&");		
	}

	public function convertGreaterThan_Forward(_str:String):String
	{
		return convertChars(_str,">","[gt]");		
	}	

	public function convertGreaterThan_Backward(_str:String):String
	{
		return convertChars(_str,"[gt]",">");		
	}	
	
	public function convertLessThan_Forward(_str:String):String
	{
		return convertChars(_str,"<","[lt]");		
	}	

	public function convertLessThan_Backward(_str:String):String
	{
		return convertChars(_str,"[lt]","<");		
	}

	public function encodeText(_str:String):String
	{
		_str = convertSingleQuote_Forward(_str);
		_str = convertDoubleQuote_Forward(_str);
		_str = convertBackSlash_Forward(_str);
		_str = convertAmpersand_Forward(_str);
		_str = convertGreaterThan_Forward(_str);
		_str = convertLessThan_Forward(_str);
		
		return _str;
	}

	public function decodeText(_str:String):String
	{
		_str = convertSingleQuote_Backward(_str);
		_str = convertDoubleQuote_Backward(_str);
		_str = convertBackSlash_Backward(_str);
		_str = convertAmpersand_Backward(_str);
		_str = convertGreaterThan_Backward(_str);
		_str = convertLessThan_Backward(_str);
		
		return _str
	}


	public function trimAllSpace(_str:String):String
	{
		var tmpStr:String = trimString(_str);
		var tmpArr:Array = tmpStr.split(" ");
		var resultStr:String = "";
		for(var i=0; i<tmpArr.length; i++)
		{
			resultStr += tmpArr[i];
		}
		return resultStr;
	}	
	public function traceAll(obj:Object):Void
	{
		for(var str:String in obj)
			trace(str);
	}
	public function setFormUION(status:Boolean):Void{}
}