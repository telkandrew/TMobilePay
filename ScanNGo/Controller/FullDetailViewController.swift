//
//  FullDetailViewController.swift
//  ScanNGo
//
//  Created by Eric Townsend on 10/21/17.
//  Copyright © 2017 TrapFi. All rights reserved.
//

import UIKit
import SDWebImage

class FullDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var product = Product()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addToCart(_ sender: UIButton) {
        CartProducts.products.append(product)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func back (_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}

class FullDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var productTite: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension FullDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var identifer: String! = ""
        
        switch indexPath.row {
        case 0:
            identifer = "fullDetailTableViewCell"
        case 1:
            identifer = "fullDetailTableViewCell1"
        case 2:
            identifer = "fullDetailTableViewCell2"
        default:
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifer, for: indexPath) as! FullDetailTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.mainImage.sd_setImage(with: URL(string: product.productImage ?? ""), completed: nil)
        case 1:
            cell.productTite.text = product.productName ?? ""
            cell.productPrice.text = product.productPrice ?? ""
        case 2:
            cell.productDescription.text = product.productDescription ?? ""
        default:
            return cell
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 300.0
        case 1:
            return UITableViewAutomaticDimension
        case 2:
            return UITableViewAutomaticDimension
        default:
            return UITableViewAutomaticDimension
        }
    }
}
