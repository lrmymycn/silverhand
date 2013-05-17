package com.webility.ibutler.view 
{
	import com.captainsoft.flash.view.Component;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.display.StageDisplayState;
	/**
	 * ...
	 * @author Sam Wang
	 */
	public class AdminPanel extends Component
	{
		
		public function AdminPanel(mc:MovieClip) 
		{
			super(mc);
			
			_mc.addEventListener(MouseEvent.CLICK, onDoubleClick);
		}
		
		private function onDoubleClick(e:MouseEvent):void 
		{
			trace('kk');
			_mc.stage.displayState = StageDisplayState.FULL_SCREEN;
		}
	}

}