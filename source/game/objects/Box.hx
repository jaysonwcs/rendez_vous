package game.objects;

import flixel.*;

/**
 * ...
 * @author ...
 */
class Box extends FlxSprite
{

	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		makeGraphic(40, 40, 0xff00ff00);
	}
	
}