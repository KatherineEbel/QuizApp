//
//  QuestionModel.swift
//  TrueFalseStarter
//
//  Created by Katherine Ebel on 10/14/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation
import GameKit

struct Trivia {
  let questions : [QuizQuestion] = [
    QuizQuestion(question: "This was the only US President to serve more than two consecutive terms.",
      options: ["George Washington", "Franklin D. Roosevelt", "Woodrow Wilson", "Andrew Jackson"],
      correctOption: 1),
    QuizQuestion(question: "Which of the following countries has the most residents?",
      options: ["Nigeria", "Russia", "Iran", "Vietnam"],
      correctOption: 0),
    QuizQuestion(question: "In what year was the United Nations founded?",
      options: ["1918", "1919", "1945", "1954"],
      correctOption: 2),
    QuizQuestion(question: "The Titanic departed from the United Kingdom, where was it supposed to arrive?",
      options: ["Paris", "Washington D.C.", "New York City", "Boston"],
      correctOption: 2),
    QuizQuestion(question: "Which nation produces the most oil?",
      options: ["Iran", "Iraq", "Brazil", "Canada"],
      correctOption: 3),
    QuizQuestion(question: "Which country has most recently won consecutive World Cups in Soccer?",
      options: ["Italy", "Brazil", "Argentina", "Spain"],
      correctOption: 1),
    QuizQuestion(question: "Which of the following rivers is longest?",
      options: ["Yangtze", "Mississippi", "Congo", "Mekong"],
      correctOption: 1),
    QuizQuestion(question: "Which city is the oldest?",
      options: ["Mexico City", "Cape Town", "San Juan", "Sydney"],
      correctOption: 0),
    QuizQuestion(question: "Which country was the first to allow women to vote in national elections?",
      options: ["Poland", "United States", "Sweden", "Senegal"],
      correctOption: 0),
    QuizQuestion(question: "Which of these countries won the most medals in the 2012 Summer Games?",
      options: ["France", "Germany", "Japan", "Great Britain"],
      correctOption: 3),
  ]
  
  var randomQuestion : QuizQuestion {
    let indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: questions.count)
    return questions[indexOfSelectedQuestion]
  }
}
