package wordList {

    import radixTree.RadixTree;

    public class RadixTreeWordList extends WordListBase {
        
        private var tree:RadixTree;
        private var loader:IWordListFileLoader;
        
        public function RadixTreeWordList() {
            this.tree = new RadixTree;
        }
        
        override public function addWord(word:String):void {
            this.tree.addWord(word);
        }
        
        override public function readWordsFromFile(file:String, minLength:int, maxLength:int):void {
            this.loader = new URLFileLoader();
            this.loader.loadFileIntoList(file, this, minLength, maxLength);
        }
        
        override public function isWordInList(word:String):Boolean {
            return this.tree.isValidWord(word);
        }
        
        override public function getAllWords():Array {
            return this.tree.getValidWords();
        }
        
        override public function createWordListFromCharacterSet(set:String):IWordList {
            var newWordList:RadixTreeWordList = new RadixTreeWordList();
            newWordList.setTree(this.tree.createTreeFromCharacterSet(set));
            
            return newWordList;
        }
        
        override public function createWordListFromCharacterMultiset(multiset:String):IWordList {
            var newWordList:RadixTreeWordList = new RadixTreeWordList();
            newWordList.setTree(this.tree.createTreeFromCharacterMultiset(multiset));
            
            return newWordList;
        }
        
        override public function fileLoadProgress(percent:Number):void {
            dispatchEvent(new WordListEvent(WordListEvent.FILE_LOAD_PROGRESS, percent));
        }
        
        override public function fileLoadComplete():void {
            dispatchEvent(new WordListEvent(WordListEvent.FILE_LOAD_COMPLETE));
        }
        
        override public function fileLoadError(message:String):void {
            dispatchEvent(new WordListEvent(WordListEvent.FILE_LOAD_ERROR));
        }
        
        private function setTree(newTree:RadixTree):void {
            this.tree = newTree;
        }
    }

}