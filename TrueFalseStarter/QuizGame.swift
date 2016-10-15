//
//  QuizGame.swift
//  TrueFalseStarter
//
//  Created by Katherine Ebel on 10/14/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//
import AudioToolbox

class QuizGame {
  let questionsPerRound = 4
  let trivia : Trivia
  var questionsAsked = 0
  var correctQuestions = 0
  var gameSound: SystemSoundID = 0
  var currentQuestion: [String : String]
  var result : String!
  
  init(trivia: Trivia) {
    self.trivia = trivia
    currentQuestion = trivia.getRandomQuestion()
  }
  
  func nextRound() {
    if questionsAsked == questionsPerRound {
      // Game is over
      gameOver()
    } else {
      // Continue game
      currentQuestion = getQuestion()
    }
  }
  
  func getResult() -> String {
    return "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
  }
  
  func gameOver() {
    result = getResult()
  }
  // MARK: Helper Methods
  
  func loadNextRoundWithDelay(seconds: Int) {
    // Converts a delay in seconds to nanoseconds as signed 64 bit integer
    let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
    // Calculates a time value to execute the method given current time and delay
    let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
    
    // Executes the nextRound method at the dispatch time on the main queue
    DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
      self.nextRound()
    }
  }
  
  func loadGameStartSound() {
    let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
    let soundURL = URL(fileURLWithPath: pathToSoundFile!)
    AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
  }
  
  func playGameStartSound() {
    AudioServicesPlaySystemSound(gameSound)
  }
  
  func getQuestion() -> [String: String] {
    return trivia.getRandomQuestion()
  }
}

