package game;

import flixel.addons.editors.tiled.TiledLayer;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.input.keyboard.FlxKeyList;
import game.inventory.Inventory;
import flixel.util.FlxPoint;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import game.objects.AirTank;
import game.objects.FuelTank;
import game.objects.Tank;
import game.utils.Constants;

/**
 * ...
 * @author Jayson Weslley Cezar Silva
 */
class MainCharacter extends FlxSprite
{

	//[Embed(source = '../../assets/spritesheets/astronauta.png')] public static var playerImg:Class;
	//[Embed(source = '../../assets/sfx/hurt.mp3')] public static var hurtSfx:Class;
	
	//public var controller: ICharacterController;
	public var life: Float;
	private var dying: Bool;
	private var gameCore: GameCore;
	private var counter: Float;
	
	public var lastVelocity: FlxPoint;
	
	private var leftBtnPressed: Bool;
	private var rightBtnPressed: Bool;
	private var upBtnPressed: Bool;
	private var downBtnPressed: Bool;
	
	private var deathBlank: FlxSprite;
	
	//Our emmiter
	private var theEmitter:FlxEmitter;

	//Our white pixel (This is to prevent creating 200 new pixels all to a new variable each loop)
	private var whitePixel:FlxParticle;
	
	private var inventory: Inventory;
	
	public var fuel: Float;
	public var airTime: Float;
	public static inline var AIRTIME: Float = 300;
	public static inline var FUEL: Float = 15;
	public var lastBreath: Float;
	public static inline var LASTBREATH: Float = 10;
	
	public var impulse: Bool;
	
	private var currentlyTile: FlxPoint;
	
	private var currentTileX: Int;
	private var currentTileY: Int;
	
	private var posToCalcTile: FlxPoint;
	
	private var upRightTile: Float;
	private var upUpRightTile: Float;
	private var upLeftTile: Float;
	private var upUpLeftTile: Float;
	private var upTile: Float;
	private var downRightTile: Float;
	private var downLeftTile: Float;
	private var downTile: Float;
	private var leftTile: Float;
	private var rightTile: Float;
	
	private var currentlyTileNum: Float;
	
	private var turning: Bool;
	private var fillingAirTank:Bool;
	private var oldVelocity:FlxPoint;
	private var fillingFuelTank:Bool;
	private var fillingTank: Bool;
	
	public var suitDamage(default, set): Float;
	
	private var keysJustPressed: FlxKeyList;
	private var keysPressed: FlxKeyList;
	private var keysJustReleased: FlxKeyList;
	
	private var flicking: Bool = false;
	private var lastFlickingStatus: Bool;
	private var flickerTime: Float;
	private static inline var FLICKER_TIME: Float = 0.1;
	private var flickerDuration: Float;
	
	
	public function new(gameCore: GameCore, inventory: Inventory, fuel: Float = FUEL) 
	{
		super();
		
		loadGraphic(AssetPaths.astronauta__png, true, 39, 61);
		
		drag.x = 0;
		drag.y = 0;
		maxVelocity.x = 1000000000;
		maxVelocity.y = 1000000000;
		life = 3;
		airTime = AIRTIME;
		this.fuel = fuel;
		lastBreath = LASTBREATH;
		counter = 1;
		
		this.inventory = inventory;
		
		theEmitter = new FlxEmitter(this.x + 20, this.y + 30, 50);
		theEmitter.lifespan = 0.5;
		//Now by default the emitter is going to have some properties set on it and can be used immediately
		//but we're going to change a few things.

		//Let's also make our pixels rebound off surfaces
		//theEmitter.bounce = .8;

		//Now let's add the emitter to the state.
		gameCore.gameLayer.add(theEmitter);
		
		//Now it's almost ready to use, but first we need to give it some pixels to spit out!
		//Lets fill the emitter with some white pixels
		var i: Float = 0;
		while (i < theEmitter.maxSize / 2)
		{
			whitePixel = new FlxParticle();
			whitePixel.makeGraphic(2, 2, 0xFFFFFFFF);
			whitePixel.visible = false; //Make sure the particle doesn't show up at (0, 0)
			theEmitter.add(whitePixel);
			whitePixel = new FlxParticle();
			whitePixel.makeGraphic(1, 1, 0xFFFFFFFF);
			whitePixel.visible = false;
			theEmitter.add(whitePixel);
			i += 1;
		}
		
		//width = 20;
		//height = 35;
		//offset.x = 15;
		//offset.y = 12;
		
		lastVelocity = new FlxPoint();
		
		posToCalcTile = new FlxPoint();
		currentlyTile = new FlxPoint();
		oldVelocity = new FlxPoint();
		
		suitDamage = 0;
		
		this.gameCore = gameCore;
		
		FlxG.watch.add(acceleration, "x");
		FlxG.watch.add(velocity, "x");
	}
	
	override public function update():Void {
		super.update();
		
		if (flicking)
			flicker();
		
		if (airTime >= 0)
			if (suitDamage >= 100)
				airTime -= FlxG.elapsed * 5;
			else
				airTime -= FlxG.elapsed;
		else {
			lastBreath -= FlxG.elapsed;
			
			if (lastBreath > 5)
				gameCore.blinkRed(0.05);
			else if (lastBreath > 2)
				gameCore.blinkRed(0.1);
			else
				gameCore.blinkRed(0.2);
		}
		
		if (lastBreath <= 0)
			kill();
		
		if (!isTouching(FlxObject.ANY))
			dying = false;
			
		lastVelocity.x = velocity.x;
		lastVelocity.y = velocity.y;
		
		keysJustPressed = FlxG.keys.justPressed;
		keysPressed = FlxG.keys.pressed;
		keysJustReleased = FlxG.keys.justReleased;
		
		if (keysJustPressed.SPACE) {
			FlxG.overlap(this, gameCore.inventoryItemsList, function (obj1: FlxObject, obj2: FlxObject):Void 
			{
				gameCore.gameLayer.remove(obj2);
				inventory.add(obj2);
			});
		}
		
		if (keysPressed.SPACE) {
			FlxG.overlap(this, gameCore.airTanksList, fillAirTank);
			FlxG.overlap(this, gameCore.fuelTanksList, fillFuelTank);
		}
		
		if (keysJustReleased.SPACE || fillingTank && ((airTime >= AIRTIME) ||
			(fillingFuelTank && fuel >= FUEL))) {
			if (airTime >= AIRTIME)
				airTime = AIRTIME;
				
			if (fuel >= FUEL)
				fuel = FUEL;
			
			fillingTank = false;
			velocity = oldVelocity;
		}
		
		posToCalcTile.x = x + width/2;
		posToCalcTile.y = y + height/2;
		
		//currentlyTile.x = Math.floor(posToCalcTile.x / 20/*Constants.TILE_SIZE*/);
		//currentlyTile.y = Math.floor(posToCalcTile.y / 20/*Constants.TILE_SIZE*/);
		
		currentTileX = Math.floor(posToCalcTile.x / Constants.TILE_SIZE);
		currentTileY = Math.floor(posToCalcTile.y / Constants.TILE_SIZE);
		
		currentlyTileNum = gameCore.level.getTile(currentTileX, currentTileY);
		upRightTile = gameCore.level.getTile(currentTileX + 1, currentTileY - 1);
		upUpRightTile = gameCore.level.getTile(currentTileX + 1, currentTileY - 2);
		upLeftTile = gameCore.level.getTile(currentTileX - 1, currentTileY - 1);
		upUpLeftTile = gameCore.level.getTile(currentTileX - 1, currentTileY - 2);
		upTile = gameCore.level.getTile(currentTileX, currentTileY - 1);
		downRightTile = gameCore.level.getTile(currentTileX + 1, currentTileY + 1);
		downLeftTile = gameCore.level.getTile(currentTileX - 1, currentTileY + 1);
		downTile = gameCore.level.getTile(currentTileX, currentTileY + 1);
		rightTile = gameCore.level.getTile(currentTileX + 1, currentTileY);
		leftTile = gameCore.level.getTile(currentTileX - 1, currentTileY);
		
		if (!fillingTank) {
			if((keysPressed.A || keysPressed.LEFT) && fuel > 0 && !impulse && acceleration.x == 0 && acceleration.y == 0) {
				fuel -= FlxG.elapsed;
				
				theEmitter.x = this.x + 20 + (velocity.x / 30);
				theEmitter.y = this.y + 30 + (velocity.y / 30);
				
				facing = FlxObject.LEFT;
				velocity.x -= 10;
				leftBtnPressed = true;
				theEmitter.setXSpeed(100 + this.velocity.x, 250 + this.velocity.x);
				theEmitter.setYSpeed(-25 + this.velocity.y, 25 + this.velocity.y);
				theEmitter.emitParticle();
				theEmitter.emitParticle();
				theEmitter.emitParticle();
			}
			if((keysPressed.D || keysPressed.RIGHT) && fuel > 0 && !impulse && acceleration.x == 0 && acceleration.y == 0) {
				fuel -= FlxG.elapsed;
				
				theEmitter.x = this.x + 20 + (velocity.x / 30);
				theEmitter.y = this.y + 30 + (velocity.y / 30);
				
				facing = FlxObject.RIGHT;
				velocity.x += 10;
				rightBtnPressed = true;
				theEmitter.setXSpeed(-100 + this.velocity.x, -250 + this.velocity.x);
				theEmitter.setYSpeed(-25 + this.velocity.y, 25 + this.velocity.y);
				theEmitter.emitParticle();
				theEmitter.emitParticle();
				theEmitter.emitParticle();
			}
			if ((keysPressed.W || keysPressed.UP) && fuel > 0 && !impulse && acceleration.x == 0 && acceleration.y == 0) {
				fuel -= FlxG.elapsed;
				
				theEmitter.x = this.x + 20 + (velocity.x / 30);
				theEmitter.y = this.y + 30 + (velocity.y / 30);
				
				velocity.y -= 10;
				upBtnPressed = true;
				theEmitter.setYSpeed(100 + this.velocity.y, 250 + this.velocity.y);
				theEmitter.setXSpeed(-25 + this.velocity.x, 25 + this.velocity.x);
				theEmitter.emitParticle();
				theEmitter.emitParticle();
				theEmitter.emitParticle();
			}
			if ((keysPressed.S || keysPressed.DOWN) && fuel > 0 && !impulse && acceleration.x == 0 && acceleration.y == 0) {
				fuel -= FlxG.elapsed;
				
				theEmitter.x = this.x + 20 + (velocity.x / 30);
				theEmitter.y = this.y + 30 + (velocity.y / 30);
				
				velocity.y += 10;
				downBtnPressed = true;
				theEmitter.setYSpeed(-100 + this.velocity.y, -250 + this.velocity.y);
				theEmitter.setXSpeed(-25 + this.velocity.x, 25 + this.velocity.x);
				theEmitter.emitParticle();
				theEmitter.emitParticle();
				theEmitter.emitParticle();
			}
			
			//Walking on the right
			if (acceleration.x > 0) {
				if ((keysPressed.W || keysPressed.UP)) {
					velocity.y = -50;
				} else if ((keysPressed.S || keysPressed.DOWN)) {
					velocity.y = 50;
				} else if (keysPressed.D || keysPressed.RIGHT) {
					if (upRightTile == 0) {
						velocity.y = -50;
						turning = true;
					} else if (downRightTile == 0) {
						velocity.y = 50;
						turning = true;
					}
				} else if (keysJustPressed.A || keysJustPressed.LEFT) {
					acceleration.x = 0;
					velocity.x = -50;
					velocity.y = 0;
					impulse = true;
				}
			} else if (turning && impulse && (keysPressed.D || keysPressed.RIGHT)) {
				if (upRightTile == 0) {
					turning = false;
					velocity.x = 50;
					velocity.y = 50;
				} else if (downRightTile == 0) {
					turning = false;
					velocity.x = 50;
					velocity.y = -50;
				}
			}
			
			//Walking on the left
			if (acceleration.x < 0) {
				if ((keysPressed.W || keysPressed.UP)) {
					velocity.y = -50;
				} else if ((keysPressed.S || keysPressed.DOWN)) {
					velocity.y = 50;
				} else if (keysPressed.A || keysPressed.LEFT) {
					if (upLeftTile == 0) {
						velocity.y = -50;
						turning = true;
					} else if (downLeftTile == 0) {
						velocity.y = 50;
						turning = true;
					}
				} else if (keysJustPressed.D || keysJustPressed.RIGHT) {
					acceleration.x = 0;
					velocity.x = 50;
					velocity.y = 0;
					impulse = true;
				}
			} else if (turning && impulse && (keysPressed.A || keysPressed.LEFT)) {
				if (upLeftTile == 0) {
					turning = false;
					velocity.x = -50;
					velocity.y = 50;
				} else if (downLeftTile == 0) {
					turning = false;
					velocity.x = -50;
					velocity.y = -50;
				}
			}
			
			//Walking on down
			if (acceleration.y > 0) {
				if ((keysPressed.A || keysPressed.LEFT)) {
					velocity.x = -50;
				} else if ((keysPressed.D || keysPressed.RIGHT)) {
					velocity.x = 50;
				} else if (keysPressed.S || keysPressed.DOWN) {
					if (downLeftTile == 0) {
						velocity.x = -50;
						turning = true;
					} else if (downRightTile == 0) {
						velocity.x = 50;
						turning = true;
					}
				} else if (keysJustPressed.W || keysJustPressed.UP) {
					acceleration.y = 0;
					velocity.x = 0;
					velocity.y = -50;
					impulse = true;
				}
			} else if (turning && impulse && (keysPressed.S || keysPressed.DOWN)) {
				if (downLeftTile == 0) {
					turning = false;
					velocity.y = 50;
					velocity.x = 50;
				} else if (downRightTile == 0) {
					turning = false;
					velocity.y = 50;
					velocity.x = -50;
				}
			}
			
			//Walking on up
			if (acceleration.y < 0) {
				if ((keysPressed.A || keysPressed.LEFT)) {
					velocity.x = -50;
				} else if ((keysPressed.D || keysPressed.RIGHT)) {
					velocity.x = 50;
				} else if (keysPressed.W || keysPressed.UP) {
					if (upLeftTile == 0) {
						velocity.x = -50;
						turning = true;
					} else if (upRightTile == 0) {
						velocity.x = 50;
						turning = true;
					}
				} else if (keysJustPressed.S || keysJustPressed.DOWN) {
					acceleration.y = 0;
					velocity.y = 50;
					velocity.x = 0;
					impulse = true;
				}
			} else if (turning && impulse && (keysPressed.W || keysPressed.UP)) {
				if (upLeftTile == 0) {
					turning = false;
					velocity.y = -50;
					velocity.x = 50;
				} else if (upRightTile == 0) {
					turning = false;
					velocity.y = -50;
					velocity.x = -50;
				}
			}
		}
		
		if (keysJustReleased.A || keysJustReleased.LEFT){
			leftBtnPressed = impulse = turning = false;
		}
		if(keysJustReleased.D || keysJustReleased.RIGHT){
			rightBtnPressed = impulse = turning = false;
		}
		if (keysJustReleased.W || keysJustReleased.UP){
			upBtnPressed = impulse = turning = false;
		}
		if (keysJustReleased.S || keysJustReleased.DOWN){
			downBtnPressed = impulse = turning = false;
		}
	}
	
	private function fillTank(tank: Tank):Void
	{
		if (keysJustPressed.SPACE) {
			oldVelocity = new FlxPoint(velocity.x, velocity.y);
			velocity.x = 0;
			velocity.y = 0;
		}
		
		fillingTank = true;
		
		if (tank.volume > 0) {
			tank.volume -= 1;
			
			if (Std.is(tank, AirTank)) {
				airTime += 1;
			} else if (Std.is(tank, FuelTank)) {
				fuel += 1;
			}
		} else {
			fillingTank = false;
			velocity = oldVelocity;
		}
	}
	
	private function fillAirTank(obj1: FlxObject, obj2: FlxObject):Void
	{
		if (airTime < AIRTIME && Std.is(obj2, AirTank)) {
			lastBreath = LASTBREATH;
			gameCore.resetBlinkRed();
			fillTank(cast(obj2, Tank));
		} else {
			fillingTank = false;
			velocity = oldVelocity;
		}
	}
	
	private function fillFuelTank(obj1: FlxObject, obj2: FlxObject):Void
	{
		if (fuel < FUEL && Std.is(obj2, FuelTank)) {
			fillTank(cast(obj2, Tank));
		} else {
			fillingTank = false;
			velocity = oldVelocity;
		}
	}
	
	override public function kill():Void {
		FlxG.resetState();
		
		velocity.x = 0;
		velocity.y = 0;
		
		airTime = 50;
		life = 3;
		gameCore.resetHud();
	}
	
	public function causeHurt():Void {
		if (!dying) {
			FlxG.sound.play(AssetPaths.hurt__mp3);
			
			dying = true;
			life -= 1;
			startFlicker(1);
			gameCore.life = life;
			velocity.x = -200;
			velocity.y = -200;
			
			if (life <= 0) {
				kill();
			}
		}
		else if (counter > 0) {
			counter -= FlxG.elapsed;
		}
		else if (counter <= 0) {
			counter = 1;
			dying = false;
		}
	}
	
	function startFlicker(duration: Float) 
	{
		flicking = true;
		flickerDuration = duration;
		flickerTime = FLICKER_TIME;
	}
	
	function flicker() 
	{
		flickerTime -= FlxG.elapsed;
		flickerDuration -= FlxG.elapsed;
		
		if (flickerDuration <= 0)
		{
			flicking = false;
			alpha = 1;
		}
		else 
		{
			if (flickerTime < 0)
			{
				flickerTime = FLICKER_TIME;
				
				if (alpha == 0)
				{
					alpha = 1;
				}
				else 
				{
					alpha = 0;
				}
			}
		}
	}
	
	public function set_suitDamage(value:Float):Float 
	{
		suitDamage = value;
		if (suitDamage > 100)
			suitDamage = 100;
		else if (suitDamage < 0)
			suitDamage = 0;
			
		return suitDamage;
	}
	
}