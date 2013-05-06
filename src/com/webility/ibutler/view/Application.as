package com.webility.ibutler.view 
{
	import com.captainsoft.flash.view.Component;
	import com.webility.ibutler.control.Controller;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.webility.ibutler.model.Model;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Sam Wang
	 */
	public class Application extends Component
	{
		private var _controller:Controller;
		private var _model:Model;
		public var testPanel:TestPanel;
		public var lockerPanel:LockerPanel;
		public var logger:Logger;
		
		public function Application(mc:MovieClip) 
		{
			super(mc);
			_controller = new Controller();
			_model = Model.getInstance();
			_model.application = this;
			
			this.logger = new Logger(_mc.mc_logger);
			this.testPanel = new TestPanel(_mc.mc_testpanel);
			this.testPanel.getComponent().y = -2000;
			this.lockerPanel = new LockerPanel(_mc.mc_lockerpanel);
			
			CairngormEventDispatcher.getInstance().dispatchEvent(new CairngormEvent(Controller.START));
		}
		
	}

}