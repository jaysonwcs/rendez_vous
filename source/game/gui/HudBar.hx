package game.gui;

import flixel.FlxSprite;
import flixel.group.FlxGroup;

/**
 * ...
 * @author Jayson Weslley Cezar Silva
 */
class HudBar extends FlxGroup
{
	private var parentRef:Dynamic;
	private var variable:String;
	private var color:Int;
	
	private var bar: FlxSprite;
	private var border: FlxSprite;
	private var width: Int;
	private var height: Int;
	private var x: Float;
	private var y: Float;
	
	private var value: Float;
	private var range: Float;
	
	private var worst: Float;
	
	/**
	 * 
	 * 
	 * @param	color
	 * @param	parentRef
	 * @param	variable
	 * @param	range
	 * @param	worst	If 1: when bigger, worst.
	 * 					If 0: when lower, worst.
	 * @param	x
	 * @param	y
	 * @param	width
	 * @param	height
	 */
	public function new(color:Int, parentRef:Dynamic, variable:String, range: Float, worst: Float, x: Float = 0, y: Float = 0, width: Int = 202, height: Int = 7) 
	{
		super();
		
		this.color = color;
		this.parentRef = parentRef;
		this.variable = variable;
		this.width = width;
		this.height = height;
		this.range = range;
		this.worst = worst;
		
		border = new FlxSprite(x, y);
		border.makeGraphic(width, height, 0x7fffffff);
		border.scrollFactor.x = 0;
		border.scrollFactor.y = 0;
		add(border);
		
		bar = new FlxSprite(x + 1, y + 1);
		bar.makeGraphic(width - 2, height - 2, color);
		bar.visible = false;
		bar.scrollFactor.x = 0;
		bar.scrollFactor.y = 0;
		add(bar);
	}
	
	override public function update():Void {
		if (Reflect.field(parentRef, variable) != value) {
			value = Reflect.field(parentRef, variable);
			
			var ratio: Float = value / range;
			var barSize: Float = ratio * (width - 2);
			
			if (barSize > 1) {
				bar.makeGraphic(Math.round(value / range * (width - 2)), height - 2, color);
				bar.visible = true;
				
				if (worst == 0) {
					if (ratio < 0.25)
						border.color = 0x7fffff00;
					else
						border.color = 0x7fffffff;
				} else if (worst == 1) {
					if (ratio >= 1) {
						border.color = 0x7fff0000;
					} else if (ratio > 0.75)
						border.color = 0x7fffff00;
					else
						border.color = 0x7fffffff;
				}
			} else if (worst == 0){
				bar.visible = false;
				border.color = 0x07ff0000;
			}
		}
	}
	
}