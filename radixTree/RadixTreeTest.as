package radixTree {

    import flexunit.framework.TestCase;

    public class RadixTreeTest extends TestCase {
        
        public function testNewTree():void {
            var tree:RadixTree;
            
            tree = new RadixTree();
            assertEquals("New tree has no words", 0, tree.getValidWords().length);
        }
        
        public function testAddWords():void {
            var tree:RadixTree;
            
            tree = new RadixTree();
            tree.addWord("test");
            assertEquals("Tree has words:", "test", tree.getValidWords().toString());
            
            tree.addWord("apple");
            assertEquals("Tree has words:", "apple,test", tree.getValidWords().toString());
            
            tree.addWord("temp");
            tree.addWord("temporary");
            assertEquals("Tree has words:", "apple,temp,temporary,test", tree.getValidWords().toString());
            
            tree.addWord("a");
            assertEquals("Tree has words:", "a,apple,temp,temporary,test", tree.getValidWords().toString());
        }
        
        public function testTreesFromCharacterSets():void {
            var tree1:RadixTree;
            var tree2:RadixTree;
            var set:String;
            
            // Set up a tree.
            tree1 = new RadixTree();
            tree1.addWord("apple");
            tree1.addWord("ape");
            tree1.addWord("test");
            tree1.addWord("testing");
            tree1.addWord("temp");
            tree1.addWord("temporary");
            tree1.addWord("tests");
            
            // Make new trees from character sets.
            
            set = "aepst";
            tree2 = tree1.createTreeFromCharacterSet(set);
            assertEquals("Tree has words:", "ape,test,tests", tree2.getValidWords().toString());
            
            set = "tpase";
            tree2 = tree1.createTreeFromCharacterSet(set);
            assertEquals("Tree has words:", "ape,test,tests", tree2.getValidWords().toString());
            
            set = "aempst";
            tree2 = tree1.createTreeFromCharacterSet(set);
            assertEquals("Tree has words:", "ape,temp,test,tests", tree2.getValidWords().toString());
            
            set = "aelmpst";
            tree2 = tree1.createTreeFromCharacterSet(set);
            assertEquals("Tree has words:", "ape,apple,temp,test,tests", tree2.getValidWords().toString());
            
            // Make new trees from character multisets.
            
            set = "aepst";
            tree2 = tree1.createTreeFromCharacterMultiset(set);
            assertEquals("Tree has words:", "ape", tree2.getValidWords().toString());
            
            set = "aepstt";
            tree2 = tree1.createTreeFromCharacterMultiset(set);
            assertEquals("Tree has words:", "ape,test", tree2.getValidWords().toString());
            
            set = "stepta";
            tree2 = tree1.createTreeFromCharacterMultiset(set);
            assertEquals("Tree has words:", "ape,test", tree2.getValidWords().toString());
            
            set = "aelmpstt";
            tree2 = tree1.createTreeFromCharacterMultiset(set);
            assertEquals("Tree has words:", "ape,temp,test", tree2.getValidWords().toString());
            
            set = "aelmppstt";
            tree2 = tree1.createTreeFromCharacterMultiset(set);
            assertEquals("Tree has words:", "ape,apple,temp,test", tree2.getValidWords().toString());
        }
        
    }
    
}