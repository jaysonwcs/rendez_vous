package game;

import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.util.FlxPoint;
import massive.munit.util.Timer;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;
import game.GameCore;

class GameCoreTest 
{
	var instance:GameCore;
	var playerPos: FlxPoint;
	
	public function new() 
	{
	}
	
	@BeforeClass
	public function beforeClass():Void
	{
	}
	
	@AfterClass
	public function afterClass():Void
	{
	}
	
	@Before
	public function setup():Void
	{
		instance = new GameCore();
	}
	
	@After
	public function tearDown():Void
	{
	}
	
	@Test
	public function testNew():Void
	{
		Assert.isNotNull(instance.backgroundLayer);
		Assert.isNotNull(instance.gameLayer);
		Assert.isNotNull(instance.boxesList);
		Assert.isNotNull(instance.interfaceLayer);
		Assert.isNotNull(instance.inventoryItemsList);
		Assert.isNotNull(instance.level);
		Assert.isNotNull(instance.objectsMap);
		Assert.isNotNull(instance.backgroundMap);
		Assert.isNotNull(instance.checkPointsList);
		Assert.isNotNull(instance.enemiesList);
		Assert.isNotNull(instance.airTanksList);
		Assert.isNotNull(instance.fuelTanksList);
	}
	
	@Test
	public function testCreate():Void
	{
		//For checking player position after
		var players: Array<FlxPoint> = instance.objectsMap.getTileCoords(1, false);
		if (players != null)
		{
			for (pos in players) 
			{
				playerPos = pos;
			}
		}
		
		//Executing method
		instance.create();
		
		//Checking for worldBounds
		Assert.areEqual(instance.level.width, FlxG.worldBounds.width);
		Assert.areEqual(instance.level.height, FlxG.worldBounds.height);
		Assert.areEqual(0, FlxG.worldBounds.left);
		Assert.areEqual(0, FlxG.worldBounds.top);
		
		//setupLevel();
		
		//add(backgroundLayer);
		//add(gameLayer);
		//add(interfaceLayer);
		Assert.areEqual(3, instance.length);
		
		//gameLayer.add(level);
		//gameLayer.add(inventoryItemsList);
		//gameLayer.add(boxesList);
		//gameLayer.add(airTanksList);
		//gameLayer.add(fuelTanksList);
		////gameLayer.add(checkPoints);
		////gameLayer.add(enemies);
		
		
		//backgroundLayer.add(backgroundMap);
		Assert.areEqual(1, instance.backgroundLayer.length);
		
		//player = new MainCharacter(this, inventory);
		var player = Reflect.field(instance, "player");
		Assert.isNotNull(player);
		//TODO: check if player is instantiated
		
		//setupCamera();
		Assert.isNotNull(instance.gameCamera);
		
		//LevelGenerator.generateLevel(this);
		Assert.areEqual(playerPos.x, player.x);
		Assert.areEqual(playerPos.y, player.y);
		//TODO: Continue testing the generateLevel process
		
		//objectsMap.destroy();
		Assert.isNull(instance.objectsMap);
		
		//gameLayer.add(player);
		Assert.areEqual(6, instance.gameLayer.length);
		
		//TODO: Continue testing
		//txtVelocity = new FlxText(10, 10, 200);
		//txtVelocity.scrollFactor.x = 0;
		//txtVelocity.scrollFactor.y = 0;
		//interfaceLayer.add(txtVelocity);
		//txtVelocity.text = "Velocidades:";
		//
		//txtXVelocity = new FlxText(10, 20, 200);
		//txtXVelocity.scrollFactor.x = 0;
		//txtXVelocity.scrollFactor.y = 0;
		//interfaceLayer.add(txtXVelocity);
		//txtXVelocity.text = Math.abs(player.velocity.x).toString();
		//
		//txtAir = new FlxText(10, 60, 200);
		//txtAir.scrollFactor.x = 0;
		//txtAir.scrollFactor.y = 0;
		//interfaceLayer.add(txtAir);
		//txtAir.text = player.airTime.toString();
		//
		//txtFuel = new FlxText(10, 70, 200);
		//txtFuel.scrollFactor.x = 0;
		//txtFuel.scrollFactor.y = 0;
		//interfaceLayer.add(txtFuel);
		//txtFuel.text = player.fuel.toString();
		//
		//airBarBase = new FlxSprite(txtAir.x + 79, txtAir.y + 1);
		//airBarBase.makeGraphic(202, 7, 0x7fffffff);
		//airBarBase.scrollFactor.x = 0;
		//airBarBase.scrollFactor.y = 0;
		//interfaceLayer.add(airBarBase);
		//
		//airBar = new FlxSprite(txtAir.x + 80, txtAir.y + 2);
		//airBar.makeGraphic(200, 5, 0xff0000ff);
		//airBar.scrollFactor.x = 0;
		//airBar.scrollFactor.y = 0;
		//interfaceLayer.add(airBar);
		//
		//fuelBarBase = new FlxSprite(txtFuel.x + 79, txtFuel.y + 1);
		//fuelBarBase.makeGraphic(202, 7, 0x7fffffff);
		//fuelBarBase.scrollFactor.x = 0;
		//fuelBarBase.scrollFactor.y = 0;
		//interfaceLayer.add(fuelBarBase);
		//
		//fuelBar = new FlxSprite(txtFuel.x + 80, txtFuel.y + 2);
		//fuelBar.makeGraphic(200, 5, 0xff00ff00);
		//fuelBar.scrollFactor.x = 0;
		//fuelBar.scrollFactor.y = 0;
		//interfaceLayer.add(fuelBar);
		//
		////txtYVelocity = new FlxText(10, 20, 200);
		////txtYVelocity.scrollFactor.x = 0;
		////txtYVelocity.scrollFactor.y = 0;
		////interfaceLayer.add(txtYVelocity);
		////txtYVelocity.text = Math.abs(player.velocity.y).toString();
		////txtYVelocity.text = player.life.toString();
		//
		//directionH = new FlxText(10, 30, 200);
		//directionH.scrollFactor.x = 0;
		//directionH.scrollFactor.y = 0;
		//interfaceLayer.add(directionH);
		//
		//directionV = new FlxText(10, 40, 200);
		//directionV.scrollFactor.x = 0;
		//directionV.scrollFactor.y = 0;
		//interfaceLayer.add(directionV);
		//
		//txtDistance = new FlxText(70, 90, 200);
		//txtDistance.scrollFactor.x = 0;
		//txtDistance.scrollFactor.y = 0;
		//interfaceLayer.add(txtDistance);
		//
		//txtDangerSuit = new FlxText(10, map.y + map.height + 5, 200);
		//txtDangerSuit.scrollFactor.x = 0;
		//txtDangerSuit.scrollFactor.y = 0;
		//interfaceLayer.add(txtDangerSuit);
		//
		//txtLeak = new FlxText(10, txtDangerSuit.y + txtDangerSuit.height + 5, 200);
		//txtLeak.scrollFactor.x = 0;
		//txtLeak.scrollFactor.y = 0;
		//interfaceLayer.add(txtLeak);
		//txtLeak.text = "Vazamento";
		//txtLeak.visible = false;
		//
		//suitDamageBar = new HudBar(0xffff0000, player, "suitDamage", 100, 1, 10, txtDangerSuit.y + 10);
		//interfaceLayer.add(suitDamageBar);
		//
		//redBackground.makeGraphic(FlxG.width, FlxG.height, 0xffff0000);
		//interfaceLayer.add(redBackground);
		//redBackground.alpha = 0;
		//
		//FlxG.playMusic(titleMusic);
	}
}