package wordList {

    /**
     * This interface defines a WordList which is used to load up and store
     * a list of words.
     */
    public interface IWordList {
        
        /**
         * Add a word to the list.
         *
         * @param word The word to add.
         */
        function addWord(word:String):void;
        
        /**
         * Reads in words from a file. It skips words which are either too short or long.
         *
         * @param file The path to the file.
         * @param minLength The minimum length required to add the word to the list.
         * @param maxLength The maximum length of word which may be added to the list.
         * A value of zero (0) indicates no maximum length.
         */
        function readWordsFromFile(file:String, minLength:int, maxLength:int):void;
        
        /**
         * Returns whether the specified word is in the list.
         * 
         * @param word The word to check.
         * @return TRUE if the word is in the list, FALSE otherwise.
         */
        function isWordInList(word:String):Boolean;
        
        /**
         * Returns an array of all the words in the list.
         *
         * @return An array of words.
         */
        function getAllWords():Array;
        
        /**
         * Creates a word list from the specified set of characters.
         *
         * @param set The set of characters to use.
         * @return A new IWordList.
         */
        function createWordListFromCharacterSet(set:String):IWordList;
        
        /**
         * Creates a word list from the specified multiset of characters.
         * (The cardinality matters - the multiset "est" will not return "test",
         * but "estt" will.)
         *
         * @param multiset The multiset of characters.
         * @return A new IWordList.
         */
        function createWordListFromCharacterMultiset(multiset:String):IWordList;
        
        /**
         * Function which can be used by word-loading code to indicate the percent complete.
         * This method will dispatch WordListEvents.
         *
         * @param percent The percentage complete, defined from [0-1].
         */
        function fileLoadProgress(percent:Number):void;
        
        /**
         * Function called by word-loading code to indicate that the file load is done.
         */
        function fileLoadComplete():void;
        
        /**
         * Function called by word-loading code if there is an error loading the file.
         */
        function fileLoadError(message:String):void;
    }

}