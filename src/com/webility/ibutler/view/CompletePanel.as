package com.webility.ibutler.view 
{
	import com.captainsoft.flash.view.Component;
	import com.webility.ibutler.model.Model;
	import com.webility.ibutler.model.PickUpModel;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.webility.ibutler.control.Controller;
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
			_mc.btn_complete.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			_mc.btn_complete.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			_mc.btn_complete.gotoAndStop(2);
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			_mc.btn_complete.gotoAndStop(1);
			
			var pickUpCode = generateRandomString(6);
			var pickUpMode:PickUpModel = new PickUpModel();
			pickUpMode.passcode = pickUpCode;
			pickUpMode.door = _model.currentOpenDoor;
			pickUpMode.apartment = _model.currentApartment;
			
			_model.pickUpArray.push(pickUpMode);
			_model.application.logger.log('Pickup code: ' + pickUpCode);
			
			_model.usedDoors.push(_model.currentOpenDoor);
			_model.currentOpenDoor = null;
			
			this.hide();
			_model.application.landingPanel.show();
			_model.application.pickUpPanel.show();
			
			var event:CairngormEvent = new CairngormEvent(Controller.NOTIFICATION);
			event.data = pickUpMode;
			CairngormEventDispatcher.getInstance().dispatchEvent(event);
		}
		
		function generateRandomString(strlen:Number):String{
			var chars:String = "0123456789";
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