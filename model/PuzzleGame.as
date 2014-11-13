package model {

    import flash.events.EventDispatcher;
    import flash.events.TimerEvent;
    import flash.utils.Timer;
    
    import wordList.IWordList;

    public class PuzzleGame extends EventDispatcher {
        
        /**
         * Interval used for the game timer, in milliseconds.
         */
        private static const timerInterval:Number = 500;
        
        /**
         * Number of seconds for a game.
         */
        private static const totalGameSeconds:int = 180;
        
        private var puzzle:PuzzleBlock;
        private var validWords:IWordList;
        private var scoreKeeper:ScoreKeeper;
        private var gameTimer:Timer;
        private var lastTime:Number;
        private var secondsLeft:int;
        
        function PuzzleGame(puzzle:PuzzleBlock, validWords:IWordList) {
            this.puzzle = puzzle;
            this.validWords = validWords;
            this.scoreKeeper = new ScoreKeeper();
            
            this.gameTimer = new Timer(PuzzleGame.timerInterval);
            this.gameTimer.addEventListener(TimerEvent.TIMER, gameTimerHandler, false, 0, true);
        }
        
        public function getPuzzle():PuzzleBlock {
            return puzzle;
        }
        
        public function isValidWordForPuzzle(word:String):Boolean {
            if (validWords == null) {
                return false;
            }
            
            return validWords.isWordInList(word);
        }
        
        public function getAllWordsForPuzzle():Array {
            if (validWords == null) {
                return null;
            }
            
            return validWords.getAllWords();
        }
        
        public function scoreWordForPuzzle(word:String):int {
            // Is it a valid word?
            if (!this.isValidWordForPuzzle(word)) {
                return 0;
            }
            
            return this.scoreKeeper.scoreWord(word);
        }
        
        public function getScore():int {
            return this.scoreKeeper.getTotalScore();
        }
        
        public function startGame():void {
            var now:Date;
            
            // Set the total game time.
            this.secondsLeft = PuzzleGame.totalGameSeconds;
            
            // Start the timer.
            now = new Date();
            this.lastTime = now.time;
            this.gameTimer.start();
        }
        
        
        public function pauseGame():void {
            // Pause the timer.
            this.gameTimer.stop();
        }
        
        public function unpauseGame():void {
            // Resume the timer.
            this.gameTimer.start();
        }
        
        
        
        private function gameTimerHandler(e:TimerEvent):void {
            var secondsDiff:Number;
            var now:Date;
            var event:GameEvent;
            
            now = new Date();
            
            secondsDiff = Math.floor((now.time - this.lastTime) / 1000);
            if (secondsDiff > 0) {
                this.secondsLeft -= secondsDiff;
                this.lastTime = now.time;
            }
            
            // Stop the timer at the end.
            if (this.secondsLeft <= 0) {
                this.gameTimer.stop();
                // Send a timer event.
                event = new GameEvent(GameEvent.TIMER_END);
                event.secondsLeft = 0;
                dispatchEvent(event);
                return;
            }
            
            // Send an event with the number of seconds left.
            event = new GameEvent(GameEvent.TIMER_PROGRESS);
            event.secondsLeft = this.secondsLeft;
            dispatchEvent(event);
        }
        
        
        
    }
}
