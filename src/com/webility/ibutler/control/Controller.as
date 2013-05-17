package com.webility.ibutler.control 
{
	import com.adobe.cairngorm.control.FrontController;
	import com.webility.ibutler.command.StartCommand;
	import com.webility.ibutler.command.EmailCommand;
	import com.webility.ibutler.command.SMSCommand;
	import com.webility.ibutler.command.OpenCommand;
	import com.webility.ibutler.command.EnterCommand;
	import com.webility.ibutler.command.NotificationCommand;
	/**
	 * ...
	 * @author Sam Wang
	 */
	public class Controller extends FrontController
	{
		public static const START:String = 'Controller.START';
		public static const EMAIL:String = 'Controller.EMAIL';
		public static const SMS:String = 'Controller.SMS';
		public static const OPEN:String = 'Controller.OPEN';
		public static const ENTER:String = 'Controller.ENTER';
		public static const NOTIFICATION:String = 'Controller.NOTIFICATION';
		
		public function Controller() 
		{
			initCommands();
		}
		
		public function initCommands():void 
		{
			addCommand(START, StartCommand);
			addCommand(EMAIL, EmailCommand);
			addCommand(SMS, SMSCommand);
			addCommand(OPEN, OpenCommand);
			addCommand(ENTER, EnterCommand);
			addCommand(NOTIFICATION, NotificationCommand);
		}
		
	}

}