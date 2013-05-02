package com.webility.ibutler.view 
{
	import com.captainsoft.flash.view.Component;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Sam Wang
	 */
	public class Application extends Component
	{
		public var testPanel:TestPanel;
		
		public function Application(mc:MovieClip) 
		{
			super(mc);
			
			this.testPanel = new TestPanel(_mc.mc_testpanel);
		}
		
	}

}