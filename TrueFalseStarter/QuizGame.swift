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
  var gameSounds: [String : SystemSoundID] = ["GameSound": 0, "CorrectAnswer": 0, "IncorrectAnswer": 0, "Win": 0, "Lose": 0]
  var currentQuestion: [String : Any] = [:]
  var result : String!
  var usedQuestions : [[String : Any]] = []
  
  init(trivia: Trivia) {
    self.trivia = trivia
    questionsPerRound = Double(trivia.questions.count)
  }
  
  func start() {
    loadGameSounds()
    playSoundFor(eventName: "GameSound")
    nextRound()
  }
  
  // returns true if question is in usedQuestions array.
  func used(question: [String : Any]) -> Bool {
    return usedQuestions.contains(where: { (questionDict) -> Bool in
      questionDict["Question"] as? String == question["Question"] as? String
    })
  }
  
  func nextQuestion() {
    repeat {
      currentQuestion = trivia.getRandomQuestion()
    } while used(question: currentQuestion)
    usedQuestions.append(currentQuestion)
  }
  
  func nextRound() {
    if isGameOver() {
      // Game is over
      let isWinner = gameWon()
      isWinner ? playSoundFor(eventName: "Win") : playSoundFor(eventName: "Lose")
      result = getResult(won: isWinner)
    } else {
      // Continue game
      nextQuestion()
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
  
  // evant names used for game sounds probably would have worked better as enums, but have not yet been covered
  // in course, so wasn't sure if I was allowed to use.
  func playSoundFor(eventName name: String) {
    if let sound = gameSounds[name] {
      AudioServicesPlaySystemSound(sound)
    }
  }
  
  // player wins with score greater or equal to 70%
  func gameWon() -> Bool {
    return correctQuestions / questionsPerRound >= 0.70
  }
  
  // reset properties and load next question
  func playAgain() {
    questionsAsked = 0
    correctQuestions = 0
    usedQuestions = []
    nextRound()
  }
  
  // returns a string with result of game based on whether player won or lost
  func getResult(won: Bool) -> String {
    let message = won ? "Way to go!\nYou got " : "Sorry!\nYou only got "
    let result = "\(Int(correctQuestions)) correct!"
    return "\(message)\(result)"
  }
  
  func isGameOver() -> Bool {
    return questionsAsked == questionsPerRound ? true : false
  }
}
