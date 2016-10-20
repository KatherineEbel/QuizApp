//
//  QuizViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
  @IBOutlet weak var questionField: UILabel!
  @IBOutlet weak var correctAnswerField: UILabel!
  @IBOutlet weak var choice1Button: UIButton!
  @IBOutlet weak var choice2Button: UIButton!
  @IBOutlet weak var choice3Button: UIButton!
  @IBOutlet weak var choice4Button: UIButton!
  @IBOutlet weak var playAgainButton: UIButton!
  let correctResponseMessage = "Correct!"
  let incorrectResponseMessage = "Sorry, that's not it!"
  let timeUpMessage = "Sorry, time's up!"
  let quizGame = QuizGame()
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
    if let currentQuestion = quizGame.currentQuestion {
      let isCorrectAnswer = currentQuestion.correctAnswer == sender.currentTitle!
      handleResponseFor(isCorrectAnswer: isCorrectAnswer)
    }
  }
  
  
  @IBAction func playAgain() {
    if quizGame.isGameOver() {
      playAgainButton.setTitle("Play Again", for: .normal)
      quizGame.end()
      quizGame.playAgain()
      displayScore()
    } else {
      playAgainButton.setTitle("Next Question", for: .normal)
      loadNextRound()
    }
  }
  
  // MARK: Helper Methods
  func handleResponseFor(isCorrectAnswer: Bool) {
    highlightCorrectOptionButton()
    isCorrectAnswer ? handleCorrectAnswer() : handleIncorrectAnswer()
    correctAnswerField.isHidden = false
    playAgainButton.isHidden = false
  }
  
  func startTimerForRound() {
    let timeLimit = quizGame.timeLimitPerQuestion
    questionTimer = Timer.scheduledTimer(timeInterval: timeLimit, target: self, selector: #selector(QuizViewController.displayTimesUp), userInfo: nil, repeats: false)
  }
  
  // handle when timer is up, show correct answer
  func displayTimesUp() {
    questionField.text = timeUpMessage
    handleResponseFor(isCorrectAnswer: false)
  }
  
  func loadNextRound() {
    quizGame.getNextQuestion()
    displayQuestion()
  }
  
  
  // update buttons/labels for current quiz question, start timer for current round
  func displayQuestion() {
    quizGame.playSoundFor(eventName: "GameSound")
    quizGame.questionsAsked += 1
    playAgainButton.isHidden = true
    correctAnswerField.isHidden = true
    if let currentQuestion = quizGame.currentQuestion {
      questionField.text = currentQuestion.question
      updateOptionButtons()
      startTimerForRound()
    }
  }
 
  // hide answer buttons and display game result
  func displayScore() {
      playAgainButton.isHidden = false
      questionField.text = quizGame.result
  }
  
  // allow quizgame to respond for correct answer and adjust UI
  func handleCorrectAnswer() {
    quizGame.correctQuestions += 1
    quizGame.playSoundFor(eventName: "CorrectAnswer")
    correctAnswerField.textColor = UIColor(red: 2/255.0, green: 119/255.0, blue: 116/255.0, alpha: 1.0)
    correctAnswerField.text = correctResponseMessage
  }
  
  func handleIncorrectAnswer() {
    quizGame.playSoundFor(eventName: "IncorrectAnswer")
    correctAnswerField.textColor = UIColor(red: 222/255.0, green: 146/255.0, blue: 93/255.0, alpha: 1.0)
    correctAnswerField.text = incorrectResponseMessage
  }
  
  func updateOptionButtons() {
    let buttons = [choice1Button, choice2Button, choice3Button, choice4Button]
    if let currentQuestion = quizGame.currentQuestion {
      for index in 0..<buttons.count {
        // restore button initial colors and update title for new question
        buttons[index]?.backgroundColor = UIColor(red: 12/255.0, green: 121/255.0, blue: 150/255.0, alpha: 1.0)
        buttons[index]?.tintColor = UIColor.white
        buttons[index]?.isEnabled = true
        buttons[index]?.isUserInteractionEnabled = true
        buttons[index]?.setTitle(currentQuestion.options[index], for: .normal)
      }
    }
  }
  
  // after question is answered the buttons will change colors to display correct answer
  // the only button that can respond to touches at this point is the playAgain/next button
  func highlightCorrectOptionButton() {
    if let currentQuestion = quizGame.currentQuestion {
      let buttons = [choice1Button, choice2Button, choice3Button, choice4Button]
      for button in buttons {
        button?.isUserInteractionEnabled = false
        if button?.currentTitle == currentQuestion.correctAnswer {
          // correct answer button will be white with dark blue text
          button?.backgroundColor = UIColor.white
          button?.tintColor = UIColor(red: 8/255.0, green: 43/255.0, blue: 62/255.0, alpha: 1.0)
        } else {
          button?.isEnabled = false
        }
      }
    }
  }
}
