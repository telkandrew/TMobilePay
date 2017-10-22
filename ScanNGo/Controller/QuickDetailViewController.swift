//
//  QuickDetailViewController.swift
//  ScanNGo
//
//  Created by Eric Townsend on 10/21/17.
//  Copyright © 2017 TrapFi. All rights reserved.
//

import UIKit
import SDWebImage

class QuickDetailViewController: UIViewController {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!

    var product = Product()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard product.productName != nil else {
            self.goBack(UIButton())
            return
        }
        
        productNameLabel.text = product.productName ?? ""
        productPriceLabel.text = product.productPrice ?? ""
        productImageView.sd_setImage(with: URL(string: product.productImage ?? ""), completed: nil)
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {
            NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "startSession"), object: nil)
        })
    }
    
    @IBAction func readMore(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {
            NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "showProduct"), object: nil)
        })
    }

}
