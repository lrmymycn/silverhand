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
		public static const AGENT:String = 'Application.AGENT';
		public static const PICKUP:String = 'Application.PICKUP';
		
		private var _controller:Controller;
		private var _model:Model;
		public var testPanel:TestPanel;
		public var lockerPanel:LockerPanel;
		public var landingPanel:LandingPanel;
		public var agentLoginPanel:AgentLoginPanel;
		public var agentPanel:AgentPanel;
		public var apartmentPanel:ApartmentPanel;
		public var doorOpenMessage:DoorOpenMessage;
		public var completePanel:CompletePanel;
		public var pickUpPanel:PickUpPanel;
		public var adminPanel:AdminPanel;
		public var logger:Logger;
		public var keyboard:KeyBoard;
		
		public function Application(mc:MovieClip) 
		{
			super(mc);
			_controller = new Controller();
			_model = Model.getInstance();
			_model.application = this;
			_model.usedDoors = new Array();
			_model.pickUpArray = new Array();
			
			this.logger = new Logger(_mc.mc_logger);
			this.keyboard = new KeyBoard(_mc.mc_keyboard);
			this.testPanel = new TestPanel(_mc.mc_testpanel);
			this.testPanel.getComponent().y = -2000;
			this.lockerPanel = new LockerPanel(_mc.mc_lockerpanel);
			this.lockerPanel.getComponent().y = -2000;
			this.landingPanel = new LandingPanel(_mc.mc_landingpanel);
			this.agentLoginPanel = new AgentLoginPanel(_mc.mc_agentloginpanel);
			this.agentPanel = new AgentPanel(_mc.mc_agentpanel);
			this.apartmentPanel = new ApartmentPanel(_mc.mc_apartmentpanel);
			this.doorOpenMessage = new DoorOpenMessage(_mc.mc_dooropen);
			this.completePanel = new CompletePanel(_mc.mc_completepanel);
			this.pickUpPanel = new PickUpPanel(_mc.mc_pickuppanel);
			this.adminPanel = new AdminPanel(_mc.mc_admin);
			
			CairngormEventDispatcher.getInstance().dispatchEvent(new CairngormEvent(Controller.START));
		}
		
	}

}