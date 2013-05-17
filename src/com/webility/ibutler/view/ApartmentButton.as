package com.webility.ibutler.view 
{
	import com.webility.ibutler.model.AgentModel;
	import com.webility.ibutler.model.ApartmentModel;
	import com.webility.ibutler.model.Model;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.webility.ibutler.control.Controller;
	/**
	 * ...
	 * @author Sam Wang
	 */
	public class ApartmentButton extends MovieClip
	{
		private var _model:Model;
		private var _apartment:ApartmentModel;
		
		public function ApartmentButton(apartment:ApartmentModel) 
		{
			_model = Model.getInstance();
			_apartment = apartment;
			
			this.txt_unit.text = _apartment.unit;
			this.buttonMode = true;
			this.mouseChildren = false;
			this.addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		private function onMouseClick(e:MouseEvent):void 
		{
			this.removeEventListener(MouseEvent.CLICK, onMouseClick);
			
			var agents:Array = _model.agentArray;
			var agent:AgentModel = null;
			var i = 0;
			for (i = 0; i < agents.length; i ++) {
				if (agents[i].name == _model.currentAgent) {
					agent = agents[i];
					break;
				}
			}
			
			if (agent == null) {
				_model.application.logger.log('Agent not found');
			}else {
				var doors:Array = agent.doors;
				var door:String = '';
				for (i = 0; i < doors.length; i++) {
					door = doors[i];
					var doorIsUsed = false;
					for (var j = 0; j < _model.usedDoors.length ; j++) {
						if (door == _model.usedDoors[j]) {
							//the door is used
							doorIsUsed = true;
							break;
						}
					}
					if (!doorIsUsed) {
						break;
					}
				}
				
				if (door == '') {
					_model.application.logger.log('All doors are in used');
				}else {
					_model.currentOpenDoor = door;
					_model.currentApartment = _apartment;;
					var event:CairngormEvent = new CairngormEvent(Controller.OPEN);
					event.data = door;
					CairngormEventDispatcher.getInstance().dispatchEvent(event);
					
					this.addEventListener(MouseEvent.CLICK, onMouseClick);
				}
			}
		}
	}

}