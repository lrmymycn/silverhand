package com.webility.ibutler.view 
{
	import com.captainsoft.flash.view.Component;
	import com.webility.ibutler.model.DoorModel;
	import com.webility.ibutler.model.Model;
	import com.webility.ibutler.model.PickUpModel;
	import flash.display.MovieClip;
	import flash.events.FocusEvent;
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
			
			//this.hide();
			
			_mc.btn_back.buttonMode = true;
			_mc.btn_back.addEventListener(MouseEvent.CLICK, onBackClick);
			_mc.txt_code.addEventListener(FocusEvent.FOCUS_IN, onCodeFocus);
			//_mc.txt_code.addEventListener(FocusEvent.FOCUS_OUT, onCodeBlur);
			
			_mc.btn_au.buttonMode = true;
			_mc.btn_au.addEventListener(MouseEvent.CLICK, onFlagClick);
			_mc.btn_cn.buttonMode = true;
			_mc.btn_cn.addEventListener(MouseEvent.CLICK, onFlagClick);
			_mc.btn_jp.buttonMode = true;
			_mc.btn_jp.addEventListener(MouseEvent.CLICK, onFlagClick);
			_mc.btn_kr.buttonMode = true;
			_mc.btn_kr.addEventListener(MouseEvent.CLICK, onFlagClick);
		}
		
		private function onCodeFocus(e:FocusEvent):void 
		{
			_mc.mc_code_bg.gotoAndStop(2);
			_model.currentInput = _mc.txt_code;
			
			_model.application.keyboard.show(KeyBoard.NUM);
			_model.application.landingPanel.hide();
			_model.currentModel = Application.PICKUP;
		}
		
		private function onCodeBlur(e:FocusEvent):void 
		{
			_mc.mc_code_bg.gotoAndStop(1);
		}
		
		private function onFlagClick(e:MouseEvent):void 
		{
			var name = e.target.name;
			switch (name) 
			{
				case 'btn_au':
					_model.currentLanguage = 'au';
					break;
				case 'btn_cn':
					_model.currentLanguage = 'cn';
					break;
				case 'btn_jp':
					_model.currentLanguage = 'jp';
					break;
				case 'btn_kr':
					_model.currentLanguage = 'kr';
					break;
				default:
					break;
			}
			
			_mc.mc_label.gotoAndStop(_model.currentLanguage);
		}
		
		public function login():void 
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
			//this.hide();
			_model.application.keyboard.hide();
			_model.application.landingPanel.show();
		}
		
		private function openDoor(code:String):void 
		{
			var door:DoorModel = null;
			var i = 0;
			for (i = 0; i < _model.pickUpArray.length; i++) {
				var pickUpModel:PickUpModel = _model.pickUpArray[i];
				if (pickUpModel.passcode == code) {
					door = pickUpModel.door;
					break;
				}
			}
			
			if (door == null) {
				_mc.txt_error.text = 'invalid pick up code';
			}else {
				_model.currentOpenDoor = door;
				_mc.txt_code.text = '';
				_mc.txt_error.text = '';

				_model.pickUpArray.splice(i, 1);
				
				var j = 0;
				for (j = 0; j < _model.usedDoors.length; j++) {
					if (_model.usedDoors[j].code == door.code) {
						break;
					}
				}
				_model.usedDoors.splice(j, 1);
				
				var event:CairngormEvent = new CairngormEvent(Controller.OPEN);
				event.data = door.code;
				CairngormEventDispatcher.getInstance().dispatchEvent(event);
				
				_model.application.locker.OpenDoor(door.mc);
			}
		}
		
		public function hide():void
		{
			_mc.y = -2000;
			_mc.txt_code.text = '';
			_model.application.keyboard.hide();
		}
		
		public function show():void 
		{
			_mc.y = 150;
			
			//_mc.txt_code.stage.focus = _mc.txt_code;
			//_mc.txt_code.setSelection(0, _mc.txt_code.length);
		}
	}

}