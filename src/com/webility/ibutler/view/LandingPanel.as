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
	public class LandingPanel extends Component
	{
		private var _model:Model;
		
		public function LandingPanel(mc:MovieClip) 
		{
			super(mc);
			
			_model = Model.getInstance();
			
			_mc.btn_agentlogin.buttonMode = true;
			
			_mc.btn_agentlogin.addEventListener(MouseEvent.MOUSE_DOWN, onAgentMouseDown);
			_mc.btn_agentlogin.addEventListener(MouseEvent.MOUSE_UP, onAgentLoginMouseUp);
		}
		
		private function onAgentMouseDown(e:MouseEvent):void 
		{
			_mc.btn_agentlogin.gotoAndStop(2);
		}
		
		private function onAgentLoginMouseUp(e:MouseEvent):void 
		{
			_mc.btn_agentlogin.gotoAndStop(1);
			_model.currentModel = Application.AGENT;
			this.hide();
			//_model.application.agentLoginPanel.show();
			_model.application.agentSelectPanel.show();
			_model.application.pickUpPanel.hide();
		}
		
		public function show():void 
		{
			_mc.y = 150;
		}
		
		public function hide():void 
		{
			_mc.y = -2000;
		}

	}

}