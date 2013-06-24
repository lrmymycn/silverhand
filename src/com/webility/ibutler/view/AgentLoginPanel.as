package com.webility.ibutler.view 
{
	import com.captainsoft.flash.view.Component;
	import com.webility.ibutler.model.Model;
	import flash.display.MovieClip;
	import flash.events.FocusEvent;
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
			_mc.btn_back.buttonMode = true;
			_mc.btn_back.addEventListener(MouseEvent.CLICK, onBackClick);
			
			//_mc.txt_agentname.addEventListener(FocusEvent.FOCUS_IN, onAgentNameFocus);
			//_mc.txt_agentname.addEventListener(FocusEvent.FOCUS_OUT, onAgentNameBlur);
			_mc.txt_password.addEventListener(FocusEvent.FOCUS_IN, onPasswordFocus);
			//_mc.txt_password.addEventListener(FocusEvent.FOCUS_OUT, onPasswordBlur);
		}
		
		public function login():void 
		{
			var agentName = _mc.txt_agentname.text;
			var password = _mc.txt_password.text;
			
			if (agentName.length > 0 && password.length > 0) {				
				if (checkPassword(agentName, password)) {
					this.hide();
					_model.application.keyboard.hide();
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
		
		private function onAgentNameFocus(e:FocusEvent):void 
		{
			_model.currentInput = _mc.txt_agentname;
			_mc.mc_agentname_bg.gotoAndStop(2);
			_mc.mc_password_bg.gotoAndStop(1);
		}
		
		private function onAgentNameBlur(e:FocusEvent):void 
		{
			if (_model.currentInput.name == _mc.txt_agentname.name) {
				_model.currentInput = null;
			}
			_mc.mc_agentname_bg.gotoAndStop(1);
		}
		
		private function onPasswordFocus(e:FocusEvent):void 
		{
			_model.currentInput = _mc.txt_password;
			_mc.mc_password_bg.gotoAndStop(2);
			_mc.mc_agentname_bg.gotoAndStop(1);
		}
		
		private function onPasswordBlur(e:FocusEvent):void 
		{
			if (_model.currentInput.name == _mc.txt_password.name) {
				_model.currentInput = null;
			}
			_mc.mc_password_bg.gotoAndStop(1);
		}
		
		public function show():void 
		{
			_mc.y = 150;
			_model.application.keyboard.show(KeyBoard.NUM);
			//_mc.txt_agentname.stage.focus = _mc.txt_agentname;
			//_mc.txt_agentname.setSelection(0, _mc.txt_agentname.length);
			_mc.txt_agentname.text = _model.currentAgent;
			_mc.txt_password.stage.focus = _mc.txt_password;
			_mc.txt_password.setSelection(0, _mc.txt_password.length);
		}
		
		public function hide():void 
		{
			_mc.txt_agentname.text = '';
			_mc.txt_password.text = '';
			_mc.txt_error.text = '';
			_mc.y = -2000;
			
			_model.application.keyboard.hide();
		}
	}

}