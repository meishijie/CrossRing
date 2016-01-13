package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxCollision.pixelPerfectCheck;
import flixel.util.FlxSpriteUtil; 
import flixel.util.FlxPoint;
import openfl.Lib;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxTween.TweenOptions;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.loaders.SparrowData;
import flixel.FlxCamera;
import flixel.plugin.MouseEventManager;

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
	private var _btnBack:FlxSprite;
	private var _btnStop:FlxSprite;
	private var _btnMenu:FlxSprite;
	private var _uiLayer:FlxGroup;
	
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
		//_hitspr.acceleration.set(100, 0);
		_hitspr.maxVelocity.set(100, 1000);
		
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
		
		_uiLayer = new FlxGroup();
		add(_uiLayer);
		
		var texturepack = new SparrowData("assets/sprites.xml","assets/sprites.png");
		_btnBack = new FlxSprite();
		_btnBack.loadGraphicFromTexture(texturepack, true, "ui_start.png");
		_btnBack.centerOrigin();	
		_btnBack.y += 100;
		FlxSpriteUtil.screenCenter(_btnBack);
		//_btnBack.x -= 100;
		_uiLayer.add(_btnBack);
		
		//_btnStop = new FlxSprite();
		//_btnStop.loadGraphicFromTexture(texturepack, true, "ui_button2.png");
		//_btnStop.centerOrigin();		
		//FlxSpriteUtil.screenCenter(_btnStop);
		//_uiLayer.add(_btnStop);
		
		//_btnMenu = new FlxSprite();
		//_btnMenu.loadGraphicFromTexture(texturepack, true, "ui_button3.png");
		//_btnMenu.centerOrigin();		
		//FlxSpriteUtil.screenCenter(_btnMenu);
		//_btnMenu.x += 100;
		//_uiLayer.add(_btnMenu);
				
		MouseEventManager.add(_btnBack, btnBackDown);
		FlxG.camera.antialiasing = true;
		
		FlxG.camera.follow(_hitspr, FlxCamera.STYLE_PLATFORMER);
		/*var currentLoc = new FlxPoint(_hitspr.x, _hitspr.y);
		var p1 = new FlxPoint(100, 300);
		var p2 = new FlxPoint(200, 50);
		var p3 = new FlxPoint(300, 300);
		var options:TweenOptions = { type: FlxTween.PINGPONG, ease: FlxEase.quadIn };*/
		//FlxTween.linearPath(_hitspr, [currentLoc, p1, p2,p3],3);
		//FlxTween.quadPath(_hitspr, [ p1, p2,p3], 3, true,options);
		
		
	}
	
	private function btnBackDown(o:FlxObject):Void{
		_hitspr.acceleration.x = 100;
		trace("ok");
	}
	override public function update():Void 
	{
		_hitdown.setPosition(_hitspr.x + 30, _hitspr.y-30 );
		_hitup.setPosition(_hitspr.x + 30,_hitspr.y+140);
		_hitspr_r.setPosition(_hitspr.x+33,_hitspr.y);
		//_hitspr.setPosition(FlxG.mouse.x, FlxG.mouse.y);
		//GameSta = STOP;
		if (FlxG.pixelPerfectOverlap(_hitdown, lines,20) || FlxG.pixelPerfectOverlap(_hitup, lines, 20)) {
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
			_hitspr.acceleration.y = _hitspr_r.acceleration.y = _hitdown.acceleration.y = _hitup.acceleration.y = 800;
			//_hitspr.acceleration.x = 100;
			
		}else if(_Touchstate == Touch){
			_hitspr.acceleration.y = _hitspr_r.acceleration.y = _hitdown.acceleration.y = _hitup.acceleration.y = -800;
			//_hitspr.acceleration.x = 100;
		}else{
			//_hitspr.acceleration.set(0,0);
		}
		
		//_hitspr.acceleration.set(500,0);
		
		
	}
	
	

	

}