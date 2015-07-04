package game;

import flixel.addons.editors.tiled.TiledLayer;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
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
	public var isPaused(default, null): Bool;
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
	
	public var life(never, set): Float;
	
	override public function create():Void
	{
		super.create();
		
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
		
		backgroundLayer.add(backgroundMap);
		
		player = new MainCharacter(this, inventory);
		
		setupCamera();
		
		LevelGenerator.generateLevel(this);
		objectsMap.destroy();
		
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
		txtXVelocity.text = Std.string(Math.abs(player.velocity.x));
		
		txtAir = new FlxText(10, 60, 200);
		txtAir.scrollFactor.x = 0;
		txtAir.scrollFactor.y = 0;
		interfaceLayer.add(txtAir);
		txtAir.text = Std.string(player.airTime);
		
		txtFuel = new FlxText(10, 70, 200);
		txtFuel.scrollFactor.x = 0;
		txtFuel.scrollFactor.y = 0;
		interfaceLayer.add(txtFuel);
		txtFuel.text = Std.string(player.fuel);
		
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
		
		txtYVelocity = new FlxText(10, 20, 200);
		txtYVelocity.scrollFactor.x = 0;
		txtYVelocity.scrollFactor.y = 0;
		interfaceLayer.add(txtYVelocity);
		txtYVelocity.text = Std.string(Math.abs(player.velocity.y));
		txtYVelocity.text = Std.string(player.life);
		
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
		
		txtDangerSuit = new FlxText(10, map.y + map.height + 5, 200);
		txtDangerSuit.scrollFactor.x = 0;
		txtDangerSuit.scrollFactor.y = 0;
		interfaceLayer.add(txtDangerSuit);
		
		txtLeak = new FlxText(10, txtDangerSuit.y + txtDangerSuit.height + 5, 200);
		txtLeak.scrollFactor.x = 0;
		txtLeak.scrollFactor.y = 0;
		interfaceLayer.add(txtLeak);
		txtLeak.text = "Vazamento";
		txtLeak.visible = false;
		
		suitDamageBar = new HudBar(0xffff0000, player, "suitDamage", 100, 1, 10, txtDangerSuit.y + 10);
		interfaceLayer.add(suitDamageBar);
		
		redBackground.makeGraphic(FlxG.width, FlxG.height, 0xffff0000);
		interfaceLayer.add(redBackground);
		redBackground.alpha = 0;
		
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
	
	override public function update():Void
	{
		//if (Constants.isDebugBuild)
		//{
			//updateDebugMode();
		//}
		
		if (!isPaused)
		{
			if (FlxG.keys.pressed.X)
				FlxG.timeScale /= 8;
			
			super.update();
			
			vectorVelocity = Math.round(Math.sqrt(Math.pow(player.velocity.x, 2) + Math.pow(player.velocity.y, 2)));
			if (vectorVelocity > DEATH_VELOCITY)
				txtXVelocity.color = 0xffff0000;
			else if (vectorVelocity > WARNING_VELOCITY)
				txtXVelocity.color = 0xffffff00;
			else
				txtXVelocity.color = 0xffffffff;
			
			FlxG.collide(player, level, playerLevelColision);
			FlxG.collide(player, boxesList);
			FlxG.collide(boxesList, level);
			
			//txtXVelocity.text = Math.abs(player.velocity.x).toString();
			txtXVelocity.text = Std.string(vectorVelocity);
			
			if (player.velocity.x > 0) {
				directionH.text = "-> ";
			} else if (player.velocity.x < 0) {
				directionH.text = "<- ";
			} else
				directionH.text = "";
			
			directionH.text = directionH.text + Std.string(Math.round(Math.abs(player.velocity.x)));
			
			if (player.velocity.y > 0) {
				directionV.text = "V ";
			} else if (player.velocity.y < 0) {
				directionV.text = "A ";
			} else
				directionV.text = "";
			
			directionV.text = directionV.text + Std.string(Math.round(Math.abs(player.velocity.y)));
			
			txtAir.text = "Ar:";
			if ((player.airTime / MainCharacter.AIRTIME * 200) >= 1)  {
				airBar.makeGraphic(Math.round(player.airTime / MainCharacter.AIRTIME * 200), 5, 0xff0000ff);
				airBar.visible = true;
				
				if ((player.airTime / MainCharacter.AIRTIME) < 0.25)
					airBarBase.color = 0x7fffff00;
				else
					airBarBase.color = 0x7fffffff;
			}
			else {
				airBar.visible = false;
				airBarBase.color = 0x7fff0000;
			}
			
			txtFuel.text = "Combustível:";
			if ((player.fuel / MainCharacter.FUEL * 200) >= 1) {
				fuelBar.makeGraphic(Math.round(player.fuel / MainCharacter.FUEL * 200), 5, 0xff00ff00);
				fuelBar.visible = true;
				
				if ((player.fuel / MainCharacter.FUEL) < 0.25)
					fuelBarBase.color = 0x7fffff00;
				else
					fuelBarBase.color = 0x7fffffff;
			}
			else {
				fuelBar.visible = false;
				fuelBarBase.color = 0x7fff0000;
			}
			
			
			//txtDistance.text = "Distância: " + Utils.formatWithZerosString(hudFormatter.formatNumber(new Number(Math.round(Math.sqrt(Math.pow(map.pos.x, 2) + Math.pow(map.pos.y, 2))) / 40)), 3, hudFormatter);
			txtDistance.text = "Distância: " + Std.string(Math.round(Math.sqrt(Math.pow(map.pos.x, 2) + Math.pow(map.pos.y, 2))) / 40);
			
			txtDangerSuit.text = "Danos à roupa: " + Std.string(Math.round(player.suitDamage));
			
			if (player.suitDamage >= 100)
				txtLeak.visible = true;
				
			if (player.acceleration.x > 0 && !player.isTouching(FlxObject.RIGHT)) {
				player.impulse = true;
				player.acceleration.x = 0;
				player.velocity.x = 0;
			}
			if (player.acceleration.x < 0 && !player.isTouching(FlxObject.LEFT)) {
				player.impulse = true;
				player.acceleration.x = 0;
				player.velocity.x = 0;
			}
			if (player.acceleration.y > 0 && !player.isTouching(FlxObject.DOWN)) {
				player.impulse = true;
				player.acceleration.y = 0;
				player.velocity.y = 0;
			}
			if (player.acceleration.y < 0 && !player.isTouching(FlxObject.UP)) {
				player.impulse = true;
				player.acceleration.y = 0;
				player.velocity.y = 0;
			}
			
			if (FlxG.keys.justPressed.P || FlxG.keys.justPressed.ESCAPE)
				pause();
		}
		else
		{
			inventory.update();
			
			if (FlxG.keys.justPressed.P || FlxG.keys.justPressed.ESCAPE)
				unpause();
		}
	}
	
	private function playerLevelColision(obj1: FlxObject, obj2: FlxObject):Void
	{
		if (player.isTouching(FlxObject.WALL) || player.isTouching(FlxObject.CEILING) || player.isTouching(FlxObject.FLOOR))
			if (vectorVelocity > DEATH_VELOCITY)
					player.kill();
			else if (vectorVelocity > WARNING_VELOCITY) {
				var dangerVelocityRange: Float = DEATH_VELOCITY - WARNING_VELOCITY;
				var dangerImpactRatio: Float = (vectorVelocity - dangerVelocityRange) / dangerVelocityRange;
				
				player.suitDamage += dangerImpactRatio * 100;
			}
		
		if (player.velocity.x > 0) {
			player.velocity.x -= 100;
			if (player.velocity.x < 0)
				player.velocity.x = 0;
		}
		else if (player.velocity.x < 0) {
			player.velocity.x += 100;
			if (player.velocity.x > 0)
				player.velocity.x = 0;
		}
		
		if (player.velocity.y > 0) {
			player.velocity.y -= 100;
			if (player.velocity.y < 0)
			player.velocity.y = 0;
		} else if (player.velocity.y < 0) {
			player.velocity.y += 100;
			if (player.velocity.y > 0)
			player.velocity.y = 0;
		}
		
		if (player.isTouching(FlxObject.RIGHT))
			player.acceleration.x = 100;
		
		if (player.isTouching(FlxObject.LEFT))
			player.acceleration.x = -100;
		
		if (player.isTouching(FlxObject.UP))
			player.acceleration.y = -100;
		
		if (player.isTouching(FlxObject.DOWN))
			player.acceleration.y = 100;
	}
	
	public function pause():Void {
		isPaused = true;
		
		FlxG.mouse.visible = true;
		interfaceLayer.add(inventory);
		
		//FlxG.play(Assets.sfxPause);
		//if (Utils.playingGameMusic1)
			//FlxG.music.volume -= 0.8;
		//else
			//FlxG.music.volume -= 0.3;
	}
	
	public function unpause():Void {
		isPaused = false;
		FlxG.mouse.visible = false;
		interfaceLayer.remove(inventory);
		//FlxG.play(Assets.sfxPauseEnd);
		//if (Utils.playingGameMusic1)
			//FlxG.music.volume += 0.8;
		//else
			//FlxG.music.volume += 0.3;
	}
	
	public function resetHud():Void {
		//txtXVelocity.text = "0";
		//txtYVelocity.text = "3";
	}
	
	public function blinkRed(redBlinkingSpeed:Float):Void
	{
		if (redBackground.alpha >= 1)
			fadingOut = true;
		else if (redBackground.alpha <= 0)
			fadingOut = false;
		
		if (fadingOut)
			redBackground.alpha -= redBlinkingSpeed;
		else if (!fadingOut)
			redBackground.alpha += redBlinkingSpeed;
	}
	
	public function resetBlinkRed():Void {
		redBackground.alpha = 0;
	}
	
	public function set_life(value: Float):Float
	{
		txtYVelocity.text = Std.string(value);
		
		return value;
	}
	
}