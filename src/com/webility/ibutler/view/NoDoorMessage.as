package com.webility.ibutler.view 
{
	import com.captainsoft.flash.view.Component;
	import com.webility.ibutler.model.Model;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Sam Wang
	 */
	public class NoDoorMessage extends Component
	{
		private var _model:Model;
		
		public function NoDoorMessage(mc:MovieClip) 
		{
			super(mc);
			_model = Model.getInstance();
			
			this.hide();
			
			_mc.btn_cancel.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			_mc.btn_cancel.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			_mc.btn_cancel.gotoAndStop(2);
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			this.hide();
			_model.application.landingPanel.show();
		}
		
		public function show():void 
		{
			_mc.y = 150;
		}
		
		public function hide():void 
		{
			_mc.y = -2000;
		}
	}

}