package game.objects;

/**
 * ...
 * @author Jayson Weslley Cezar Silva
 */
class AirTank extends Tank
{

	//[Embed(source = '../../../assets/spritesheets/ar.png')] public static var tankImg:Class;
	
	public function new(volume: Float, limit: Float, X:Float=0, Y:Float=0) 
	{
		super(volume, limit, X, Y, true);
		
		loadGraphic(AssetPaths.ar__png);
	}
	
	override public function set_volume(value:Float):Float 
	{
		drawBar(value / limit, true);
		
		return value;
	}
	
}