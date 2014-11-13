package model {
    
    import flash.events.Event;
    
    /**
     * This custom Event can be dispatched from an IWordList.
     */
    public class ModelEvent extends Event 
    {
        /**
         * Event type to use to indicate that loading a file has begun.
         */
        public static const FILE_LOAD_START:String = "file_load_start";
        
        /**
         * Event type to use to indicate progress of loading a file.
         */
        public static const FILE_LOAD_PROGRESS:String = "file_load_progress";
        
        /**
         * Event type to use to indicate the file has completed loading.
         */
        public static const FILE_LOAD_COMPLETE:String = "file_load_complete";
        
        /**
         * Event type to use to indicate an error when loading a file.
         */
        public static const FILE_LOAD_ERROR:String = "file_load_error";
        
        
        /**
         * Tracks the percentage of the file has been loaded.
         */
        public var percent:Number;
        
        /**
         * Constructor.
         */
        public function ModelEvent(type:String)
        {
            super(type);
        }
        
        /**
         * Creates and returns a copy of the current instance.
         * @return A copy of the current instance.
         */
        public override function clone():Event
        {
            return new ModelEvent(this.type);
        }
        
        /**
         * Returns a String representation of the event instance.
         * @return A String.
         */
        public override function toString():String
        {
            return "[ModelEvent: " + this.type + ", percent: "+this.percent+"]";
        }

    }

    
}