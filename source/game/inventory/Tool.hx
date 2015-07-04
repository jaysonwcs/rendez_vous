package game.inventory;

import flixel.FlxSprite;

/**
 * ...
 * @author ...
 */
class Tool extends FlxSprite
{

	public function new(X:Float=0, Y:Float=0, ?SimpleGraphic:Dynamic) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(40, 40, 0xff681268);
	}
	
}