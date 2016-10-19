//
//  QuizQuestion.swift
//  TrueFalseStarter
//
//  Created by Katherine Ebel on 10/19/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//
struct QuizQuestion {
  let question : String
  let options : [String]
  let correctOption : Int
  var correctAnswer : String {
    return options[correctOption]
  }
  
  func isCorrect(answer: String) -> Bool {
    return answer == correctAnswer
  }
  
  func displayCorrectAnswer() -> String {
    return "The correct answer is: \(correctAnswer)"
  }
}
