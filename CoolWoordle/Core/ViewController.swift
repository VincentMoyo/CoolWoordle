//
//  ViewController.swift
//  CoolWoordle
//
//  Created by Vincent Moyo on 2022/03/09.
//

import UIKit

class ViewController: UIViewController {
    
    private var viewModel = ViewModel()
    let keyboardVC = CoolWoordle.KeyboardViewController()
    let boardVC = BoardViewController()
    var answer = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answer = viewModel.answers.randomElement() ?? "fives"
        view.backgroundColor = .systemGray6
        addChildren()
    }
    
    private func addChildren() {
        addChild(keyboardVC)
        setupKeyboardVC()
        
        addChild(boardVC)
        setupBoardVC()
        
        addConstrains()
    }
    
    private func setupKeyboardVC() {
        keyboardVC.didMove(toParent: self)
        keyboardVC.delegate = self
        keyboardVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keyboardVC.view)
    }
    
    private func setupBoardVC() {
        boardVC.didMove(toParent: self)
        boardVC.view.translatesAutoresizingMaskIntoConstraints = false
        boardVC.datasource = self
        view.addSubview(boardVC.view)
    }
    
    private func addConstrains() {
        NSLayoutConstraint.activate([
            boardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            boardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            boardVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            boardVC.view.bottomAnchor.constraint(equalTo: keyboardVC.view.topAnchor),
            boardVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            
            keyboardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ViewController: KeyboardViewControllerDelegate {
    func KeyboardViewController(_ vc: KeyboardViewController, didTapKey letter: Character) {
        viewModel.updateGuesses(after: letter)
        boardVC.reloadData()
    }
}

extension ViewController: BoardViewControllerDatasource {
    var currentGuesses: [[Character?]] {
        viewModel.guesses
    }
    
    func boxColour(at indexPath: IndexPath) -> UIColor? {
        let indexedAnswer = Array(answer)
        
        guard viewModel.retrieveGuessCount(forRowIndex: indexPath.section) == 5 else { return nil }
        guard let letter = viewModel.guesses[indexPath.section][indexPath.row], indexedAnswer.contains(letter) else { return nil }
        
        if indexedAnswer[indexPath.row] == letter { return .systemGreen }
        
        return .systemOrange
    }
}

