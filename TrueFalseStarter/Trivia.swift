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
  
  let trivia: [[String : String]] = [
      ["Question": "Only female koalas can whistle", "Answer": "False"],
      ["Question": "Blue whales are technically whales", "Answer": "True"],
      ["Question": "Camels are cannibalistic", "Answer": "False"],
      ["Question": "All ducks are birds", "Answer": "True"]
  ]
  
  func getRandomQuestion() -> [String : String] {
    indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: trivia.count)
    return trivia[indexOfSelectedQuestion]
  }
  
  func isCorrect(answer: String, forQuestion question: [String : String]) -> Bool {
    return answer == question["Answer"]
  }
}
