//
//  HomeViewController.swift
//  ScanNGo
//
//  Created by Eric Townsend on 10/21/17.
//  Copyright © 2017 TrapFi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewRightConstraint: NSLayoutConstraint!
    
    var menuIcons: [UIImage] = [#imageLiteral(resourceName: "home-icon"), #imageLiteral(resourceName: "scan-n-go-icon"), #imageLiteral(resourceName: "alerts-icon"), #imageLiteral(resourceName: "billing-info"), #imageLiteral(resourceName: "usage-details-icon"),#imageLiteral(resourceName: "account-icon"), #imageLiteral(resourceName: "shop-icon"), #imageLiteral(resourceName: "location-icon"), #imageLiteral(resourceName: "settings-icon"), #imageLiteral(resourceName: "help-icon"),#imageLiteral(resourceName: "info-icon")]
    var menuTitles : [String] = ["HOME", "SCAN N' GO", "ALERTS", "BILLING & PAYMENTS",
                                 "USAGE & PLANS", "PROFILE SETTINGS", "CART",
                                 "STORE LOCATOR", "APP SETTINGS", "HELP", "ABOUT"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableViewRightConstraint.constant = self.view.frame.width
        self.view.layoutSubviews()
        self.tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showCart() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyCartViewController") as! MyCartViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToBarCodeScanner() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BarcodeViewController") as! BarcodeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func openSlideOutMenu() {
        UIView.animate(withDuration: 0.4, animations: {
            self.tableViewRightConstraint.constant = 140.0
            self.view.layoutSubviews()
        })
    }
    
    @objc func closeSlideOutMenu() {
        UIView.animate(withDuration: 0.4, animations: {
            self.tableViewRightConstraint.constant = self.view.frame.width
            self.view.layoutSubviews()
        })
    }

}

class MenuTableViewCell: UITableViewCell {
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuTableViewCell", for: indexPath) as! MenuTableViewCell
        cell.itemName.text = menuTitles[indexPath.row]
        cell.itemImage.image = menuIcons[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            self.closeSlideOutMenu()
            self.goToBarCodeScanner()
        } else if indexPath.row == 6 {
            self.closeSlideOutMenu()
            self.showCart()
        }
    }
}
