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
	public class PickUpPanel extends Component
	{
		private var _model:Model;
		
		public function PickUpPanel(mc:MovieClip) 
		{
			super(mc);
			_model = Model.getInstance();
			
			this.hide();
			
			_mc.btn_enter.buttonMode = true;
			_mc.btn_enter.addEventListener(MouseEvent.CLICK, onMouseClick);
			
			_mc.btn_back.buttonMode = true;
			_mc.btn_back.addEventListener(MouseEvent.CLICK, onBackClick);
			
			
			//test
			
			/*
			var pickUpMode:PickUpModel = new PickUpModel();
			pickUpMode.passcode = '123456';
			pickUpMode.door = '1701'
			pickUpMode.unit = 'A101';
			
			_model.pickUpArray.push(pickUpMode);
			*/
		}
		
		private function onMouseClick(e:MouseEvent):void 
		{
			var code:String = _mc.txt_code.text;
			if (code.length != 6) {
				_mc.txt_error.text = 'invalid pick up code';
			}else {
				openDoor(code);
			}
		}
		
		private function onBackClick(e:MouseEvent):void 
		{
			this.hide();
			_model.application.landingPanel.show();
		}
		
		private function openDoor(code:String):void 
		{
			var door = '';
			var i = 0;
			for (i = 0; i < _model.pickUpArray.length; i++) {
				var pickUpModel:PickUpModel = _model.pickUpArray[i];
				if (pickUpModel.passcode == code) {
					door = pickUpModel.door;
					break;
				}
			}
			
			if (door == '') {
				_mc.txt_error.text = 'invalid pick up code';
			}else {
				_model.currentOpenDoor = door;
				_mc.txt_code.text = '';
				_mc.txt_error.text = '';

				_model.pickUpArray.splice(i, 1);
				
				var j = 0;
				for (j = 0; j < _model.usedDoors.length; j++) {
					if (_model.usedDoors[j] == door) {
						break;
					}
				}
				_model.usedDoors.splice(j, 1);
				
				var event:CairngormEvent = new CairngormEvent(Controller.OPEN);
				event.data = door;
				CairngormEventDispatcher.getInstance().dispatchEvent(event);
			}
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