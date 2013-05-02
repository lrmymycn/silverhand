package com.webility.ibutler.view 
{
	import com.captainsoft.flash.view.Component;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.ServerSocketConnectEvent;
	import flash.net.Socket;
	import flash.net.ServerSocket;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import com.adobe.serialization.json.JSON;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Sam Wang
	 */
	public class TestPanel extends Component
	{
		private var _socket:Socket;
		private var _serverSocket:ServerSocket;
		private var _lockerIpAddress:String = '';
		
		private var _lockerIpAddressList:Array = ['192.168.0.15','192.168.0.16'];
		
		private var _dataToSend = '';
		
		public function TestPanel(mc:MovieClip) 
		{
			super(mc);
			
			_mc.btn_send.buttonMode = true;
			_mc.btn_email.buttonMode = true;
			_mc.btn_sms.buttonMode = true;
			
			_mc.btn_send.addEventListener(MouseEvent.CLICK, onBtnSendClick);
			_mc.btn_email.addEventListener(MouseEvent.CLICK, onBtnEmailClick);
			_mc.btn_sms.addEventListener(MouseEvent.CLICK, onBtnSMSClick);
			
			_socket = new Socket();
			_socket.timeout = 2000;
			_socket.addEventListener(Event.CONNECT, onSocketConnect);
			_socket.addEventListener(Event.CLOSE, onSocketClose);
			_socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketResponse);
			_socket.addEventListener(IOErrorEvent.IO_ERROR, onSocketError);
						
			_serverSocket = new ServerSocket();
			try{
				_serverSocket.bind(88);
				_serverSocket.addEventListener(ServerSocketConnectEvent.CONNECT, onServerConnect);
				_serverSocket.listen();
				log('listening at port ' + _serverSocket.localPort);
			}
			catch (err:Error)
			{
				trace(err);
			}
			
			this.checkLokerStatus();
		}
		
		public function checkLokerStatus() {
			_dataToSend = '9999';
			for (var i = 0; i < _lockerIpAddressList.length; i++) {
				var ip = _lockerIpAddressList[i];
				log('check ' + ip);
				_socket.connect(ip, 23);
			}
		}
		
		private function onBtnSendClick(e:MouseEvent):void 
		{
			var command:String = _mc.txt_send.text;
			var desctination:String = command.charAt(0);
			if (desctination == '1') {
				_lockerIpAddress = _lockerIpAddressList[0];
			}else if (desctination == '2') {
				_lockerIpAddress = _lockerIpAddressList[1];
			}
			
			if (_lockerIpAddress == '') {
				log('No client is connected');
			}else {
				log('Connecting to ' +  _lockerIpAddress);
				_dataToSend = _mc.txt_send.text;
				_socket.connect(_lockerIpAddress, 23);
			}
		}
		
		private function onSocketConnect(e:Event):void 
		{
			_socket.writeUTFBytes(_dataToSend);
			_socket.flush();
		}
		
		private function onSocketClose(e:Event):void 
		{
			trace('closed');
		}
		
		private function onSocketResponse(e:ProgressEvent):void 
		{
			var res = _socket.readUTFBytes(_socket.bytesAvailable);
			log(res);
			
			_socket.close();
			log('Connection closed');
		}
		
		private function onSocketError(e:IOErrorEvent):void 
		{
			log('Connection timeout');
		}
		
		private function onServerConnect(e:ServerSocketConnectEvent):void 
		{
			log('a client is connected');
			var socket:Socket = e.socket;
			_lockerIpAddress = socket.remoteAddress;
			
			socket.addEventListener(ProgressEvent.SOCKET_DATA, onServerSocketResponse);
		}
		
		private function onServerSocketResponse(e:ProgressEvent):void 
		{
			var bytes:ByteArray = new ByteArray();
			var socket:Socket = e.target as Socket;
			socket.readBytes(bytes);
			log(bytes + '');
			socket.close();
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
			
			var req:URLRequest = new URLRequest();
			req.method = URLRequestMethod.GET;
			req.url = 'http://ibutler.webility.com.au/locker/test?email=' + email;
			
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onLoadComplete);
			loader.load(req);
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
			
			var req:URLRequest = new URLRequest();
			req.method = URLRequestMethod.GET;
			req.url = 'http://ibutler.webility.com.au/locker/smstest?number=' + number;
			
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onLoadComplete);
			loader.load(req);
		}
		
		private function onLoadComplete(e:Event):void 
		{
			_mc.btn_email.addEventListener(MouseEvent.CLICK, onBtnEmailClick);
			_mc.btn_sms.addEventListener(MouseEvent.CLICK, onBtnSMSClick);
			
			var loader:URLLoader = URLLoader(e.target);
			var json = com.adobe.serialization.json.JSON.decode(loader.data);
			log(json.messages);
			_mc.txt_email.text = '';
		}
		
		private function log(text:String):void 
		{
			_mc.txt_message.text += text + '\r';
			_mc.txt_message.scrollV = _mc.txt_message.maxScrollV;
		}
	}

}