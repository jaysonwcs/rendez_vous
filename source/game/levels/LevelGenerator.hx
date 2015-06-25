package game.levels;
import flixel.tile.FlxTilemap;
import flixel.util.FlxPoint;
import game.gui.Radar;
import game.objects.AirTank;
import game.objects.FuelTank;

/**
 * ...
 * @author Jayson Weslley Cezar Silva
 */
class LevelGenerator
{

	private static var map: FlxTilemap;
	private static var state: GameCore;
	
	private var level1: Level1;
	
	
	public static function generateLevel(level:GameCore):Void {
		LevelGenerator.state = level;
		//LevelGenerator.map = state.objectsMap;
		
		startPlayerPos();
		//airTanks();
		//fuelTanks();
		//radar();
	}
	
	static private function radar():Void {
		//var dotPositions: Array<FlxPoint>;
		//var totalPositions: Array<FlxPoint> = new Array();
		//
		//for (i in 1...60) 
		//{
			//dotPositions = state.level.getTileCoords(i, false);
		//
			//if (dotPositions != null)
			//{
				//for (pos in dotPositions) 
				//{
					//totalPositions.push(pos);
				//}
			//}
		//}
			//
		//state.map = new Radar(10, 90, state, totalPositions);
		//state.interfaceLayer.add(state.map);
		//state.interfaceLayer.add(state.map.player);
		//state.interfaceLayer.add(state.map.bussola);
	}
	
	static private function fuelTanks():Void {
		//var fuelTanks: Array<FlxPoint> = state.objectsMap.getTileCoords(3, false);
		//var fuelTank: FuelTank;
		//
		//if (fuelTanks != null)
		//{
			//for (pos in fuelTanks) {
				//fuelTank = new FuelTank(75, 75, pos.x, pos.y);
				//state.fuelTanksList.add(fuelTank);
				//state.gameLayer.add(fuelTank.volumeBar);
			//}
		//}
	}
	
	static private function airTanks():Void {
		//var airTanks: Array<FlxPoint> = state.objectsMap.getTileCoords(2, false);
		//var airTank: AirTank;
		//
		//if (airTanks != null)
		//{
			//for (pos in airTanks) 
			//{
				//airTank = new AirTank(1500, 1500, pos.x, pos.y);
				//state.airTanksList.add(airTank);
				//state.gameLayer.add(airTank.volumeBar);
			//}
		//}
	}
	
	static public function startPlayerPos():Void 
	{
		//var players: Array<FlxPoint> = state.objectsMap.getTileCoords(1, false);
		
		//if (players != null)
		//{
			//for (pos in players) 
			//{
				//BUG: Problema com a câmera, qnd personagem ta fora da tela dá pau!
				//BUG: provavelmente relacionado com o update do game
				//state.player.x = pos.x;
				//state.player.y = pos.y;
			//}
		//}
	}
	
}