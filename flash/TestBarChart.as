import mx.controls.*;
import mx.services.*;
class TestBarChart extends ATDB_Form
{
	public function TestBarChart()
	{
		super();		
		_winLink_str = "EmptyClip";
		_winTitle_str = "Test Chart Drawing:";
	}
	
	public function init()
	{
		var self:Object = this;
		var mc:MovieClip = win_mc.content;
		mc.createEmptyMovieClip("bar_mc", mc.getNextHighestDepth());
		var barChart:BarChart = new BarChart(mc.bar_mc);
		barChart.show();
	
		win_mc.setSize(win_mc._width+6,win_mc._height+34);
		win_mc.move((Stage.width-win_mc._width)/2,(Stage.height-win_mc._height)/2);		
		
		win_mc.visible = true;
	}
		
	public function show()
	{
		createWindow(_winLink_str,_winTitle_str);
	}	
}