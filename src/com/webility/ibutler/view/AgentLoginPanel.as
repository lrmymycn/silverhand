package com.webility.ibutler.view 
{
	import com.captainsoft.flash.view.Component;
	import com.webility.ibutler.model.Model;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Sam Wang
	 */
	public class AgentLoginPanel extends Component
	{
		private var _model:Model;
		
		public function AgentLoginPanel(mc:MovieClip) 
		{
			super(mc);
			_model = Model.getInstance();
			
			this.hide();
			
			_mc.txt_password.displayAsPassword = true;
			_mc.btn_login.buttonMode = true;
			_mc.btn_login.addEventListener(MouseEvent.CLICK, onLoginClick);
			
			_mc.btn_back.buttonMode = true;
			_mc.btn_back.addEventListener(MouseEvent.CLICK, onBackClick);
		}
		
		private function onLoginClick(e:MouseEvent):void 
		{
			var agentName = _mc.txt_agentname.text;
			var password = _mc.txt_password.text;
			
			if (agentName.length > 0 && password.length > 0) {				
				if (checkPassword(agentName, password)) {
					this.hide();
					_model.currentAgent = agentName;
					_model.application.agentPanel.show();
				}else {
					_mc.txt_error.text = 'Invalid agentname or password';
				}
			}else {
				_mc.txt_error.text = 'Please enter agentname and password';
			}
		}
		
		private function onBackClick(e:MouseEvent):void 
		{
			this.hide();
			_model.application.landingPanel.show();
		}
		
		private function checkPassword(agentName:String, password:String):Boolean 
		{
			var arr:Array = _model.agentArray;
			for (var i = 0; i < arr.length; i++) {
				var agent = arr[i];
				
				if (agent.name == agentName && agent.password == password) {
					return true;
				}
			}
			
			return false;
		}
		
		public function show():void 
		{
			_mc.y = 150;
		}
		
		public function hide():void 
		{
			_mc.txt_agentname.text = '';
			_mc.txt_password.text = '';
			_mc.txt_error.text = '';
			_mc.y = -2000;
		}
	}

}