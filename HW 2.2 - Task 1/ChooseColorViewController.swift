//
//  ViewController.swift
//  HW 2.2 - Task 1
//
//  Created by User on 16.10.2020.
//  Copyright © 2020 Evgeny. All rights reserved.
//

import UIKit

class ChooseColorViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet var paintedView: UIView!
    
    @IBOutlet var redColorLabel: UILabel!
    @IBOutlet var greenColorLabel: UILabel!
    @IBOutlet var blueColorLabel: UILabel!
    
    @IBOutlet var redColorSlider: UISlider!
    @IBOutlet var greenColorSlider: UISlider!
    @IBOutlet var blueColorSlider: UISlider!
    
    @IBOutlet var redColorTextField: UITextField!
    @IBOutlet var greenColorTextField: UITextField!
    @IBOutlet var blueColorTextField: UITextField!
    
    // MARK: - Properties
    var delegate: StartViewControllerDelegate!
    var chosenColor: UIColor!
        
    // MARK: - Types
    enum UpdateMode {
        case red, green, blue, all
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        redColorSlider.minimumTrackTintColor = .red
        greenColorSlider.minimumTrackTintColor = .green
        redColorTextField.delegate = self
        greenColorTextField.delegate = self
        blueColorTextField.delegate = self

        paintedView.layer.cornerRadius = 15
        updateObjects(for: .all)
        
        addDoneButtonOnKeyboard(for: redColorTextField)
        addDoneButtonOnKeyboard(for: greenColorTextField)
        addDoneButtonOnKeyboard(for: blueColorTextField)
    }
    
    // MARK: - Actions
    @IBAction func colorSlidersChanged(_ sender: UISlider) {
        updateChosenColor()
        
        switch sender {
        case redColorSlider: updateObjects(for: .red)
        case greenColorSlider: updateObjects(for: .green)
        case blueColorSlider: updateObjects(for: .blue)
        default: break
        }
    }
    
    @IBAction func doneButtonPressed() {
        delegate.setupViewBackgroundColor(chosenColor)
        dismiss(animated: true)
    }
    
    @objc private func doneKeyAction() {
        view.endEditing(true)
    }
    
    // MARK: - Private methods
    private func getStringValue(from value: CGFloat) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        return numberFormatter.string(for: value)
    }
    
    private func updateChosenColor() {
        let red = CGFloat(redColorSlider.value)
        let green = CGFloat(greenColorSlider.value)
        let blue = CGFloat(blueColorSlider.value)
        chosenColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    private func updateObjects(for mode: UpdateMode) {
        let ciColor = CIColor(color: chosenColor)
        
        switch mode {
        case .red, .all:
            redColorLabel.text = getStringValue(from: ciColor.red)
            redColorSlider.value = Float(ciColor.red)
            redColorTextField.text = getStringValue(from: ciColor.red)
            if mode == .all { fallthrough }
        case .green:
            greenColorLabel.text = getStringValue(from: ciColor.green)
            greenColorSlider.value = Float(ciColor.green)
            greenColorTextField.text = getStringValue(from: ciColor.green)
            if mode == .all { fallthrough }
        case .blue:
            blueColorLabel.text = getStringValue(from: ciColor.blue)
            blueColorSlider.value = Float(ciColor.blue)
            blueColorTextField.text = getStringValue(from: ciColor.blue)
        }
        paintedView.backgroundColor = chosenColor
    }
    
    private func addDoneButtonOnKeyboard(for textField: UITextField) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        textField.inputAccessoryView = keyboardToolbar
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil,
                                        action: nil)
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .done,
                                         target: self,
                                         action: #selector(doneKeyAction))
        keyboardToolbar.items = [flexSpace, doneButton]
    }
}

// MARK: - TextFieldDelegate
extension ChooseColorViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        guard let value = Float(text) else { return }
        
        switch textField {
        case redColorTextField:
            redColorSlider.setValue(value, animated: true)
            colorSlidersChanged(redColorSlider)
        case greenColorTextField:
            greenColorSlider.setValue(value, animated: true)
            colorSlidersChanged(greenColorSlider)
        case blueColorTextField:
            blueColorSlider.setValue(value, animated: true)
            colorSlidersChanged(blueColorSlider)
        default: break
        }
    }
}
