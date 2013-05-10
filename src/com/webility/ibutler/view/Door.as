package com.webility.ibutler.view 
{
	import com.captainsoft.flash.view.Component;
	import com.webility.ibutler.model.Model;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.webility.ibutler.control.Controller;
	/**
	 * ...
	 * @author Sam Wang
	 */
	public class Door extends Component
	{
		private var _code:String;
		private var _model:Model;
		
		public function Door(mc:MovieClip, code:String) 
		{
			super(mc);
			_code = code;
			_model = Model.getInstance();
			
			close();
		}
		
		private function onMouseClick(e:MouseEvent):void 
		{
			var event:CairngormEvent = new CairngormEvent(Controller.OPEN);
			event.data = _code;
			CairngormEventDispatcher.getInstance().dispatchEvent(event);
			
			open();
		}
		
		public function open():void 
		{
			_mc.gotoAndStop(2);
			_mc.buttonMode = false;
			_mc.removeEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		public function close():void 
		{
			_mc.gotoAndStop(1);
			_mc.buttonMode = true;
			_mc.addEventListener(MouseEvent.CLICK, onMouseClick);
		}
	}

}