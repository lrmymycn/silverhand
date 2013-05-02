package com.captainsoft.flash.view 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * @author Sam Wang
	 */
	public class Component 
	{
		protected var _mc:MovieClip;
		protected var _stage:MovieClip;
		protected var _distance:Number;
		protected var _dist_count:Number = 0;
		protected var _speed:Number;
		protected var _moving:Boolean = false;
		
		public function Component(mc:MovieClip) 
		{
			_mc = mc;
			_stage = MovieClip(_mc.root);
		}
		
		public function move(distance:Number, speed:Number):void {
			_distance = distance;
			_speed = speed;
			_moving = true;
			_mc.addEventListener(Event.ENTER_FRAME, moveMc);
		}
		
		public function moveMc(e:Event) {
			e.currentTarget.x += _speed;
			_dist_count += _speed;
			
			if(_dist_count > 0){
				if (_dist_count >= _distance) {
					_moving = false;
					_dist_count = 0;
					_mc.removeEventListener(Event.ENTER_FRAME, moveMc);
				}
			}else {
				if (_dist_count <= _distance) {
					_moving = false;
					_dist_count = 0;
					_mc.removeEventListener(Event.ENTER_FRAME, moveMc);
				}
			}
		}
		
		public function isMoving():Boolean {
			return _moving;
		}
		
		public function addDistance(value:Number):void {
			_distance += value;
		}
		
		public function destory():void {
			_mc.parent.removeChild(_mc);
		}
		
		public function setButton(buttonMode:Boolean = true):void {
			_mc.buttonMode = buttonMode;
		}
		
		public function getComponent():MovieClip {
			return _mc;
		}
		
		public function setX(x:Number):void {
			_mc.x = x;
		}
		
		public function getX():Number {
			return _mc.x;
		}
		
		public function setY(y:Number):void {
			_mc.y = y;
		}
		
		public function getY():Number {
			return _mc.y;
		}
		
		public function setAlpha(alpha:Number):void {
			_mc.alpha = alpha;
		}
	}
	
}