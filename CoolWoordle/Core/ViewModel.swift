//
//  ViewModel.swift
//  CoolWoordle
//
//  Created by Vincent Moyo on 2022/03/15.
//

import Foundation

class ViewModel {
    
    let answers = ["after", "later", "three", "marks", "ultra"]
    var guesses: [[Character?]] = Array(repeating: Array(repeating: nil,
                                                         count: 5),
                                        count: 6)
    
    func updateGuesses(after letter: Character) {
        var stop = false
        for i in 0..<guesses.count {
            for j in 0..<guesses[i].count {
                if guesses[i][j] == nil {
                    guesses[i][j] = letter
                    stop = true
                    break
                }
            }
            if stop {
                break
            }
        }
    }
    
    func retrieveGuessCount(forRowIndex section: Int) -> Int {
        guesses[section].compactMap({ $0 }).count
    }
}
