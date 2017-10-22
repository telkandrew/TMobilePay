//
//  MyCartViewController.swift
//  ScanNGo
//
//  Created by Eric Townsend on 10/21/17.
//  Copyright © 2017 TrapFi. All rights reserved.
//

import UIKit
import PopupDialog

struct CartProducts {
    static var products = [Product]()
}

class MyCartViewController: UIViewController {
    
    @IBOutlet weak var emptyLabel: UIButton!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.emptyLabel.isHidden = !CartProducts.products.isEmpty
        self.tableView.tableFooterView = UIView()
        NotificationCenter.default.addObserver(self, selector: #selector(removeAllProducts), name: NSNotification.Name.init("removeAll"), object: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func back (_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func removeItemFromProducts (_ sender: UIButton) {
        CartProducts.products.remove(at: sender.tag)
        self.tableView.reloadData()
        self.emptyLabel.isHidden = !CartProducts.products.isEmpty
    }
    
    @objc func removeAllProducts() {
        CartProducts.products.removeAll()
        self.tableView.reloadData()
    }
    
    @IBAction func checkout (_ sender: UIButton) {
        // Do popupdialog
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CheckoutViewController") as! CheckoutViewController
        let popup = PopupDialog(viewController: vc)
        popup.transitionStyle = .bounceUp
        
        let overlayAppearance = PopupDialogOverlayView.appearance()
        overlayAppearance.color  = UIColor.clear
        
        self.present(popup, animated: true, completion: nil)
    }
}

class CartTableViewCell: UITableViewCell {
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productId: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension MyCartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartTableViewCell", for: indexPath) as! CartTableViewCell
        cell.productName.text = CartProducts.products[indexPath.row].productName ?? ""
        cell.productId.text = CartProducts.products[indexPath.row].productId ?? ""
        cell.productPrice.text = CartProducts.products[indexPath.row].productPrice ?? ""
        
        cell.removeButton.addTarget(self, action: #selector(removeItemFromProducts(_:)), for: .touchUpInside)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartProducts.products.count
    }
}
