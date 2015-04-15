package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.utils.setInterval;
	import flash.text.TextField;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Benjamin
	 */
	public class Main extends Sprite
	{
		public var aObstacle:Array = new Array();
		
		private var score:TextField = new TextField();
		private var endScreenText:TextField = new TextField;
		private var scoreInt:int = 0;
		private var scrollSpeed:uint = 12;
		private var s1:MovieClip;
		private var s2:MovieClip;
		private var player:Player = new Player();
		private var backgroundSound:Sound = new BackgroundMusic;
		private var spawnRate:int;
		private var endScreen:MovieClip;
		private var isEndScreen:Boolean = false;
		private var format:TextFormat;
		
		
		
		public function Main() 
		{
			function playSound():void
			{
				var channel:SoundChannel = backgroundSound.play();
				channel.addEventListener(Event.SOUND_COMPLETE, onComplete);
			}

			function onComplete(event:Event):void
			{
				SoundChannel(event.target).removeEventListener(event.type, onComplete);
				playSound();
			}
			
			playSound();
			
			for (var i:int = 0; i < 1; i++) 
			{
				aObstacle.push(new Obstacle());
			}
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			s1 = new ScrollBg();
			s2 = new ScrollBg();
			
			
			addChild(s1); 
			addChild(s2);
			addChild(player);
			
			s1.x = 0;
			s2.x = s1.width;
		
			addEventListener(Event.ENTER_FRAME, update);
			
			function addMeters():void 
			{
				scoreInt += 1;
			}
			
			setInterval(addMeters, 50)
			
			
			setInterval(spawnOb, spawnRate + 2000);
		}
		
		private function update(e:Event):void 
		{
			
			score.text = "Distance: " + scoreInt + " M";
			score.x = 10;
			score.y = 130;
			addChild(score);
			
			s1.x -= scrollSpeed;
			s2.x -= scrollSpeed;
				
			if (s1.x <= -s1.width)
			{
				s1.x = s2.x+s2.width;
			}
			else 
			if (s2.x <= -s2.width)
			{
				s2.x = s1.x+s1.width;
			}
			
			
			
			var aO:int = aObstacle.length;
			for (var i:int = 0; i < aO; i++) 
			{
				aObstacle[i].x -= scrollSpeed * 2;
				if (player.hitTestObject(aObstacle[i]) && !isEndScreen) 
				{
					
					endScreen = new GameOver;
					stage.frameRate = 0;
					addChild(endScreen);
					
					format = new TextFormat();
					format.color = 0xffffff;
					format.size = 20;
					endScreenText.text = "Game over, press Space to restart!";
					endScreenText.setTextFormat(format);
					endScreenText.x = 150;
					endScreenText.y = 300;
					endScreenText.scaleX = 50;
					addChild(endScreenText);
					
					isEndScreen = true;
					
					
					stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
					
					function onKeyDown(e:KeyboardEvent):void 
					{
						if ((e.keyCode == Keyboard.SPACE) && (isEndScreen))
						{
							removeChild(endScreen);
							removeChild(endScreenText);
							stage.frameRate = 30;
							scoreInt = 0;
							isEndScreen = false;
						}      
					}
				}
			}
		}
		
		private function spawnOb():void 
		{
			var aO:int = aObstacle.length;
			for (var i:int = 0; i < aO; i++) 
			{
				addChild(aObstacle[i])
				aObstacle[i].Add();
				spawnRate = Math.random() * 2000;
				
				
				if (aObstacle[i].x < 100)
				{
					removeChild(aObstacle[i]);
				}
			}
		}
	}
}