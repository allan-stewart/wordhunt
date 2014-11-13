package wordList {
    
    internal interface IWordListFileLoader {
        
        function loadFileIntoList(file:String, list:IWordList, minLength:int, maxLength:int):void;
        
    }
    
}