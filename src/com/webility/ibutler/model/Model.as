package com.webility.ibutler.model 
{
	import com.webility.ibutler.view.Application;
	import flash.net.Socket;
	import flash.net.ServerSocket;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Sam Wang
	 */
	public class Model 
	{
		public var application:Application;
		public var lockerAddressList:Array;
		public var socket:Socket;
		public var serverSocket:ServerSocket;
		public var dataToSend:String = '';
		public var doors:Array;
		public var usedDoors:Array;
		public var currentOpenDoor:DoorModel;
		public var currentApartment:ApartmentModel;
		public var agentArray:Array;
		public var currentAgent:String;
		public var apartmentArray:Array;
		public var pickUpArray:Array;
		public var currentModel:String;
		public var currentInput:TextField;
		public var sendEmail:String;
		public var sendSMS:String;
		public var currentLanguage:String;
		private static var _instance:Model;
		
		public static function getInstance():Model 
		{
			return _instance = _instance || new Model();
		}
	}

}