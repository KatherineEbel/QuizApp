//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
  @IBOutlet weak var questionField: UILabel!
  @IBOutlet weak var choice1Button: UIButton!
  @IBOutlet weak var choice2Button: UIButton!
  @IBOutlet weak var choice3Button: UIButton!
  @IBOutlet weak var choice4Button: UIButton!
  @IBOutlet weak var playAgainButton: UIButton!
  let quizGame = QuizGame(trivia: Trivia())

  override func viewDidLoad() {
      super.viewDidLoad()
      // Start game
      quizGame.loadGameStartSound()
      quizGame.playGameStartSound()
      displayQuestion()
      updateButtonTitles()
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
  @IBAction func checkAnswer(_ sender: UIButton) {
      // Increment the questions asked counter
      quizGame.questionsAsked += 1
      
      let selectedQuestionDict = quizGame.currentQuestion
      let options = selectedQuestionDict["Options"] as! [String]
      let answerIndex = selectedQuestionDict["AnswerIndex"] as! Int
      let correctAnswer = options[answerIndex]
      if sender.currentTitle == correctAnswer {
        quizGame.correctQuestions += 1
        questionField.text = "Correct!"
      } else {
        questionField.text = "Sorry, wrong answer!"
      }
      loadNextRoundWithDelay(seconds: 2)
  }
  
  @IBAction func playAgain() {
      // Show the answer buttons
      toggleChoiceButtons()
      quizGame.startOver()
      updateUI()
  }
  
  // MARK: Helper Methods
  
  func loadNextRoundWithDelay(seconds: Int) {
    // Converts a delay in seconds to nanoseconds as signed 64 bit integer
    let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
    // Calculates a time value to execute the method given current time and delay
    let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
    
    // Executes the nextRound method at the dispatch time on the main queue
    DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
      self.quizGame.nextRound()
      self.updateUI()
    }
  }
  
  func displayQuestion() {
      questionField.text = quizGame.currentQuestion["Question"] as! String?
      playAgainButton.isHidden = true
      updateButtonTitles()
  }
  
  func displayScore() {
      // Hide the answer buttons
      toggleChoiceButtons()
      // Display play again button
      playAgainButton.isHidden = false
      questionField.text = quizGame.result
  }
  
  func updateUI() {
    if quizGame.isGameOver() {
      displayScore()
    } else {
      displayQuestion()
    }
  }
  
  func toggleChoiceButtons() {
    let buttons = [choice1Button, choice2Button, choice3Button, choice4Button]
    for button in buttons {
      button?.isHidden = (button?.isHidden)! ? false : true
    }
  }
  
  func updateButtonTitles() {
    let buttons = [choice1Button, choice2Button, choice3Button, choice4Button]
    let options = quizGame.currentQuestion["Options"] as! [String]
    for idx in 0..<buttons.count {
      buttons[idx]?.setTitle(options[idx], for: .normal)
    }
  }
}

