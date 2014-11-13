package controller {
    
    import flash.events.Event;
    
    import model.GameEvent;
    import model.PuzzleGame;
    import model.PuzzleBlock;
    
    import mx.events.FlexEvent;
    
    import view.GameView;

    public class GameController {
        
        private var appControl:AppController;
        private var puzzle:PuzzleGame;
        private var myView:GameView;
        private var blockController:LetterBlockController;
        
        function GameController(appController:AppController, puzzle:PuzzleGame) {
            var block:PuzzleBlock;
            var temp:*;
            
            this.appControl = appController;
            this.puzzle = puzzle;
            
            // Add listeners to the puzzle.
            this.puzzle.addEventListener(GameEvent.TIMER_PROGRESS, timerHandler, false, 0, true);
            this.puzzle.addEventListener(GameEvent.TIMER_END, timerHandler, false, 0, true);
            
            // Set up the view.
            this.myView = new GameView();
            this.myView.setScore(this.puzzle.getScore());
            this.myView.addInputListener(Event.CHANGE, inputHandler);
            this.myView.addInputListener(FlexEvent.ENTER, inputEnterHandler);
            
            block = this.puzzle.getPuzzle();
            blockController = new LetterBlockController(block.getAllLetters(), block.getWidth());
            temp = blockController.getView();
            temp.x = 50;
            temp.y = 70;
            this.myView.addChild(temp);
            
            // todo: remove this testing code.
            startGame();
            //this.myView.setWordText(this.puzzle.getAllWordsForPuzzle().toString() + "\n");
        }
        
        public function getView():GameView {
            return this.myView;
        }
        
        public function startGame():void {
            this.puzzle.startGame();
        }
        
        
        
        private function timerHandler(e:GameEvent):void {
            var min:uint;
            var sec:uint;
            var time:String;
            
            min = Math.floor(e.secondsLeft / 60);
            sec = e.secondsLeft % 60;
            
            time = min + ":";
            if (sec < 10) {
                time += "0";
            }
            time += sec;
            
            this.myView.setTimer(time);
        }
        
        private function inputHandler(e:Event):void {
            var word:String;
            var moves:Array;
            
            // Get the text they typed in lower case.
            word = this.myView.getInputText().toLowerCase();
            
            // Get the valid moves for this word.
            moves = this.puzzle.getPuzzle().getValidMovesForString(word);
            
            // Put the word back into the field (capitalized).
           this.myView.setInputText(word.toUpperCase(), (moves.length > 0));
           
           // Take the moves and highlight the board appropriately.
           blockController.highlightMoves(moves);
        }
        
        private function inputEnterHandler(e:FlexEvent):void {
            var word:String;
            var points:int;
            
            // Get the text they typed in lower case.
            word = this.myView.getInputText().toLowerCase();
            
            // Score the word (which will make sure it is a valid word).
            points = this.puzzle.scoreWordForPuzzle(word);
            
            if (points > 0) {
                this.myView.appendWordText(word + " - " + points + " points\n");
                this.myView.setScore(this.puzzle.getScore());
                this.myView.setInputText("", true);
                blockController.clearAllHighlights();
            }
        }
        
    }
}