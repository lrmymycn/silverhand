package com.webility.ibutler.command 
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.webility.ibutler.model.Model;
	/**
	 * ...
	 * @author Sam Wang
	 */
	public class OpenCommand implements ICommand
	{
		private var _model:Model;
		
		public function execute(e:CairngormEvent):void 
		{
			_model = Model.getInstance();
			var code = e.data as String;
			
			send(code);
		}
		
		public function send(code):void 
		{
			var destination = code.charAt(0);
			var ip = '';
			var index = Number(destination) - 1;

			ip = _model.lockerAddressList[index];
			
			if (ip == '') {
				_model.application.logger.log('No client is connected');
			}else {
				_model.application.logger.log('Connecting to ' +  ip);
				_model.dataToSend = code;
				_model.socket.connect(ip, 23);
			}
		}
	}

}