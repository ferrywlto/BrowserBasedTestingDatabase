/*			C:\Inetpub\wwwroot\ATDB_WS\Flash_Client\TestDrawForm.as
 * 
 * Class Name:	TestDrawForm
 * Description: Form to test drawing charts in ATDB System
 * Created By:	Ferry To
 * Created At:	Fri Mar 24 16:36:12 2006
 * Version:		1.0.1
 * Events:		None
 */
import mx.controls.*;
import mx.services.*;

class TestDrawForm extends ATDB_Form
{
	public function TestDrawForm()
	{
		super();
		_winLink_str = "TestDraw";
		_winTitle_str = "Test Chart Drawing:";		
	}
	
	public function init()
	{
		var self:Object = this;
		
		win_mc.setSize(win_mc._width+6,win_mc._height+34);
		win_mc.move((Stage.width-win_mc._width)/2,(Stage.height-win_mc._height)/2);		
		
		// Calling web service to insert a tester record
		_ws_call = _ws.TestDraw();			
		_ws_call.onResult = function(result) { self.H_WS_TestDraw(result); };
		
		win_mc.visible = true;
	}
		
	public function H_WS_TestDraw(result)
	{
		var self:Object = this;
		var mc:MovieClip = win_mc.content;
		mc.t1id_lbl.autoSize = "left";
		mc.t1sv_lbl.autoSize = "left";
		mc.t1num_lbl.autoSize = "left";
		mc.t1sy_lbl.autoSize = "left";
		mc.t2id_lbl.autoSize = "left";
		mc.t2sv_lbl.autoSize = "left";
		mc.t2num_lbl.autoSize = "left";
		mc.t2sy_lbl.autoSize = "left";
		
		mc.t1id_lbl.text = result.xmlNodes[0].childNodes[0].firstChild;
		mc.t1sv_lbl.text = result.xmlNodes[0].childNodes[1].firstChild;
		mc.t1num_lbl.text = result.xmlNodes[0].childNodes[2].firstChild;
		mc.t1sy_lbl.text = result.xmlNodes[0].childNodes[3].firstChild;
		mc.t2id_lbl.text = result.xmlNodes[1].childNodes[0].firstChild;
		mc.t2sv_lbl.text = result.xmlNodes[1].childNodes[1].firstChild;
		mc.t2num_lbl.text = result.xmlNodes[1].childNodes[2].firstChild;
		mc.t2sy_lbl.text = result.xmlNodes[1].childNodes[3].firstChild;
		
		mc.createEmptyMovieClip("circle_mc", 1);
		var pieChart:PieChart = new PieChart(mc.circle_mc);
		var tmp1 = Math.ceil((1-(parseInt(mc.t1sy_lbl.text)/parseInt(mc.t1num_lbl.text)))*100);
		var tmp2 = Math.ceil(parseInt(mc.t1sy_lbl.text)/parseInt(mc.t1num_lbl.text)*100);
		trace("tmp1:"+tmp1+" tmp2:"+tmp2);
		trace(pieChart.addPartition(tmp1,0xFF0000,"Test1 Fail"));
		trace(pieChart.addPartition(tmp2,0x0000FF,"Test1 Success"));
		pieChart.show(0,0,50);
		mc.circle_mc._x = 400;
		mc.circle_mc._y = 60;

	}
}