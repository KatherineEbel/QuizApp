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
  
  func loadGameStartSound() {
    let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
    let soundURL = URL(fileURLWithPath: pathToSoundFile!)
    AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
  }
  
  func playGameStartSound() {
    AudioServicesPlaySystemSound(gameSound)
  }
  
  func nextRound() {
    if isGameOver() {
      // Game is over
      result = getResult()
    } else {
      // Continue game
      currentQuestion = getQuestion()
    }
  }
  
  func startOver() {
    questionsAsked = 0
    correctQuestions = 0
    nextRound()
  }
  
  func getResult() -> String {
    return "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
  }
  
  func isGameOver() -> Bool {
    return questionsAsked == questionsPerRound ? true : false
  }
  
  func getQuestion() -> [String: String] {
    return trivia.getRandomQuestion()
  }
}

