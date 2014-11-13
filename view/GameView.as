package view {

    import mx.core.ScrollPolicy;

    import mx.containers.Canvas;
    import mx.containers.VBox;
    
    import mx.controls.Label;
    import mx.controls.TextArea;
    import mx.controls.TextInput;

    public class GameView extends Canvas {
        
        private var timeLabel:Label;
        private var scoreLabel:Label;
        private var wordsArea:TextArea;
        private var wordInput:TextInput;
        
        function GameView() {
            super();
            
            var label:Label;
            var vbox:VBox;
            
            // Set up this canvas.
            this.width = 800;
            this.height = 600;
            this.horizontalScrollPolicy = ScrollPolicy.OFF;
            this.verticalScrollPolicy = ScrollPolicy.OFF;
            this.setStyle("borderStyle", "solid");
            this.setStyle("borderThickness", 1);
            this.setStyle("backgroundColor", 0xFFFFFF);
            
            // Add the title.
            label = new Label();
            label.y = 10;
            label.width = this.width;
            label.setStyle("fontSize", 30);
            label.setStyle("textAlign", "center");
            label.text = "Word Hunt";
            this.addChild(label);
            
            // Create a VBox for holding the stuff on the right side.
            vbox = new VBox();
            vbox.x = 550;
            vbox.y = 70;
            vbox.width = 200;
            vbox.height = 500;
            this.addChild(vbox);
            
            // Add a place for the time.
            timeLabel = new Label();
            timeLabel.width = vbox.width;
            timeLabel.text = "GAME TIMER";
            vbox.addChild(timeLabel);
            
            // Add the score.
            scoreLabel = new Label();
            scoreLabel.width = vbox.width;
            scoreLabel.text = "SCORE";
            vbox.addChild(scoreLabel);
            
            // Add the textarea for words they've found.
            label = new Label();
            label.width = vbox.width;
            label.text = "Words found:";
            vbox.addChild(label);
            
            wordsArea = new TextArea();
            wordsArea.width = vbox.width;
            wordsArea.height = 300;
            vbox.addChild(wordsArea);
            
            // Add the word input field.
            wordInput = new TextInput();
            wordInput.x = 50;
            wordInput.y = 450;
            wordInput.width = 400;
            wordInput.setStyle("fontSize", 30);
            this.addChild(wordInput);
        }
        
        public function setTimer(time:String):void {
            timeLabel.text = "Time Remaining: "+time;
        }
        
        public function setScore(score:int):void {
            scoreLabel.text = "Score: "+score+" points";
        }
        
        public function setWordText(text:String):void {
            wordsArea.text = text;
        }
        
        public function appendWordText(text:String):void {
            wordsArea.text += text;
        }
        
        public function addInputListener(type:String, func:Function):void {
            wordInput.addEventListener(type, func, false, 0, true);
        }
        
        public function getInputText():String {
            return wordInput.text;
        }
        
        public function setInputText(text:String, valid:Boolean):void {
            wordInput.text = text;
            if (valid) {
                wordInput.setStyle("color", 0x000000);
            } else {
                wordInput.setStyle("color", 0xFF0000);
            }
        }
        
    }
}