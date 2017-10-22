//
//  CheckoutViewController.swift
//  ScanNGo
//
//  Created by Eric Townsend on 10/21/17.
//  Copyright © 2017 TrapFi. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back (_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func payAndCheckout (_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name.init("removeAll"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }

}
