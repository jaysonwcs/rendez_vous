package game.objects;

import flixel.FlxSprite;

/**
 * ...
 * @author Jayson Weslley Cezar Silva
 */
class Tank extends FlxSprite
{
	public var volume (default, set): Float;
	private var limit: Float;
	
	public var volumeBar (default, null): FlxSprite;
	
	private var originalY: Float;
	private var originalHeight: Float;

	public function new(volume: Float, limit: Float, X:Float=0, Y:Float=0, isVertical: Bool = false) 
	{
		super(X, Y);
		
		if (isVertical) {
			volumeBar = new FlxSprite(x + 21, y + 4);
			volumeBar.makeGraphic(2, 32, 0xff0000ff);
		} else {
			volumeBar = new FlxSprite(x + 4, y + 21);
			volumeBar.makeGraphic(32, 2, 0xff00ff00);
		}
		
		originalY = volumeBar.y;
		originalHeight = volumeBar.height;
		
		this.limit = limit;
		this.volume = volume;
	}
	
	function set_volume(value:Float):Float {
		if (value <= 0)
			value = 0;
		else if (value >= limit)
			value = limit;
			
		return value;
	}
	
	private function drawBar(ratio: Float, isVertical: Bool):Void {
		if (isVertical) {
			volumeBar.makeGraphic(2, Math.round(32 * ratio), 0xff0000ff);
			volumeBar.y = originalY + originalHeight - volumeBar.height;
		} else
			volumeBar.makeGraphic(Math.round(32 * ratio), 2, 0xff00ff00);
	}
	
	//public function get volumeBar():FlxSprite {
		//return _volumeBar;
	//}
	
}