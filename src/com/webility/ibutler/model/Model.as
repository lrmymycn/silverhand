package com.webility.ibutler.model 
{
	import com.webility.ibutler.view.Application;
	import flash.net.Socket;
	import flash.net.ServerSocket;
	/**
	 * ...
	 * @author Sam Wang
	 */
	public class Model 
	{
		public var application:Application;
		public var lockerAddressList:Array = ['192.168.0.15', '192.168.0.16'];
		public var socket:Socket;
		public var serverSocket:ServerSocket;
		public var dataToSend:String = '';
		public var doors:Array;
		private static var _instance:Model;
		
		public static function getInstance():Model 
		{
			return _instance = _instance || new Model();
		}
	}

}