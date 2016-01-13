package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxCollision.pixelPerfectCheck;
import flixel.util.FlxSpriteUtil; 
import flixel.util.FlxPoint;
import openfl.Lib;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxTween.TweenOptions;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;


/**
 * BlendModes demo
 *
 * @author Lars Doucet
 * @link https://github.com/HaxeFlixel/flixel-demos/BlendModes
 */
enum Gstate {
		START; RUN; STOP;
		}
enum TouchState {
	Touch; noTouch; runTouch;
}
class PlayState extends FlxState
{
	private var _hitspr:FlxSprite;
	private var _hitspr_r:FlxSprite;
	private var _hitdown:FlxSprite;
	private var _hitup:FlxSprite;
		
	private var lines:FlxSprite;
	private var GameSta:Gstate = Gstate.RUN;
	private var _Touchstate:TouchState = runTouch;
	
	
	override public function create():Void
	{
		super.create();
		FlxG.cameras.bgColor  = 0xFFFFFFFF;
		//fade(Color:Int = FlxColor.BLACK, Duration:Float = 1, FadeIn:Bool = false, ?OnComplete:Void‑>Void, Force:Bool = false):Void
		FlxG.camera.fade(FlxColor.BLACK, 1,true);
		
		_hitspr = new FlxSprite();
		_hitspr.loadGraphic("assets/ui_left.png");
		_hitspr.y = 200;
		_hitspr.x = FlxG.width / 2 - 50;
		_hitspr.scale.y = 1.5;
		add(_hitspr);
		
		lines = new FlxSprite(0, 180);
		lines.loadGraphic("assets/ui_heart.png");
		lines.antialiasing = true;
		add(lines);
		
		_hitspr_r = new FlxSprite();
		_hitspr_r.loadGraphic("assets/ui_right.png");
		_hitspr_r.scale.y = 1.5;
		add(_hitspr_r);
		
		_hitdown = new FlxSprite();
		_hitdown.loadGraphic("assets/ui_down.png");
		add(_hitdown);
		
		_hitup = new FlxSprite();
		_hitup.loadGraphic("assets/ui_up.png");
		add(_hitup);
		
		FlxG.camera.antialiasing = true;
		
		/*var currentLoc = new FlxPoint(_hitspr.x, _hitspr.y);
		var p1 = new FlxPoint(100, 300);
		var p2 = new FlxPoint(200, 50);
		var p3 = new FlxPoint(300, 300);
		var options:TweenOptions = { type: FlxTween.PINGPONG, ease: FlxEase.quadIn };*/
		//FlxTween.linearPath(_hitspr, [currentLoc, p1, p2,p3],3);
		//FlxTween.quadPath(_hitspr, [ p1, p2,p3], 3, true,options);
		
		
	}
	
	override public function update():Void 
	{
		_hitdown.setPosition(_hitspr.x + 22.5, _hitspr.y-30 );
		_hitup.setPosition(_hitspr.x + 22.5,_hitspr.y+140);
		_hitspr_r.setPosition(_hitspr.x+22.5,_hitspr.y);
		//_hitspr.setPosition(FlxG.mouse.x, FlxG.mouse.y);
		//GameSta = STOP;
		if (pixelPerfectCheck(_hitdown, lines, 20) || pixelPerfectCheck(_hitup, lines, 20)) {
			GameSta = STOP;	
			trace("hit");
		};
		if (FlxG.mouse.pressed)
		{
			// The left mouse button is currently pressed
			_Touchstate = TouchState.Touch;
		}

		if (FlxG.mouse.justReleased)
		{
			// The left mouse button has just been released
			_Touchstate = TouchState.noTouch;
		}
		
		super.update();
		
		if (GameSta == Gstate.STOP) {
			FlxG.resetState();
			return;
		}
		
		if(_Touchstate == TouchState.noTouch){
			_hitspr.acceleration.set(0,800);
		}else if(_Touchstate == Touch){
			_hitspr.acceleration.set(0,-800);
		}else{
			_hitspr.acceleration.set(0,0);
		}
		
		lines.x -= 2;
		
		
	}
	
	

	

}