//
//  QuizGame.swift
//  TrueFalseStarter
//
//  Created by Katherine Ebel on 10/14/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//
import AudioToolbox

class QuizGame {
  let questionsPerRound = 10
  let trivia : Trivia
  var questionsAsked = 0
  var correctQuestions = 0
  var gameSound: SystemSoundID = 0
  var currentQuestion: [String : Any]
  var result : String!
  var usedQuestions : [[String : Any]] = []
  
  init(trivia: Trivia) {
    self.trivia = trivia
    currentQuestion = trivia.getRandomQuestion()
  }
    
  func used(question: [String : Any]) -> Bool {
    return usedQuestions.contains(where: { (questionDict) -> Bool in
      questionDict["Question"] as? String == question["Question"] as? String
    })
  }
  
  func getQuestion() {
    repeat {
      currentQuestion = trivia.getRandomQuestion()
    } while used(question: currentQuestion)
    usedQuestions.append(currentQuestion)
  }
  
  func nextRound() {
    if isGameOver() {
      // Game is over
      result = getResult()
    } else {
      // Continue game
      getQuestion()
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
  
  func startOver() {
    questionsAsked = 0
    correctQuestions = 0
    usedQuestions = []
    nextRound()
  }
  
  func getResult() -> String {
    return "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
  }
  
  func isGameOver() -> Bool {
    return questionsAsked == questionsPerRound ? true : false
  }
}
