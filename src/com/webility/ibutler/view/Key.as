package com.webility.ibutler.view 
{
	import com.webility.ibutler.model.Model;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Sam Wang
	 */
	public class Key extends MovieClip
	{
		private var _char:String;
		private var _model:Model;
		
		public function Key(char:String) 
		{
			_char = char;
			_model = Model.getInstance();
			
			this.buttonMode = true;
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
			this.txt_char.text = _char;
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			this.gotoAndStop(2);
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			this.gotoAndStop(1);
			trace(_char);
			if (_model.currentInput != null && _model.currentInput.text.length < 10) {
				_model.currentInput.appendText(_char);
			}
		}
	}

}