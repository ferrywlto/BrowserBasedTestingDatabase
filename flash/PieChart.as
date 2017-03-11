class PieChart extends ATDB_Charts
{
	private var _parent:MovieClip;
	private var _data:Array;
	
	public function PieChart(_parent:MovieClip)
	{
		this._parent = _parent;
		_data = new Array();
	}
	
	// Add pie partitions
	public function addPartition(percent:Number,color:Number,label:String):Boolean
	{
		if(percent > 1 && percent < 100)
		{
			var count:Number = 0;
			for(var i:Number=0; i<_data.length; i++)
			{
				count += _data[i].percent;
				if(count > 100){
					trace("dead 1");
					return false;
				}
			}
			if(count + percent > 100)
			{
				trace("dead 2");
				return false;
			}
			else
			{
				_data.push({arc:percent/100*360,color:color,label:label});
				return true;
			}
		}
		else
		{
			trace("dead 3");
			return false;
		}
	}
	
	public function show(originX:Number,originY:Number,radius:Number)
	{
		_parent.lineStyle(0, 0x0000FF, 10);

		// Init vars
		var segAngle, theta, angle, angleMid, segs, ax, ay, bx, by, cx, cy;	
		var startAngle = 0;
		
		// Draw out the pie
		for(var i:Number =0; i<_data.length; i++)
		{
			// Flash uses 8 segments per circle, to match that, we draw in a maximum
			// of 45 degree segments. First we calculate how many segments are needed
			// for our arc.
			segs = Math.ceil(Math.abs(_data[i].arc)/45);
			// Now calculate the sweep of each segment.
			segAngle = _data[i].arc/segs;
			// The math requires radians rather than degrees. To convert from degrees
			// use the formula (degrees/180)*Math.PI to get radians.
			theta = -1*toRadian(segAngle);
			// convert angle startAngle to radians
			angle = -1*toRadian(startAngle);
			// draw the curve in segments no larger than 45 degrees.
			
			trace("segs: " + segs +" segAngle: "+segAngle+ " theta: " + theta + " angle: ");
			if (segs>0) 
			{
				_parent.beginFill(_data[i].color,100);
				// draw a line from the center to the start of the curve
				ax = originX+Math.cos(toRadian(startAngle))*radius;
				ay = originY+Math.sin(-1*toRadian(startAngle))*radius;
				_parent.lineTo(ax, ay);
				// Loop for drawing curve segments
				for (var j = 0; j<segs; j++) 
				{
					angle += theta;
					angleMid = angle-(theta/2);
					bx = originX+Math.cos(angle)*radius;
					by = originY+Math.sin(angle)*radius;
					cx = originX+Math.cos(angleMid)*(radius/Math.cos(theta/2));
					cy = originY+Math.sin(angleMid)*(radius/Math.cos(theta/2));
					_parent.curveTo(cx, cy, bx, by);
				}
				// close the wedge by drawing a line to the center
				_parent.lineTo(originX, originY);
				_parent.endFill();
				
				startAngle += _data[i].arc;
			}
		}
		
		// Draw out the legends
		var tmpx = radius*1.5;
		var tmpy = -radius;
		var boxSize = 10;
		for(var i:Number=0; i<_data.length; i++)
		{
			_parent.moveTo(0,0);
			_parent.moveTo(tmpx,tmpy);
			_parent.beginFill(_data[i].color,100);
			_parent.lineTo(tmpx+boxSize, tmpy);
			_parent.lineTo(tmpx+boxSize, tmpy+boxSize);
			_parent.lineTo(tmpx, tmpy+boxSize);
			_parent.lineTo(tmpx,tmpy);
			_parent.endFill();
			_parent.createTextField("_tf"+i,_parent.getNextHighestDepth(),tmpx+boxSize*2,tmpy,150,25);
			_parent["_tf"+i].text = _data[i].label;
			tmpy += 25;
		}
	}
}