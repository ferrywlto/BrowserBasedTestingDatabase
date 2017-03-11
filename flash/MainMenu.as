/*			C:\Inetpub\wwwroot\ATDB_WS\Flash_Client\MainMenu.as
 * 
 * Class Name:	MainMenu
 * Description: The main menu of the ATDB system
 * Created By:	Ferry To
 * Created At:	Tue Mar 14 14:33:18 2006
 * Version:		1.1.0
 * Events:	  	None
 */
import mx.core.UIObject;
import mx.controls.MenuBar;
import mx.controls.Menu;

class MainMenu
{
	private var _mb:MenuBar;
	private var _xml:XML;
	private static var _xml_str:String = "ATDB_Menu.xml";
	private static var menu_lis:Object;
	
	/*===	Init function and constructor	===*/	
	public function MainMenu()	{ init(); }
	
	public function init():Void
	{
		_xml = new XML();
		_xml.ignoreWhite = true;
		
		menu_lis = new Object();

		menu_lis.change = procMenuChange;
		_xml.onLoad = procXMLLoadSucc;
	}

	/*===	Event dispatch functions	===*/
	/*	None	*/
	
	/*===	Callback and Handlers	===*/
	
	public function procMenuChange(evt_obj:Object):Void
	{
		var iName:String = evt_obj.menuItem.attributes.instanceName;
		trace("Menu item chosen: " + iName);

		if(iName == "t1")
		{
			var tForm:TestForm = new TestForm();
			tForm.show();
		}
		else if(iName == "t2")
		{
			var tForm:TestCaseForm = new TestCaseForm();
			tForm.show();
		}
		else if(iName == "t3")
		{
			var tForm:TestRecordForm = new TestRecordForm();
			tForm.show();
		}
		else if(iName == "t4")
		{
			var tForm:TestRecordSearchForm = new TestRecordSearchForm();
			tForm.show();
		}
		else if(iName == "r1")
		{
			var tForm:TesterForm = new TesterForm();
			tForm.show();
		}
		else if(iName == "r2")
		{
			var tForm:TestDrawForm = new TestDrawForm();
			tForm.show();
		}
		else if(iName == "r3")
		{
			var tForm:TestBarChart = new TestBarChart();
			tForm.show();
		}
		else if(iName == "ct1")
		{
			var tForm:Testcase_tmpForm = new Testcase_tmpForm();
			tForm.show();
		}

	}
	
	public function procXMLLoadSucc(success:Boolean):Void
	{
		if(success)
		{
			trace("XML Process Completed");
			_mb = _root.createClassObject(MenuBar,"_mb",0);
			_mb.move(0,0,false);
			_mb.setSize(Stage.width,25,false);
			_mb.dataProvider = this;
			var count:Number =0;
			while(_mb.getMenuAt(count) != undefined){
				count++;
			}
			trace(menu_lis);
			for(var i:Number=0; i<count; i++){
				var menuI:Menu = _mb.getMenuAt(i);
				menuI.addEventListener("change",MainMenu.menu_lis);
			}	
		}
		else
			trace("read XML fail");
	}
	
	/*===	Independent functions	===*/
	public function show():Void
	{
		_xml.load(_xml_str);
	}
}