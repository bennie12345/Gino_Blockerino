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
			this.y = 430;
			this.scaleX = 0.2;
			this.scaleY = 0.2;
		}
		
	}

}