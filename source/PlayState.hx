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
import flixel.util.FlxSave;
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
import flixel.util.FlxTimer;
import flixel.ui.FlxButton;
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
	private var _score:Int = 0;
	private var _subscore:Int = 0;
	private var _scoreStep:Int = 1;
	private var _timestep:Int = 0;
	private var _timestep1:Int = 0;
	private var _sText:FlxText;
	private var _subsText:FlxText;
	private var _yText:FlxText;
	private var _bText:FlxText;
	private var _best:String;
	private var myButton:FlxButton;
	
	private var _gameSave:FlxSave;
	private var lines:FlxSprite;
	private var GameSta:Gstate = START;
	private var _Touchstate:TouchState = runTouch;
	
	
	override public function create():Void
	{
		super.create();
		FlxG.cameras.bgColor  = 0xFFFFFFFF;
		//fade(Color:Int = FlxColor.BLACK, Duration:Float = 1, FadeIn:Bool = false, ?OnComplete:Void‑>Void, Force:Bool = false):Void
		FlxG.camera.fade(FlxColor.BLACK, 1,true);		
		_gameSave = new FlxSave();
		_gameSave.bind("SaveDemo");
		_best = "0";
		if(_gameSave.data.best){
			_best = _gameSave.data.best;
		}	
		
		GameSta = START;
		
		myButton = new FlxButton(0, 0, "", btn_reset);
		// Custom graphics
		myButton.loadGraphic("assets/ui_reset.png");
		FlxSpriteUtil.screenCenter(myButton);
		myButton.y += 100;
		add(myButton);
		myButton.scrollFactor.set(0, 0);
		myButton.visible = false;
		
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
		
		_sText = new FlxText(0, 0, 0, "Score 0", 15);
        //_sText.setBorderStyle(FlxText.BORDER_SHADOW, FlxColor.GRAY, 1, 1);
		_sText.color = 0xFF00B0CC;
		_sText.autoSize = true;
		add(_sText);
		_sText.scrollFactor.set(0, 0);
		
		_subsText = new FlxText(_sText.width, 0, 0, "", 15);
		_subsText.color = 0xFF00B0CC;
		add(_subsText);
		_subsText.scrollFactor.set(0, 0);
		
		
		_yText = new FlxText(0, 0, 0, "YOUR ", 15);
		_yText.color = 0xFF00B0CC;
		_yText.alignment = "center";
		_yText.autoSize = true;		
		FlxSpriteUtil.screenCenter(_yText);
		_yText.centerOrigin();
		_yText.y -= 220;
		add(_yText);
		_yText.visible = false;
		
		_bText = new FlxText(0, 0, 0, "BEST ", 15);
		_bText.color = 0xFF00B0CC;
		_bText.alignment = "center";
		_bText.autoSize = true;		
		FlxSpriteUtil.screenCenter(_bText);
		_bText.centerOrigin();
		_bText.y -= 190;
		add(_bText);
		//_bText.visible = false;		
		_bText.text = "BEST "+_best;
		
		var texturepack = new SparrowData("assets/sprites.xml","assets/sprites.png");
		_btnBack = new FlxSprite();
		_btnBack.loadGraphicFromTexture(texturepack, true, "ui_start.png");
		_btnBack.centerOrigin();	
		FlxSpriteUtil.screenCenter(_btnBack);
		_btnBack.y += 100;		
		add(_btnBack);
		_btnBack.scrollFactor.set(0, 0);
		
				
		MouseEventManager.add(_btnBack, btnBackDown);
		FlxG.camera.antialiasing = true;
		
		FlxG.camera.follow(_hitspr, FlxCamera.STYLE_PLATFORMER);
				
		
	}
	
	private function btnBackDown(o:FlxObject):Void{
		_hitspr.acceleration.x = 100;
		trace("ok");
		GameSta = RUN;
	}
	override public function update():Void 
	{
		_bText.x = FlxG.width / 2 - _bText.width / 2;
		_bText.scrollFactor.set(0, 0);
		_yText.x = FlxG.width / 2 - _bText.width / 2;
		_yText.scrollFactor.set(0, 0);
		
		_subsText.x = _sText.width;
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
			//FlxG.resetState();
						
			_hitspr.acceleration.set(0, 0);
			_hitspr.velocity.set(0, 0);
			_hitdown.velocity.set(0, 0);
			_hitspr_r.velocity.set(0, 0);
			_hitup.velocity.set(0, 0);
			//FlxTween.tween(_hitspr, { x:FlxG.width / 2 - 50, y:200 }, 1, { ease:FlxEase.quadInOut, complete:changeGstate } );
			//new FlxTimer(1, resetState);
			var nowscore = Std.parseFloat(_score+"." + _subscore);
			var bestscore = Std.parseFloat(_best);
			_bText.text = "BEST "+Std.string(bestscore);
			if(nowscore>bestscore){
				_gameSave.data.best = Std.string(nowscore);
				_bText.text = "BEST "+Std.string(nowscore);
			}
			
			_yText.visible = true;
			_yText.text = "YOUR "+Std.string(nowscore);
			_bText.visible = true;
			
			
			myButton.visible = true;
			//if(_hitspr.alive == true){
				//_hitspr.kill();
				//_hitspr = null;
				//_hitspr_r.kill();
				//_hitspr_r = null;
				//_hitup.kill();
				//_hitup = null;
				//_hitdown.kill();
				//_hitdown = null;
			//}
			return;
		}else {
			if (GameSta == RUN) {
				_bText.visible = false;
				_btnBack.visible = false;
				_timestep ++;
				if (_timestep >= 60) {
					_timestep = 0;
					_score += 1;
				}
				
				_timestep1 ++;
				if(_timestep1 >=6){
					_timestep1 = 0;
					_subscore += 1;
					if (_subscore >= 10) {
						_subscore = 0;					
					}
				}
				
				_sText.text = "Score " + _score;
				_subsText.text = "." + _subscore;
			}
			
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
	
	private function checkNumber(){
		
	}
	
	private function changeGstate(tween:FlxTween):Void
	{
		
		if(_hitspr.alive == true){
				_hitspr.kill();
				_hitspr = null;
				_hitspr_r.kill();
				_hitspr_r = null;
				_hitup.kill();
				_hitup = null;
				_hitdown.kill();
				_hitdown = null;
			}
		new FlxTimer(1, resetState);
		
		// change the color of the sprite here
		
	}
	private function resetState(Timer:FlxTimer):Void
	{
		FlxG.resetState();
		GameSta = START;
	}
	
	private function btn_reset():Void
	{
		FlxG.resetState();
		GameSta = START;
	}

}