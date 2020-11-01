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
    
    private let viewCornerRadius: CGFloat = 15
    
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

        paintedView.layer.cornerRadius = viewCornerRadius
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
        let colorComponents = chosenColor.components
        guard let components = colorComponents else { return }
        
        switch mode {
        case .red, .all:
            redColorLabel.text = getStringValue(from: components.red)
            redColorSlider.value = Float(components.red)
            redColorTextField.text = getStringValue(from: components.red)
            if mode == .all { fallthrough }
        case .green:
            greenColorLabel.text = getStringValue(from: components.green)
            greenColorSlider.value = Float(components.green)
            greenColorTextField.text = getStringValue(from: components.green)
            if mode == .all { fallthrough }
        case .blue:
            blueColorLabel.text = getStringValue(from: components.blue)
            blueColorSlider.value = Float(components.blue)
            blueColorTextField.text = getStringValue(from: components.blue)
        }
        paintedView.backgroundColor = chosenColor
    }
    
    private func addDoneButtonOnKeyboard(for textField: UITextField) {
        let doneToolbar = UIToolbar(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: view.frame.width,
                                                  height: 50))
        doneToolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil,
                                        action: nil)
        let doneButton = UIBarButtonItem(title: "Done",
                                   style: .done,
                                   target: self,
                                   action: #selector(doneKeyAction))
        doneToolbar.items = [flexSpace, doneButton]
        doneToolbar.sizeToFit()
        
        textField.inputAccessoryView = doneToolbar
    }
}

// MARK: - TextFieldDelegate
extension ChooseColorViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        guard let value = Float(text) else { return }
        
        switch textField {
        case redColorTextField:
            redColorSlider.value = value
            colorSlidersChanged(redColorSlider)
        case greenColorTextField:
            greenColorSlider.value = value
            colorSlidersChanged(greenColorSlider)
        case blueColorTextField:
            blueColorSlider.value = value
            colorSlidersChanged(blueColorSlider)
        default: break
        }
    }
}

extension UIColor {
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        return getRed(&r, green: &g, blue: &b, alpha: &a) ? (r, g, b, a) : nil
    }
}
