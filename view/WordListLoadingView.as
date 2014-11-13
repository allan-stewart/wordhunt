package view {

    import mx.containers.Canvas;
    import mx.controls.Label;
    import mx.controls.ProgressBar;
    import mx.controls.ProgressBarMode;

    public class WordListLoadingView extends Canvas {
        
        private var progressBar:ProgressBar;
        
        function WordListLoadingView() {
            super();
            
            var label:Label;
            
            // Set up this canvas.
            this.width = 800;
            this.height = 600;
            //this.setStyle("borderStyle", "solid");
            //this.setStyle("borderThickness", 1);
            //this.setStyle("backgroundColor", 0xFFFFFF);
            
            // Add the title.
            label = new Label();
            label.y = 150;
            label.width = this.width;
            //label.setStyle("fontFamily", "Verdana");
            label.setStyle("fontSize", 30);
            label.setStyle("textAlign", "center");
            label.text = "Word Hunt";
            this.addChild(label);
            
            // Add the info text.
            label = new Label();
            label.y = 375;
            label.width = this.width;
            label.setStyle("fontSize", 14);
            label.setStyle("textAlign", "center");
            label.text = "Loading word list...";
            this.addChild(label);
            
            // Create the progress bar.
            progressBar = new ProgressBar();
            progressBar.mode = ProgressBarMode.MANUAL;
            progressBar.x = 25;
            progressBar.y = 400;
            progressBar.width = 750;
            progressBar.height = 10;
            this.addChild(progressBar);
        }
        
        public function setProgress(percent:Number, total:Number):void {
            progressBar.setProgress(percent, total);
        }
        
    }

}