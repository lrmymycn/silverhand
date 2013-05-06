package com.webility.ibutler.view 
{
	import com.captainsoft.flash.view.Component;
	import com.webility.ibutler.model.Model;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.webility.ibutler.control.Controller;
	
	/**
	 * ...
	 * @author Sam Wang
	 */
	public class TestPanel extends Component
	{
		private var _model:Model;
		
		public function TestPanel(mc:MovieClip) 
		{
			super(mc);
			
			_model = Model.getInstance();
			
			_mc.btn_send.buttonMode = true;
			_mc.btn_email.buttonMode = true;
			_mc.btn_sms.buttonMode = true;
			
			_mc.btn_send.addEventListener(MouseEvent.CLICK, onBtnSendClick);
			_mc.btn_email.addEventListener(MouseEvent.CLICK, onBtnEmailClick);
			_mc.btn_sms.addEventListener(MouseEvent.CLICK, onBtnSMSClick);
		}

		private function onBtnSendClick(e:MouseEvent):void 
		{
			var command:String = _mc.txt_send.text;
			var desctination:String = command.charAt(0);
			var ip = '';
			if (desctination == '1') {
				ip = _model.lockerAddressList[0];
			}else if (desctination == '2') {
				ip = _model.lockerAddressList[1];
			}
			
			if (ip == '') {
				log('No client is connected');
			}else {
				log('Connecting to ' +  ip);
				_model.dataToSend = _mc.txt_send.text;
				_model.socket.connect(ip, 23);
			}
		}
		
		private function onBtnEmailClick(e:MouseEvent):void 
		{
			var email:String = _mc.txt_email.text;
			if (email.indexOf('@') < 0) {
				log('Invalid email');
				return;
			}
			
			_mc.btn_email.removeEventListener(MouseEvent.CLICK, onBtnEmailClick);
			_mc.btn_sms.removeEventListener(MouseEvent.CLICK, onBtnSMSClick);
			
			var event:CairngormEvent = new CairngormEvent(Controller.EMAIL);
			event.data = email;
			CairngormEventDispatcher.getInstance().dispatchEvent(event);
		}
		
		private function onBtnSMSClick(e:MouseEvent):void 
		{
			var number:String = _mc.txt_sms.text;
			if (number.length != 10) {
				log('Invalid phone number');
				return;
			}
			
			if (number.indexOf('04') != 0) {
				log('Invliad phone number');
				return;
			}
			
			_mc.btn_email.removeEventListener(MouseEvent.CLICK, onBtnEmailClick);
			_mc.btn_sms.removeEventListener(MouseEvent.CLICK, onBtnSMSClick);
			
			var event:CairngormEvent = new CairngormEvent(Controller.SMS);
			event.data = number;
			CairngormEventDispatcher.getInstance().dispatchEvent(event);
		}
		
		public function enableButtons():void 
		{
			_mc.btn_email.addEventListener(MouseEvent.CLICK, onBtnEmailClick);
			_mc.btn_sms.addEventListener(MouseEvent.CLICK, onBtnSMSClick);
		}
		
		private function log(msg:String):void 
		{
			_model.application.logger.log(msg);
		}
	}

}