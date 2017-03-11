/* Usage:
* SET:	
* 	var errObj:ATDB_Error =  new ATDB_Error(1,"ID Field cannot be blank or containing invaild characters.");
* GET:
* 	if(errObj.getCode() == 1)
* 		trace(errObj.getMsg());
*/
class ATDB_Error
{
	// Error Code
	private var errCode:Number;
	// Error Message
	private var errMsg:String;
	
	public function ATDB_Error(code:Number,msg:String)
	{
		errCode = code;
		errMsg = msg;
	}
	
	public function getCode(){return this.errCode;}
	public function getMsg(){return this.errMsg;}
}