package com.webility.ibutler.view 
{
	import com.captainsoft.flash.view.Component;
	import com.webility.ibutler.model.Model;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Sam Wang
	 */
	public class LockerPanel extends Component
	{
		private var _model:Model;
		
		public function LockerPanel(mc:MovieClip) 
		{
			super(mc);
			_model = Model.getInstance();
			
			_model.doors = new Array();
			_model.doors.push(new Door(_mc.mc_door1101, '1101'));
			_model.doors.push(new Door(_mc.mc_door1201, '1201'));
			_model.doors.push(new Door(_mc.mc_door1701, '1701'));
			_model.doors.push(new Door(_mc.mc_door2101, '2101'));
			_model.doors.push(new Door(_mc.mc_door2201, '2201'));
			_model.doors.push(new Door(_mc.mc_door2701, '2701'));
		}
		
	}

}