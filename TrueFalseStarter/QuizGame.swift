//
//  QuizGame.swift
//  TrueFalseStarter
//
//  Created by Katherine Ebel on 10/14/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//
import AudioToolbox

class QuizGame {
  let questionsPerRound : Double
  let trivia : Trivia
  let timeLimitPerQuestion = 15.0
  var questionsAsked : Double = 0
  var correctQuestions : Double = 0
  var gameSounds: [String : SystemSoundID] = ["GameSound": 0, "Correct": 0, "Incorrect": 0, "Win": 0, "Lose": 0]
  var currentQuestion: [String : Any] = [:]
  var result : String!
  var usedQuestions : [[String : Any]] = []
  
  init(trivia: Trivia) {
    self.trivia = trivia
    questionsPerRound = Double(trivia.questions.count)
  }
  
  // returns true if question is in usedQuestions array.
  func used(question: [String : Any]) -> Bool {
    return usedQuestions.contains(where: { (questionDict) -> Bool in
      questionDict["Question"] as? String == question["Question"] as? String
    })
  }
  
  func getNextQuestion() {
    repeat {
      currentQuestion = trivia.getRandomQuestion()
    } while used(question: currentQuestion)
    usedQuestions.append(currentQuestion)
  }
  
  func nextRound() {
    if isGameOver() {
      let hasWon = gameWon()
      // Game is over
      print("Game over")
      hasWon ? playSoundFor(eventName: "Win") : playSoundFor(eventName: "Lose")
      result = getResult(won: hasWon)
    } else {
      // Continue game
      getNextQuestion()
    }
  }
  
  func loadGameSounds() {
    for (name, _) in gameSounds {
      let pathToSoundFile: String?
      let soundURL: URL
      switch name {
        case "Win":
          pathToSoundFile = Bundle.main.path(forResource: name, ofType: "mp3")
      default:
          pathToSoundFile = Bundle.main.path(forResource: name, ofType: "wav")
      }
      if let pathToSoundFile = pathToSoundFile {
        soundURL = URL(fileURLWithPath: pathToSoundFile)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSounds[name]!)
      } else {
        print("Error loading sound: \(name)")
      }
    }
  }
  
  func playSoundFor(eventName name: String) {
    if let sound = gameSounds[name] {
      AudioServicesPlaySystemSound(sound)
    }
  }
  
  func gameWon() -> Bool {
    return correctQuestions / questionsPerRound >= 0.70
  }
  
  func startOver() {
    questionsAsked = 0
    correctQuestions = 0
    usedQuestions = []
    nextRound()
  }
  
  func getResult(won: Bool) -> String {
    let message = won ? "Way to go!\nYou got " : "Sorry!\nYou only got "
    let result = "\(Int(correctQuestions)) correct!"
    return "\(message)\(result)"
  }
  
  func isGameOver() -> Bool {
    return questionsAsked == questionsPerRound ? true : false
  }
}
