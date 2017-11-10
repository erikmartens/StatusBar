//
//  ViewController.swift
//  StatusBar
//
//  Created by  Erik Maximilian Martens on 30.06.17.
//  Copyright © 2017  Erik Maximilian Martens. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Hello World"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .default
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.black]
        
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = .white
        
        navigationController?.view.layer.removeAllAnimations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func pushButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController2") as! DetailViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func presentButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController2") as! DetailViewController
        let navController = UINavigationController(rootViewController: viewController)
        
        navigationController?.present(navController, animated: true)
    }
    
    @IBAction func presentButtonWithCustomAnimationPressed(_ sender: UIButton) {
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        navigationController?.view.layer.add(transition, forKey: nil)
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController2") as! DetailViewController
        viewController.wasPresentedWithCustomAnimation = true
        viewController.parentNavigationController = navigationController
        viewController.view.layer.add(transition, forKey: nil)
        
        navigationController?.present(viewController, animated: true)
    }
}

