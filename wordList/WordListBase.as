package wordList {

    import flash.events.EventDispatcher;

    internal class WordListBase extends EventDispatcher implements IWordList {
        
        public function addWord(word:String):void {
        
        }
        
        public function readWordsFromFile(file:String, minLength:int, maxLength:int):void {
        
        }
        
        public function isWordInList(word:String):Boolean {
            return false;
        }
        
        public function getAllWords():Array {
            return null;
        }
        
        public function createWordListFromCharacterSet(set:String):IWordList {
            return null;
        }
        
        public function createWordListFromCharacterMultiset(multiset:String):IWordList {
            return null;
        }
        
        public function fileLoadProgress(percent:Number):void {
            
        }
        
        public function fileLoadComplete():void {
            
        }
        
        public function fileLoadError(message:String):void {
            
        }
        
    }

}