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
	public class AgentPanel extends Component
	{
		private var _model:Model;
		
		public function AgentPanel(mc:MovieClip) 
		{
			super(mc);
			_model = Model.getInstance();
			
			this.hide();
			
			_mc.btn_dropoff.buttonMode = true;
			_mc.btn_logoff.buttonMode = true;
			_mc.btn_dropoff.addEventListener(MouseEvent.CLICK, onDropOffClick);
			_mc.btn_logoff.addEventListener(MouseEvent.CLICK, onLogOffClick);
		}
		
		private function onDropOffClick(e:MouseEvent):void 
		{
			this.hide();
			_model.application.apartmentPanel.show();
		}
		
		private function onLogOffClick(e:MouseEvent):void 
		{
			_model.currentAgent = '';
			this.hide();
			_model.application.landingPanel.show();
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