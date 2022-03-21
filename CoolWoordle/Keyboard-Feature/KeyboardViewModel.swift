//
//  KeyboardViewModel.swift
//  CoolWoordle
//
//  Created by Vincent Moyo on 2022/03/16.
//

import Foundation

class KeyboardViewModel {
    
    var letters = ["qwertyuiop","asdfghjkl","zxcvbnm"]
    var keys: [[Character]] = []
    
    func createKeyBoard() {
        for row in letters {
            let chars = Array(row)
            keys.append(chars)
        }
    }
    
}
