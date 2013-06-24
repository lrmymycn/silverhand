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
	public class AgentSelectPanel extends Component
	{
		private var _model:Model;
		
		public function AgentSelectPanel(mc:MovieClip) 
		{
			super(mc);
			_model = Model.getInstance();
			
			this.hide();
			
			_mc.btn_back.buttonMode = true;
			_mc.btn_back.addEventListener(MouseEvent.CLICK, onBackClick);
		}
		
		public function init():void 
		{
			var arr:Array = _model.agentArray;
			var x = 50;
			var y = 0;
			for (var i = 0; i < arr.length; i++) {
				if (i % 2 == 0) {
					x = 50;
				}else {
					x = 395;
				}
				
				if (i > 1) {
					y = 200;
				}
				
				var button:AgentButton = new AgentButton(arr[i]);
				button.x = x;
				button.y = y;
				_mc.addChild(button);
			}
		}
		
		private function onBackClick(e:MouseEvent):void 
		{
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