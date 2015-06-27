package game.levels;

import flixel.FlxSprite;
import flixel.system.FlxAssets;
import flixel.tile.FlxTilemap;
import game.GameCore;
import lime.Assets;

/**
 * ...
 * @author Jayson Weslley Cezar Silva
 */
class Level1 extends GameCore
{
	private static inline var SCROOLFACTOR_BACK: Float = 0.04;
	
	override public function create():Void 
	{
		super.create();
		
		//var tool: Tool = new Tool(200, 200);
		//inventoryItemsList.add(tool);
		//
		//var box: Box = new Box(500, 500);
		//boxesList.add(box);
	}
	
	override function setupLevel():Void 
	{
		super.setupLevel();
		
		var backgroundSprite: FlxSprite = new FlxSprite(0, 0, AssetPaths.sunshine__png);
		backgroundLayer.add(backgroundSprite);
		backgroundSprite.scrollFactor.x = SCROOLFACTOR_BACK;
		backgroundSprite.scrollFactor.y = SCROOLFACTOR_BACK;
		
		var mapCsv: String = Assets.getText(AssetPaths.mapCSV_Group1_map__csv);
		
		backgroundMap.loadMap(Assets.getText(AssetPaths.mapCSV_Group1_back__csv), AssetPaths.tileset_back__png, 40, 40);
		level.loadMap(mapCsv, AssetPaths.tileset__png, 40, 40, FlxTilemap.OFF, 0, 1, 1);
		objectsMap.loadMap(Assets.getText(AssetPaths.mapCSV_Group1_obj__csv), AssetPaths.tileset__png, 40, 40, FlxTilemap.OFF, 0, 1, 1);
	}
	
}