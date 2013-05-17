package com.webility.ibutler.command 
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.webility.ibutler.model.ApartmentModel;
	import com.webility.ibutler.model.Model;
	import com.webility.ibutler.model.PickUpModel;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.events.Event;
	import com.adobe.serialization.json.JSON;
	import flash.net.URLVariables;
	/**
	 * ...
	 * @author Sam Wang
	 */
	public class NotificationCommand implements ICommand
	{
		private var _model:Model;
		
		public function execute(e:CairngormEvent):void 
		{
			_model = Model.getInstance();
			var pickup = e.data as PickUpModel;
			send(pickup);
		}
		
		private function send(pickup:PickUpModel):void 
		{			
			var req:URLRequest = new URLRequest('http://ibutler.webility.com.au/locker/notification');
			req.method = URLRequestMethod.POST;
			var data:URLVariables = new URLVariables();
			data.code = pickup.passcode;
			if (_model.sendEmail)
			{
				data.email = pickup.apartment.email;
			}
			if (_model.sendSMS)
			{
				data.mobile = pickup.apartment.mobile;
			}
			data.type = _model.currentAgent;
			req.data = data;
			
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onLoadComplete);
			loader.load(req);
			
		}
		
		private function onLoadComplete(e:Event):void 
		{
			var loader:URLLoader = URLLoader(e.target);
			var json = com.adobe.serialization.json.JSON.decode(loader.data);
			
			_model.application.logger.log(json.messages);			
			_model.application.testPanel.enableButtons();
		}
	}

}