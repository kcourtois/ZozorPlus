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
            if let textUpdate = calculator.addNewNumber(index) {
                textView.text = textUpdate
            }
        }
    }

    @IBAction func plus() {
        if let textUpdate = calculator.addNewOperator(newOperator: .plus) {
            textView.text = textUpdate
        }
    }

    @IBAction func minus() {
        if let textUpdate = calculator.addNewOperator(newOperator: .minus) {
            textView.text = textUpdate
        }
    }

    @IBAction func multiply() {
        if let textUpdate = calculator.addNewOperator(newOperator: .multiply) {
            textView.text = textUpdate
        }
    }

    @IBAction func equal() {
        if let total = calculator.calculateTotal() {
            textView.text += "=\(total)"
        }
    }

    // MARK: - Methods

    //Triggers on notification didSendAlert
    @objc private func onDidSendAlert(_ notification: Notification) {
        if let data = notification.userInfo as? [String: String] {
            for (_, message) in data {
                showAlert(message: message)
            }
        }
    }

    //Shows an alert with a custom message
    private func showAlert(message: String) {
        let alertVC = UIAlertController(title: "Zéro!", message: message,
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
