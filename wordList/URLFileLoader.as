package wordList {

    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.TimerEvent
    
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    
    import flash.utils.Timer;
    
    import mx.utils.StringUtil;

    internal class URLFileLoader implements IWordListFileLoader {
        
        private var targetWordList:IWordList;
        private var minWordLength:int;
        private var maxWordLength:int;
        private var loader:URLLoader;
        private var wordData:String;
        private var currentWord:String;
        private var charIndex:int;
        private var processTimer:Timer;
        
        /**
         * Constructor
         */
        public function URLFileLoader() {
            this.targetWordList = null;
            this.minWordLength = 0;
            this.maxWordLength = 0;
            this.loader = null;
        }
        
        public function loadFileIntoList(file:String, list:IWordList, minLength:int, maxLength:int):void {
            this.targetWordList = list;
            this.minWordLength = minLength;
            this.maxWordLength = maxLength;
            
            // Make a URLLoader to load up the data.
            this.loader = new URLLoader();
            this.loader.addEventListener(Event.COMPLETE, loadCompleteHandler, false, 0, true);
            this.loader.addEventListener(ProgressEvent.PROGRESS, loadProgressHandler, false, 0, true);
            this.loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loadSecurityErrorHandler, false, 0, true);
            this.loader.addEventListener(IOErrorEvent.IO_ERROR, loadIOErrorHandler, false, 0, true);
            
            var request:URLRequest = new URLRequest(file);
            try {
                this.loader.load(request);
            } catch (error:Error) {
                this.targetWordList.fileLoadError("Loader error: " + error.message);
            }
        }
        
        /**
         * Handles the Event.COMPLETE event dispatched when file loading is finished.
         */
        private function loadCompleteHandler(e:Event):void {
            this.wordData = this.loader.data as String;
            this.currentWord = "";
            this.charIndex = 0;
            
            this.processTimer = new Timer(10);
            this.processTimer.addEventListener(TimerEvent.TIMER, processWordData, false, 0, true);
            this.processTimer.start();
        }
        
        private function processWordData(e:TimerEvent):void {
            var totalLength:int;
            var i:int;
            var letter:String;
            var percent:Number;
            
            totalLength = this.wordData.length;
            
            // Parse the string.
            for (i=this.charIndex; i<totalLength; i++) {
                // Get the letter.
                letter = this.wordData.charAt(i);
                
                // Check for whitespace.
                if (StringUtil.isWhitespace(letter)) {
                    this.addWord(this.currentWord);
                    this.currentWord = "";
                } else {
                    // Append the letter to the word.
                    this.currentWord += letter;
                }
                
                if (i % 1000 == 0) {
                    // Calculate the percentage.
                    // (Divide by 2 because adding words is only half the work,
                    //  add .5 because loading the file was the other half.)
                    percent = (i / totalLength) / 2 + .5;
                    this.targetWordList.fileLoadProgress(percent);
                    this.charIndex = i+1;
                    return;
                }
            }
            
            // Done parsing, add the last word.
            this.processTimer.stop();
            this.addWord(this.currentWord);
            this.targetWordList.fileLoadComplete();
            this.clearRefs();
        }
        
        /**
         * Checks whether the word is valid, and adds it to the wordList if it is.
         */
        private function addWord(word:String):void {
            // Is it even a word?
            if (word.length == 0) {
                return;
            }
            
            // Is it too small?
            if (word.length < this.minWordLength) {
                return;
            }
            
            // Is it too long?
            if ((this.maxWordLength > 0) && (word.length > this.maxWordLength)) {
                return;
            }
            
            // Add the word to the word list.
            this.targetWordList.addWord(word);
        }
        
        /**
         * Handles ProgressEvents dispatched when loading a file.
         */
        private function loadProgressHandler(e:ProgressEvent):void {
            // Determine the loading percent, then divide by 2 because loading
            // represents half the work, the other half is adding the words.
            var percent:Number = (e.bytesLoaded / e.bytesTotal) / 2;
            this.targetWordList.fileLoadProgress(percent);
        }
        
        /**
         * Handles SecurityErrorEvents dispatched when trying to load the file.
         */
        private function loadSecurityErrorHandler(e:SecurityErrorEvent):void {
            this.targetWordList.fileLoadError("Security error: " + e.toString());
            this.clearRefs();
        }
        
        /**
         * Handles IOErrorEvents dispatched when trying to load the file.
         */
        private function loadIOErrorHandler(e:IOErrorEvent):void {
            this.targetWordList.fileLoadError("IO error: " + e.toString());
            this.clearRefs();
        }
        
        /**
         * This removes the references used in this class so things can be properly
         * garbage collected later.
         */
        private function clearRefs():void {
            this.targetWordList = null;
            this.loader = null;
            this.processTimer = null;
        }
        
    }

}