package com.captainsoft.flash.utility 
{
	
	/**
	 * ...
	 * @author Sam Wang
	 */
	public class Crypto 
	{	
		private var _key:String;
		
		public function Crypto(key:String):void 
		{
			_key = key;
		}
		
		public function decrypt(txtToDecrypt:String) : String {
			return xor(Base64.decodeString(txtToDecrypt)); 
		}
		
		/**
		 * Based on: http://blog.dannypatterson.com/?p=135 
		 * 
		 */
		private function xor(source:String):String {
			var key:String = _key;
			var result:String = new String();
			for(var i:Number = 0; i < source.length; i++) {
				if(i > (key.length - 1)) {
					key += key;
				}
				result += String.fromCharCode(source.charCodeAt(i) ^ key.charCodeAt(i));
			}
			return result;
		}
	}
	
}