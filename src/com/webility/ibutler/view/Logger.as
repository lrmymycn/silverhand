package com.webility.ibutler.view 
{
	import com.captainsoft.flash.view.Component;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Sam Wang
	 */
	public class Logger extends Component
	{
		
		public function Logger(mc:MovieClip) 
		{
			super(mc);
		}

		public function log(text:String):void 
		{
			_mc.txt_message.text += text + '\r';
			_mc.txt_message.scrollV = _mc.txt_message.maxScrollV;
		}
	}

}