//
//  ViewController2.swift
//  StatusBar
//
//  Created by  Erik Maximilian Martens on 30.06.17.
//  Copyright © 2017  Erik Maximilian Martens. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var wasPresentedWithCustomAnimation: Bool = false
    var parentNavigationController: UINavigationController!
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var goHomeButton: UIButton!
    
//    override var childViewControllerForStatusBarStyle: UIViewController? {
//        return self.presentingViewController?.presentedViewController
//    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        get {
//            if isModal {
//                return .lightContent
//            } else {
//                return .default
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .black
        goHomeButton.isHidden = true
        
        if isModal {
            if wasPresentedWithCustomAnimation {
                goHomeButton.isHidden = false
                navigationItem.title = "PresentWithCustomAnimation"
                 textLabel.text = "Hello Present (Modal) with Custom Animation"
            } else {
                navigationItem.title = "Present"
                 textLabel.text = "Hello Present (Modal)"
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
            
            textLabel.text = "Hello Push (Non-Modal)"
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
}
