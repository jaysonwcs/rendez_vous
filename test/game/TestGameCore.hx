package game;

import game.GameCore;
import haxe.unit.TestCase;

/**
 * ...
 * @author Jayson Weslley Cezar Silva
 */
class TestGameCore extends TestCase
{

	public function testNew():Void
	{
		var gameCore:GameCore = new GameCore();
		
		this.assertTrue(gameCore.gameLayer != null);
		//boxesList = new FlxGroup();
		//interfaceLayer = new FlxGroup();
		//inventoryItemsList = new FlxGroup();
		//level = new FlxTilemap();
		//objectsMap = new FlxTilemap();
		//backgroundMap = new FlxTilemap();
		//checkPointsList = new FlxGroup();
		//enemiesList = new FlxGroup();
		////inventory = new Inventory();
		//airTanksList = new FlxGroup();
		//fuelTanksList = new FlxGroup();
		//
		//redBackground = new FlxSprite();
		//redBackground.scrollFactor.x = 0;
		//redBackground.scrollFactor.y = 0;
	}
	
	static function main():Void {
		var runner = new haxe.unit.TestRunner();
        runner.add(new TestGameCore());
        var success = runner.run();
	}
	
}