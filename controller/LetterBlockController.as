package controller {

    import view.LetterBlockView;
    import view.LetterCellView;

    public class LetterBlockController {
        
        private var myView:LetterBlockView;
        private var letterCount:uint;
        
        function LetterBlockController(letters:String, perRow:uint) {
            this.myView = new LetterBlockView(letters, perRow);
            this.letterCount = letters.length;
        }
        
        public function getView():LetterBlockView {
            return this.myView;
        }
        
        public function highlightMoves(moves:Array):void {
            var i:int;
            var j:int;
            var move:Array;
            var full:Boolean;
            var cell:LetterCellView;
            
            clearAllHighlights();
            
            full = (moves.length > 1);
            
            for (i=0; i<moves.length; i++) {
                move = moves[i] as Array;
                for (j=0; j<move.length; j++) {
                    cell = this.myView.getCellAtIndex(move[j]);
                    if (full) {
                        cell.setPartialHighlight();
                    } else {
                        cell.setFullHighlight();
                    }
                }
            }
            
        }
        
        public function clearAllHighlights():void {
            var i:int;
            var cell:LetterCellView;
            
            for (i=0; i<letterCount; i++) {
                cell = this.myView.getCellAtIndex(i);
                cell.clearHighlight();
            }
        }
        
    }
}