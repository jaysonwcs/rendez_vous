package game;

import flixel.FlxCamera;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;

/**
 * ...
 * @author Jayson Weslley Cezar Silva
 */
class GameCore extends FlxState
{
	//Main objects
	//[Embed(source = '../../assets/musics/Space Atmosphere2.mp3')] public static var titleMusic:Class;
	
	//public var player: MainCharacter;
	public var level: FlxTilemap;
	public var objectsMap: FlxTilemap;
	public var backgroundMap: FlxTilemap;
	public var gameCamera: flixel.FlxCamera;
	//public var controlHandler: FlxControlHandler;
	public var background: FlxSprite;
	private var _paused: Bool;
	private var txtXVelocity: FlxText;
	private var txtYVelocity: FlxText;
	private var txtAir: FlxText;
	private var txtFuel: FlxText;
	private var txtVelocity: FlxText;
	private var txtDistance: FlxText;
	private var txtDangerSuit: FlxText;
	private var txtLeak: FlxText;
	
	//private var suitDamageBar: HudBar;
	
	private var airBar: FlxSprite;
	private var airBarBase: FlxSprite;
	private var fuelBar: FlxSprite;
	private var fuelBarBase: FlxSprite;
	
	//Main Layers
	public var backgroundLayer: FlxGroup;
	public var gameLayer: FlxGroup;
	public var airTanksList: FlxGroup;
	public var fuelTanksList: FlxGroup;
	public var inventoryItemsList: FlxGroup;
	public var boxesList: FlxGroup;
	public var interfaceLayer: FlxGroup;
	public var enemiesList: FlxGroup;
	public var checkPointsList: FlxGroup;
	
	//private var inventory: Inventory;
	private var directionV: FlxText;
	private var directionH: FlxText;
	private var vectorVelocity: Float;
	
	//public var map: Map;
	
	private static inline var DEATH_VELOCITY: Float = 300;
	private static inline var WARNING_VELOCITY: Float = 150;
	
	//private var hudFormatter: NumberFormatter;
	private var redBackground: FlxSprite;
	private var fadingOut:Bool;
	
	public function new() 
	{
		super();
		
		backgroundLayer = new FlxGroup();
		gameLayer = new FlxGroup();
		boxesList = new FlxGroup();
		interfaceLayer = new FlxGroup();
		inventoryItemsList = new FlxGroup();
		level = new FlxTilemap();
		objectsMap = new FlxTilemap();
		backgroundMap = new FlxTilemap();
		checkPointsList = new FlxGroup();
		enemiesList = new FlxGroup();
		//inventory = new Inventory();
		airTanksList = new FlxGroup();
		fuelTanksList = new FlxGroup();
		
		redBackground = new FlxSprite();
		redBackground.scrollFactor.x = 0;
		redBackground.scrollFactor.y = 0;
		
		//hudFormatter = new NumberFormatter(LocaleID.DEFAULT);
		//hudFormatter.fractionalDigits = 3;
		//hudFormatter.leadingZero = true;
		//hudFormatter.trailingZeros = true;
	}
	
	//TODO: override public function create():void
	//TODO: override public function create():void
	//TODO: protected function setupLevel():void
	//TODO: private function setupCamera():void
	//TODO: override public function update():void
	//TODO: private function playerLevelColision(obj1: FlxObject, obj2: FlxObject):void
	//TODO: public function pause():void
	//TODO: public function unpause():void
	//TODO: public function updateDebugMode():void
	//TODO: public function get isPaused():Boolean
	//TODO: public function resetHud():void
	//TODO: public function blinkRed(redBlinkingSpeed:Number):void
	//TODO: public function resetBlinkRed():void
	//TODO: public function set life(value:Number):void
	
}