package;


import haxe.Timer;
import haxe.Unserializer;
import lime.app.Future;
import lime.app.Preloader;
import lime.app.Promise;
import lime.audio.AudioSource;
import lime.audio.openal.AL;
import lime.audio.AudioBuffer;
import lime.graphics.Image;
import lime.net.HTTPRequest;
import lime.system.CFFI;
import lime.text.Font;
import lime.utils.Bytes;
import lime.utils.UInt8Array;
import lime.Assets;

#if sys
import sys.FileSystem;
#end

#if flash
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.media.Sound;
import flash.net.URLLoader;
import flash.net.URLRequest;
#end


class DefaultAssetLibrary extends AssetLibrary {
	
	
	public var className (default, null) = new Map <String, Dynamic> ();
	public var path (default, null) = new Map <String, String> ();
	public var type (default, null) = new Map <String, AssetType> ();
	
	private var lastModified:Float;
	private var timer:Timer;
	
	
	public function new () {
		
		super ();
		
		#if (openfl && !flash)
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_arial_ttf);
		
		#end
		
		#if flash
		
		className.set ("assets/sound/buttonStart.wav", __ASSET__assets_sound_buttonstart_wav);
		type.set ("assets/sound/buttonStart.wav", AssetType.SOUND);
		className.set ("assets/sound/hitTheLine.wav", __ASSET__assets_sound_hittheline_wav);
		type.set ("assets/sound/hitTheLine.wav", AssetType.SOUND);
		className.set ("assets/sound/jumpUp.wav", __ASSET__assets_sound_jumpup_wav);
		type.set ("assets/sound/jumpUp.wav", AssetType.SOUND);
		className.set ("assets/sprites.png", __ASSET__assets_sprites_png);
		type.set ("assets/sprites.png", AssetType.IMAGE);
		className.set ("assets/sprites.xml", __ASSET__assets_sprites_xml);
		type.set ("assets/sprites.xml", AssetType.TEXT);
		className.set ("assets/ui_button1.png", __ASSET__assets_ui_button1_png);
		type.set ("assets/ui_button1.png", AssetType.IMAGE);
		className.set ("assets/ui_button2.png", __ASSET__assets_ui_button2_png);
		type.set ("assets/ui_button2.png", AssetType.IMAGE);
		className.set ("assets/ui_button3.png", __ASSET__assets_ui_button3_png);
		type.set ("assets/ui_button3.png", AssetType.IMAGE);
		className.set ("assets/ui_down.png", __ASSET__assets_ui_down_png);
		type.set ("assets/ui_down.png", AssetType.IMAGE);
		className.set ("assets/ui_heart.png", __ASSET__assets_ui_heart_png);
		type.set ("assets/ui_heart.png", AssetType.IMAGE);
		className.set ("assets/ui_heart1.png", __ASSET__assets_ui_heart1_png);
		type.set ("assets/ui_heart1.png", AssetType.IMAGE);
		className.set ("assets/ui_left.png", __ASSET__assets_ui_left_png);
		type.set ("assets/ui_left.png", AssetType.IMAGE);
		className.set ("assets/ui_reset.png", __ASSET__assets_ui_reset_png);
		type.set ("assets/ui_reset.png", AssetType.IMAGE);
		className.set ("assets/ui_right.png", __ASSET__assets_ui_right_png);
		type.set ("assets/ui_right.png", AssetType.IMAGE);
		className.set ("assets/ui_start.png", __ASSET__assets_ui_start_png);
		type.set ("assets/ui_start.png", AssetType.IMAGE);
		className.set ("assets/ui_up.png", __ASSET__assets_ui_up_png);
		type.set ("assets/ui_up.png", AssetType.IMAGE);
		className.set ("assets/sounds/beep.mp3", __ASSET__assets_sounds_beep_mp3);
		type.set ("assets/sounds/beep.mp3", AssetType.MUSIC);
		className.set ("assets/sounds/flixel.mp3", __ASSET__assets_sounds_flixel_mp3);
		type.set ("assets/sounds/flixel.mp3", AssetType.MUSIC);
		className.set ("assets/fonts/nokiafc22.ttf", __ASSET__assets_fonts_nokiafc22_ttf);
		type.set ("assets/fonts/nokiafc22.ttf", AssetType.FONT);
		className.set ("assets/fonts/arial.ttf", __ASSET__assets_fonts_arial_ttf);
		type.set ("assets/fonts/arial.ttf", AssetType.FONT);
		
		
		#elseif html5
		
		var id;
		id = "assets/sound/buttonStart.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sound/hitTheLine.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sound/jumpUp.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sprites.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/sprites.xml";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/ui_button1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/ui_button2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/ui_button3.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/ui_down.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/ui_heart.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/ui_heart1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/ui_left.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/ui_reset.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/ui_right.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/ui_start.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/ui_up.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/sounds/beep.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "assets/sounds/flixel.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "assets/fonts/nokiafc22.ttf";
		className.set (id, __ASSET__assets_fonts_nokiafc22_ttf);
		
		type.set (id, AssetType.FONT);
		id = "assets/fonts/arial.ttf";
		className.set (id, __ASSET__assets_fonts_arial_ttf);
		
		type.set (id, AssetType.FONT);
		
		
		var assetsPrefix = null;
		if (ApplicationMain.config != null && Reflect.hasField (ApplicationMain.config, "assetsPrefix")) {
			assetsPrefix = ApplicationMain.config.assetsPrefix;
		}
		if (assetsPrefix != null) {
			for (k in path.keys()) {
				path.set(k, assetsPrefix + path[k]);
			}
		}
		
		#else
		
		#if (windows || mac || linux)
		
		var useManifest = false;
		
		className.set ("assets/sound/buttonStart.wav", __ASSET__assets_sound_buttonstart_wav);
		type.set ("assets/sound/buttonStart.wav", AssetType.SOUND);
		
		className.set ("assets/sound/hitTheLine.wav", __ASSET__assets_sound_hittheline_wav);
		type.set ("assets/sound/hitTheLine.wav", AssetType.SOUND);
		
		className.set ("assets/sound/jumpUp.wav", __ASSET__assets_sound_jumpup_wav);
		type.set ("assets/sound/jumpUp.wav", AssetType.SOUND);
		
		className.set ("assets/sprites.png", __ASSET__assets_sprites_png);
		type.set ("assets/sprites.png", AssetType.IMAGE);
		
		className.set ("assets/sprites.xml", __ASSET__assets_sprites_xml);
		type.set ("assets/sprites.xml", AssetType.TEXT);
		
		className.set ("assets/ui_button1.png", __ASSET__assets_ui_button1_png);
		type.set ("assets/ui_button1.png", AssetType.IMAGE);
		
		className.set ("assets/ui_button2.png", __ASSET__assets_ui_button2_png);
		type.set ("assets/ui_button2.png", AssetType.IMAGE);
		
		className.set ("assets/ui_button3.png", __ASSET__assets_ui_button3_png);
		type.set ("assets/ui_button3.png", AssetType.IMAGE);
		
		className.set ("assets/ui_down.png", __ASSET__assets_ui_down_png);
		type.set ("assets/ui_down.png", AssetType.IMAGE);
		
		className.set ("assets/ui_heart.png", __ASSET__assets_ui_heart_png);
		type.set ("assets/ui_heart.png", AssetType.IMAGE);
		
		className.set ("assets/ui_heart1.png", __ASSET__assets_ui_heart1_png);
		type.set ("assets/ui_heart1.png", AssetType.IMAGE);
		
		className.set ("assets/ui_left.png", __ASSET__assets_ui_left_png);
		type.set ("assets/ui_left.png", AssetType.IMAGE);
		
		className.set ("assets/ui_reset.png", __ASSET__assets_ui_reset_png);
		type.set ("assets/ui_reset.png", AssetType.IMAGE);
		
		className.set ("assets/ui_right.png", __ASSET__assets_ui_right_png);
		type.set ("assets/ui_right.png", AssetType.IMAGE);
		
		className.set ("assets/ui_start.png", __ASSET__assets_ui_start_png);
		type.set ("assets/ui_start.png", AssetType.IMAGE);
		
		className.set ("assets/ui_up.png", __ASSET__assets_ui_up_png);
		type.set ("assets/ui_up.png", AssetType.IMAGE);
		
		className.set ("assets/sounds/beep.mp3", __ASSET__assets_sounds_beep_mp3);
		type.set ("assets/sounds/beep.mp3", AssetType.MUSIC);
		
		className.set ("assets/sounds/flixel.mp3", __ASSET__assets_sounds_flixel_mp3);
		type.set ("assets/sounds/flixel.mp3", AssetType.MUSIC);
		
		className.set ("assets/fonts/nokiafc22.ttf", __ASSET__assets_fonts_nokiafc22_ttf);
		type.set ("assets/fonts/nokiafc22.ttf", AssetType.FONT);
		
		className.set ("assets/fonts/arial.ttf", __ASSET__assets_fonts_arial_ttf);
		type.set ("assets/fonts/arial.ttf", AssetType.FONT);
		
		
		if (useManifest) {
			
			loadManifest ();
			
			if (Sys.args ().indexOf ("-livereload") > -1) {
				
				var path = FileSystem.fullPath ("manifest");
				lastModified = FileSystem.stat (path).mtime.getTime ();
				
				timer = new Timer (2000);
				timer.run = function () {
					
					var modified = FileSystem.stat (path).mtime.getTime ();
					
					if (modified > lastModified) {
						
						lastModified = modified;
						loadManifest ();
						
						onChange.dispatch ();
						
					}
					
				}
				
			}
			
		}
		
		#else
		
		loadManifest ();
		
		#end
		#end
		
	}
	
	
	public override function exists (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var assetType = this.type.get (id);
		
		if (assetType != null) {
			
			if (assetType == requestedType || ((requestedType == SOUND || requestedType == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			#if flash
			
			if (requestedType == BINARY && (assetType == BINARY || assetType == TEXT || assetType == IMAGE)) {
				
				return true;
				
			} else if (requestedType == TEXT && assetType == BINARY) {
				
				return true;
				
			} else if (requestedType == null || path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (requestedType == BINARY || requestedType == null || (assetType == BINARY && requestedType == TEXT)) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getAudioBuffer (id:String):AudioBuffer {
		
		#if flash
		
		var buffer = new AudioBuffer ();
		buffer.src = cast (Type.createInstance (className.get (id), []), Sound);
		return buffer;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		if (className.exists(id)) return AudioBuffer.fromBytes (cast (Type.createInstance (className.get (id), []), Bytes));
		else return AudioBuffer.fromFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getBytes (id:String):Bytes {
		
		#if flash
		
		switch (type.get (id)) {
			
			case TEXT, BINARY:
				
				return Bytes.ofData (cast (Type.createInstance (className.get (id), []), flash.utils.ByteArray));
			
			case IMAGE:
				
				var bitmapData = cast (Type.createInstance (className.get (id), []), BitmapData);
				return Bytes.ofData (bitmapData.getPixels (bitmapData.rect));
			
			default:
				
				return null;
			
		}
		
		return cast (Type.createInstance (className.get (id), []), Bytes);
		
		#elseif html5
		
		var loader = Preloader.loaders.get (path.get (id));
		
		if (loader == null) {
			
			return null;
			
		}
		
		var bytes = loader.bytes;
		
		if (bytes != null) {
			
			return bytes;
			
		} else {
			
			return null;
		}
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Bytes);
		else return Bytes.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Font {
		
		#if flash
		
		var src = Type.createInstance (className.get (id), []);
		
		var font = new Font (src.fontName);
		font.src = src;
		return font;
		
		#elseif html5
		
		return cast (Type.createInstance (className.get (id), []), Font);
		
		#else
		
		if (className.exists (id)) {
			
			var fontClass = className.get (id);
			return cast (Type.createInstance (fontClass, []), Font);
			
		} else {
			
			return Font.fromFile (path.get (id));
			
		}
		
		#end
		
	}
	
	
	public override function getImage (id:String):Image {
		
		#if flash
		
		return Image.fromBitmapData (cast (Type.createInstance (className.get (id), []), BitmapData));
		
		#elseif html5
		
		return Image.fromImageElement (Preloader.images.get (path.get (id)));
		
		#else
		
		if (className.exists (id)) {
			
			var fontClass = className.get (id);
			return cast (Type.createInstance (fontClass, []), Image);
			
		} else {
			
			return Image.fromFile (path.get (id));
			
		}
		
		#end
		
	}
	
	
	/*public override function getMusic (id:String):Dynamic {
		
		#if flash
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif openfl_html5
		
		//var sound = new Sound ();
		//sound.__buffer = true;
		//sound.load (new URLRequest (path.get (id)));
		//return sound;
		return null;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return null;
		//if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		//else return new Sound (new URLRequest (path.get (id)), null, true);
		
		#end
		
	}*/
	
	
	public override function getPath (id:String):String {
		
		//#if ios
		
		//return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		//#else
		
		return path.get (id);
		
		//#end
		
	}
	
	
	public override function getText (id:String):String {
		
		#if html5
		
		var loader = Preloader.loaders.get (path.get (id));
		
		if (loader == null) {
			
			return null;
			
		}
		
		var bytes = loader.bytes;
		
		if (bytes != null) {
			
			return bytes.getString (0, bytes.length);
			
		} else {
			
			return null;
		}
		
		#else
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.getString (0, bytes.length);
			
		}
		
		#end
		
	}
	
	
	public override function isLocal (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		
		#if flash
		
		//if (requestedType != AssetType.MUSIC && requestedType != AssetType.SOUND) {
			
			return className.exists (id);
			
		//}
		
		#end
		
		return true;
		
	}
	
	
	public override function list (type:String):Array<String> {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var items = [];
		
		for (id in this.type.keys ()) {
			
			if (requestedType == null || exists (id, type)) {
				
				items.push (id);
				
			}
			
		}
		
		return items;
		
	}
	
	
	public override function loadAudioBuffer (id:String):Future<AudioBuffer> {
		
		var promise = new Promise<AudioBuffer> ();
		
		#if (flash)
		
		if (path.exists (id)) {
			
			var soundLoader = new Sound ();
			soundLoader.addEventListener (Event.COMPLETE, function (event) {
				
				var audioBuffer:AudioBuffer = new AudioBuffer();
				audioBuffer.src = event.currentTarget;
				promise.complete (audioBuffer);
				
			});
			soundLoader.addEventListener (ProgressEvent.PROGRESS, function (event) {
				
				if (event.bytesTotal == 0) {
					
					promise.progress (0);
					
				} else {
					
					promise.progress (event.bytesLoaded / event.bytesTotal);
					
				}
				
			});
			soundLoader.addEventListener (IOErrorEvent.IO_ERROR, promise.error);
			soundLoader.load (new URLRequest (path.get (id)));
			
		} else {
			
			promise.complete (getAudioBuffer (id));
			
		}
		
		#else
		
		promise.completeWith (new Future<AudioBuffer> (function () return getAudioBuffer (id)));
		
		#end
		
		return promise.future;
		
	}
	
	
	public override function loadBytes (id:String):Future<Bytes> {
		
		var promise = new Promise<Bytes> ();
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = Bytes.ofString (event.currentTarget.data);
				promise.complete (bytes);
				
			});
			loader.addEventListener (ProgressEvent.PROGRESS, function (event) {
				
				if (event.bytesTotal == 0) {
					
					promise.progress (0);
					
				} else {
					
					promise.progress (event.bytesLoaded / event.bytesTotal);
					
				}
				
			});
			loader.addEventListener (IOErrorEvent.IO_ERROR, promise.error);
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			promise.complete (getBytes (id));
			
		}
		
		#elseif html5
		
		if (path.exists (id)) {
			
			var request = new HTTPRequest ();
			promise.completeWith (request.load (path.get (id) + "?" + Assets.cache.version));
			
		} else {
			
			promise.complete (getBytes (id));
			
		}
		
		#else
		
		promise.completeWith (new Future<Bytes> (function () return getBytes (id)));
		
		#end
		
		return promise.future;
		
	}
	
	
	public override function loadImage (id:String):Future<Image> {
		
		var promise = new Promise<Image> ();
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bitmapData = cast (event.currentTarget.content, Bitmap).bitmapData;
				promise.complete (Image.fromBitmapData (bitmapData));
				
			});
			loader.contentLoaderInfo.addEventListener (ProgressEvent.PROGRESS, function (event) {
				
				if (event.bytesTotal == 0) {
					
					promise.progress (0);
					
				} else {
					
					promise.progress (event.bytesLoaded / event.bytesTotal);
					
				}
				
			});
			loader.contentLoaderInfo.addEventListener (IOErrorEvent.IO_ERROR, promise.error);
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			promise.complete (getImage (id));
			
		}
		
		#elseif html5
		
		if (path.exists (id)) {
			
			var image = new js.html.Image ();
			image.onload = function (_):Void {
				
				promise.complete (Image.fromImageElement (image));
				
			}
			image.onerror = promise.error;
			image.src = path.get (id) + "?" + Assets.cache.version;
			
		} else {
			
			promise.complete (getImage (id));
			
		}
		
		#else
		
		promise.completeWith (new Future<Image> (function () return getImage (id)));
		
		#end
		
		return promise.future;
		
	}
	
	
	#if (!flash && !html5)
	private function loadManifest ():Void {
		
		try {
			
			#if blackberry
			var bytes = Bytes.readFile ("app/native/manifest");
			#elseif tizen
			var bytes = Bytes.readFile ("../res/manifest");
			#elseif emscripten
			var bytes = Bytes.readFile ("assets/manifest");
			#elseif (mac && java)
			var bytes = Bytes.readFile ("../Resources/manifest");
			#elseif (ios || tvos)
			var bytes = Bytes.readFile ("assets/manifest");
			#else
			var bytes = Bytes.readFile ("manifest");
			#end
			
			if (bytes != null) {
				
				if (bytes.length > 0) {
					
					var data = bytes.getString (0, bytes.length);
					
					if (data != null && data.length > 0) {
						
						var manifest:Array<Dynamic> = Unserializer.run (data);
						
						for (asset in manifest) {
							
							if (!className.exists (asset.id)) {
								
								#if (ios || tvos)
								path.set (asset.id, "assets/" + asset.path);
								#else
								path.set (asset.id, asset.path);
								#end
								type.set (asset.id, cast (asset.type, AssetType));
								
							}
							
						}
						
					}
					
				}
				
			} else {
				
				trace ("Warning: Could not load asset manifest (bytes was null)");
				
			}
		
		} catch (e:Dynamic) {
			
			trace ('Warning: Could not load asset manifest (${e})');
			
		}
		
	}
	#end
	
	
	public override function loadText (id:String):Future<String> {
		
		var promise = new Promise<String> ();
		
		#if html5
		
		if (path.exists (id)) {
			
			var request = new HTTPRequest ();
			var future = request.load (path.get (id) + "?" + Assets.cache.version);
			future.onProgress (function (progress) promise.progress (progress));
			future.onError (function (msg) promise.error (msg));
			future.onComplete (function (bytes) promise.complete (bytes.getString (0, bytes.length)));
			
		} else {
			
			promise.complete (getText (id));
			
		}
		
		#else
		
		promise.completeWith (loadBytes (id).then (function (bytes) {
			
			return new Future<String> (function () {
				
				if (bytes == null) {
					
					return null;
					
				} else {
					
					return bytes.getString (0, bytes.length);
					
				}
				
			});
			
		}));
		
		#end
		
		return promise.future;
		
	}
	
	
}


#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__assets_sound_buttonstart_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sound_hittheline_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sound_jumpup_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sprites_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_sprites_xml extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_ui_button1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_ui_button2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_ui_button3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_ui_down_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_ui_heart_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_ui_heart1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_ui_left_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_ui_reset_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_ui_right_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_ui_start_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_ui_up_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_beep_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_flixel_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_nokiafc22_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_arial_ttf extends flash.text.Font { }


#elseif html5



















@:keep #if display private #end class __ASSET__assets_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { super (); name = "Nokia Cellphone FC Small"; } } 
@:keep #if display private #end class __ASSET__assets_fonts_arial_ttf extends lime.text.Font { public function new () { super (); name = "Arial"; } } 


#else



#if (windows || mac || linux || cpp)


@:file("assets/sound/buttonStart.wav") #if display private #end class __ASSET__assets_sound_buttonstart_wav extends lime.utils.Bytes {}
@:file("assets/sound/hitTheLine.wav") #if display private #end class __ASSET__assets_sound_hittheline_wav extends lime.utils.Bytes {}
@:file("assets/sound/jumpUp.wav") #if display private #end class __ASSET__assets_sound_jumpup_wav extends lime.utils.Bytes {}
@:image("assets/sprites.png") #if display private #end class __ASSET__assets_sprites_png extends lime.graphics.Image {}
@:file("assets/sprites.xml") #if display private #end class __ASSET__assets_sprites_xml extends lime.utils.Bytes {}
@:image("assets/ui_button1.png") #if display private #end class __ASSET__assets_ui_button1_png extends lime.graphics.Image {}
@:image("assets/ui_button2.png") #if display private #end class __ASSET__assets_ui_button2_png extends lime.graphics.Image {}
@:image("assets/ui_button3.png") #if display private #end class __ASSET__assets_ui_button3_png extends lime.graphics.Image {}
@:image("assets/ui_down.png") #if display private #end class __ASSET__assets_ui_down_png extends lime.graphics.Image {}
@:image("assets/ui_heart.png") #if display private #end class __ASSET__assets_ui_heart_png extends lime.graphics.Image {}
@:image("assets/ui_heart1.png") #if display private #end class __ASSET__assets_ui_heart1_png extends lime.graphics.Image {}
@:image("assets/ui_left.png") #if display private #end class __ASSET__assets_ui_left_png extends lime.graphics.Image {}
@:image("assets/ui_reset.png") #if display private #end class __ASSET__assets_ui_reset_png extends lime.graphics.Image {}
@:image("assets/ui_right.png") #if display private #end class __ASSET__assets_ui_right_png extends lime.graphics.Image {}
@:image("assets/ui_start.png") #if display private #end class __ASSET__assets_ui_start_png extends lime.graphics.Image {}
@:image("assets/ui_up.png") #if display private #end class __ASSET__assets_ui_up_png extends lime.graphics.Image {}
@:file("C:/Users/lanhuoyi/android/flixel/3,3,12/assets/sounds/beep.mp3") #if display private #end class __ASSET__assets_sounds_beep_mp3 extends lime.utils.Bytes {}
@:file("C:/Users/lanhuoyi/android/flixel/3,3,12/assets/sounds/flixel.mp3") #if display private #end class __ASSET__assets_sounds_flixel_mp3 extends lime.utils.Bytes {}
@:font("C:/Users/lanhuoyi/android/flixel/3,3,12/assets/fonts/nokiafc22.ttf") #if display private #end class __ASSET__assets_fonts_nokiafc22_ttf extends lime.text.Font {}
@:font("C:/Users/lanhuoyi/android/flixel/3,3,12/assets/fonts/arial.ttf") #if display private #end class __ASSET__assets_fonts_arial_ttf extends lime.text.Font {}



#end
#end

#if (openfl && !flash)
@:keep #if display private #end class __ASSET__OPENFL__assets_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__assets_fonts_nokiafc22_ttf (); src = font.src; name = font.name; super (); }}
@:keep #if display private #end class __ASSET__OPENFL__assets_fonts_arial_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__assets_fonts_arial_ttf (); src = font.src; name = font.name; super (); }}

#end

#end