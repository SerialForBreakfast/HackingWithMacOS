//
//  ViewController.swift
//  Project2
//
//  Created by Joseph McCraw on 5/31/17.
//  Copyright © 2017 Joseph McCraw. All rights reserved.
//

import Cocoa
import GameplayKit

class ViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    var answer = ""
    var guesses = [String]()
    
    
    @IBOutlet var tableView: NSTableView!
    @IBOutlet var guess: NSTextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }

    
    @IBAction func submitGuess(_ sender: Any) {
        let guessString = guess.stringValue
        guard Set(guessString.characters).count == 4 else {return}
        
        let badCharacters = CharacterSet(charactersIn: "0123456789").inverted
        guard guessString.rangeOfCharacter(from: badCharacters) == nil else {return}
        
        guesses.insert(guessString, at: 0)
        
        tableView.insertRows(at: IndexSet(integer: 0), withAnimation: .slideDown)
        // did player win?
        let resultString = result(for: guessString)
        
        if resultString.contains("4b") {
            let alert = NSAlert()
            alert.messageText = "You win"
            alert.informativeText = "Congratulations! Click OK to play agin."
            alert.runModal()
            startNewGame()
        }
        
    }
    
    
    func startNewGame() {
        guess.stringValue = ""
        guesses.removeAll()
        
        answer = ""
        
        var numbers = Array(0...9)
        numbers = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: numbers) as! [Int]
        
        for _ in 0 ..< 4 {
            answer.append(String(numbers.removeLast()))
        }
        //Print answer for testing
        print(answer)
        tableView.reloadData()
        
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return guesses.count
    }
    
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let vw = tableView.make(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else {return nil}
        if tableColumn?.title == "Guess" {
            vw.textField?.stringValue = guesses[row]
        } else {
            vw.textField?.stringValue = result(for: guesses[row])
        }
        return vw
    }
    
    func tableView(_ tableView:NSTableView, shouldSelectRow row: Int) -> Bool {
        return false
    }
    
    
    
    func result(for guess: String) -> String {
        var bulls = 0
        var cows = 0
        
        
        
        let guessLetters = Array(guess.characters)
        let answerLetters = Array(answer.characters)
        
        for (index, letter) in guessLetters.enumerated() {
            if letter == answerLetters[index] {
                bulls += 1
            } else if answerLetters.contains (letter) {
                cows += 1
            }
        }
        return "\(bulls)b \(cows)c"
        
    }
    
    
}




