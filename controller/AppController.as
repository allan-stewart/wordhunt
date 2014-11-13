package controller {

    import model.MainModel;
    import model.ModelEvent;
    
    import mx.core.Application;
    
    import view.WordListLoadingView;

    public class AppController {
        
        private var myModel:MainModel;
        private var loadingView:WordListLoadingView;
        private var game:GameController;
        
        function AppController() {
            myModel = new MainModel();
            myModel.addEventListener(ModelEvent.FILE_LOAD_PROGRESS, wordListLoadHandler, false, 0, true);
            myModel.addEventListener(ModelEvent.FILE_LOAD_COMPLETE, wordListLoadHandler, false, 0, true);
            myModel.addEventListener(ModelEvent.FILE_LOAD_ERROR, wordListLoadHandler, false, 0, true);
            
            game = null;
            
            // Display the loading screen.
            loadingView = new WordListLoadingView();
            Application.application.addChild(loadingView);
            
            // Start loading the word list.
            myModel.loadWordListFile("wordlist.txt");
        }
        
        public function newGame():void {
            // Remove the view of the previous game controller, if needed.
            if (game != null) {
                Application.application.removeChild(game.getView());
            }
            
            // Create a new game controller & add its view.
            game = new GameController(this, myModel.createNewPuzzle(4,4));
            Application.application.addChild(game.getView());
        }
        
        private function wordListLoadHandler(e:ModelEvent):void {
            if (e.type == ModelEvent.FILE_LOAD_PROGRESS) {
                loadingView.setProgress(e.percent, 1);
            }
            
            if (e.type == ModelEvent.FILE_LOAD_COMPLETE) {
                Application.application.removeChild(loadingView);
                loadingView = null;
                newGame();
            }
        }
        
    }
}