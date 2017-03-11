/*			C:\Inetpub\wwwroot\ATDB_WS\Flash_Client\LoginForm.as
 * 
 * Class Name:	LoginForm
 * Description: The login form shown when the system start
 * Created By:	Ferry To
 * Created At:	Mon Mar 13 10:55:52 2006
 * Version:		1.1.0
 * Events:	
 * -	complete: indicate that the login process is complete
 */
import mx.services.*;
import mx.controls.Alert;

class LoginForm extends ATDB_Form
{
	private var loginBtnClick_lis:Object;

	/*===	Init function and constructor	===*/
	public function LoginForm()	
	{
		super();
		_winLink_str = "loginForm";
		_winTitle_str = "Login to test database system:";		
	}
	
	public function init():Void	
	{
		var self:Object = this;
		var _mc:MovieClip = win_mc.content;	

		win_mc.removeEventListener("click",winComplete_lis);
		win_mc.closeButton = false;

		_mc.ac_txt.maxChars = 5;
		_mc.pw_txt.maxChars = 10;
				
		loginBtnClick_lis = new Object();
		loginBtnClick_lis.click = function()
		{
			self.win_mc.content.login_btn.removeEventListener("click",this);
			_mc.login_btn.enabled = false;
			
			_mc.ac_txt.editable = false;
			_mc.pw_txt.editable = false;			
			_mc.err_lbl.text = "";
			self.execWebServices();
		}
		_mc.login_btn.addEventListener("click",loginBtnClick_lis);
		centerWindow();
		win_mc.visible = true;
	}
	
	/*===	Event dispatch functions	===*/
	public function notifyComplete():Void
	{
			/* This class will dispatch a "complete" event when login process complete */
			var complete_evt:Object = {target:this, type:"complete"};
			// Dispatch the complete event to notifty the completion of the login process
			dispatchEvent(complete_evt);		
	}	
	
	/*===	Callback and Handlers	===*/
	
	public function execWebServices():Void
	{
		var _mc:MovieClip = win_mc.content;
		var self:Object = this;
		
		_ws_call = _ws.Login(_mc.ac_txt.text,_mc.pw_txt.text); 
		_ws_call.onResult = function(result)
		{
			trace(result);
			if(result == true) { self.procLoginSucc(); } else { self.resetUI(); }
		}
	}
	
	public function procLoginSucc():Void
	{
		var self:Object = this;
		var click_lis:Object = new Object();
		click_lis.click = function()
		{
			// For user features pirority and concurrent edit control
			_global.GTID = self.win_mc.content.ac_txt.text.toLowerCase();
			trace("clicked");
			self.win_mc.deletePopUp();
			self.notifyComplete();
		}
		var dialog_win:Object = Alert.show("Login Success", "Notice:", Alert.OK, null, click_lis, "", Alert.OK);
		dialog_win.addEventListener("click",click_lis);
	}
	
	/*===	Independent functions	===*/
	
	public function resetUI():Void
	{
		var _mc:MovieClip = win_mc.content;
		_mc.ac_txt.editable = true;
		_mc.pw_txt.editable = true;
		_mc.pw_txt.text = "";
		_mc.login_btn.enabled = true;
		_mc.err_lbl.setStyle("color","0xFF0000");
		_mc.err_lbl.text = "Login failed, please try again";
		_mc.login_btn.addEventListener("click",loginBtnClick_lis);
	}

}