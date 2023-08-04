package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.display.FlxBackdrop;
import flixel.*;
import flixel.FlxSprite;
import flixel.text.FlxText;
import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
#if sys
import sys.FileSystem;
#end
import flixel.addons.ui.FlxInputText;

class BiosMenuState extends MusicBeatState {
	
	var bg:FlxSprite;
	var background:FlxSprite;
    var imageSprite:FlxSprite;
	
    var imagePath:Array<String>;
    var charDesc:Array<String>;
    var charName:Array<String>;
	var bgColors:Array<String>;

	var curSelected:Int = -1;
    var currentIndex:Int = 0;

    var descriptionText:FlxText;
    var characterName:FlxText;

	override function create() {
		
		FlxG.mouse.visible = false;

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Bios Menu", null);
		#end

		
		background = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
        background.setGraphicSize(Std.int(background.width * 1.2));
		background.color = 0xFF683FFD;
        background.screenCenter();
        add(background);

		// i took this from psych's engine code lol
		var grid:FlxBackdrop = new FlxBackdrop(FlxGridOverlay.createGrid(80, 80, 160, 160, true, 0x33000000, 0x0));
		grid.velocity.set(30, 30);
		grid.alpha = 0;
		FlxTween.tween(grid, {alpha: 1}, 0.5, {ease: FlxEase.quadOut});
		add(grid);

		// EDIT YOU IMAGES HERE / DONT FORGET TO CREATE A FOLDER IN images CALLED bios IT SHOULD LOOK LIKE THIS 'images/bios'
		// REMINDER!!! THE IMAGES MUST BE 518x544, IF NOT, THEY WONT FIT ON THE SCREEN!!
		imagePath = ["bios/sample", "bios/sample", "bios/sample"];

		// DESCRIPTION HERE
        charDesc = ["This is a description text.", "This is a description text.", "This is a description text."];

		// NAME HERE
        charName = ["Sample", "Name 2", "Name 3"];


		// SET UP THE FIRST IMAGE YOU WANT TO SEE WHEN ENTERING THE MENU
		imageSprite = new FlxSprite(55, 99).loadGraphic(Paths.image("bios/sample"));
        add(imageSprite);

		characterName = new FlxText(630, 94, charName[currentIndex]);
        characterName.setFormat(Paths.font("vcr.ttf"), 96, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		characterName.antialiasing = true;
		characterName.borderSize = 4;
        add(characterName);

		descriptionText = new FlxText(630, 247, charDesc[currentIndex]);
        descriptionText.setFormat(Paths.font("vcr.ttf"), 34, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descriptionText.antialiasing = true;
		descriptionText.borderSize = 2.5;
        add(descriptionText);

		var arrows = new FlxSprite(218, 26).loadGraphic(Paths.image('bios/assets/biosThing'));
		add(arrows);

		super.create();
	}

	override function update(elapsed:Float) {
		
		if (FlxG.keys.justPressed.UP || FlxG.keys.justPressed.W) 
			{
				currentIndex--;
				if (currentIndex < 0)
				{
					currentIndex = imagePath.length - 1;
				}
				remove(imageSprite);
				imageSprite = new FlxSprite(55, 99).loadGraphic(Paths.image(imagePath[currentIndex]));
				add(imageSprite);
				descriptionText.text = charDesc[currentIndex];
				characterName.text = charName[currentIndex];
				FlxG.sound.play(Paths.sound('scrollMenu'));  
	
			}
			else if (FlxG.keys.justPressed.DOWN || FlxG.keys.justPressed.S)
			{
				currentIndex++;
				if (currentIndex >= imagePath.length)
				{
					currentIndex = 0;
				}
				remove(imageSprite);
				imageSprite = new FlxSprite(55, 99).loadGraphic(Paths.image(imagePath[currentIndex]));
				add(imageSprite);
				descriptionText.text = charDesc[currentIndex];
				characterName.text = charName[currentIndex];  
				FlxG.sound.play(Paths.sound('scrollMenu'));    
		
			}
			if (controls.BACK)
				{
					FlxG.sound.play(Paths.sound('cancelMenu'));
					MusicBeatState.switchState(new MainMenuState());
				}
		
		super.update(elapsed);
	}
}