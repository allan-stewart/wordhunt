package model {
    
    import flash.events.Event;
    
    /**
     * This custom Event is dispatched from a running game.
     */
    public class GameEvent extends Event 
    {
        /**
         * Event type dispatched when the game timer starts.
         */
        public static const TIMER_START:String = "timer_start";
        
        /**
         * Event type used to indicate the progress of a running timer.
         */
        public static const TIMER_PROGRESS:String = "timer_progress";
        
        /**
         * Event type dispached when the game timer has expired.
         */
        public static const TIMER_END:String = "timer_end";
        
        
        /**
         * The number of seconds left in the game.
         */
        public var secondsLeft:int;
        
        /**
         * Constructor.
         */
        public function GameEvent(type:String)
        {
            super(type);
        }
        
        /**
         * Creates and returns a copy of the current instance.
         * @return A copy of the current instance.
         */
        public override function clone():Event
        {
            return new GameEvent(this.type);
        }
        
        /**
         * Returns a String representation of the event instance.
         * @return A String.
         */
        public override function toString():String
        {
            return "[GameEvent: " + this.type + ", secondsLeft: "+this.secondsLeft+"]";
        }

    }

    
}