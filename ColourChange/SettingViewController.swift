//
//  ViewController.swift
//  ColourChange
//
//  Created by roman Khilchenko on 04.08.2022.
//

import UIKit

class SettingViewController: UIViewController {
    
    //MARK: - @IBOutlet Properties
    @IBOutlet var colorWindow: UIView!
    
    @IBOutlet var redStaticLabel: UILabel!
    @IBOutlet var greenStaticLabel: UILabel!
    @IBOutlet var blueStaticLabel: UILabel!
    
    @IBOutlet var redRangeLabel: UILabel!
    @IBOutlet var greenRangeLabel: UILabel!
    @IBOutlet var blueRangeLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    @IBOutlet var toolBar: UIToolbar!
    
    //MARK: - Public Property
    var delegate: SettingViewControllerDelegate!
    
    var colorValue: UIColor!

    
    //MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWindowView()
        setupStaticLabel()
        setupRangeLabel()
        setupSlider()
        setupColour()
        setupTextField()
        hideKeyboardTappedAround()
        colorWindow.backgroundColor = colorValue
        
    }

    
    //MARK: - @IBAction Functions
    @IBAction func redSliderAction() {
        colorWindow.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                              green: CGFloat(greenSlider.value),
                                              blue: CGFloat(blueSlider.value), alpha: 1)
        redRangeLabel.text = String(Float(round(redSlider.value * 100) / 100))
        redTextField.text = redRangeLabel.text
    }
    
    @IBAction func greenSliderAction() {
        colorWindow.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                              green: CGFloat(greenSlider.value),
                                              blue: CGFloat(blueSlider.value), alpha: 1)
        greenRangeLabel.text = String(Float(round(greenSlider.value * 100) / 100))
        greenTextField.text = greenRangeLabel.text
        
    }
    
    @IBAction func blueSliderAction() {
        colorWindow.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                              green: CGFloat(greenSlider.value),
                                              blue: CGFloat(blueSlider.value), alpha: 1)
        blueRangeLabel.text = String(Float(round(blueSlider.value * 100) / 100))
        blueTextField.text = blueRangeLabel.text
    }
    
    
    @IBAction func doneButtonAction() {
        delegate.setColor(colorWindow.backgroundColor)
        dismiss(animated: true)
    }
    
    
    @IBAction func toolBarButtonAction(_ sender: UIBarButtonItem) {
        let textFields = [redTextField, greenTextField, blueTextField]
        textFields.forEach { textField in
            textField?.resignFirstResponder()
        }
    }
    
    //MARK: - Private Functions
    private func setupWindowView() {
        colorWindow.layer.cornerRadius = 20
        
    }
    
    private func setupStaticLabel()  {
        let staticLabels = [redStaticLabel, greenStaticLabel, blueStaticLabel]
        let nameLabels = ["Red:", "Green:", "Blue:"]
        for (index, staticLabel) in staticLabels.enumerated() {
            if let staticLabel = staticLabel {
                staticLabel.text = nameLabels[index]
                staticLabel.textColor = .white
                
            }
        }
    }
    
    private func setupRangeLabel() {
        let rangeLabels = [redRangeLabel, greenRangeLabel, blueRangeLabel]
        for rangeLabel in rangeLabels {
            if let rangeLabel = rangeLabel {
                rangeLabel.text = String(redSlider.value)
                rangeLabel.textColor = .white
            }
            
        }
    }
    
    private func setupSlider() {
        let sliders = [redSlider, greenSlider, blueSlider]
        let colours: [UIColor] = [.red, .green, .blue]
        for (index, slider) in sliders.enumerated() {
            if let slider = slider {
                slider.minimumTrackTintColor = colours[index]
            }
        }
    }
    
    private func setupTextField() {
        let textFields = [redTextField, greenTextField, blueTextField]
        textFields.forEach { textField in
            textField?.delegate = self
            textField?.inputAccessoryView = toolBar
            textField?.keyboardType = .decimalPad
        }
    }
}


//MARK: - Extension Functions
extension SettingViewController {
    private func setupColour() {
        colorWindow.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                              green: CGFloat(greenSlider.value),
                                              blue: CGFloat(blueSlider.value), alpha: 1)
    }
}

extension SettingViewController {
    private func hideKeyboardTappedAround() {
        let press: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        press.cancelsTouchesInView = false
        view.addGestureRecognizer(press)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension SettingViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        guard let newValueTF = Float(newValue) else {return}
        guard newValueTF <= 1.0 else {
            setupAlertController(title: "Wrong format!", message: "Please enter correct value")
            textField.text = ""
            return
        }
        switch textField {
        case redTextField:
            redSlider.value = newValueTF
            redRangeLabel.text = redTextField.text
            setupColour()
        case greenTextField:
            greenSlider.value = newValueTF
            greenRangeLabel.text = greenTextField.text
            setupColour()
        default:
            blueSlider.value = newValueTF
            blueRangeLabel.text = blueTextField.text
            setupColour()
        }
    }
}


extension SettingViewController {
    private func setupAlertController(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}
