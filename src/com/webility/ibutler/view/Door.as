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
			var destination = _code.charAt(0);
			var ip = '';
			if (destination == '1') {
				ip = _model.lockerAddressList[0];
			}else if (destination == '2') {
				ip = _model.lockerAddressList[1];
			}
			
			if (ip == '') {
				_model.application.logger.log('No client is connected');
			}else {
				_model.application.logger.log('Connecting to ' +  ip);
				_model.dataToSend = _code;
				_model.socket.connect(ip, 23);
			}
			
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