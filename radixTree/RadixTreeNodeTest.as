package radixTree {

    import flexunit.framework.TestCase;

    public class RadixTreeNodeTest extends TestCase {
        
        public function testNewNode():void {
            var node:RadixTreeNode;
            
            // Case 1.
            node = new RadixTreeNode("test", true);
            assertEquals("New node has value of test", "test", node.getValue());
            assertTrue("New node is a valid word", node.isValidNode());
            assertEquals("New node has 0 children", 0, node.numberOfChildren());
            
            // Case 2.
            node = new RadixTreeNode("test", false);
            assertEquals("New node has value of test", "test", node.getValue());
            assertFalse("New node is not a valid word", node.isValidNode());
            assertEquals("New node has 0 children", 0, node.numberOfChildren());
            
            // Case 3.
            node = new RadixTreeNode("", false);
            assertEquals("New node value is empty string", "", node.getValue());
            assertFalse("New node is not a valid word", node.isValidNode());
            assertEquals("New node has 0 children", 0, node.numberOfChildren());
        }
        
        public function testMatching():void {
            var node:RadixTreeNode;
            var testStr:String;
            
            // Anything should match the empty string (root node).
            node = new RadixTreeNode("", false);
            assertTrue("Node should match for string: a", node.doesStringMatch("a"));
            assertTrue("Node should match for string: t", node.doesStringMatch("t"));
            assertTrue("Node should match for string: test", node.doesStringMatch("test"));
            
            // Test against the a non-empty-string node.
            node = new RadixTreeNode("test", true);
            
            assertTrue("Node should match for string: t", node.doesStringMatch("t"));
            assertTrue("Node should match for string: te", node.doesStringMatch("te"));
            assertFalse("Node should not match for string: a", node.doesStringMatch("a"));
            assertFalse("Node should not match for empty string", node.doesStringMatch(""));
            
            testStr = "";
            assertEquals("Node should have 0 matches", 0, node.numberOfMatchingCharacters(testStr));
            assertFalse("Node should not match", node.doesStringMatch(testStr));
            
            testStr = "a";
            assertEquals("Node should have 0 matches", 0, node.numberOfMatchingCharacters(testStr));
            assertFalse("Node should not match", node.doesStringMatch(testStr));
            
            testStr = "bc";
            assertEquals("Node should have 0 matches", 0, node.numberOfMatchingCharacters(testStr));
            assertFalse("Node should not match", node.doesStringMatch(testStr));
            
            testStr = "t";
            assertEquals("Node should have 1 match", 1, node.numberOfMatchingCharacters(testStr));
            assertTrue("Node should match", node.doesStringMatch(testStr));
            
            testStr = "te";
            assertEquals("Node should have 2 matches", 2, node.numberOfMatchingCharacters(testStr));
            assertTrue("Node should match", node.doesStringMatch(testStr));
            
            testStr = "temp";
            assertEquals("Node should have 2 match", 2, node.numberOfMatchingCharacters(testStr));
            assertTrue("Node should match", node.doesStringMatch(testStr));
            
            testStr = "test";
            assertEquals("Node should have 4 matches", 4, node.numberOfMatchingCharacters(testStr));
            assertTrue("Node should match", node.doesStringMatch(testStr));
            
            testStr = "testing";
            assertEquals("Node should have 2 match", 4, node.numberOfMatchingCharacters(testStr));
            assertTrue("Node should match", node.doesStringMatch(testStr));
        }
        
        public function testAddNode():void {
            var node:RadixTreeNode;
            var testStr:String;
            var errorThrown:Boolean;
            
            node = new RadixTreeNode("test", true);
            
            // Case 1: Try to add apple to test.
            errorThrown = false;
            try {
                node.addNode("apple");
            } catch (e:Error) {
                errorThrown = true;
            }
            assertTrue("Word: apple. Invalid root char throws error", errorThrown);
            
            // Case 2: Add the same word.
            errorThrown = false;
            try {
                node.addNode("test");
            } catch (e:Error) {
                errorThrown = true;
            }
            assertTrue("Word: test. Adding existing word throws error", errorThrown);
            
            // Case 3: Add the word testing.
            testStr = "testing";
            assertEquals("Node should have 0 children before", 0, node.numberOfChildren());
            node.addNode(testStr);
            assertEquals("Word: "+testStr+". Node should have 1 child after", 1, node.numberOfChildren());
            assertEquals("Word: "+testStr+". Node value should be test", "test", node.getValue());
            
            // Case 4: Add the word testings.
            testStr = "testings";
            assertEquals("Word: "+testStr+". Node should have 1 child before", 1, node.numberOfChildren());
            node.addNode(testStr);
            assertEquals("Word: "+testStr+". Node should have 1 child after", 1, node.numberOfChildren());
            assertEquals("Word: "+testStr+". Node value should be test", "test", node.getValue());
            
            // Case 5: Add the word testly.
            testStr = "testly";
            assertEquals("Word: "+testStr+". Node should have 1 child before", 1, node.numberOfChildren());
            node.addNode(testStr);
            assertEquals("Word: "+testStr+". Node should have 2 children after", 2, node.numberOfChildren());
            assertEquals("Word: "+testStr+". Node value should be test", "test", node.getValue());
            
            // Case 6: Add the word testable.
            testStr = "testable";
            assertEquals("Word: "+testStr+". Node should have 2 children before", 2, node.numberOfChildren());
            node.addNode(testStr);
            assertEquals("Word: "+testStr+". Node should have 3 children after", 3, node.numberOfChildren());
            assertEquals("Word: "+testStr+". Node value should be test", "test", node.getValue());
            
            // Case 7: Add the word temp. Check that te is not valid, should have 2 children.
            testStr = "temp";
            assertEquals("Word: "+testStr+". Node should still be 'test' before", "test", node.getValue());
            assertTrue("Word: "+testStr+". Node should still be a valid word before", node.isValidNode());
            node.addNode(testStr);
            assertEquals("Word: "+testStr+". Node should now be 'te'", "te", node.getValue());
            assertFalse("Word: "+testStr+". Node should not be a valid word after", node.isValidNode());
            assertEquals("Word: "+testStr+". Node should now have 2 children", 2, node.numberOfChildren());
            
            // Case 8: Add the word te. Check that te is valid.
            testStr = "te";
            node.addNode(testStr);
            assertTrue("Word: "+testStr+". Node should now be valid", node.isValidNode());
            assertEquals("Word: "+testStr+". Node should still have 2 children", 2, node.numberOfChildren());
            
            // Case 9: Add the word t. Check that t is valid.
            testStr = "t";
            node.addNode(testStr);
            assertEquals("Word: "+testStr+". Node should now be 't'", "t", node.getValue());
            assertTrue("Word: "+testStr+". Node should be valid", node.isValidNode());
            assertEquals("Word: "+testStr+". Node should still have 1 child", 1, node.numberOfChildren());
            
            // Case 10: Add several words to a empty-string node.
            node = new RadixTreeNode("", false);
            node.addNode("apple");
            node.addNode("test");
            assertEquals("Empty-string Node should have 2 children", 2, node.numberOfChildren());
        }
        
        public function testValidWords():void {
            var node:RadixTreeNode;
            var checkArray:Array = new Array("temp", "temporary", "test", "testable", "testing", "tests");
            var actualArray:Array;
            var i:int;
            
            node = new RadixTreeNode("", false);
            assertEquals("Empty tree should have no valid words.", 0, node.getValidWords().length);
            
            node.addNode("apple");
            node.addNode("axis");
            node.addNode("baby");
            node.addNode("temp");
            assertTrue("Word: apple should be valid", node.isValidWord("apple"));
            assertTrue("Word: axis should be valid", node.isValidWord("axis"));
            assertTrue("Word: baby should be valid", node.isValidWord("baby"));
            assertTrue("Word: temp should be valid", node.isValidWord("temp"));
            
            node = new RadixTreeNode("tests", true);
            assertTrue("Word: tests should be valid", node.isValidWord("tests"));
            assertFalse("Word: test should be invalid", node.isValidWord("test"));
            assertFalse("Word: apple should be invalid", node.isValidWord("apple"));
            
            node.addNode("test");
            assertTrue("Word: tests should be valid", node.isValidWord("tests"));
            assertTrue("Word: test should be valid", node.isValidWord("test"));
            
            node.addNode("testing");
            node.addNode("testable");
            node.addNode("temp");
            node.addNode("temporary");
            
            assertTrue("Word: tests should be valid", node.isValidWord("tests"));
            assertTrue("Word: test should be valid", node.isValidWord("test"));
            assertTrue("Word: testing should be valid", node.isValidWord("testing"));
            assertTrue("Word: testable should be valid", node.isValidWord("testable"));
            assertTrue("Word: temp should be valid", node.isValidWord("temp"));
            assertTrue("Word: temporary should be valid", node.isValidWord("temporary"));
            
            assertFalse("Word: a should be invalid", node.isValidWord("a"));
            assertFalse("Word: t should be invalid", node.isValidWord("t"));
            assertFalse("Word: te should be invalid", node.isValidWord("te"));
            assertFalse("Word: tes should be invalid", node.isValidWord("tes"));
            assertFalse("Word: testi should be invalid", node.isValidWord("testi"));
            assertFalse("Word: tempo should be invalid", node.isValidWord("tempo"));
            
            actualArray = node.getValidWords();
            assertEquals("The arrays should have the same length", checkArray.length, actualArray.length);
            for (i=0; i<checkArray.length; i++) {
                assertEquals("The values should match", checkArray[i], actualArray[i]);
            }
        }
        
        public function testCreatingTreesFromCharacterSet():void {
            var tree1:RadixTreeNode;
            var tree2:RadixTreeNode;
            var set:String;
            
            // Create tree1 and populate it with words.
            tree1 = new RadixTreeNode("", false);
            tree1.addNode("ape");
            tree1.addNode("apple");
            tree1.addNode("test");
            tree1.addNode("tests");
            tree1.addNode("testing");
            tree1.addNode("temp");
            tree1.addNode("temporary");
            
            // Make tree2 with different sets.
            
            set = "";
            tree2 = tree1.createTreeFromCharacterSet(set);
            assertNull("[Set 1] should have no matching words", tree2);
            
            set = "x";
            tree2 = tree1.createTreeFromCharacterSet(set);
            assertNull("[Set 2] should have no matching words", tree2);
            
            set = "aempst";
            tree2 = tree1.createTreeFromCharacterSet(set);
            assertEquals("[Set 3] words should match", "ape,temp,test,tests", tree2.getValidWords().toString());
            
            set = "mepats";
            tree2 = tree1.createTreeFromCharacterSet(set);
            assertEquals("[Set 4] words should match", "ape,temp,test,tests", tree2.getValidWords().toString());
            
            set = "aelmpst";
            tree2 = tree1.createTreeFromCharacterSet(set);
            assertEquals("[Set 5] words should match", "ape,apple,temp,test,tests", tree2.getValidWords().toString());
            
            // Make tree2 with different multisets.
            
            set = "";
            tree2 = tree1.createTreeFromCharacterMultiset(set);
            assertNull("[Multiset 1] should have no matching words", tree2);
            
            set = "x";
            tree2 = tree1.createTreeFromCharacterMultiset(set);
            assertNull("[Multiset 2] should have no matching words", tree2);
            
            set = "aempst";
            tree2 = tree1.createTreeFromCharacterMultiset(set);
            assertEquals("[Multiset 3] words should match", "ape,temp", tree2.getValidWords().toString());
            
            set = "mepats";
            tree2 = tree1.createTreeFromCharacterMultiset(set);
            assertEquals("[Multiset 4] words should match", "ape,temp", tree2.getValidWords().toString());
            
            set = "aelmpstt";
            tree2 = tree1.createTreeFromCharacterMultiset(set);
            assertEquals("[Multiset 5] words should match", "ape,temp,test", tree2.getValidWords().toString());
        }
        
    }
    
}