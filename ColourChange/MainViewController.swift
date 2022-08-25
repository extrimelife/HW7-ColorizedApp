//
//  MainViewController.swift
//  AppColourChange
//
//  Created by roman Khilchenko on 23.08.2022.
//

import UIKit

protocol SettingViewControllerDelegate {
    func setColor(_ color: UIColor?)
}

class MainViewController: UIViewController {
    
    //MARK: - IBOutlet Properties
    @IBOutlet var rightBarButton: UIBarButtonItem!
    
   
    
    //MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarButton()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingVc = segue.destination as? SettingViewController else { return }
        settingVc.colorValue = view.backgroundColor
        settingVc.delegate = self
        
    }
    
    
    //MARK: - @IBAction Finctions
    @IBAction func rightBarButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "SettingVc", sender: self)
    }
    
    //MARK: - Private Functions
    private func setupBarButton() {
        view.backgroundColor = .white
        rightBarButton.image = UIImage(systemName: "square.and.pencil")
    }
    
}

//MARK: - Extention Functions
extension MainViewController: SettingViewControllerDelegate {
    func setColor(_ color: UIColor?) {
        view.backgroundColor = color
    }
}
