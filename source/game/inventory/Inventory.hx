package game.inventory;

import flixel.*;
import flixel.group.*;

/**
 * ...
 * @author Jayson Weslley Cezar Silva
 */
class Inventory extends FlxGroup
{
	private var background: FlxSprite;
		
	public function new() 
	{
		super();
		
		background = new FlxSprite();
		background.makeGraphic(FlxG.width, FlxG.height, 0x7fffffff);
		background.scrollFactor.x = 0;
		background.scrollFactor.y = 0;
		add(background);
	}
	
	override public function update():Void {
		
	}
	
	override public function add(Object:FlxBasic):FlxBasic {
		
		if (Std.is(Object, Tool))
		{
			cast(Object, Tool).x = 50;
			cast(Object, Tool).y = 50;
			cast(Object, Tool).scrollFactor.x = 0;
			cast(Object, Tool).scrollFactor.y = 0;
		}
		
		return super.add(Object);
	}
	
}