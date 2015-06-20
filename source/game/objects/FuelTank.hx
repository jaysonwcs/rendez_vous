package game.objects;

/**
 * ...
 * @author Jayson Weslley Cezar Silva
 */
class FuelTank extends Tank
{
	//[Embed(source = '../../../assets/spritesheets/combustivel.png')] public static var fuelImg:Class;

	public function new(volume:Float, limit:Float, X:Float=0, Y:Float=0) 
	{
		super(volume, limit, X, Y);
		
		loadGraphic(AssetPaths.combustivel__png);
	}
	
	override public function set_volume(value:Float):Float 
	{
		drawBar(value / limit, false);
		
		return value;
	}
	
}