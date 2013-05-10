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
			_mc.btn_pickup.buttonMode = true;
			
			_mc.btn_agentlogin.addEventListener(MouseEvent.CLICK, onAgentLoginClick);
			_mc.btn_pickup.addEventListener(MouseEvent.CLICK, onPickUpClick);
		}
		
		private function onAgentLoginClick(e:MouseEvent):void 
		{
			_model.currentModel = Application.AGENT;
			this.hide();
			_model.application.agentLoginPanel.show();
		}
		
		private function onPickUpClick(e:MouseEvent):void 
		{
			_model.currentModel = Application.PICKUP;
			this.hide();
			_model.application.pickUpPanel.show();
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