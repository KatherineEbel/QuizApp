//
//  QuestionModel.swift
//  TrueFalseStarter
//
//  Created by Katherine Ebel on 10/14/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation
import GameKit

class Trivia {
  var indexOfSelectedQuestion: Int = 0
  let questions: [[String : Any]] = [
      ["Question": "This was the only US President to serve more than two consecutive terms.",
       "Options": ["George Washington", "Franklin D. Roosevelt", "Woodrow Wilson", "Andrew Jackson"],
       "AnswerIndex": 1],
      ["Question": "Which of the following countries has the most residents?",
       "Options": ["Nigeria", "Russia", "Iran", "Vietnam"],
       "AnswerIndex": 0],
      ["Question": "In what year was the United Nations founded?",
       "Options": ["1918", "1919", "1945", "1954"],
       "AnswerIndex": 2],
      ["Question": "The Titanic departed from the United Kingdom, where was it supposed to arrive?",
       "Options": ["Paris", "Washington D.C.", "New York City", "Boston"],
       "AnswerIndex": 2],
      ["Question": "Which nation produces the most oil?",
       "Options": ["Iran", "Iraq", "Brazil", "Canada"],
       "AnswerIndex": 3],
      ["Question": "Which country has most recently won consecutive World Cups in Soccer?",
       "Options": ["Italy", "Brazil", "Argentina", "Spain"],
       "AnswerIndex": 1],
      ["Question": "Which of the following rivers is longest?",
       "Options": ["Yangtze", "Mississippi", "Congo", "Mekong"],
       "AnswerIndex": 1],
      ["Question": "Which city is the oldest?",
       "Options": ["Mexico City", "Cape Town", "San Juan", "Sydney"],
       "AnswerIndex": 0],
      ["Question": "Which country was the first to allow women to vote in national elections?",
       "Options": ["Poland", "United States", "Sweden", "Senegal"],
       "AnswerIndex": 0],
      ["Question": "Which of these countries won the most medals in the 2012 Summer Games?",
       "Options": ["France", "Germany", "Japan", "Great Britain"],
       "AnswerIndex": 3]
  ]
  
  func getRandomQuestion() -> [String : Any] {
    indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: questions.count)
    return questions[indexOfSelectedQuestion]
  }
  
  func isCorrect(answer: String, forQuestion question: [String : Any]) -> Bool {
    let correctAnswerIdx = question["AnswerIndex"] as! Int
    let options = question["Options"] as! [String]
    return answer == options[correctAnswerIdx] 
  }
  
  func answerFor(question: [String : Any]) -> String {
    let options = question["Options"] as! [String]
    return "The correct answer is: \(options[question["AnswerIndex"] as! Int])"
  }
}
