package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.media.Sound;
	/**
	 * ...
	 * @author Benjamin
	 */
	public class Player extends PlayerCube
	{
		private var grav:Number = 8;
		private var jumping:Boolean = false;
		private var jumpPow:Number = 0;
		private var sound:Sound = new JumpSound;
		
		public function Player() 
		{
			
			
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			this.x = 150;
			this.y = 460;
			this.scaleX = 0.2;
			this.scaleY = 0.2;
		}
		
		private function init(e:Event):void 
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.SPACE)
			{
				//Player pressed Spacebar
			 
				if(jumping != true)
				{
					sound.play();
					jumpPow = -60;
					jumping = true;
				}
			}
			
		}
		private function update(evt:Event):void
		{
			if(jumping)
				{
					this.rotation += 22.5;
					this.y += jumpPow;
					jumpPow += grav;
					

					if(this.y >= 460)
					{
						jumping = false;
						this.y = 460;
					}
				}
			
		}
		
	}

}