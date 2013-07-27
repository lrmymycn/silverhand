package com.webility.ibutler.view 
{
	import com.captainsoft.flash.view.Component;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Sam Wang
	 */
	public class DoorOpenMessage extends Component
	{
		
		public function DoorOpenMessage(mc:MovieClip) 
		{
			super(mc);
			
			this.hide();
		}
		
		public function show():void 
		{
			_mc.y = 470;
		}
		
		public function hide():void 
		{
			_mc.y = -2000;
		}
	}

}