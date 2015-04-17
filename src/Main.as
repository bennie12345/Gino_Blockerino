package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.setInterval;
	import flash.text.TextField;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Benjamin
	 */
	public class Main extends Sprite
	{
		public var aObstacle:Array = [];
		
		private var score:TextField = new TextField();
		private var yourScoreText:TextField = new TextField();
		private var format1:TextFormat;
		
		
		private var scoreInt:int = 0;
		private var scrollSpeed:uint = 12;
		private var speedOffset:int;
		private var yourScore:int;
		
		private var s1:MovieClip;
		private var s2:MovieClip;
		private var endScreen:MovieClip;
		private var beginScreen:MovieClip = new StartScreen();
		
		private var player:Player = new Player();
		private var enemyObstacle:Obstacle;
		
		private var backgroundSound:Sound = new BackgroundMusic;
		
		private var isEndScreen:Boolean = false;
		private var isInHomeScreen:Boolean;
		
		private var spawnTimer:Timer = new Timer (1000, 0);
	
		
		
	
		
		public function Main() 
		{
			addChild(beginScreen);
			
			playSound();
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			
			stage.addEventListener(Event.ADDED_TO_STAGE, init);
			
			isInHomeScreen = true;
		}
		
		private function init(e:Event):void 
		{
			
			spawnTimer.addEventListener(TimerEvent.TIMER, spawnEnemy);
			addEventListener(Event.ENTER_FRAME, update);
			
			spawnTimer.start();
			
			//set background movieclips
			s1 = new ScrollBg();
			s2 = new ScrollBg();
			
			//add player and background(s) to stage
			addChild(s1);
			addChild(s2);
			addChild(player);
			
			
			
			//set postition of backgrrounds
			s1.x = 0;
			s2.x = s1.width;
		
			
			
			//add to score at interrval
			setInterval(addMeters, 50);
			
			//add to speedOffset variable at interval
			setInterval(addSpeed, 1000);
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function spawnEnemy(e:TimerEvent):void
		{
			enemyObstacle = new Obstacle();
			addChild(enemyObstacle);
			aObstacle.push(enemyObstacle);
			enemyObstacle.x = 800;
			enemyObstacle.y = 415;
			enemyObstacle.scaleX = 0.25;
			enemyObstacle.scaleY = 0.25;
		}
		
		//loop background music
		private function playSound():void
		{
			var channel:SoundChannel = backgroundSound.play();
			channel.addEventListener(Event.SOUND_COMPLETE, onComplete);
		}

		private function onComplete(event:Event):void
		{
			SoundChannel(event.target).removeEventListener(event.type, onComplete);
			playSound();
		}
		
		//add to score
		private function addMeters():void
		{
			scoreInt += 1;
		}
		
		private function addSpeed ():void
		{
			speedOffset += 1;
		}
		
		private function update(e:Event):void 
		{
			//make score count and set its position on stage
			score.text = "Distance: " + scoreInt + " M";
			score.x = 10;
			score.y = 130;
			addChild(score);
			
			//scroll the backgrounds
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
			
			for (var i:int = 0; i < aObstacle.length; i++ )
			{
				aObstacle[i].x -= scrollSpeed * 2 + speedOffset;
				if (aObstacle[i].x < -120 || player.hitTestObject(enemyObstacle))
				{
					removeChild(aObstacle[i]);
					aObstacle.splice(i,1);
				}
				
				
				if (player.hitTestObject(enemyObstacle) && !isEndScreen) 
				{
					format1 = new TextFormat;
					endScreen = new GameOver;
					stage.frameRate = 0;
					addChild(endScreen);
					spawnTimer.stop();
					yourScore = scoreInt;
					format1.font = "Arial Black"
					format1.color = 0xd48f77;
					format1.size = 30;
					yourScoreText.text = "Your Score: " + yourScore + " M";
					yourScoreText.setTextFormat(format1);
					yourScoreText.x = 250;
					yourScoreText.y = 150;
					yourScoreText.width = 300;
					yourScoreText.height = 200;
					addChild(yourScoreText);
					
					
					isEndScreen = true;
					
					stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
					
				}
			}
			
		}
		private function onKeyDown(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.SPACE && isEndScreen)
			{
				removeChild(endScreen);
				removeChild(yourScoreText);
				stage.frameRate = 30;
				scoreInt = 0;
				speedOffset = 0;
				spawnTimer.start();
				isEndScreen = false;
			}
			if (e.keyCode == Keyboard.SPACE && isInHomeScreen)
			{
				removeChild(beginScreen);
				init(null);
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
				isInHomeScreen = false;
			}
		}
	}
}