package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import Sys;
import Date;
import DateTools;


using StringTools;

class DebugWarning extends MusicBeatState
{
	public static var isDebug:Bool = false;
	var alreadySeen:Bool = false;
	var programmerName:String = "devin503";
	var langText:FlxText;
	var curLang:String = "English";
	var txt:FlxText;
	var timeString:FlxText;
	var yourTime = DateTools.format(Date.now(), "%r");
	
	override public function create():Void
	{
		super.create();
		#if debug
		isDebug = true;
		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('debugWarn', 'shared'));
		bg.screenCenter();
		add(bg);
		txt = new FlxText(0, 0, FlxG.width, "This is a debug version of the mod, and should be for testing purposes only.\nIf you were sent this build by " + programmerName + ", press SPACE\nto continue and playtest the mod.", 32);
		txt.setFormat("VCR OSD Mono", 32, FlxColor.fromRGB(166, 211, 136), CENTER);
		txt.borderColor = FlxColor.fromRGB(71, 117, 0);
		txt.borderSize = 3;
		txt.borderStyle = FlxTextBorderStyle.OUTLINE;
		txt.screenCenter();
		add(txt);
		langText = new FlxText(0, 0, FlxG.width, "", 32);
		langText.setFormat(Paths.font("nintendo.ttf"), 32, FlxColor.fromRGB(69, 69, 69), CENTER);
		langText.borderColor = FlxColor.fromRGB(0, 0, 255);
		langText.borderSize = 2;
		langText.borderStyle = FlxTextBorderStyle.OUTLINE;
		langText.text = "Pressione 6 para ver esta mensagem em português.";
		add(langText);
		timeString = new FlxText(0, 0, FlxG.width, yourTime, 32);
		timeString.x = FlxG.width * 0.91;
		timeString.y = FlxG.height * 0.9621;
		timeString.setFormat(Paths.font("micross.ttf"), 16, FlxColor.BLACK, LEFT);
		add(timeString);
		#end
		}
		
		override function update(elapsed:Float)
		{
			if (FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.SPACE)
			{
				alreadySeen = true;
				trace('Dismissing debug warning');
				#if cpp
				FlxG.switchState(new Caching());
				#else
				FlxG.switchState(new MainMenuState());
				#end
			}
			
			if (FlxG.keys.justPressed.BACKSPACE || FlxG.keys.justPressed.ESCAPE)
			{
				Sys.exit(0);
			}
			
			if (FlxG.keys.justPressed.SIX && curLang == 'English')
			{
				curLang = "Portuguese";
				txt.text = "Esta é uma versão de depuração do mod\ne deve ser apenas para fins de teste.\nSe você recebeu esta construção por " + programmerName + ", pressione ESPAÇO para continuar e testar o mod.";
				langText.text = "Press 6 to view this message in English.";
			}
			else if (FlxG.keys.justPressed.SIX && curLang == 'Portuguese')
			{
				curLang = "English";
				txt.text = "This is a debug version of the mod, and should be for testing purposes only.\nIf you were sent this build by " + programmerName + ", press SPACE\nto continue and playtest the mod.";
				langText.text = "Pressione 6 para ver esta mensagem em português.";
			}
			
			timeString.text = DateTools.format(Date.now(), "%r");
		}
	}