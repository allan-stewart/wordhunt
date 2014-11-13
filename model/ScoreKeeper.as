package model {
    
    import wordList.RadixTreeWordList;

    public class ScoreKeeper {
        
        private var wordsScored:RadixTreeWordList;
        private var totalScore:int;
        
        function ScoreKeeper() {
            this.wordsScored = new RadixTreeWordList();
        }
        
        public function getTotalScore():int {
            return totalScore;
        }
        
        /**
         * Note: The words sent to this function should have already been verified
         * that they are valid words for the puzzle.
         */
        public function scoreWord(word:String):int {
            var score:int;
            
            // Have we already scored this word?
            if (wordsScored.isWordInList(word)) {
                return 0;
            }
            wordsScored.addWord(word);
            
            score = word.length;
            totalScore += score;
            
            return score;
        }
    }
}