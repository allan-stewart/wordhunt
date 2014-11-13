package model {

    import flexunit.framework.TestCase;

    public class PuzzleBlockTest extends TestCase {
        
        public function testConstructor():void {
            var puz:PuzzleBlock;
            var width:uint;
            var height:uint;
            var errorThrown:Boolean;
            var letters:String;
            
            width = 4;
            height = 4;
            
            puz = new PuzzleBlock(PuzzleBlock.MODE_JUMP, width, height);
            assertEquals("Checking mode", PuzzleBlock.MODE_JUMP, puz.getMode());
            assertEquals("Checking width", width, puz.getWidth());
            assertEquals("Checking height", height, puz.getHeight());
            assertEquals("Checking length", (width*height), puz.getAllLetters().length);
            
            width = 5;
            height = 3;
            
            puz = new PuzzleBlock(PuzzleBlock.MODE_JUMP, width, height);
            assertEquals("Checking mode", PuzzleBlock.MODE_JUMP, puz.getMode());
            assertEquals("Checking width", width, puz.getWidth());
            assertEquals("Checking height", height, puz.getHeight());
            assertEquals("Checking length", (width*height), puz.getAllLetters().length);
            
            width = 3;
            height = 5;
            
            puz = new PuzzleBlock(PuzzleBlock.MODE_JUMP, width, height);
            assertEquals("Checking mode", PuzzleBlock.MODE_JUMP, puz.getMode());
            assertEquals("Checking width", width, puz.getWidth());
            assertEquals("Checking height", height, puz.getHeight());
            assertEquals("Checking length", (width*height), puz.getAllLetters().length);
            
            width = 0;
            height = 4;
            
            errorThrown = false;
            try {
                puz = new PuzzleBlock(PuzzleBlock.MODE_JUMP, width, height);
            } catch (e:Error) {
                errorThrown = true;
            }
            assertTrue("Invalid width throws an error", errorThrown);
            
            width = 4;
            height = 0;
            
            errorThrown = false;
            try {
                puz = new PuzzleBlock(PuzzleBlock.MODE_JUMP, width, height);
            } catch (e:Error) {
                errorThrown = true;
            }
            assertTrue("Invalid height throws an error", errorThrown);
            
            width = 4;
            height = 4;
            letters = "abcdefg";
            
            errorThrown = false;
            try {
                puz = new PuzzleBlock(PuzzleBlock.MODE_JUMP, width, height, letters);
            } catch (e:Error) {
                errorThrown = true;
            }
            assertTrue("Invalid letters length throws an error", errorThrown);
            
            width = 4;
            height = 4;
            letters = "abcdefghijklmnopq";
            
            errorThrown = false;
            try {
                puz = new PuzzleBlock(PuzzleBlock.MODE_JUMP, width, height, letters);
            } catch (e:Error) {
                errorThrown = true;
            }
            assertTrue("Invalid letters length throws an error", errorThrown);
            
            width = 4;
            height = 4;
            letters = "abcdefghijklmnop";
            puz = new PuzzleBlock(PuzzleBlock.MODE_JUMP, width, height, letters);
            assertEquals("Checking mode", PuzzleBlock.MODE_JUMP, puz.getMode());
            assertEquals("Checking width", width, puz.getWidth());
            assertEquals("Checking height", height, puz.getHeight());
            assertEquals("Checking length", (width*height), puz.getAllLetters().length);
            assertEquals("Checking letters", letters, puz.getAllLetters());
        }
        
        
        public function testValidMovesJump():void {
            var moves:Array;
            var puz:PuzzleBlock;
            
            puz = new PuzzleBlock(PuzzleBlock.MODE_JUMP, 4, 4, "abcdefghijklmnop");
            
            moves = puz.getValidMovesForString("abpjl");
            assertEquals("Checking valid moves", 1, moves.length);
            assertEquals("Valid moves", "0,1,15,9,11", moves[0].toString());
            
            moves = puz.getValidMovesForString("abapjl");
            assertEquals("Checking valid moves", 0, moves.length);
            
            moves = puz.getValidMovesForString("abpqjl");
            assertEquals("Checking valid moves", 0, moves.length);
            
            
            puz = new PuzzleBlock(PuzzleBlock.MODE_JUMP, 4, 4, "abcdefghijklmnap");
            
            moves = puz.getValidMovesForString("abpjl");
            assertEquals("Checking valid moves", 2, moves.length);
            
            moves = puz.getValidMovesForString("bpajl");
            assertEquals("Checking valid moves", 2, moves.length);
            
            moves = puz.getValidMovesForString("bpajla");
            assertEquals("Checking valid moves", 2, moves.length);
        }
        
        public function testValidMovesAdjacent():void {
            var moves:Array;
            var puz:PuzzleBlock;
            
            puz = new PuzzleBlock(PuzzleBlock.MODE_ADJACENT, 4, 4, "abcdefghijklmnop");
            
            moves = puz.getValidMovesForString("abpjl");
            assertEquals("Checking valid moves", 0, moves.length);
            
            moves = puz.getValidMovesForString("de");
            assertEquals("Checking valid moves", 0, moves.length);
            
            moves = puz.getValidMovesForString("af");
            assertEquals("Checking valid moves", 0, moves.length);
            
            moves = puz.getValidMovesForString("aba");
            assertEquals("Checking valid moves", 0, moves.length);
            
            moves = puz.getValidMovesForString("ea");
            assertEquals("Checking valid moves", 1, moves.length);
            
            moves = puz.getValidMovesForString("abfgkjnopl");
            assertEquals("Checking valid moves", 1, moves.length);
        }
        
        public function testValidMovesDiagonal():void {
            var moves:Array;
            var puz:PuzzleBlock;
            
            puz = new PuzzleBlock(PuzzleBlock.MODE_DIAGONAL, 4, 4, "abcdefghijklmnop");
            
            moves = puz.getValidMovesForString("abpjl");
            assertEquals("Checking valid moves", 0, moves.length);
            
            moves = puz.getValidMovesForString("ab");
            assertEquals("Checking valid moves", 0, moves.length);
            
            moves = puz.getValidMovesForString("de");
            assertEquals("Checking valid moves", 0, moves.length);
            
            moves = puz.getValidMovesForString("afa");
            assertEquals("Checking valid moves", 0, moves.length);
            
            moves = puz.getValidMovesForString("af");
            assertEquals("Checking valid moves", 1, moves.length);
            
            moves = puz.getValidMovesForString("afchkni");
            assertEquals("Checking valid moves", 1, moves.length);
            
            moves = puz.getValidMovesForString("afchknif");
            assertEquals("Checking valid moves", 0, moves.length);
        }
        
        public function testValidMovesAdjacentDiagonal():void {
            var moves:Array;
            var puz:PuzzleBlock;
            
            puz = new PuzzleBlock(PuzzleBlock.MODE_ADJACENT_DIAGONAL, 4, 4, "abcdefghijklmnop");
            
            moves = puz.getValidMovesForString("abpjl");
            assertEquals("Checking valid moves", 0, moves.length);
            
            moves = puz.getValidMovesForString("ag");
            assertEquals("Checking valid moves", 0, moves.length);
            
            moves = puz.getValidMovesForString("abg");
            assertEquals("Checking valid moves", 1, moves.length);
            
            moves = puz.getValidMovesForString("afa");
            assertEquals("Checking valid moves", 0, moves.length);
            
            moves = puz.getValidMovesForString("abefkpolhd");
            assertEquals("Checking valid moves", 1, moves.length);
            
            puz = new PuzzleBlock(PuzzleBlock.MODE_ADJACENT_DIAGONAL, 4, 4, "abcdefabcdefabcd");
            
            moves = puz.getValidMovesForString("fab");
            assertEquals("Checking valid moves", 5, moves.length);
        }
        
    }
}