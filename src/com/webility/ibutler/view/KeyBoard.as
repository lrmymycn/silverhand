package com.webility.ibutler.view 
{
	import com.captainsoft.flash.view.Component;
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
	public class KeyBoard extends Component
	{
		private var keyWidth:Number = 77;
		private var keyGap:Number = 5;
		private var keyRow1:String = '1234567890';
		private var keyRow2:String = 'QWERTYUIOP';
		private var keyRow3:String = 'ASDFGHJKL';
		private var keyRow4:String = 'ZXCVBNM';
		private var _model:Model;
		
		public function KeyBoard(mc:MovieClip) 
		{
			super(mc);
			this.generateKeyRow1();
			this.generateKeyRow2();
			this.generateKeyRow3();
			this.generateKeyRow4();
			
			_model = Model.getInstance();
			
			hide();
		}
		
		public function show():void 
		{
			_mc.y = 242;
		}
		
		public function hide():void 
		{
			_mc.y = -1000;
		}
		
		private function generateKeyRow1():void 
		{
			var x = 85;
			var y = 10;
			for (var i = 0; i < keyRow1.length; i++)
			{
				var char = keyRow1.charAt(i);
				var key:Key = new Key(char);
				key.x = x;
				key.y = y;
				_mc.addChild(key);
				
				x += keyWidth + keyGap;
			}
		}
		
		private function onDeleteMouseDown(e:MouseEvent):void 
		{
			_mc.mc_delete.gotoAndStop(2);
		}
		
		private function onDeleteMouseUp(e:MouseEvent):void 
		{
			_mc.mc_delete.gotoAndStop(1);
			if (_model.currentInput != null) {
				var text = _model.currentInput.text;
				if (text.length > 0) {
					text = text.slice(0, -1);
				}
				_model.currentInput.text = text;
			}
		}
		
		private function generateKeyRow2():void 
		{
			var x = 60;
			var y = 97;
			for (var i = 0; i < keyRow2.length; i++)
			{
				var char = keyRow2.charAt(i);
				var key:Key = new Key(char);
				key.x = x;
				key.y = y;
				_mc.addChild(key);
				
				x += keyWidth + keyGap;
			}
			
			_mc.mc_delete.y = y;
			_mc.mc_delete.x = x;
			_mc.mc_delete.buttonMode = true;
			_mc.mc_delete.addEventListener(MouseEvent.MOUSE_DOWN, onDeleteMouseDown);
			_mc.mc_delete.addEventListener(MouseEvent.MOUSE_UP, onDeleteMouseUp);
		}
		
		private function generateKeyRow3():void 
		{
			var x = 85;
			var y = 184;
			for (var i = 0; i < keyRow3.length; i++)
			{
				var char = keyRow3.charAt(i);
				var key:Key = new Key(char);
				key.x = x;
				key.y = y;
				_mc.addChild(key);
				
				x += keyWidth + keyGap;
			}
			
			_mc.mc_enter.x = x;
			_mc.mc_enter.y = y;
			_mc.mc_enter.buttonMode = true;
			_mc.mc_enter.addEventListener(MouseEvent.MOUSE_DOWN, onEnterMouseDown);
			_mc.mc_enter.addEventListener(MouseEvent.MOUSE_UP, onEnterMouseUp);
		}
		
		private function onEnterMouseDown(e:MouseEvent):void 
		{
			_mc.mc_enter.gotoAndStop(2);
		}
		
		private function onEnterMouseUp(e:MouseEvent):void 
		{
			_mc.mc_enter.gotoAndStop(1);
			var event:CairngormEvent = new CairngormEvent(Controller.ENTER);
			CairngormEventDispatcher.getInstance().dispatchEvent(event);
		}
		
		private function generateKeyRow4():void 
		{
			var x = 110;
			var y = 271;
			for (var i = 0; i < keyRow4.length; i++)
			{
				var char = keyRow4.charAt(i);
				var key:Key = new Key(char);
				key.x = x;
				key.y = y;
				_mc.addChild(key);
				
				x += keyWidth + keyGap;
			}
		}
	}

}