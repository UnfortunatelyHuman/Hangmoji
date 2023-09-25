//
//  ViewController.swift
//  Hangmoji
//
//  Created by Dhruv Patel on 2023-06-15.
//

import UIKit

class ViewController: UIViewController {

    //Main Image view and wins, loses labels
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var lossesLabel: UILabel!
    
    //Output Text Fields
    @IBOutlet weak var oneTextField: UITextField!
    @IBOutlet weak var twoTextField: UITextField!
    @IBOutlet weak var threeTextField: UITextField!
    @IBOutlet weak var fourTextField: UITextField!
    @IBOutlet weak var fiveTextField: UITextField!
    @IBOutlet weak var sixTextField: UITextField!
    @IBOutlet weak var sevenTextField: UITextField!
    
    //Other layouts
    @IBOutlet weak var keyBoardView: UIView!
    @IBOutlet weak var answerContainer: UIView!
    
    //Difficulty level buttons
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    
    /* All Variables and Arrays Starts Here */
    var gameDifficultySelected: String = ""
    var winCount = 0
    var loseCount = 0
    var randomWord: String = ""
    var randomWordSpiltted: [Substring] = []
    var valueMatched = false
    
    // For four word game
    var fourWordsArray: [String] = ["Ruby", "Lion", "Kite", "Iris", "Nova", "Tide", "Jolt", "Raze", "Yoga", "Wisp", "Zest", "Omen", "Flux", "Echo", "Puma", "Rhea", "Haze", "Mink", "Zeta", "Yawn"]
    var fourWordCorrectAnswerArray: [String] = ["0", "1" , "2" , "3"]
    var wrongSelectCount = 0
    
    // For five word game
    var fiveWordsArray : [String] = ["Apple", "Bread", "Chair", "Dance", "Earth", "Fairy", "Grape", "Hotel", "Image", "Judge", "Knees", "Light", "Music", "North", "Olive", "Peach", "Quiet", "Round", "Shirt", "Tiger"]
    var fiveWordCorrectAnswerArray: [String] = ["0", "1" , "2" , "3", "4"]
    
    // For seven word game
    var sevenWordsArray : [String] = ["Account", "Balloon", "Captain", "Diamond", "Economy", "Freedom", "Gateway", "Husband", "Journey", "Kitchen", "Lantern", "Monster", "Natural", "Package", "Quality", "Rainbow", "Stadium", "Traffic", "Upgrade", "Victory"]
    var sevenWordCorrectAnswerArray: [String] = ["0", "1" , "2" , "3", "4", "5", "6"]
    
    // Array to hold pressed keys of keyboard to reset it's look and behaviour
    var allPressedKeys: [UIButton] = []
    
    // Exit variable
    var keepGameRunning = true
    /* All Variables and Arrays Ends Here */
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    /* All IBActions Code Starts Here */
    @IBAction func levelButtonPressed(_ sender: UIButton) {
        // This will hold title name of difficulty level button selected
        gameDifficultySelected = sender.titleLabel?.text ?? ""
        
        if(keepGameRunning){
            startGame()
        }
    }
    
    
    @IBAction func keyboardButtonPressed(_ sender: UIButton) {
        gameInProgress(pressedButton: sender)
    }
    /* All IBActions Code Ends Here */
    
    /* Helper Functions Code Starts Here */
    // This is the first function to be executed after level has been selected by the user
    func startGame(){
        //Setting Default Image (Empty rope (no body parts))
        characterImage.image = UIImage(named: "1.default")
        
        // Showing Keyboard and Answer Showing Container Because User Selected Difficulty Level
        keyBoardView.isHidden = false
        answerContainer.isHidden = false
        
        // This function will hide difficulty level buttons other than selected
        hideOtherDifficultyButtonsAndViews()
        
        //Assign random word
        getRandomWord()
    }
    
    // This function hides buttons other than selected and extra views
    func hideOtherDifficultyButtonsAndViews(){
        if(gameDifficultySelected == "EASY"){
            mediumButton.isHidden = true
            hardButton.isHidden = true
            fiveTextField.isHidden = true
            sixTextField.isHidden = true
            sevenTextField.isHidden = true
        } else if (gameDifficultySelected == "MEDIUM"){
            easyButton.isHidden = true
            hardButton.isHidden = true
            sixTextField.isHidden = true
            sevenTextField.isHidden = true
        } else {
            easyButton.isHidden = true
            mediumButton.isHidden = true
        }
    }

    // This function will get random words
    func getRandomWord(){
        if(gameDifficultySelected == "EASY"){
            // Four word game
            randomWord = fourWordsArray.randomElement() ?? "";
            randomWordSpiltted =  randomWord.uppercased().split(separator: "")
            print(randomWordSpiltted)
        } else if (gameDifficultySelected == "MEDIUM"){
            randomWord = fiveWordsArray.randomElement() ?? "";
            randomWordSpiltted =  randomWord.uppercased().split(separator: "")
            print(randomWordSpiltted)
        } else {
            randomWord = sevenWordsArray.randomElement() ?? "";
            randomWordSpiltted =  randomWord.uppercased().split(separator: "")
            print(randomWordSpiltted)
        }
    }
    
    //This function will execute each time user selects a value
    func gameInProgress(pressedButton : UIButton){
        // Pressed key are stored in this array for reset
        allPressedKeys.append(pressedButton)
        
        // Value Selected will hold the label of the button pressed
        let valueSelected = pressedButton.titleLabel?.text ?? ""
        
        if(gameDifficultySelected == "EASY"){
            var index = 0
            
            // This flag will only increase if button pressed by the user is correct
            var flag = 0
    
            while (index < randomWordSpiltted.count){
                if(valueSelected == randomWordSpiltted[index]){
                    fourWordCorrectAnswerArray[index] = String(randomWordSpiltted[index])
                    
                    //Change color here
                    pressedButton.backgroundColor = UIColor.green
                    
                    //If value matched
                    valueMatched = true
                    flag += 1
                    
                    if (index == 0) {
                        oneTextField.text = String(randomWordSpiltted[index])
                    } else if (index == 1){
                        twoTextField.text = String(randomWordSpiltted[index])
                    } else if (index == 2){
                        threeTextField.text = String(randomWordSpiltted[index])
                    } else if (index == 3){
                        fourTextField.text = String(randomWordSpiltted[index])
                    }
                    
                    // This function will check whether user has selected all the characters right or not
                    checkForWordMatch(totalCharcters: "FOUR")
                }
                
                // If flag value is zero then button doesn't matched to any value of the random word
                if(flag == 0){
                    //Change color here
                    pressedButton.backgroundColor = UIColor.red
                }
                
                // Disabling button so that user can not press that button again
                pressedButton.isEnabled = false
                
                // Increasing index value
                index += 1
            } //End of while loop
            
            //Checking whether value matched or not
            if(!valueMatched){
                wrongSelectCount += 1
                addNewBodyPartForFourWordGame()
            }
            
            // Resetting value to false
            valueMatched = false
        } else if (gameDifficultySelected == "MEDIUM"){
            var index = 0
            
            // This flag will only increase if button pressed by the user is correct
            var flag = 0
    
            while (index < randomWordSpiltted.count){
                if(valueSelected == randomWordSpiltted[index]){
                    fiveWordCorrectAnswerArray[index] = String(randomWordSpiltted[index])
                    
                    //Change color here
                    pressedButton.backgroundColor = UIColor.green
                    
                    //If value matched
                    valueMatched = true
                    flag += 1
                    
                    if (index == 0) {
                        oneTextField.text = String(randomWordSpiltted[index])
                    } else if (index == 1){
                        twoTextField.text = String(randomWordSpiltted[index])
                    } else if (index == 2){
                        threeTextField.text = String(randomWordSpiltted[index])
                    } else if (index == 3){
                        fourTextField.text = String(randomWordSpiltted[index])
                    } else if (index == 4) {
                        fiveTextField.text = String(randomWordSpiltted[index])
                    }
                    
                    // This function will check whether user has selected all the characters right or not
                    checkForWordMatch(totalCharcters: "FIVE")
                }
                
                // If flag value is zero then button doesn't matched to any value of the random word
                if(flag == 0){
                    //Change color here
                    pressedButton.backgroundColor = UIColor.red
                }
                
                // Disabling button so that user can not press that button again
                pressedButton.isEnabled = false
                
                // Increasing index value
                index += 1
            } //End of while loop
            
            //Checking whether value matched or not
            if(!valueMatched){
                wrongSelectCount += 1
                addNewBodyPartForFiveWordGame()
            }
            
            // Resetting value to false
            valueMatched = false
        } else {
            var index = 0
            
            // This flag will only increase if button pressed by the user is correct
            var flag = 0
    
            while (index < randomWordSpiltted.count){
                if(valueSelected == randomWordSpiltted[index]){
                    sevenWordCorrectAnswerArray[index] = String(randomWordSpiltted[index])
                    
                    //Change color here
                    pressedButton.backgroundColor = UIColor.green
                    
                    //If value matched
                    valueMatched = true
                    flag += 1
                    
                    if (index == 0) {
                        oneTextField.text = String(randomWordSpiltted[index])
                    } else if (index == 1){
                        twoTextField.text = String(randomWordSpiltted[index])
                    } else if (index == 2){
                        threeTextField.text = String(randomWordSpiltted[index])
                    } else if (index == 3){
                        fourTextField.text = String(randomWordSpiltted[index])
                    } else if (index == 4) {
                        fiveTextField.text = String(randomWordSpiltted[index])
                    } else if (index == 5){
                        sixTextField.text = String(randomWordSpiltted[index])
                    } else if (index == 6){
                        sevenTextField.text = String(randomWordSpiltted[index])
                    }
                    
                    // This function will check whether user has selected all the characters right or not
                    checkForWordMatch(totalCharcters: "SEVEN")
                }
                
                // If flag value is zero then button doesn't matched to any value of the random word
                if(flag == 0){
                    //Change color here
                    pressedButton.backgroundColor = UIColor.red
                }
                
                // Disabling button so that user can not press that button again
                pressedButton.isEnabled = false
                
                // Increasing index value
                index += 1
            } //End of while loop
            
            //Checking whether value matched or not
            if(!valueMatched){
                wrongSelectCount += 1
                addNewBodyPartForSevenWordGame()
            }
            
            // Resetting value to false
            valueMatched = false
        }
    }
    
    
    // This function will check whether user has selected all the characters right
    func checkForWordMatch(totalCharcters : String){
        var correctWord = ""

        if(totalCharcters == "FOUR"){
            correctWord = fourWordCorrectAnswerArray.joined()
        } else if(totalCharcters == "FIVE"){
            correctWord = fiveWordCorrectAnswerArray.joined()
        } else {
            correctWord = sevenWordCorrectAnswerArray.joined()
        }

        if(correctWord == randomWord.uppercased()){
            winCount += 1
            characterImage.image = UIImage(named: "won")
            updateWinsLabel()
            gameOver(gameResult: "WON")
        }
    }
    
    // This function will change image for four word game
    func addNewBodyPartForFourWordGame(){
        if(wrongSelectCount == 0){
            characterImage.image = UIImage(named: "1.default")
        } else if (wrongSelectCount == 1){
            characterImage.image = UIImage(named: "2.head")
        } else if(wrongSelectCount == 2){
            characterImage.image = UIImage(named: "5.right arm")
        } else if (wrongSelectCount == 3){
            characterImage.image = UIImage(named: "7.game lost")
            
            gameOver(gameResult: "LOST")
        }
    }
    
    // This function will change image for five word game
    func addNewBodyPartForFiveWordGame(){
        if(wrongSelectCount == 0){
            characterImage.image = UIImage(named: "1.default")
        } else if (wrongSelectCount == 1){
            characterImage.image = UIImage(named: "2.head")
        } else if (wrongSelectCount == 2){
            characterImage.image = UIImage(named: "3.body")
        } else if (wrongSelectCount == 3) {
            characterImage.image = UIImage(named: "5.right arm")
        } else if (wrongSelectCount == 4){
            characterImage.image = UIImage(named: "7.game lost")
            
            gameOver(gameResult: "LOST")
        }
    }
    
    // This function will change image for seven word game
    func addNewBodyPartForSevenWordGame(){
        if(wrongSelectCount == 0){
            characterImage.image = UIImage(named: "1.default")
        } else if (wrongSelectCount == 1){
            characterImage.image = UIImage(named: "2.head")
        } else if (wrongSelectCount == 2){
            characterImage.image = UIImage(named: "3.body")
        } else if (wrongSelectCount == 3) {
            characterImage.image = UIImage(named: "4.left arm")
        } else if (wrongSelectCount == 4) {
            characterImage.image = UIImage(named: "5.right arm")
        } else if (wrongSelectCount == 5) {
            characterImage.image = UIImage(named: "6.left leg")
        } else if (wrongSelectCount == 6){
            characterImage.image = UIImage(named: "7.game lost")
            
            gameOver(gameResult: "LOST")
        }
    }
    
    //This function will be called when game over
    func gameOver(gameResult : String){
        if(gameResult == "LOST"){
            //Updating loses label
            loseCount += 1
            updateLosesLabel()
            
            //Showing alert with correct word
            let alert = UIAlertController(title: "Sorry", message: "The correct word was \(randomWord) \n Would you like to play again?", preferredStyle: .alert)
            
            let okayAction = UIAlertAction(title: "Yes", style: .default) { _ in
                self.resetGameBoard()
            }
            let noAction = UIAlertAction(title: "No", style: .destructive, handler: stopResetingBoard(action:))
            
            alert.addAction(okayAction)
            alert.addAction(noAction)
            
            self.present(alert, animated: true, completion: nil)
        } else {
            //Showing alert with correct word
            let alert = UIAlertController(title: "Woohoo!", message: "I'm safe! Would you like to play again?", preferredStyle: .alert)
            
            let okayAction = UIAlertAction(title: "Yes", style: .default) { UIAlertAction in
                self.resetGameBoard()
            }
            let noAction = UIAlertAction(title: "No", style: .destructive, handler: stopResetingBoard(action:))
            
            alert.addAction(okayAction)
            alert.addAction(noAction)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //This function will stop the game
    func stopResetingBoard(action: UIAlertAction) -> Void{
        keepGameRunning = false
        exit(0) //Dhruv Edit
    }
    
    // This function will reset the game board
    func resetGameBoard(){
        //Setting Initial Image
        characterImage.image = UIImage(named: "0.Initial Screen")
        
        // Showing all difficulty level buttons, so that user can choose difficulty level again
        easyButton.isHidden = false
        mediumButton.isHidden = false
        hardButton.isHidden = false
        
        // Showing extra text fields, that were hidden for different difficulty levels
        fiveTextField.isHidden = false
        sixTextField.isHidden = false
        sevenTextField.isHidden = false
        
        //This will hide keyboard and answer container again
        keyBoardView.isHidden = true
        answerContainer.isHidden = true
        
        // This will clear all output fields
        oneTextField.text = ""
        twoTextField.text = ""
        threeTextField.text = ""
        fourTextField.text = ""
        fiveTextField.text = ""
        sixTextField.text = ""
        sevenTextField.text = ""
        
        // This for loop will reset the color of the keyboard pressed keys and also enable them again
        for button in allPressedKeys{
            button.backgroundColor = UIColor.white
            button.isEnabled = true
        }
        
        // Resetting wrong select counter
        wrongSelectCount = 0
    }
 
    // This function will update wins label
    func updateWinsLabel(){
        winsLabel.text = "WINS: " + String(winCount)
    }
    
    // This function will update loses label
    func updateLosesLabel(){
        lossesLabel.text = "LOSES: " + String(loseCount)
    }
    
    /* Helper Functions Code Ends Here */
}

