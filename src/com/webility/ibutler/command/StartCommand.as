package com.webility.ibutler.command 
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.webility.ibutler.model.Model;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	import flash.net.ServerSocket;
	import flash.events.ServerSocketConnectEvent;
	import flash.utils.ByteArray;
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
		}
		
		private function initSocket():void
		{
			_model.socket = new Socket();
			_model.socket.timeout = 2000;
			_model.socket.addEventListener(Event.CONNECT, onSocketConnect);
			_model.socket.addEventListener(Event.CLOSE, onSocketClose);
			_model.socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketResponse);
			_model.socket.addEventListener(IOErrorEvent.IO_ERROR, onSocketError);
			
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
			
			switch (response) 
			{
				case '1111':
					_model.doors[0].close();
					break;
				case '1211':
					_model.doors[1].close();
					break;
				case '1711':
					_model.doors[2].close();
					break;
				case '2111':
					_model.doors[3].close();
					break;
				case '2211':
					_model.doors[4].close();
					break;
				case '2711':
					_model.doors[5].close();
					break;
				default:
					break;
			}
		}
		
		public function checkLokerStatus() 
		{
			if (_model.lockerAddressList.length > _checkingStatusIndex && _checkingStatusIndex != -1)
			{
				_model.dataToSend = '9999';
				var ip = _model.lockerAddressList[_checkingStatusIndex];
				_model.application.logger.log('Check: ' + ip);
				_model.socket.connect(ip, 23);
				_checkingStatusIndex++;
			}else {
				_checkingStatusIndex = -1;
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
		
		private function onSocketResponse(e:ProgressEvent):void 
		{
			var res = _model.socket.readUTFBytes(_model.socket.bytesAvailable);
			_model.application.logger.log('Data received: ' + res);
			
			_model.socket.close();
			
			checkLokerStatus();
		}
		
		private function onSocketError(e:IOErrorEvent):void 
		{
			_model.application.logger.log('Connection timeout');
			
			checkLokerStatus();
		}
	}

}