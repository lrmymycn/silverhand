package com.webility.ibutler.command 
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.webility.ibutler.model.Model;
	import com.webility.ibutler.view.Application;
	/**
	 * ...
	 * @author Sam Wang
	 */
	public class EnterCommand implements ICommand
	{
		private var _model:Model;
		
		public function execute(e:CairngormEvent):void
		{
			_model = Model.getInstance();
			
			this.triggerEnter();
		}
		
		private function triggerEnter():void 
		{
			trace('enter');
			if (_model.currentModel == Application.AGENT) {
				_model.application.agentLoginPanel.login();
			}else {
				_model.application.pickUpPanel.login();
			}
		}
	}

}