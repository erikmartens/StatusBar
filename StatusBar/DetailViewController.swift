//
//  ViewController2.swift
//  StatusBar
//
//  Created by  Erik Maximilian Martens on 30.06.17.
//  Copyright © 2017  Erik Maximilian Martens. All rights reserved.
//

import UIKit
import PhoneNumberKit

class DetailViewController: UIViewController {
  
  var wasPresentedWithCustomAnimation: Bool = false
  var parentNavigationController: UINavigationController!
  
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var countryTextField: UITextField!
  @IBOutlet weak var textLabel: UILabel!
  @IBOutlet weak var parseStatusLabel: UILabel!
  @IBOutlet weak var goHomeButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.barStyle = .black
    goHomeButton.isHidden = true
    
    parseStatusLabel.text = "Parse status not determined"
    textField.placeholder = "phonenumber"
    countryTextField.placeholder = "country iso code"
    
    textField.delegate = self
    countryTextField.delegate = self
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
    view.addGestureRecognizer(tap)
    
    if isModal {
      if wasPresentedWithCustomAnimation {
        goHomeButton.isHidden = false
        navigationItem.title = "PresentWithCustomAnimation"
        textLabel.text = "Present (Modal) with Custom Animation"
      } else {
        navigationItem.title = "Present"
        textLabel.text = "Present (Modal)"
      }
      
      navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
      
      navigationController?.navigationBar.tintColor = .white
      navigationController?.navigationBar.barTintColor = .blue
      
      navigationItem.rightBarButtonItem = UIBarButtonItem(title: "X".uppercased(), style: .done, target: self, action: #selector(DetailViewController.popViewController(_:)))
    } else {
      navigationItem.title = "Push"
      navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
      
      navigationController?.navigationBar.tintColor = .white
      navigationController?.navigationBar.barTintColor = .red
      
      textLabel.text = "Push (Non-Modal)"
    }
  }
  
  var isModal: Bool {
    return self.presentingViewController?.presentedViewController == self
      || (self.navigationController != nil && self.navigationController?.presentingViewController?.presentedViewController == self.navigationController)
      || self.tabBarController?.presentingViewController is UITabBarController
  }
  
  @objc func popViewController(_ sender: UIBarButtonItem) {
    navigationController!.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func goHomeButtonPressed(_ sender: UIButton) {
    parentNavigationController?.dismiss(animated: true, completion: nil)
  }
  @IBAction func parseButtonPressed(_ sender: UIButton) {
    let phoneNumberKit = PhoneNumberKit()
    do {
      guard let text = textField.text, text != "" else {
        parseStatusLabel.text = "Nothing Entered"
        parseStatusLabel.textColor = .red
        return
      }
      var phoneNumber: PhoneNumber
      if let countryCode = countryTextField.text, countryCode != "" {
        phoneNumber = try phoneNumberKit.parse(text, withRegion: countryCode)
      } else {
        phoneNumber = try phoneNumberKit.parse(text)
      }
      parseStatusLabel.text = "Parsed: \(phoneNumber.adjustedNationalNumber()), \(phoneNumber.countryCode)"
      parseStatusLabel.textColor = .green
    } catch {
      parseStatusLabel.text = error.localizedDescription
      parseStatusLabel.textColor = .red
    }
  }
  @objc private func handleTap(_ sender: UITapGestureRecognizer) {
    view.endEditing(true)
  }
}

extension DetailViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    view.endEditing(true)
    return true
  }
}
