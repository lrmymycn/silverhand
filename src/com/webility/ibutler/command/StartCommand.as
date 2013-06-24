package com.webility.ibutler.command 
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.webility.ibutler.model.AgentModel;
	import com.webility.ibutler.model.Model;
	import com.webility.ibutler.model.ApartmentModel;
	import com.webility.ibutler.view.Application;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	import flash.net.ServerSocket;
	import flash.events.ServerSocketConnectEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Sam Wang
	 */
	public class StartCommand implements ICommand
	{
		private var _model:Model;
		private var _checkingStatusIndex:Number;
		
		public function execute(e:CairngormEvent):void 
		{
			_model = Model.getInstance();
			loadConfig();
		}
		
		private function initSocket():void
		{
			_model.socket = new Socket();
			_model.socket.timeout = 2000;
			_model.socket.addEventListener(Event.CONNECT, onSocketConnect);
			_model.socket.addEventListener(Event.CLOSE, onSocketClose);
			//_model.socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketResponse);
			//_model.socket.addEventListener(IOErrorEvent.IO_ERROR, onSocketError);
			_model.socket.addEventListener(ProgressEvent.SOCKET_DATA, onCheckSocketResponse);
			_model.socket.addEventListener(IOErrorEvent.IO_ERROR, onCheckSocketError);
			
			_model.serverSocket = new ServerSocket();
			try{
				_model.serverSocket.bind(88);
				_model.serverSocket.addEventListener(ServerSocketConnectEvent.CONNECT, onServerConnect);
				_model.serverSocket.listen();
				_model.application.logger.log('Listening at port ' + _model.serverSocket.localPort);
			}
			catch (err:Error)
			{
				trace(err);
			}
			
			_checkingStatusIndex = 0;
			checkLokerStatus();
		}
		
		private function onServerConnect(e:ServerSocketConnectEvent):void 
		{
			_model.application.logger.log('a client is connected');
			var socket:Socket = e.socket;
			
			socket.addEventListener(ProgressEvent.SOCKET_DATA, onServerSocketResponse);
		}
		
		private function onServerSocketResponse(e:ProgressEvent):void 
		{
			var bytes:ByteArray = new ByteArray();
			var socket:Socket = e.target as Socket;
			socket.readBytes(bytes);
			var response:String = bytes + '';
			_model.application.logger.log(response);
			socket.close();
			
			_model.application.doorOpenMessage.hide();
			if (_model.currentModel == Application.AGENT)
			{
				_model.application.completePanel.show();
			}
			else if(_model.currentModel == Application.PICKUP)
			{
				_model.application.landingPanel.show();
			}
		}
		
		public function checkLokerStatus() 
		{
			if (_model.lockerAddressList.length > _checkingStatusIndex)
			{
				_model.dataToSend = '9999';
				var ip = _model.lockerAddressList[_checkingStatusIndex];
				_model.application.logger.log('Check: ' + ip);
				_model.socket.connect(ip, 23);
				_checkingStatusIndex++;
			}else {				
				//change event listener
				_model.socket.removeEventListener(ProgressEvent.SOCKET_DATA, onCheckSocketResponse);
				_model.socket.removeEventListener(IOErrorEvent.IO_ERROR, onCheckSocketError);
				_model.socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketResponse);
				_model.socket.addEventListener(IOErrorEvent.IO_ERROR, onSocketError);
			}
		}
		
		private function onSocketConnect(e:Event):void 
		{
			_model.socket.writeUTFBytes(_model.dataToSend);
			_model.socket.flush();
		}
		
		private function onSocketClose(e:Event):void 
		{
			_model.application.logger.log('Socket is closed');
		}
		
		private function onCheckSocketResponse(e:ProgressEvent):void 
		{
			var res = _model.socket.readUTFBytes(_model.socket.bytesAvailable);
			_model.application.logger.log('Data received: ' + res);		
			_model.socket.close();
			
			checkLokerStatus();
		}
		
		private function onCheckSocketError(e:IOErrorEvent):void 
		{
			_model.application.logger.log('Connection timeout');
			
			checkLokerStatus();
		}
		
		private function onSocketResponse(e:ProgressEvent):void 
		{
			var res = _model.socket.readUTFBytes(_model.socket.bytesAvailable);
			_model.application.logger.log('Data received: ' + res);
			
			_model.socket.close();
			
			if (_model.currentModel == Application.AGENT)
			{
				_model.application.apartmentPanel.hide();
			}
			else if(_model.currentModel == Application.PICKUP){
				_model.application.pickUpPanel.hide();
			}
			_model.application.doorOpenMessage.show();
		}
		
		private function onSocketError(e:IOErrorEvent):void 
		{
			_model.application.logger.log('Connection timeout');
		}
		
		private function loadConfig():void 
		{
			var urlLoader:URLLoader = new URLLoader();
			var urlRequest:URLRequest = new URLRequest('config.xml');
			urlLoader.addEventListener(Event.COMPLETE, onConfigLoaded);
			urlLoader.load(urlRequest);
		}
		
		private function onConfigLoaded(e:Event):void 
		{
			var loader:URLLoader = e.target as URLLoader;
			if (loadConfig != null) {
				var xml:XML = new XML(loader.data);
				parseXML(xml);;
			}else {
				_model.application.logger.log('Config file loading failed');
			}
		}
		
		private function parseXML(xml:XML):void 
		{
			parseSettings(xml..settings);
			parseLock(xml..locker);
			parseAgent(xml..agent);
			parseApartment(xml..apartment);
		}
		
		private function parseSettings(dataList:XMLList):void 
		{
			var data = dataList[0];
			_model.sendEmail = data.sendemail;
			_model.sendSMS = data.sendsms;
		}
		
		private function parseLock(dataList:XMLList):void 
		{
			var arr:Array = new Array();
			for each(var lock:XML in dataList) {
				arr.push(lock);
			}
			_model.lockerAddressList = arr;
			
			initSocket();
		}
		
		private function parseAgent(dataList:XMLList):void 
		{
			var arr:Array = new Array();
			for each(var agent:XML in dataList) {
				var model:AgentModel = new AgentModel();
				model.name = agent.name;
				model.password = agent.password;
				model.doors = new Array();
				parseDoor(agent..door, model);
				arr.push(model);
			}
			_model.agentArray = arr;
			
			_model.application.agentSelectPanel.init();
		}
		
		private function parseDoor(doors:XMLList, model:AgentModel):void 
		{
			for each (var door:XML in doors) {
				model.doors.push(door);
			}
		}
		
		private function parseApartment(dataList:XMLList):void 
		{
			var arr:Array = new Array();
			for each(var apartment:XML in dataList) {
				var model:ApartmentModel = new ApartmentModel();
				model.unit = apartment.unit;
				model.email = apartment.email;
				model.mobile = apartment.mobile;
				arr.push(model);
			}
			_model.apartmentArray = arr;
			
			_model.application.apartmentPanel.init();
		}
	}

}