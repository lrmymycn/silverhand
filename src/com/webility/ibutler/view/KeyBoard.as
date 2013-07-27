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
		public static const FULL:String = 'KeyBoard.FULL';
		public static const NUM:String = 'KeyBoard.NUM';
		
		public function KeyBoard(mc:MovieClip) 
		{
			super(mc);
			_model = Model.getInstance();
			
			this.generateFullKeyBoard();
			this.generateNumKeyBoard();
			
			hide();
		}
		
		private function generateFullKeyBoard():void 
		{
			this.generateKeyRow1();
			this.generateKeyRow2();
			this.generateKeyRow3();
			this.generateKeyRow4();
		}
		
		private function generateNumKeyBoard():void 
		{
			var x = 220;
			var y = 10;
			for (var i = 0; i < keyRow1.length; i++)
			{
				var char = keyRow1.charAt(i);
				var key:Key = new Key(char);
				if (char == '0') {
					x += keyWidth + keyGap;
				}
				key.x = x;
				key.y = y;
				_mc.mc_numkeyboard.addChild(key);
				
				x += keyWidth + keyGap;
				
				if (i % 3 == 2) {
					x = 220;
					y = y + keyWidth + 10;
				}
			}
			
			_mc.mc_numkeyboard.mc_delete.buttonMode = true;
			_mc.mc_numkeyboard.mc_delete.addEventListener(MouseEvent.MOUSE_DOWN, onDeleteMouseDown);
			_mc.mc_numkeyboard.mc_delete.addEventListener(MouseEvent.MOUSE_UP, onDeleteMouseUp);
			
			_mc.mc_numkeyboard.mc_enter.buttonMode = true;
			_mc.mc_numkeyboard.mc_enter.addEventListener(MouseEvent.MOUSE_DOWN, onEnterMouseDown);
			_mc.mc_numkeyboard.mc_enter.addEventListener(MouseEvent.MOUSE_UP, onEnterMouseUp);
		}
		
		public function show(mode:String):void 
		{
			if (mode == KeyBoard.FULL) {
				_mc.mc_fullkeyboard.visible = true;
				_mc.mc_numkeyboard.visible = false;
			}
			else if (mode == KeyBoard.NUM) {
				_mc.mc_fullkeyboard.visible = false;
				_mc.mc_numkeyboard.visible = true;
			}
			_mc.y = 840;
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
				_mc.mc_fullkeyboard.addChild(key);
				
				x += keyWidth + keyGap;
			}
		}
		
		private function onDeleteMouseDown(e:MouseEvent):void 
		{
			var mc:MovieClip = e.target as MovieClip;
			mc.gotoAndStop(2);
		}
		
		private function onDeleteMouseUp(e:MouseEvent):void 
		{
			var mc:MovieClip = e.target as MovieClip;
			mc.gotoAndStop(1);
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
				_mc.mc_fullkeyboard.addChild(key);
				
				x += keyWidth + keyGap;
			}
			
			_mc.mc_fullkeyboard.mc_delete.y = y;
			_mc.mc_fullkeyboard.mc_delete.x = x;
			_mc.mc_fullkeyboard.mc_delete.buttonMode = true;
			_mc.mc_fullkeyboard.mc_delete.addEventListener(MouseEvent.MOUSE_DOWN, onDeleteMouseDown);
			_mc.mc_fullkeyboard.mc_delete.addEventListener(MouseEvent.MOUSE_UP, onDeleteMouseUp);
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
				_mc.mc_fullkeyboard.addChild(key);
				
				x += keyWidth + keyGap;
			}
			
			_mc.mc_fullkeyboard.mc_enter.x = x;
			_mc.mc_fullkeyboard.mc_enter.y = y;
			_mc.mc_fullkeyboard.mc_enter.buttonMode = true;
			_mc.mc_fullkeyboard.mc_enter.addEventListener(MouseEvent.MOUSE_DOWN, onEnterMouseDown);
			_mc.mc_fullkeyboard.mc_enter.addEventListener(MouseEvent.MOUSE_UP, onEnterMouseUp);
		}
		
		private function onEnterMouseDown(e:MouseEvent):void 
		{
			var mc:MovieClip = e.currentTarget as MovieClip;
			mc.gotoAndStop(2);
		}
		
		private function onEnterMouseUp(e:MouseEvent):void 
		{
			var mc:MovieClip = e.currentTarget as MovieClip;
			mc.gotoAndStop(1);
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
				_mc.mc_fullkeyboard.addChild(key);
				
				x += keyWidth + keyGap;
			}
		}
	}

}