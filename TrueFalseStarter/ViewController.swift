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
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    let quizGame = QuizGame(trivia: Trivia())

    override func viewDidLoad() {
        super.viewDidLoad()
        // Start game
        quizGame.loadGameStartSound()
        quizGame.playGameStartSound()
        displayQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayQuestion() {
        questionField.text = quizGame.currentQuestion["Question"]
        playAgainButton.isHidden = true
    }
    
    func displayScore() {
        // Hide the answer buttons
        trueButton.isHidden = true
        falseButton.isHidden = true
        
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = quizGame.result
    }
    
  @IBAction func checkAnswer(_ sender: UIButton) {
      // Increment the questions asked counter
      quizGame.questionsAsked += 1
      
      let selectedQuestionDict = quizGame.currentQuestion
      let correctAnswer = selectedQuestionDict["Answer"]
      
      if (sender === trueButton &&  correctAnswer == "True") || (sender === falseButton && correctAnswer == "False") {
          quizGame.correctQuestions += 1
          questionField.text = "Correct!"
      } else {
          questionField.text = "Sorry, wrong answer!"
      }
      
      loadNextRoundWithDelay(seconds: 2)
  }
  
  
  @IBAction func playAgain() {
      // Show the answer buttons
      trueButton.isHidden = false
      falseButton.isHidden = false
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
  
  func updateUI() {
    quizGame.isGameOver() ? displayScore() : displayQuestion()
  }
}

