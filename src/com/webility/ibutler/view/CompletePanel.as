package com.webility.ibutler.view 
{
	import com.captainsoft.flash.view.Component;
	import com.webility.ibutler.model.Model;
	import com.webility.ibutler.model.PickUpModel;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Sam Wang
	 */
	public class CompletePanel extends Component
	{
		private var _model:Model;
		
		public function CompletePanel(mc:MovieClip) 
		{
			super(mc);
			_model = Model.getInstance();
			
			this.hide();
			
			_mc.btn_complete.buttonMode = true;
			_mc.btn_complete.addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		private function onMouseClick(e:MouseEvent):void 
		{
			var pickUpCode = generateRandomString(6);
			var pickUpMode:PickUpModel = new PickUpModel();
			pickUpMode.passcode = pickUpCode;
			pickUpMode.door = _model.currentOpenDoor;
			pickUpMode.unit = _model.currentUnit;
			
			_model.pickUpArray.push(pickUpMode);
			_model.application.logger.log('Pickup code: ' + pickUpCode);
			
			_model.usedDoors.push(_model.currentOpenDoor);
			_model.currentOpenDoor = '';
			
			this.hide();
			_model.application.landingPanel.show();
		}
		
		function generateRandomString(strlen:Number):String{
			var chars:String = "abcdefghijklmnopqrstuvwxyz0123456789";
			var num_chars:Number = chars.length - 1;
			var randomChar:String = ""; 
			for (var i:Number = 0; i < strlen; i++){
				randomChar += chars.charAt(Math.floor(Math.random() * num_chars));
			}
			return randomChar;
		}
		
		public function hide():void 
		{
			_mc.y = -2000;
		}
		
		public function show():void 
		{
			_mc.y = 150;
		}
	}

}