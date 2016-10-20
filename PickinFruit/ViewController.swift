//
//  ViewController.swift
//  PickinFruit
//
//  Created by Flatiron School on 7/17/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var fruitPicker: UIPickerView!
    
    
    
    var fruitsArray = ["🍎", "🍊", "🍌", "🍐", "🍇", "🍉", "🍓", "🍒", "🍍"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.spinButton.accessibilityLabel = Constants.SPIN_BUTTON
        fruitPicker.delegate = self
        fruitPicker.dataSource = self
    }
    
    @IBAction func spinButtonTapped(_ sender: UIButton) {
        
       
        
        var selectedArray: [String] = []
        for i in 0...2 {
            let randomRow = arc4random_uniform(UInt32(fruitsArray.count))
            fruitPicker.selectRow(Int(randomRow), inComponent: i, animated: false)
            let selectedRow = fruitPicker.selectedRow(inComponent: i)
            let selectedItem = fruitsArray[selectedRow]
            selectedArray.append(selectedItem)
        }
        
        var doTheyAllMatch = false
        for (index, _) in selectedArray.enumerated() {
            if selectedArray[index] == selectedArray[0] {
                doTheyAllMatch = true
            }
            else {
                doTheyAllMatch = false
                break
            }
        }
        if doTheyAllMatch == true {
            self.resultLabel.text = "WINNER!"
            animateLabel()
        }
        else {
            
            self.resultLabel.text = "TRY AGAIN"
            animateLabel()
            
        }
        
        
    }
    
    func animateLabel() {
        
        
        self.resultLabel.alpha = 0
      
        UIView.animate(withDuration: 0.2, delay: 0.2, options: [.autoreverse], animations: {
            UIView.setAnimationRepeatCount(5.0)
            self.resultLabel.alpha = 1.0
            }) { success in
                self.resultLabel.alpha = 0
        }
        
    }

    
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 3
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return fruitsArray.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            
            return fruitsArray[row]
        }
    
    
}



// MARK: Set Up
extension ViewController {
    
    override func viewDidLayoutSubviews() {
        if self.spinButton.layer.cornerRadius == 0.0 {
            configureButton()
        }
    }
    
    func configureButton()
    {
        self.spinButton.layer.cornerRadius = 0.5 * self.spinButton.bounds.size.width
        self.spinButton.layer.borderColor = UIColor.white.cgColor
        self.spinButton.layer.borderWidth = 4.0
        self.spinButton.clipsToBounds = true
    }
    
}



