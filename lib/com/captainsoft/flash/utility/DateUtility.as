package com.captainsoft.flash.utility 
{
	
	/**
	 * ...
	 * @author Sam Wang
	 */
	public class DateUtility 
	{
		public static const months:Array = new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
		
		public function DateUtility() 
		{
			
		}
		
		public static function toString(date:Date):String {
			var day:Number = date.getDate();
			var month:Number = date.getMonth();
			var year:Number = date.getFullYear();
			var dateString = months[month] + " " + String(day) + ", " + String(year);
			
			return dateString;
		}
		
	}
	
}