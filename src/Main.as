package  
{
	import com.webility.ibutler.view.Application;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Sam Wang
	 */
	public class Main extends MovieClip
	{
		private var _app:Application;
		
		public function Main() 
		{
			_app = new Application(this);
		}
		
	}

}