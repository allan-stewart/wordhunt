package view {

    import mx.core.ScrollPolicy;

    import mx.containers.Canvas;
    
    import mx.controls.Label;

    public class LetterCellView extends Canvas {
        
        private var myLabel:Label;
        
        function LetterCellView(letter:String) {
            super();
            
            var i:int;
            var cell:LetterCellView;
            
            // Set up this canvas.
            this.width = 70;
            this.height = 70;
            this.horizontalScrollPolicy = ScrollPolicy.OFF;
            this.verticalScrollPolicy = ScrollPolicy.OFF;
            this.setStyle("borderColor", 0x000000);
            this.setStyle("borderStyle", "solid");
            this.setStyle("borderThickness", 1);
            this.setStyle("backgroundColor", 0xFFFFFF);
            
            // Create the label for this letter.
            myLabel = new Label();
            myLabel.y = 12;
            myLabel.width = this.width;
            myLabel.setStyle("fontSize", 30);
            myLabel.setStyle("textAlign", "center");
            myLabel.text = letter.toUpperCase();
            this.addChild(myLabel);
        }
        
        public function clearHighlight():void {
            this.setStyle("backgroundColor", 0xFFFFFF);
        }
        
        public function setPartialHighlight():void {
            this.setStyle("backgroundColor", 0xCCCCFF);
        }
        
        public function setFullHighlight():void {
            this.setStyle("backgroundColor", 0x9999FF);
        }
        
    }
}