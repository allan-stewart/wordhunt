package model {

    import flexunit.framework.TestCase;

    public class LetterGeneratorTest extends TestCase {
        
        public function testStringLength():void {
            var gen:LetterGenerator = new LetterGenerator();
            var str:String;
            var i:int;
            
            for (i=0; i<10; i++) {
                str = gen.generateLetterString(i);
                assertEquals("Checking string length", i, str.length);
            }
            
        }
        
    }
    
}