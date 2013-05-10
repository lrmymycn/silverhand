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
			
			initSocket();
			initAgents();
			initResidents();
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
		
		private function initAgents():void 
		{
			var arr:Array = new Array();
			var a1:AgentModel = new AgentModel();
			a1.name = 'dryclean';
			a1.password = '123456';
			a1.doors = new Array('1701', '2701');
			arr.push(a1);
			
			var a2:AgentModel = new AgentModel();
			a2.name = 'grocery';
			a2.password = '123456';
			a2.doors = new Array('2201');
			arr.push(a2);
			
			var a3:AgentModel = new AgentModel();
			a3.name = 'takeaway';
			a3.password = '123456';
			a3.doors = new Array('1201');
			arr.push(a3);
			
			var a4:AgentModel = new AgentModel();
			a4.name = 'parcel';
			a4.password = '123456';
			a4.doors = new Array('1101', '1201');
			
			_model.agentArray = arr;
		}
		
		private function initResidents():void 
		{
			var arr:Array = new Array();
			var r1:ApartmentModel = new ApartmentModel();
			r1.unit = 'A101';
			r1.email = 'huisan@outlook.com';
			r1.mobile = '0413740145';
			arr.push(r1);
			
			var r2:ApartmentModel = new ApartmentModel();
			r2.unit = 'A102';
			r2.email = 'huisan@outlook.com';
			r2.mobile = '0413740145';
			arr.push(r2);
			
			_model.apartmentArray = arr;
			
			_model.application.apartmentPanel.init();
		}
	}

}