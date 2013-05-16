package com.webility.ibutler.view 
{
	import com.captainsoft.flash.view.Component;
	import com.webility.ibutler.model.Model;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Sam Wang
	 */
	public class ApartmentPanel extends Component
	{
		private var _model:Model;
		
		public function ApartmentPanel(mc:MovieClip) 
		{
			super(mc);
			_model = Model.getInstance();
			
			this.hide();
		}
		
		public function init():void
		{
			var arr:Array = _model.apartmentArray;
			
			for (var i = 0; i < arr.length; i++) {
				var button:ApartmentButton = new ApartmentButton(arr[i].unit);
				var x = i * 125;
				button.x = x;
				_mc.addChild(button);
			}
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