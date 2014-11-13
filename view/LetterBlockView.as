package view {

    import mx.core.ScrollPolicy;

    import mx.containers.Canvas;

    public class LetterBlockView extends Canvas {
        
        private var cells:Array;
        
        function LetterBlockView(letters:String, perRow:uint) {
            super();
            
            var i:int;
            var cell:LetterCellView;
            
            // Set up this canvas.
            this.width = 400;
            this.height = 400;
            this.horizontalScrollPolicy = ScrollPolicy.OFF;
            this.verticalScrollPolicy = ScrollPolicy.OFF;
            
            // Create an array of letter cells.
            cells = new Array();
            for (i=0; i<letters.length; i++) {
                cell = new LetterCellView(letters.charAt(i));
                
                cell.x = (i % perRow) * 70;
                cell.y = Math.floor(i / perRow) * 70;
                
                cells.push(cell);
                this.addChild(cell);
            }
        }
        
        public function getCellAtIndex(index:uint):LetterCellView {
            if (index >= cells.length) {
                return null;
            }
            
            return cells[index] as LetterCellView;
        }
        
    }
}