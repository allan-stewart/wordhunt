package model {

    import flash.events.EventDispatcher;
    
    import wordList.RadixTreeWordList;
    import wordList.WordListEvent;

    public class MainModel extends EventDispatcher {
        
        private static const MIN_WORD_LENGTH:uint = 3;
        private static const MAX_WORD_LENGTH:uint = 25;
        
        private var allWordList:RadixTreeWordList;
        
        function MainModel() {
            // Create the word list for all words and add listeners.
            allWordList = new RadixTreeWordList();
            allWordList.addEventListener(WordListEvent.FILE_LOAD_PROGRESS, wordListLoadHandler, false, 0, true);
            allWordList.addEventListener(WordListEvent.FILE_LOAD_ERROR, wordListLoadHandler, false, 0, true);
            allWordList.addEventListener(WordListEvent.FILE_LOAD_COMPLETE, wordListLoadHandler, false, 0, true);
        }
        
        public function loadWordListFile(file:String):void {
            allWordList.readWordsFromFile(file, MainModel.MIN_WORD_LENGTH, MainModel.MAX_WORD_LENGTH);
        }
        
        public function createNewPuzzle(width:uint, height:uint):PuzzleGame {
            var puzzle:PuzzleBlock;
            var puzzleWordList:RadixTreeWordList;
            
            var possibleWords:Array;
            var moves:Array;
            var i:uint;
            
            // Create a new puzzle.
            puzzle = new PuzzleBlock(PuzzleBlock.MODE_ADJACENT_DIAGONAL, width, height);
            
            // Create the list of words which can be made in this puzzle.
            puzzleWordList = new RadixTreeWordList();
            possibleWords = allWordList.createWordListFromCharacterMultiset(puzzle.getAllLetters()).getAllWords();
            
            for (i=0; i<possibleWords.length; i++) {
                moves = puzzle.getValidMovesForString(possibleWords[i]);
                if (moves.length > 0) {
                    puzzleWordList.addWord(possibleWords[i]);
                }
            }
            
            // Make the game and return it.
            return new PuzzleGame(puzzle, puzzleWordList);
        }
        
        
        
        private function wordListLoadHandler(e:WordListEvent):void {
            var event:ModelEvent = null;
            
            // Dispatch a ModelEvent based on the type of event received.
            if (e.type == WordListEvent.FILE_LOAD_PROGRESS) {
                event = new ModelEvent(ModelEvent.FILE_LOAD_PROGRESS);
            }
            
            if (e.type == WordListEvent.FILE_LOAD_ERROR) {
                event = new ModelEvent(ModelEvent.FILE_LOAD_ERROR);
            }
            
            if (e.type == WordListEvent.FILE_LOAD_COMPLETE) {
                event = new ModelEvent(ModelEvent.FILE_LOAD_COMPLETE);
            }
            
            if (event != null) {
                event.percent = e.percent;
                dispatchEvent(event);
            }
        }
        
    }
}