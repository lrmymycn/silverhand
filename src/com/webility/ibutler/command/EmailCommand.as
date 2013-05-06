package com.webility.ibutler.command 
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.webility.ibutler.model.Model;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.events.Event;
	import com.adobe.serialization.json.JSON;
	
	/**
	 * ...
	 * @author Sam Wang
	 */
	public class EmailCommand implements ICommand
	{
		private var _model:Model;
		
		public function execute(e:CairngormEvent):void 
		{
			_model = Model.getInstance();
			var email = e.data as String;
			send(email);
		}
		
		private function send(email:String):void 
		{
			var req:URLRequest = new URLRequest();
			req.method = URLRequestMethod.GET;
			req.url = 'http://ibutler.webility.com.au/locker/test?email=' + email;
			
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