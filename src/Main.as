package  
{
	import com.webility.ibutler.view.Application;
	import flash.display.MovieClip;
	import flash.display.StageDisplayState;
	/**
	 * ...
	 * @author Sam Wang
	 */
	public class Main extends MovieClip
	{
		private var _app:Application;
		
		public function Main() 
		{
			stage.displayState = StageDisplayState.FULL_SCREEN;
			_app = new Application(this);
		}
		
	}

}