package model {

    /**
     * This class represents a block of letters which make up a word puzzle.
     * 
     * The PuzzleBlock will return the letters of the puzzle in a single string,
     * but valid moves are calculated based on the mode and location of the letters
     * as if they were in a block as illustrated below.
     *
     * A puzzle of the letters (in order): "abcdefghijklmnop"
     * with a width of 4, height of 4 should be displayed as:
     *
     * abcd
     * efgh
     * ijkl
     * mnop
     *
     * A similar puzzle of the letters: "abcdefghijklmnop"
     * with a width of 8, height of 2 should be displayed as:
     * 
     * abcdefgh
     * ijklmnop
     *
     */
    public class PuzzleBlock {
        
        /**
         * In this mode, any move from one letter to another is valid,
         * regardless of their positions.
         */
        public static const MODE_JUMP:uint = 0;
        
        /**
         * In this mode, moves are only valid if the letters are adjacent
         * to each other (up, down, left, right).
         */
        public static const MODE_ADJACENT:uint = 1;
        
        /**
         * In this mode, moves are only valid if the letters are next to each
         * other diagonally (1 space: up & left, up & right, down & left, down & right).
         */
        public static const MODE_DIAGONAL:uint = 2;
        
        /**
         * In this mode, moves are valid if they are either adjacent or diagonal, as
         * described by those modes.
         */
        public static const MODE_ADJACENT_DIAGONAL:uint = 3;
        
        
        /**
         * The number of valid modes, used to determine if the mode passed
         * in is a valid one.
         */
        private static const MAX_VALID_MODE:uint = 3;
        
        
        private var mode:uint;
        private var block:String;
        private var blockWidth:uint;
        private var blockHeight:uint;
        
        /**
         * Constructor.
         *
         * @param mode The validation mode to use on this puzzle block.
         * @param width The width for this puzzle block.
         * @param height The height for this puzzle block.
         */
        function PuzzleBlock(mode:uint, width:uint, height:uint, letters:String = null) {
            // Check that they provided a valid mode.
            this.mode = mode;
            if (this.mode > PuzzleBlock.MAX_VALID_MODE) {
                throw new Error("Invalid PuzzleBlock mode.");
            }
            
            // Check the width & height.
            if ((width == 0) || (height == 0)) {
                throw new Error("Invalid PuzzleBlock size.");
            }
            
            // Set the width & height.
            this.blockWidth = width;
            this.blockHeight = height;
            
            // Set the block of letters.
            if (letters == null) {
                // Generate the block of letters.
                var gen:LetterGenerator = new LetterGenerator();
                this.block = gen.generateLetterString(this.blockWidth * this.blockHeight);
            } else {
                // Make sure the length is valid.
                this.block = letters;
                if (this.block.length != (this.blockWidth * this.blockHeight)) {
                    throw new Error("Invalid PuzzleBlock size.");
                }
            }
        }
        
        /**
         * Returns the puzzle mode.
         */
        public function getMode():uint {
            return mode;
        }
        
        /**
         * Returns all the letters in the puzzle block as a single string.
         *
         * @return The letters.
         */
        public function getAllLetters():String {
            return block;
        }
        
        /**
         * Returns the width of the puzzle block.
         *
         * @return The width;
         */
        public function getWidth():uint {
            return blockWidth;
        }
        
        /**
         * Returns the height of the puzzle block.
         *
         * @return The height;
         */
        public function getHeight():uint {
            return blockHeight;
        }
        
        /**
         * Returns the letter at the specified index.
         * 
         * @param index The index into the puzzle block.
         * @return The letter, or the empty string if the index is out of range.
         */
        public function getLetterAtIndex(index:uint):String {
            if (index >= this.block.length) {
                return "";
            }
            return this.block.charAt(index);
        }
        
        /**
         * This method is used to return all the valid moves which can create the
         * specified string. Each move is an array of character indicies.
         */
        public function getValidMovesForString(str:String):Array {
            return getValidMoves(str, 0, new Array());
        }
        
        private function getValidMoves(str:String, strIndex:uint, usedCharacterIndicies:Array):Array {
            var index:uint;
            var i:uint;
            var indexUsed:Boolean;
            var move:Array;
            var validMoves:Array = new Array();
            
            // Find all instances of the character in the puzzle block.
            for (index=0; index<this.block.length; index++) {
                if (this.block.charAt(index) == str.charAt(strIndex)) {
                    
                    // We found a match! Make sure it hasn't been used before.
                    indexUsed = false;
                    for (i=0; i<usedCharacterIndicies.length; i++) {
                        if (usedCharacterIndicies[i] == index) {
                            indexUsed = true;
                            break; // This only breaks the inner loop!
                        }
                    }
                    if (indexUsed) {
                        // Continue to the next index.
                        continue;
                    }
                    
                    // Now check that it is a valid move.
                    // (The first move is always valid).
                    if (usedCharacterIndicies.length > 0) {
                        if (!isValidMove(usedCharacterIndicies[usedCharacterIndicies.length - 1], index)) {
                            // This was not a valid move.
                            // Continue to the next index.
                            continue;
                        }
                    }
                    
                    // Is this the last character of the string?
                    if (strIndex == (str.length - 1)) {
                        // We are good. Return this index in the array.
                        move = new Array();
                        move.push(index);
                        validMoves.push(move);
                        continue;
                    }
                    
                    // There are more characters to check.
                    var moves:Array = getValidMoves(str, strIndex+1, usedCharacterIndicies.concat(index));
                    
                    // Add the current index to each of these moves and add them all
                    // to the return array.
                    for (i=0; i<moves.length; i++) {
                        move = moves[i] as Array;
                        move.splice(0, 0, index)
                        validMoves.push(move);
                    }
                }
            }
            
            return validMoves;
        }
        
        /**
         * Checks whether the move is valid based on the validation mode selected
         * for this PuzzleBlock.
         */
        private function isValidMove(fromIndex:uint, toIndex:uint):Boolean {
            // Check that the indicies are valid.
            if (Math.max(fromIndex, toIndex) >= this.block.length) {
                return false;
            }
            
            // If the mode is jump, then they can go from any place to any other.
            if (this.mode == PuzzleBlock.MODE_JUMP) {
                return true;
            }
            
            // Calculate coordinate pairs for the indicies.
            var fromX:int = fromIndex % this.blockWidth;
            var fromY:int = Math.floor(fromIndex / this.blockWidth);
            var toX:int = toIndex % this.blockWidth;
            var toY:int = Math.floor(toIndex / this.blockWidth);
            
            // Determine the absolute difference from the x,y values.
            var absX:int = Math.abs(fromX-toX);
            var absY:int = Math.abs(fromY-toY);
            
            // Check adjacent letters.
            if ((this.mode == PuzzleBlock.MODE_ADJACENT) || (this.mode == PuzzleBlock.MODE_ADJACENT_DIAGONAL)) {
                // Check left & right.
                if ((fromY == toY) && (absX == 1)) {
                    return true;
                }
                
                // Check up & down.
                if ((fromX == toX) && (absY == 1)) {
                    return true;
                }
            }
            
            // Check diagonal letters.
            if ((this.mode == PuzzleBlock.MODE_DIAGONAL) || (this.mode == PuzzleBlock.MODE_ADJACENT_DIAGONAL)) {
                if ((absX == 1) && (absY == 1)) {
                    return true;
                }
            }
            
            // No valid move was found.
            return false;
        }
        
    }
}