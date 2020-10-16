//
//  ViewController.swift
//  HW 2.2 - Task 1
//
//  Created by User on 16.10.2020.
//  Copyright © 2020 Evgeny. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet var paintedView: UIView!
    
    @IBOutlet var redColorLabel: UILabel!
    @IBOutlet var greenColorLabel: UILabel!
    @IBOutlet var blueColorLabel: UILabel!
    
    @IBOutlet var redColorSlider: UISlider!
    @IBOutlet var greenColorSlider: UISlider!
    @IBOutlet var blueColorSlider: UISlider!
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paintedView.layer.cornerRadius = 15

        redColorSlider.minimumTrackTintColor = .red
        greenColorSlider.minimumTrackTintColor = .green
        blueColorSlider.minimumTrackTintColor = .systemBlue
        
        redColorLabel.text = getStringValue(from: redColorSlider.value)
        greenColorLabel.text = getStringValue(from: greenColorSlider.value)
        blueColorLabel.text = getStringValue(from: blueColorSlider.value)
        paintView()
    }
    
    // MARK: - IB Actions
    @IBAction func redColorSliderChanged() {
        redColorLabel.text = getStringValue(from: redColorSlider.value)
        paintView()
    }
    
    @IBAction func greenColorSliderChanged() {
        greenColorLabel.text = getStringValue(from: greenColorSlider.value)
        paintView()
    }
    
    @IBAction func blueColorSliderChanged() {
        blueColorLabel.text = getStringValue(from: blueColorSlider.value)
        paintView()
    }
    
    // MARK: - Private methods
    private func getStringValue(from value: Float) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        return numberFormatter.string(for: value)
    }
    
    private func paintView() {
        let red = CGFloat(redColorSlider.value)
        let green = CGFloat(greenColorSlider.value)
        let blue = CGFloat(blueColorSlider.value)
        paintedView.backgroundColor = UIColor(red: red,
                                              green: green,
                                              blue: blue,
                                              alpha: 1)
    }
}

