package 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Benjamin
	 */
	public class Obstacle extends MovieClip
	{
		
		public function Obstacle() 
		{
			var ob:MovieClip = new ObstacleCube();
			addChild (ob);
		}
		
	}

}