package game.enemies;

import flixel.FlxSprite;

/**
 * ...
 * @author ...
 */
class Skewer extends FlxSprite
{
	public var squareDetection: SquareDetection;

	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
			
		squareDetection = new SquareDetection();
		squareDetection.makeGraphic(40, 40, 0xff00ff00);
		squareDetection.immovable = true;
		squareDetection.x = x - 10;
		squareDetection.y = y - 10;
		
		makeGraphic(20, 20, 0x00000000);
		this.x = X;
		this.y = Y;
		immovable = true;
	}
	
}