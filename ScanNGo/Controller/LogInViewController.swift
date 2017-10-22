//
//  LogInViewController.swift
//  ScanNGo
//
//  Created by Eric Townsend on 10/21/17.
//  Copyright © 2017 TrapFi. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goToScanner(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainNav") as! UINavigationController
        self.present(vc, animated: true, completion: nil)
    }
    
}
