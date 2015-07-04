package game.gui;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;

using flixel.util.FlxSpriteUtil;

/**
 * ...
 * @author Jayson Weslley Cezar Silva
 */
class Radar extends FlxSprite
{
	//Radar.hx --> Map.as
	
	public var bussola(default, null): FlxSprite;
	public var player(default, null): FlxSprite;
	private var gameCore: GameCore;
	
	private var center: FlxPoint = new FlxPoint();
	public var pos: FlxPoint = new FlxPoint();
	
	private inline static var  WIDTH: Float = 50;
	private inline static var HEIGHT: Float = 50;
	private inline static var BUSSOLA_COLOR: Float = 0x7f00ff00;
	private inline static var TILE_SIZE: Float = 1;
	private inline static var TILE_COLOR: Float = 0xff00ff00;
	
	private var bussolaArray: Array<FlxSprite>;
	private var posArray: Array<FlxPoint>;
	
	private var i:Int;
	
	public function new(X: Float, Y: Float, gameCore: GameCore, posArray: Array<FlxPoint>) 
	{
		super(X, Y);
		
		//makeGraphic(20, 20);
		makeGraphic(gameCore.level.widthInTiles, gameCore.level.heightInTiles, FlxColor.TRANSPARENT, true);
		
		this.gameCore = gameCore;
		
		gameCore.interfaceLayer.add(this);
		
		bussola = new FlxSprite();
		bussola.makeGraphic(5, 5, BUSSOLA_COLOR);
		bussola.scrollFactor.x = 0;
		bussola.scrollFactor.y = 0;
		
		this.posArray = posArray;
		
		var point: FlxSprite;
		bussolaArray = new Array();
		
		
		//ISSUE: Instead of instatiate sprites, use this instead:
		//	var lineStyle = { color: FlxColor.RED, thickness: 1 };
		//var fillStyle = { color: FlxColor.RED, alpha: 0.5 };
		//// Circle
		//canvas.drawCircle(X, Y, Radius, Color, lineStyle, fillStyle);
		//
		//// Ellipse
		//canvas.drawEllipse(X, Y, Width, Height, Color, lineStyle, fillStyle);
		//
		//// Line
		//canvas.drawLine(StartX, StartY, EndX, EndY, lineStyle);
		//
		
		var lineStyle = { thickness: 1, color: FlxColor.GREEN };
		var fillStyle = { color: FlxColor.GREEN, alpha: 0.5 };
		
		for (pos in posArray) 
		{
			this.drawCircle(pos.x / 40, pos.y / 40, 1, 0x7f0000ff, { thickness: 1, color: FlxColor.GREEN }, fillStyle);
			//point = new FlxSprite();
			//point.scrollFactor.x = 0;
			//point.scrollFactor.y = 0;
			//point.makeGraphic(1, 1, 0x7f0000ff);
			//gameCore.interfaceLayer.add(point);
			//this.bussolaArray.push(point);
		}
		
		scrollFactor.x = 0;
		scrollFactor.y = 0;
		makeGraphic(WIDTH, HEIGHT, 0x00000000);
		
		player = new FlxSprite(x + width / 2, y + height / 2);
		player.makeGraphic(3, 3, 0xffffffff);
		player.x -= player.width / 2;
		player.y -= player.height / 2;
		player.scrollFactor.x = 0;
		player.scrollFactor.y = 0;
	}
	
	override public function update():Void {
		super.update();
		
		center.x = gameCore.player.x / 40;
		center.y = gameCore.player.y / 40;
		
		this.x = 50 - center.x;
		this.y = 50 - center.y;
		
		//center.x = gameCore.level.width / 2;
		//center.y = gameCore.level.height / 2;
		//
		//pos.x = center.x - gameCore.player.x;
		//pos.y = center.y - gameCore.player.y;
		//
		//if (gameCore.player.x < gameCore.level.width && gameCore.player.x > 0)
			//bussola.x = (pos.x / gameCore.level.width) * WIDTH * 2 + x + (WIDTH / 2) - (bussola.width / 2);
		//else if (gameCore.player.x <= 0) {
			//bussola.x = x + width - (bussola.width / 2);
			//bussola.makeGraphic(5, 5, 0x7fff0000);
		//}
		//else {
			//bussola.x = x - (bussola.width / 2);
			//bussola.makeGraphic(5, 5, 0x7fff0000);
		//}
		//
		//if (gameCore.player.y < gameCore.level.height && gameCore.player.y > 0)
			//bussola.y = (pos.y / gameCore.level.height) * HEIGHT * 2 + y + (HEIGHT / 2) - (bussola.height / 2);
		//else if (gameCore.player.y <= 0) {
			//bussola.makeGraphic(5, 5, 0x7fff0000);
			//bussola.y = y + height - (bussola.height / 2);
		//}
		//else {
			//bussola.makeGraphic(5, 5, 0x7fff0000);
			//bussola.y = y - (bussola.height / 2);
		//}
		//
		//if (gameCore.player.x < gameCore.level.width && gameCore.player.x > 0
			//&& gameCore.player.y < gameCore.level.height && gameCore.player.y > 0)
				//bussola.makeGraphic(5, 5, BUSSOLA_COLOR);
		//
		//i = 0;
		
		//while (i < bussolaArray.length)
		//{
			//updatePoint(bussolaArray[i], posArray[i]);
			//i++;
		//}
		
		//updatePoint(this, new FlxPoint(50, 50));
	}
	
	private function updatePoint(point:FlxSprite, tilePos:FlxPoint):Void {
		//var pos: FlxPoint = new FlxPoint();
		//
		//pos.x = tilePos.x /*- gameCore.player.x*/;
		//pos.y = tilePos.y /*- gameCore.player.y*/;
		
		//if (gameCore.player.x < gameCore.level.width && gameCore.player.x > 0)
			//point.x = (pos.x / gameCore.level.width) * WIDTH * 2 + x + (width / 2) - (point.width / 2);
		//else if (gameCore.player.x <= 0) {
			//point.x = x + width - (point.width / 2);
			////point.makeGraphic(TILE_SIZE, TILE_SIZE, TILE_COLOR);
		//}
		//else {
			//point.x = x - (point.width / 2);
			////point.makeGraphic(TILE_SIZE, TILE_SIZE, TILE_COLOR);
		//}
		//
		//if (gameCore.player.y < gameCore.level.height && gameCore.player.y > 0)
			//point.y = (pos.y / gameCore.level.height) * HEIGHT * 2 + y + (height / 2) - (point.height / 2);
		//else if (gameCore.player.y <= 0) {
			////point.makeGraphic(TILE_SIZE, TILE_SIZE, TILE_COLOR);
			//point.y = y + height - (point.height / 2);
		//}
		//else {
			////point.makeGraphic(TILE_SIZE, TILE_SIZE, TILE_COLOR);
			//point.y = y - (point.height / 2);
		//}
		//
		//if (gameCore.player.x < gameCore.level.width && gameCore.player.x > 0
			//&& gameCore.player.y < gameCore.level.height && gameCore.player.y > 0) {
				////point.makeGraphic(TILE_SIZE, TILE_SIZE, TILE_COLOR);
		//}
	}
	
}