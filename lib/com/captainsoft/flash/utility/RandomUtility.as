package com.captainsoft.flash.utility 
{
	
	/**
	 * ...
	 * @author Sam Wang
	 */
	public class RandomUtility 
	{
		
		public function RandomUtility() 
		{
			
		}
		
		public static function generateNumberBetween(min:Number, max:Number):Number {
			var randnum:Number = Math.floor(Math.random() * (max - min + 1)) + min;
			return randnum;
		}
		
	}
	
}