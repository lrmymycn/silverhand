package com.captainsoft.flash.utility 
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import gs.TweenLite;
	import gs.easing.*;
	
	/**
	 * ...
	 * @author Sam Wang
	 */
	public class Preloader extends MovieClip 
	{
		public static const NUM:String = "Number Style";
		public static const BAR:String = "Bar Style";
		
		private var _style:String;
		private var _loader:Loader;
		private var _urlRequest:URLRequest;
		
		public var mc_loader:MovieClip;
		
		public function Preloader(url:String, style:String, width:Number, height:Number, param:Object = null)
		{
			mc_loader.x = width / 2;
			mc_loader.y = height / 2;
			_style = style;
			_loader = new Loader();
			if (param != null) {
				url += "?";
				for (var key:String in param) {
					var value:String = String(param[key]);
					url = url + key + "=" + value + "&";
				}
			}
			trace(url);
			_urlRequest = new URLRequest(url);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			_loader.load(_urlRequest);
			addChild(_loader);
		}
		
		private function completeHandler(e:Event):void {
			trace("complete");
			TweenLite.to(this.mc_loader, 1, { alpha:0, ease:Expo.easeOut} );
		}
		
		private function progressHandler(e:ProgressEvent):void {
			var percent:Number = Math.floor((e.bytesLoaded / e.bytesTotal) * 100);
			
			switch (_style) {
				case NUM:
					this.mc_loader.txt_percent.text = String(percent) + "%";
					break;
				case BAR:
					this.mc_loader.mc_bar.scaleX = percent/100;
					break;
				default:
					break;
			}
		}
	}
	
}