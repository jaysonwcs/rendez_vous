package game;

import flixel.addons.editors.tiled.TiledLayer;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.util.FlxPoint;
import flixel.util.FlxRect;
import game.gui.HudBar;
import game.gui.Radar;
import game.inventory.Inventory;
import game.levels.LevelGenerator;

/**
 * ...
 * @author Jayson Weslley Cezar Silva
 */
class GameCore extends FlxState
{
	//Main objects
	/*[Embed(source = '../../assets/musics/Space Atmosphere2.mp3')]*/ public static var titleMusic:Dynamic;
	
	public var player: MainCharacter;
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
	
	private var suitDamageBar: HudBar;
	
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
	
	private var inventory: Inventory;
	private var directionV: FlxText;
	private var directionH: FlxText;
	private var vectorVelocity: Float;
	
	public var map: Radar;
	
	private static inline var DEATH_VELOCITY: Float = 300;
	private static inline var WARNING_VELOCITY: Float = 150;
	
	//private var hudFormatter: NumberFormatter;
	private var redBackground: FlxSprite;
	private var fadingOut:Bool;
	
	public function new() 
	{
		super();
		
		//backgroundLayer = new FlxGroup();
		//gameLayer = new FlxGroup();
		//boxesList = new FlxGroup();
		//interfaceLayer = new FlxGroup();
		//inventoryItemsList = new FlxGroup();
		//level = new FlxTilemap();
		////objectsMap = new FlxTilemap();
		////backgroundMap = new FlxTilemap();
		//checkPointsList = new FlxGroup();
		//enemiesList = new FlxGroup();
		//inventory = new Inventory();
		//airTanksList = new FlxGroup();
		//fuelTanksList = new FlxGroup();
		//
		//redBackground = new FlxSprite();
		//redBackground.scrollFactor.x = 0;
		//redBackground.scrollFactor.y = 0;
		//
		////hudFormatter = new NumberFormatter(LocaleID.DEFAULT);
		////hudFormatter.fractionalDigits = 3;
		////hudFormatter.leadingZero = true;
		////hudFormatter.trailingZeros = true;
	}
	
	override public function create():Void
	{
		super.create();
		
		backgroundLayer = new FlxGroup();
		gameLayer = new FlxGroup();
		boxesList = new FlxGroup();
		interfaceLayer = new FlxGroup();
		inventoryItemsList = new FlxGroup();
		level = new FlxTilemap();
		//objectsMap = new FlxTilemap();
		//backgroundMap = new FlxTilemap();
		checkPointsList = new FlxGroup();
		enemiesList = new FlxGroup();
		inventory = new Inventory();
		airTanksList = new FlxGroup();
		fuelTanksList = new FlxGroup();
		
		redBackground = new FlxSprite();
		redBackground.scrollFactor.x = 0;
		redBackground.scrollFactor.y = 0;
		
		//hudFormatter = new NumberFormatter(LocaleID.DEFAULT);
		//hudFormatter.fractionalDigits = 3;
		//hudFormatter.leadingZero = true;
		//hudFormatter.trailingZeros = true;
		
		setupLevel();
		
		FlxG.worldBounds.set(0, 0, level.width, level.height);
		
		add(backgroundLayer);
		add(gameLayer);
		add(interfaceLayer);
		
		gameLayer.add(level);
		gameLayer.add(inventoryItemsList);
		gameLayer.add(boxesList);
		gameLayer.add(airTanksList);
		gameLayer.add(fuelTanksList);
		//gameLayer.add(checkPoints);
		//gameLayer.add(enemies);
		
		//backgroundLayer.add(backgroundMap);
		
		player = new MainCharacter(this, inventory);
		
		setupCamera();
		
		LevelGenerator.generateLevel(this);
		//objectsMap.destroy();
		
		gameLayer.add(player);
		
		txtVelocity = new FlxText(10, 10, 200);
		txtVelocity.scrollFactor.x = 0;
		txtVelocity.scrollFactor.y = 0;
		interfaceLayer.add(txtVelocity);
		txtVelocity.text = "Velocidades:";
		
		txtXVelocity = new FlxText(10, 20, 200);
		txtXVelocity.scrollFactor.x = 0;
		txtXVelocity.scrollFactor.y = 0;
		interfaceLayer.add(txtXVelocity);
		//txtXVelocity.text = Math.abs(player.velocity.x).toString();
		
		txtAir = new FlxText(10, 60, 200);
		txtAir.scrollFactor.x = 0;
		txtAir.scrollFactor.y = 0;
		interfaceLayer.add(txtAir);
		//txtAir.text = player.airTime.toString();
		
		txtFuel = new FlxText(10, 70, 200);
		txtFuel.scrollFactor.x = 0;
		txtFuel.scrollFactor.y = 0;
		interfaceLayer.add(txtFuel);
		//txtFuel.text = player.fuel.toString();
		
		airBarBase = new FlxSprite(txtAir.x + 79, txtAir.y + 1);
		airBarBase.makeGraphic(202, 7, 0x7fffffff);
		airBarBase.scrollFactor.x = 0;
		airBarBase.scrollFactor.y = 0;
		interfaceLayer.add(airBarBase);
		
		airBar = new FlxSprite(txtAir.x + 80, txtAir.y + 2);
		airBar.makeGraphic(200, 5, 0xff0000ff);
		airBar.scrollFactor.x = 0;
		airBar.scrollFactor.y = 0;
		interfaceLayer.add(airBar);
		
		fuelBarBase = new FlxSprite(txtFuel.x + 79, txtFuel.y + 1);
		fuelBarBase.makeGraphic(202, 7, 0x7fffffff);
		fuelBarBase.scrollFactor.x = 0;
		fuelBarBase.scrollFactor.y = 0;
		interfaceLayer.add(fuelBarBase);
		
		fuelBar = new FlxSprite(txtFuel.x + 80, txtFuel.y + 2);
		fuelBar.makeGraphic(200, 5, 0xff00ff00);
		fuelBar.scrollFactor.x = 0;
		fuelBar.scrollFactor.y = 0;
		interfaceLayer.add(fuelBar);
		
		//txtYVelocity = new FlxText(10, 20, 200);
		//txtYVelocity.scrollFactor.x = 0;
		//txtYVelocity.scrollFactor.y = 0;
		//interfaceLayer.add(txtYVelocity);
		//txtYVelocity.text = Math.abs(player.velocity.y).toString();
		//txtYVelocity.text = player.life.toString();
		
		directionH = new FlxText(10, 30, 200);
		directionH.scrollFactor.x = 0;
		directionH.scrollFactor.y = 0;
		interfaceLayer.add(directionH);
		
		directionV = new FlxText(10, 40, 200);
		directionV.scrollFactor.x = 0;
		directionV.scrollFactor.y = 0;
		interfaceLayer.add(directionV);
		
		txtDistance = new FlxText(70, 90, 200);
		txtDistance.scrollFactor.x = 0;
		txtDistance.scrollFactor.y = 0;
		interfaceLayer.add(txtDistance);
		
		//txtDangerSuit = new FlxText(10, map.y + map.height + 5, 200);
		//txtDangerSuit.scrollFactor.x = 0;
		//txtDangerSuit.scrollFactor.y = 0;
		//interfaceLayer.add(txtDangerSuit);
		
		//txtLeak = new FlxText(10, txtDangerSuit.y + txtDangerSuit.height + 5, 200);
		//txtLeak.scrollFactor.x = 0;
		//txtLeak.scrollFactor.y = 0;
		//interfaceLayer.add(txtLeak);
		//txtLeak.text = "Vazamento";
		//txtLeak.visible = false;
		
		suitDamageBar = new HudBar(/*0xffff0000, player, "suitDamage", 100, 1, 10, txtDangerSuit.y + 10*/);
		interfaceLayer.add(suitDamageBar);
		
		//redBackground.makeGraphic(FlxG.width, FlxG.height, 0xffff0000);
		//interfaceLayer.add(redBackground);
		//redBackground.alpha = 0;
		
		FlxG.sound.playMusic(AssetPaths.SpaceAtmosphere2__mp3);
		
		FlxG.watch.add(FlxG.worldBounds, "x");
		FlxG.watch.add(FlxG.worldBounds, "y");
		FlxG.watch.add(FlxG.worldBounds, "bottom");
		FlxG.watch.add(FlxG.worldBounds, "right");
		//FlxG.watch.add(level, "width");
		//FlxG.watch.add(level, "height");
		FlxG.watch.add(player, "x");
		FlxG.watch.add(player, "y");
	}
	
	
	private function setupLevel():Void {
		
	}
	
	private function setupCamera():Void {
		gameCamera = new FlxCamera(0, 0, FlxG.width, FlxG.height, 1);
		
		gameCamera.follow(player, FlxCamera.STYLE_PLATFORMER, new FlxPoint(0, 0));
		gameCamera.setBounds(0, 0, level.width, level.height);
		FlxG.cameras.add(gameCamera);
	}
	
	//TODO: override public function update():void
	override public function update():Void 
	{
		super.update();
	}
	
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