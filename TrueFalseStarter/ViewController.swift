//
//  QuizViewController.swift
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
  @IBOutlet weak var correctAnswerField: UILabel!
  @IBOutlet weak var choice1Button: UIButton!
  @IBOutlet weak var choice2Button: UIButton!
  @IBOutlet weak var choice3Button: UIButton!
  @IBOutlet weak var choice4Button: UIButton!
  @IBOutlet weak var playAgainButton: UIButton!
  let quizGame = QuizGame(trivia: Trivia())
  var questionTimer = Timer()

  override func viewDidLoad() {
      super.viewDidLoad()
      // Start game
      quizGame.start()
      displayQuestion()
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
  @IBAction func checkAnswer(_ sender: UIButton) {
    // Increment the questions asked counter
    questionTimer.invalidate()
    let selectedQuestionDict = quizGame.currentQuestion
    let isCorrectAnswer =  quizGame.trivia.isCorrect(answer: sender.currentTitle!, forQuestion: selectedQuestionDict)
    if isCorrectAnswer {
      quizGame.correctQuestions += 1
      quizGame.playSoundFor(eventName: "CorrectAnswer")
      questionField.text = "Correct!"
    } else {
      quizGame.playSoundFor(eventName: "IncorrectAnswer")
      questionField.text = "Sorry, wrong answer!"
      correctAnswerField.isHidden = false
      correctAnswerField.text = quizGame.trivia.answerFor(question: quizGame.currentQuestion)
    }
    loadNextRoundWithDelay(seconds: 2)
  }
  
  @IBAction func playAgain() {
    // Show the answer buttons
    toggleChoiceButtons()
    quizGame.playAgain()
    quizGame.playSoundFor(eventName: "GameSound")
    updateUI()
  }
  
  // MARK: Helper Methods
  func startTimerForRound() {
    let interval = quizGame.timeLimitPerQuestion
    questionTimer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(ViewController.displayTimesUp), userInfo: nil, repeats: false)
  }
  
  // handle when timer is up, show correct answer
  func displayTimesUp() {
    questionField.text = "Sorry, Time's up!"
    quizGame.playSoundFor(eventName: "IncorrectAnswer")
    correctAnswerField.text = quizGame.trivia.answerFor(question: quizGame.currentQuestion)
    correctAnswerField.isHidden = false
    loadNextRoundWithDelay(seconds: 3)
  }
  
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
  
  // update buttons/labels for current quiz question, start timer for current round
  func displayQuestion() {
    quizGame.questionsAsked += 1
    playAgainButton.isHidden = true
    correctAnswerField.isHidden = true
    questionField.text = (quizGame.currentQuestion["Question"] as! String)
    updateButtonTitles()
    startTimerForRound()
  }
 
  // hide answer buttons and display game result
  func displayScore() {
      // Hide the answer buttons and answerTextField
      correctAnswerField.isHidden = true
      toggleChoiceButtons()
      // Display play again button
      playAgainButton.isHidden = false
      questionField.text = quizGame.result
  }
 
  // updates buttons and labels dependant on whether game is over or not
  func updateUI() {
    if quizGame.isGameOver() {
      displayScore()
    } else {
      displayQuestion()
    }
  }
  
  // displays or hides buttons based on current state
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
