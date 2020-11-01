//
//  StartViewController.swift
//  HW 2.2 - Task 1
//
//  Created by User on 01.11.2020.
//  Copyright © 2020 Evgeny. All rights reserved.
//

import UIKit

protocol StartViewControllerDelegate {
    func setupViewBackgroundColor(_ color: UIColor)
}

class StartViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let chooseColorCV = segue.destination as! ChooseColorViewController
        chooseColorCV.delegate = self
        chooseColorCV.chosenColor = view.backgroundColor
    }
}

extension StartViewController: StartViewControllerDelegate {
    func setupViewBackgroundColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
