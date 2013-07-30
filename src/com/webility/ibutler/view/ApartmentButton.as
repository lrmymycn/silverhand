package com.webility.ibutler.view 
{
	import com.webility.ibutler.model.AgentModel;
	import com.webility.ibutler.model.ApartmentModel;
	import com.webility.ibutler.model.DoorModel;
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
				var door:DoorModel = null;
				for (i = 0; i < doors.length; i++) {
					var d = doors[i];
					var doorIsUsed = false;
					for (var j = 0; j < _model.usedDoors.length ; j++) {
						if (d.code == _model.usedDoors[j].code) {
							//the door is used
							doorIsUsed = true;
							break;
						}
					}
					if (!doorIsUsed) {
						door = d;
						break;
					}
				}
				
				if (door == null) {
					//All doors of this agent have been used
					//Force open the first door of this agent
					door = agent.doors[0];

					//Remove it from used Door
					var k = 0;
					for (k = 0; k < _model.usedDoors.length; k++) {
						if (_model.usedDoors[k].code == door.code) {
							break;
						}
					}
					_model.usedDoors.splice(k, 1);
					
					//Remove it from Pickup Array
					var l = 0;
					for (l = 0; i < _model.pickUpArray.length; l++) {
						if (_model.pickUpArray[l].door.code == door.code) {
							break;
						}
					}
					_model.pickUpArray.splice(l, 1);
				}
				
				_model.currentOpenDoor = door;
				_model.currentApartment = _apartment;
				var event:CairngormEvent = new CairngormEvent(Controller.OPEN);
				event.data = door.code;
				CairngormEventDispatcher.getInstance().dispatchEvent(event);
				
				_model.application.locker.OpenDoor(door.mc);
			}
			
			this.addEventListener(MouseEvent.CLICK, onMouseClick);
		}
	}

}