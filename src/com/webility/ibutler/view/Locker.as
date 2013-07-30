package com.webility.ibutler.view 
{
	import com.captainsoft.flash.view.Component;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Sam Wang
	 */
	public class Locker extends Component
	{
		
		public function Locker(mc:MovieClip) 
		{
			super(mc);
			
			this.hide();
		}
		
		public function OpenDoor(mcName:String):void 
		{
			var mc:MovieClip = MovieClip(_mc.getChildByName(mcName));
			mc.gotoAndStop(2);
		}
		
		public function ReleaseDoor(mcName:String):void 
		{
			var mc:MovieClip = MovieClip(_mc.getChildByName(mcName));
			mc.gotoAndStop(1);
		}
		
		public function LockDoor(mcName:String):void 
		{
			var mc:MovieClip = MovieClip(_mc.getChildByName(mcName));
			mc.gotoAndStop(3);
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