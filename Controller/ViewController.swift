//
//  ViewController.swift
//  CountOnMe
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    let calculator = Calculator()
    var stringNumbers: [String] = [String()]
    var operators: [String] = ["+"]
    var index = 0
    var isExpressionCorrect: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                if stringNumbers.count == 1 {
                    showAlert(message: "Démarrez un nouveau calcul !")
                } else {
                    showAlert(message: "Entrez une expression correcte !")
                }
                return false
            }
        }
        return true
    }

    var canAddOperator: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                showAlert(message: "Expression incorrecte !")
                return false
            }
        }
        return true
    }

    // MARK: - Outlets

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!

    // MARK: - Override

    override func viewDidLoad() {
        numberButtons.sort {
            return $0.tag < $1.tag
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        //Notification observer for didSendAlert
        let nameSendAlertNotif = Notification.Name(rawValue: NotificationStrings.didSendAlertNotificationName)
        NotificationCenter.default.addObserver(self, selector: #selector(onDidSendAlert(_:)),
                                               name: nameSendAlertNotif, object: nil)
    }

    // MARK: - Action

    @IBAction func tappedNumberButton(_ sender: UIButton) {
        for (index, numberButton) in numberButtons.enumerated() where sender == numberButton {
            addNewNumber(index)
        }
    }

    @IBAction func plus() {
        if canAddOperator {
        	operators.append("+")
        	stringNumbers.append("")
            updateDisplay()
        }
    }

    @IBAction func minus() {
        if canAddOperator {
            operators.append("-")
            stringNumbers.append("")
            updateDisplay()
        }
    }

    @IBAction func equal() {
        calculateTotal()
    }

    // MARK: - Methods

    func addNewNumber(_ newNumber: Int) {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
        updateDisplay()
    }

    func calculateTotal() {
        if !isExpressionCorrect {
            return
        }

        var total = 0
        for (index, stringNumber) in stringNumbers.enumerated() {
            if let number = Int(stringNumber) {
                if operators[index] == "+" {
                    total += number
                } else if operators[index] == "-" {
                    total -= number
                }
            }
        }

        textView.text += "=\(total)"

        clear()
    }

    func updateDisplay() {
        var text = ""
        for (index, stringNumber) in stringNumbers.enumerated() {
            // Add operator
            if index > 0 {
                text += operators[index]
            }
            // Add number
            text += stringNumber
        }
        textView.text = text
    }

    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
        index = 0
    }

    //Triggers on notification didSelectLayout
    @objc private func onDidSendAlert(_ notification: Notification) {
        print("hi")
        if let data = notification.userInfo as? [String: String] {
            for (_, message) in data {
                showAlert(message: message)
            }
        }
    }

    private func showAlert(message: String) {
        let alertVC = UIAlertController(title: "Zéro!", message: message,
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
