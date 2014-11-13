package model {

    internal class LetterGenerator {
        
        private var freq:Array;
        
        /**
         * Constructor.
         */
        function LetterGenerator() {
            freq = null;
        }
        
        /**
         * Creates a string of letters from the set of a-z (all lowercase).
         *
         * @param numberOfLetters The desired length of the string.
         */
        public function generateLetterString(numberOfLetters:uint):String {
            var str:String = "";
            
            while (numberOfLetters > 0) {
                str += randomLetterByFrequency();
                numberOfLetters--;
            }
            
            return str;
        }
        
        /**
         * Returns a random letter from a-z taking the letter frequency of English
         * words into account.
         */
        private function randomLetterByFrequency():String {
            var obj:Object;
            var i:int;
            var letter:String;
            
            // Create a seed from 1-1000 (the space of the letter distribution).
            var seed:int = Math.round(Math.random() * 999) + 1;
            
            // Build the array of letter frequencies, if needed.
            if (freq == null) {
                freq = new Array();
                freq.push({letter:"a", value:73});
                freq.push({letter:"b", value:9});
                freq.push({letter:"c", value:30});
                freq.push({letter:"d", value:44});
                freq.push({letter:"e", value:130});
                freq.push({letter:"f", value:28});
                freq.push({letter:"g", value:16});
                freq.push({letter:"h", value:35});
                freq.push({letter:"i", value:74});
                freq.push({letter:"j", value:2});
                freq.push({letter:"k", value:3});
                freq.push({letter:"l", value:35});
                freq.push({letter:"m", value:25});
                freq.push({letter:"n", value:78});
                freq.push({letter:"o", value:74});
                freq.push({letter:"p", value:27});
                freq.push({letter:"q", value:3});
                freq.push({letter:"r", value:77});
                freq.push({letter:"s", value:63});
                freq.push({letter:"t", value:93});
                freq.push({letter:"u", value:27});
                freq.push({letter:"v", value:13});
                freq.push({letter:"w", value:16});
                freq.push({letter:"x", value:5});
                freq.push({letter:"y", value:19});
                freq.push({letter:"z", value:1});
            }
            
            // Determine the letter to use by the frequency.
            for (i=0; i<freq.length; i++) {
                obj = freq[i] as Object;
                letter = obj.letter;
                seed -= obj.value;
                
                if (seed <= 0) {
                    // We've found the letter.
                    break;
                }
            }
            
            return letter;
        }
    }

}