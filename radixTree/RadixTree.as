package radixTree {

    /**
     * This class is a RadixTree (a.k.a. Patricia trie or crit bit tree).
     */
    public class RadixTree {
        
        /**
         * The root node of the tree.
         */
        private var root:RadixTreeNode;
        
        /**
         * Constructor.
         */
        public function RadixTree() {
            this.root = new RadixTreeNode("", false);
        }
        
        /**
         * Adds a word to the tree.
         */
        public function addWord(word:String):void {
            this.root.addNode(word);
        }
        
        /**
         * Returns an array of all the valid words, sorted in lexographical order.
         * 
         * @return An array of valid words.
         */
        public function getValidWords():Array {
            return this.root.getValidWords();
        }
        
        /**
         * Checks whether the provided word is a valid word in the tree.
         *
         * @param word The word to check for.
         * @return Whether the word is present and valid in the tree.
         */
        public function isValidWord(word:String):Boolean {
            return this.root.isValidWord(word);
        }
        
        /**
         * This method creates a new tree using the provided string of characters.
         * The string is treated like a set (e.g. neither order nor cardinality matters).
         * Characters are not removed from the set as matches are found.
         *
         * Example: Running this method on a tree containing the words:
         *          ape, apple, temp, test, testing
         *          
         *          with a multiset of "aempst" will return a new tree with the words:
         *          ape, test, temp
         * 
         * @param set A string containing characters from which to build the new tree.
         * @return The new tree.
         */
        public function createTreeFromCharacterSet(set:String):RadixTree {
            var newTree:RadixTree;
            
            newTree = new RadixTree();
            newTree.assignRoot(this.root.createTreeFromCharacterSet(set));
            
            return newTree;
        }
        
        /**
         * This method creates a new tree using the provided string of characters.
         * The string is treated like a multiset (e.g. the order does not matter but
         * cardinality does). As matches are found, characters are removed from the
         * multiset.
         *
         * Example: Running this method on a tree containing the words:
         *          ape, apple, temp, test, testing
         *          
         *          with a multiset of "aempstt" will return a new tree with the words:
         *          ape, test, temp
         * 
         * @param multiset A string containing characters from which to build the new tree.
         * @return The new tree.
         */
        public function createTreeFromCharacterMultiset(multiset:String):RadixTree {
            var newTree:RadixTree;
            
            newTree = new RadixTree();
            newTree.assignRoot(this.root.createTreeFromCharacterMultiset(multiset));
            
            return newTree;
        }
        
        /**
         * Function to assign a new root. This is used in conjunction with other methods
         * which return a new RadixTree.
         *
         * @param newRoot The new root to use. If this is null, a new empty tree is created.
         */
        private function assignRoot(newRoot:RadixTreeNode):void {
            if (newRoot == null) {
                this.root = new RadixTreeNode("", false);
                return;
            }
            
            this.root = newRoot;
        }
        
        /**
         * This function returns a debugging string useful for seeing the tree structure.
         *
         * @return The debugging string.
         */
        public function getDebugString():String {
            return this.root.getDebugString();
        }
        
    }

}