// The simpliest bar chart, extend this to advance bar chart types
import mx.controls.*;

class BarChart extends ATDB_Charts
{
	private var _parent:MovieClip;
	private var _data:Array;
	private var chartWidth:Number = 960;
	private var chartHeight:Number = 600;
	private var barHeight:Number = 3;
	private var barSpace:Number = 0;
	private var groupSpace:Number = 10;
	private var txtColSpace:Number = 5;
	private var legendSpace:Number = 20;
	private var legendSize:Number = 10;
	private var colors:Array = new Array(0xff0000,0xf0f000,0x00ff00,0x00f0f0,0x0000ff,0xf000f0);
	private var typeArr:Array = new Array("Pass","Fail","Blocked","Not Yet Tested","Cannot Test","Not Required");	
	
	private var yAxisX:Number;
	private var txtColWidth:Number;
	private var txtColHeight:Number;
	private var chartContentWidth:Number;
	private var legendX:Number;
	private var legendY:Number;
	private var tickStep:Number;	
	private var percents:Array;
	
	public function BarChart(_parent:MovieClip)
	{
		this._parent = _parent;
		_data = new Array();
		_data.push({label:"Power Up",pass:4,fail:3,blocked:3,notTest:3,cantTest:3,notReq:3});
		_data.push({label:"Power Down",pass:2,fail:1,blocked:0,notTest:0,cantTest:0,notReq:0});
		_data.push({label:"Calling",pass:82,fail:0,blocked:0,notTest:0,cantTest:16,notReq:0});
		_data.push({label:"Browser Settings",pass:15,fail:0,blocked:0,notTest:0,cantTest:0,notReq:13});
		_data.push({label:"Internet Access",pass:27,fail:6,blocked:0,notTest:0,cantTest:7,notReq:0});
		_data.push({label:"Ring Tone Setup",pass:6,fail:1,blocked:3,notTest:0,cantTest:1,notReq:0});
		_data.push({label:"Phone Setup",pass:30,fail:4,blocked:1,notTest:0,cantTest:3,notReq:0});
		_data.push({label:"My Apps",pass:10,fail:0,blocked:2,notTest:0,cantTest:21,notReq:0});
		_data.push({label:"Phone Book",pass:32,fail:4,blocked:0,notTest:0,cantTest:1,notReq:0});
		_data.push({label:"Accessory Operations",pass:6,fail:0,blocked:0,notTest:0,cantTest:9,notReq:0});
		_data.push({label:"MMI Command",pass:34,fail:10,blocked:2,notTest:0,cantTest:5,notReq:0});
		_data.push({label:"Shortcuts",pass:9,fail:0,blocked:0,notTest:0,cantTest:0,notReq:0});
		_data.push({label:"VoiceNotes",pass:2,fail:1,blocked:0,notTest:0,cantTest:7,notReq:0});
		_data.push({label:"Data Modem",pass:7,fail:0,blocked:1,notTest:0,cantTest:0,notReq:0});
		_data.push({label:"Media Database",pass:17,fail:4,blocked:0,notTest:0,cantTest:0,notReq:0});
		_data.push({label:"Camera",pass:6,fail:5,blocked:7,notTest:0,cantTest:0,notReq:0});
		_data.push({label:"Voice Recognition",pass:2,fail:1,blocked:1,notTest:0,cantTest:0,notReq:0});
		_data.push({label:"Interaction",pass:39,fail:18,blocked:0,notTest:0,cantTest:59,notReq:0});
		_data.push({label:"Boundary",pass:17,fail:4,blocked:0,notTest:0,cantTest:13,notReq:0});		
	}
	
	public function addBar(value:Number,color:Number,label:String):Boolean
	{
		_data.push({value:value,color:color,label:label});
		return true;
	}
	
	public function drawTextColumns()
	{
		// Create text columns
		trace(_data.length);
		for(var i=0; i<_data.length; i++)
		{
			_parent.createTextField("tf_y"+i,_parent.getNextHighestDepth(),0,i*(6*(barHeight+barSpace)+groupSpace),1,1);
			_parent["tf_y"+i].autoSize = "right";
			_parent["tf_y"+i].selectable = false;
			_parent["tf_y"+i].text = _data[i].label;
		}		
	}
	
	public function drawChartAxis()
	{
		// Draw the chart axis
		txtColWidth = _parent._width;
		txtColHeight = _parent._height+10;
		
		yAxisX = txtColWidth+txtColSpace;
		chartContentWidth = chartWidth-txtColWidth;
		
		_parent.lineStyle(0, 0x000000, 100);
		_parent.moveTo(yAxisX,0);
		_parent.lineTo(yAxisX,txtColHeight);
		_parent.lineTo(chartWidth+txtColSpace,txtColHeight);		
	}
	
	public function alignTextFields()
	{
		// Align the text fields to pack with the bar line
		for(var j=0; j<_data.length; j++)
		{
			_parent["tf_y"+j]._x = txtColWidth - _parent["tf_y"+j]._width;
		}		
	}
	
	public function drawMarkers()
	{
		// Draw 0 - 100% text
		tickStep = chartContentWidth / 20;
		for(var k=0;k<21;k++)
		{
			var tmpLocX = yAxisX+k*tickStep;
			_parent.endFill();
			_parent.lineStyle(0, 0x000000, 25);
			_parent.moveTo(tmpLocX,0);
			_parent.lineTo(tmpLocX,txtColHeight+5); // The +5 is to let the line pass thought the X axis for more clear display
			_parent.createTextField("tf_x"+k,_parent.getNextHighestDepth(),tmpLocX,txtColHeight+5,1,1);
			_parent["tf_x"+k].autoSize = "center";
			_parent["tf_x"+k].selectable = false;
			_parent["tf_x"+k].text = (k*5)+"%";
		}		
	}
	
	public function drawRowBackground()
	{
		for(var x=0; x<_data.length; x++)
		{
			// Draw the alternative row background
			_parent.lineStyle(0, 0x000000, 100);
			_parent.moveTo(yAxisX-5,x*((barHeight*6+barSpace)+groupSpace));
			_parent.lineTo(yAxisX,x*((barHeight*6+barSpace)+groupSpace));
			_parent.lineStyle(0, 0x000000, 0);
			if(x%2 ==0)	{
				_parent.beginFill(0x888888,20);
			}
			else {
				_parent.beginFill(0xDDDDDD,20);
			}		
			_parent.lineTo(yAxisX+chartContentWidth,x*((barHeight*6+barSpace)+groupSpace));
			_parent.lineTo(yAxisX+chartContentWidth,(x*((barHeight*6+barSpace)+groupSpace))+barHeight*6+groupSpace);
			_parent.lineTo(yAxisX,(x*((barHeight*6+barSpace)+groupSpace))+barHeight*6+groupSpace);
			_parent.lineTo(yAxisX,x*((barHeight*6+barSpace)+groupSpace));
			_parent.endFill();			
		}
	}
	public function drawLegends()
	{
		var self = this;
		// Drawing legends and checkboxes
		legendX = yAxisX+legendSpace;
		legendY = txtColHeight+25;
		
		for(var z=0; z<typeArr.length; z++)
		{
			legendY = txtColHeight+25;
			
			// Create checkboxes
			_parent.createClassObject(mx.controls.CheckBox,"_cb"+[z], _parent.getNextHighestDepth(), {label:typeArr[z], selected:true});
			_parent["_cb"+z].move(legendX,legendY);
	
			legendY = _parent["_cb"+z].y + _parent["_cb"+z].height/2 - legendSize/2;
			_parent.lineStyle(0, 0x000000, 100);
			_parent.moveTo(legendX-legendSize-5,legendY);
			_parent.beginFill(colors[z],50);
			_parent.lineTo(legendX-5,legendY);
			_parent.lineTo(legendX-5,legendY+legendSize);
			_parent.lineTo(legendX-legendSize-5,legendY+legendSize);
			_parent.lineTo(legendX-legendSize-5,legendY);
			_parent.endFill();	
			
			// The label of those checkboxes shouldn't larger than 100 pixels width,
			// Since dont know why the checkbox component dont have autoSize property,
			// The width of created checkboxes were always 100
			legendX += _parent["_cb"+z].width+legendSpace;
			
			// Wire-up checkboxes to event-handler
			var click_lis:Object = new Object();
			click_lis.click = function (evtObj:Object) { self.H_checkbox_click(evtObj); }
			_parent["_cb"+z].addEventListener("click",click_lis);
		}			
	}
	
	public function H_checkbox_click(evtObj:Object)
	{
		var result:Array = new Array();
		for(var i:Number=0; i<typeArr.length; i++)
			result.push(_parent["_cb"+i].selected);
		drawBars(result);
	}
	
	public function drawBars(barsToDraw:Array)
	{
		if(_parent.bar_mc == undefined)
			_parent.createEmptyMovieClip("bar_mc",_parent.getNextHighestDepth());
		else
			_parent.bar_mc.clear();
		
		for(var x=0; x<_data.length; x++)
		{
			// Calculate the length of the bars respect of the chart width
			var total = _data[x].pass + _data[x].fail + _data[x].blocked + _data[x].notTest + _data[x].cantTest + _data[x].notReq;
			var passP = _data[x].pass/total;
			var failP = _data[x].fail/total;
			var blockP = _data[x].blocked/total;
			var notTestP = _data[x].notTest/total;
			var cantTestP = _data[x].cantTest/total;
			var notReqP = _data[x].notReq/total;
			percents = new Array(passP,failP,blockP,notTestP,cantTestP,notReqP);	

			// Draw the actual bars
			var x1 = 0;
			for(var y=0; y<percents.length; y++)
			{
				if(barsToDraw[y] == true && percents[y] != 0)
				{
					var x2,y1,y2;
					x2 = x1+chartContentWidth*percents[y];
					y1 = x*((barHeight*6+barSpace)+groupSpace)+y*barHeight;
					y2 = y1+barHeight;
	
					_parent.bar_mc.lineStyle(0, 0x000000, 50);
					_parent.bar_mc.moveTo(x1,y1);
					_parent.bar_mc.beginFill(colors[y]);
					
					_parent.bar_mc.lineTo(x2,y1);
					_parent.bar_mc.lineTo(x2,y2);
					_parent.bar_mc.lineTo(x1,y2);
					_parent.bar_mc.lineStyle(0, 0x000000, 100);
					_parent.bar_mc.lineTo(x1,y1);
					_parent.bar_mc.endFill();
				}
			}
		}
		_parent.bar_mc._x = yAxisX;
	}
	
	public function show()
	{
		_parent.clear();
		drawTextColumns();
		drawChartAxis();		
		alignTextFields();
		drawMarkers();
		
		drawLegends();
		drawRowBackground();		
		drawBars(new Array(true,true,true,true,true,true));			
	}
}
