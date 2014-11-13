package radixTree {

    /**
     * This class is a node used in creating a radix tree
     * (a.k.a. Patricia trie or crit bit tree).
     */
    internal class RadixTreeNode {
        
        /**
         * The value of this node.
         */
        private var value:String;
        
        /**
         * Whether this node represents the end of a valid word.
         */
        private var validNode:Boolean;
        
        /**
         * Array to hold the child nodes.
         */
        private var children:Array;
        
        
        /**
         * Constructor
         *
         * @param content The content to be the value of the node.
         * @param valid Whether this node represents the end of a valid word.
         */
        public function RadixTreeNode(content:String, valid:Boolean) {
            this.value = content;
            this.validNode = valid;
            this.children = null;
        }
        
        /**
         * @return The value of this node.
         */
        public function getValue():String {
            return this.value;
        }
        
        /**
         * @return Whether the node is the end of a valid word.
         */
        public function isValidNode():Boolean {
            return this.validNode;
        }
        
        /**
         * @return The number of children.
         */
        public function numberOfChildren():int {
            if (this.children == null) {
                return 0;
            }
            
            return this.children.length;
        }
        
        /**
         * @return The children of this node.
         */
        private function getChildren():Array {
            return this.children;
        }
        
        
        /**
         * Adds an additional node for the specified content.
         *
         * @param content The content of the word to be adding.
         */
        public function addNode(content:String):void {
            var i:int;
            var matchCount:int;
            var child:RadixTreeNode;
            var base:String;
            var remainder:String;
            var remainderNew:String;
            
            // Check the content against the value.
            matchCount = this.numberOfMatchingCharacters(content);
            if ((matchCount == 0) && (this.value.length > 0)) {
                // Throw an exception.
                throw new Error("The string '"+content+"' cannot be added to this node: '"+this.value+"'.");
            }
            if (matchCount == this.value.length) {
                // The content matches with this entire value. Are they the same?
                if (content.length == this.value.length) {
                    // The content matches this node. This is now a validNode.
                    if (this.validNode) {
                        // This word had already been entered!
                        throw new Error("This content already exists in the tree.");
                    }
                    this.validNode = true;
                    return;
                }
                
                // Since the content is longer, it is a longer word.
                remainder = content.substring(matchCount);
                
                // Init the children array if it hasn't been already.
                if (this.children == null) {
                    this.children = new Array();
                }
                
                // Look for matching children.
                for (i=0; i<this.children.length; i++) {
                    child = this.children[i] as RadixTreeNode;
                    if (child.doesStringMatch(remainder)) {
                        // We found a match. Hand off the remainder.
                        child.addNode(remainder);
                        return;
                    }
                    
                    // The children array should always stay sorted lexographically,
                    // so we can break the loop if the remainder is too big.
                    if (child.getValue() > remainder) {
                        break;
                    }
                }
                
                // There were no matching children. So we'll just add one.
                // Keep the list sorted when we add it.
                i=0;
                while (i < this.children.length) {
                    child = this.children[i] as RadixTreeNode;
                    if (child.getValue() > remainder) {
                        // This is the spot, break the loop.
                        break;
                    }
                    i++;
                }
                this.children.splice(i, 0, new RadixTreeNode(remainder, true));
                return;
            }
            
            // If we get here, the content matches part of this node, so we need to break
            // into pieces.
            base = this.value.substring(0, matchCount);
            remainder = this.value.substring(matchCount);
            remainderNew = content.substring(matchCount);
            
            // Create a new node for the remainder. If this was a valid word, then it will be too.
            // It then will get all the children from this node.
            child = new RadixTreeNode(remainder, this.validNode);
            child.assignChildren(this.children);
            
            // This node is no longer a valid word. Remove the children.
            this.value = base;
            this.validNode = false;
            this.children = new Array();
            
            // Add the new child.
            this.children.push(child);
            
            
            // Check the length of the new remainder.
            if (remainderNew.length == 0) {
                // This word is now valid again!
                this.validNode = true;
            } else {
                // We need to add another child. Keep it sorted.
                child = new RadixTreeNode(remainderNew, true);
                
                i=0;
                if (remainderNew > remainder) {
                    i++;
                }
                this.children.splice(i, 0, child);
            }
            
        }
        
        /**
         * Returns the number of characters in content which match this node's value.
         *
         * @param content The word to check against.
         * @return The number of matches.
         */
        public function numberOfMatchingCharacters(content:String):int {
            var index:int = 0;
            
            while ((index < this.value.length) &&
                    (index < content.length) &&
                    (this.value.charAt(index) == content.charAt(index))
                    ) {
                index++;
            }
            
            return index;
        }
        
        /**
         * Returns whether this node is a match for the provided string.
         * Note: This method only checks the first characters for the match
         * because that is all that is needed to determine whether the node
         * should be used to hold the string.
         *
         * @param content The string to check against.
         * @return Whether this node is a match.
         */
        public function doesStringMatch(content:String):Boolean {
            // If this is the empty string (root node), then we can match anything.
            if (this.value.length == 0) {
                return true;
            }
            
            // It only needs to match the first character.
            return (this.value.charAt(0) == content.charAt(0));
        }
        
        /**
         * Method used to assign children.
         * This should only be called by methods of this class.
         *
         * @param newChildren The sorted array of children to add to this node.
         *
         * @see addNode(content)
         * @see createTreeFromCharacterMultiset(multiset)
         */
        private function assignChildren(newChildren:Array):void {
            this.children = newChildren;
        }
        
        /**
         * This function returns a debugging string useful for seeing the tree structure.
         *
         * @param prefix The value from concatinating the parent node values.
         * @return The debugging string.
         */
        public function getDebugString(prefix:String = ""):String {
            var str:String;
            var i:int;
            var child:RadixTreeNode;
            
            str = prefix + "[" + this.value + "]";
            
            if (this.validNode) {
                str += "*";
            }
            
            // Loop over all the children and add their strings.
            if (this.children != null) {
                for (i=0; i<this.children.length; i++) {
                    child = this.children[i] as RadixTreeNode;
                    str += "\n" + child.getDebugString(prefix + this.value);
                }
            }
            
            return str;
        }
        
        /**
         * Returns an array of all the valid words, sorted in lexographical order.
         * Note: Because of the nature of the radix tree, the resulting array can
         * only be empty if the node value is the empty string and there are no
         * children.
         * 
         * @param prefix The value from concatinating the parent node values.
         * @return An array of valid words.
         */
        public function getValidWords(prefix:String = ""):Array {
            var words:Array = new Array();
            var child:RadixTreeNode;
            var i:int;
            
            if (this.validNode) {
                words.push(prefix + this.value);
            }
            
            if (this.children != null) {
                for (i=0; i<this.children.length; i++) {
                    child = this.children[i] as RadixTreeNode;
                    words = words.concat(child.getValidWords(prefix + this.value));
                }
            }
            
            return words;
        }
        
        /**
         * Checks whether the provided word is a valid word in the tree.
         *
         * @param word The word to check for.
         * @return Whether the word is present and valid in the tree.
         */
        public function isValidWord(word:String):Boolean {
            var matchCount:int;
            var child:RadixTreeNode;
            var remainder:String;
            var i:int;
            
            matchCount = 0;
            if (this.value.length > 0) {
                // Check how much this word matches the node.
                matchCount = this.numberOfMatchingCharacters(word);
                
                if (matchCount == 0) {
                    return false;
                }
                
                // Check if they matched exactly to this node.
                if ((matchCount == this.value.length) && (matchCount == word.length)){
                    if (this.validNode) {
                        return true;
                    }
                    return false;
                }
            }
            
            // Find any children that match the remainder.
            remainder = word.substring(matchCount);
            
            if (this.children != null) {
                for (i=0; i<this.children.length; i++) {
                    child = this.children[i] as RadixTreeNode;
                    if (child.doesStringMatch(remainder)) {
                        // We found a match. Hand off the remainder.
                        return child.isValidWord(remainder);
                    }
                    
                    // The children array should always stay sorted lexographically,
                    // so we can break the loop if the remainder is too big.
                    if (child.getValue() > remainder) {
                        break;
                    }
                }
            }
            
            return false;
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
         * @return The new tree node, or NULL if no match could be made.
         */
        public function createTreeFromCharacterSet(set:String):RadixTreeNode {
            // Make sure that this node value can be made from the multiset.
            var i:int; 
            var j:int;
            var found:Boolean;
            var matchingChildren:Array;
            var node:RadixTreeNode;
            var child:RadixTreeNode;
            var tree:RadixTreeNode;
            
            if (this.value.length > 0) {
                for (i=0; i<this.value.length; i++) {
                    found = false;
                    for (j=0; j<set.length; j++) {
                        if (this.value.charAt(i) == set.charAt(j)) {
                            found = true;
                            break;
                        }
                    }
                    
                    if (!found) {
                        // This node does not match the set, return null.
                        return null;
                    }
                }
            }
            
            // This node matches. Make a new node representing this one.
            node = new RadixTreeNode(this.value, this.validNode);
            
            if (this.children != null) {
                matchingChildren = new Array();
                for (i=0; i<this.children.length; i++) {
                    child = this.children[i] as RadixTreeNode;
                    tree = child.createTreeFromCharacterSet(set);
                    
                    if (tree != null) {
                        matchingChildren.push(tree);
                    }
                }
                
                if (matchingChildren.length > 0) {
                    node.assignChildren(matchingChildren);
                }
            }
            
            // There may only be one child in the node, collapse it if it can.
            node.collapseNode();
            
            // Check if this is a useable node.
            if ((node.isValidNode()) || (node.numberOfChildren() > 0)) {
                return node;
            }
            
            // We couldn't return a tree.
            return null;
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
         * @return The new tree node, or NULL if no match could be made.
         */
        public function createTreeFromCharacterMultiset(multiset:String):RadixTreeNode {
            // Make sure that this node value can be made from the multiset.
            var i:int; 
            var j:int;
            var temp:String;
            var found:Boolean;
            var matchingChildren:Array;
            var node:RadixTreeNode;
            var child:RadixTreeNode;
            var tree:RadixTreeNode;
            
            if (this.value.length > 0) {
                for (i=0; i<this.value.length; i++) {
                    found = false;
                    for (j=0; j<multiset.length; j++) {
                        if (this.value.charAt(i) == multiset.charAt(j)) {
                            temp = "";
                            if (j > 0) {
                                temp += multiset.substring(0, j);
                            }
                            if (j+1 < multiset.length) {
                                temp += multiset.substring(j+1);
                            }
                            multiset = temp;
                            found = true;
                            break;
                        }
                    }
                    
                    if (!found) {
                        // This node does not match the multiset, return null.
                        return null;
                    }
                }
            }
            
            // This node matches. Make a new node representing this one.
            node = new RadixTreeNode(this.value, this.validNode);
            
            if (this.children != null) {
                matchingChildren = new Array();
                for (i=0; i<this.children.length; i++) {
                    child = this.children[i] as RadixTreeNode;
                    tree = child.createTreeFromCharacterMultiset(multiset);
                    
                    if (tree != null) {
                        matchingChildren.push(tree);
                    }
                }
                
                if (matchingChildren.length > 0) {
                    node.assignChildren(matchingChildren);
                }
            }
            
            // There may only be one child in the node, collapse it if it can.
            node.collapseNode();
            
            // Check if this is a useable node.
            if ((node.isValidNode()) || (node.numberOfChildren() > 0)) {
                return node;
            }
            
            // We couldn't return a tree.
            return null;
        }
        
        /**
         * Calling this function will cause the node see if it has a single child
         * which it can merge with (in other words, it will try to collapse this node
         * with the single child). This is done to maintain the Radix tree structure.
         *
         * This method should only be called by other methods of this class.
         *
         * @see createTreeFromCharacterSet(set)
         * @see createTreeFromCharacterMultiset(multiset)
         */
        private function collapseNode():void {
            // If this node is a valid node, we cannot collapse.
            if (this.validNode) {
                return;
            }
            
            // If there are too many children we cannot collapse.
            if (this.children == null) {
                return;
            }
            if (this.children.length > 1) {
                return;
            }
            
            // Collapse this node with the child.
            var child:RadixTreeNode;
            child = this.children[0] as RadixTreeNode;
            
            this.value += child.getValue();
            this.validNode = child.isValidNode();
            this.children = child.getChildren();
        }
        
    }

}