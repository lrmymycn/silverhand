package com.webility.ibutler.view 
{
	import com.webility.ibutler.model.AgentModel;
	import com.webility.ibutler.model.Model;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Sam Wang
	 */
	public class AgentButton extends MovieClip
	{
		private var _model:Model;
		private var _agent:AgentModel;
		
		public function AgentButton(agent:AgentModel) 
		{
			_model = Model.getInstance();
			_agent = agent;
			
			this.txt_name.text = _agent.name;
			this.buttonMode = true;
			this.mouseChildren = false;
			this.addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		private function onMouseClick(e:MouseEvent):void 
		{
			_model.currentAgent = _agent.name;
			
			_model.application.agentSelectPanel.hide();
			_model.application.agentLoginPanel.show();
		}
	}

}