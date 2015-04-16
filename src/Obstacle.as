package 
{
	/**
	 * ...
	 * @author Benjamin
	 */
	public class Obstacle extends ObstacleCube
	{
		
		public function Obstacle() 
		{
			
		}
		
		
		public function Add():void {
			//set postition and scale of Obstacle
			this.x = 800;
			this.y = 415;
			this.scaleX = 0.25;
			this.scaleY = 0.25;
		}
		
	}

}