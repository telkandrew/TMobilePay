//
//  Networking.swift
//  ScanNGo
//
//  Created by Eric Townsend on 10/21/17.
//  Copyright © 2017 TrapFi. All rights reserved.
//

import Foundation
import Alamofire

class Networking {
    
    let baseURL: String = "http://scanngoapp.mvkku7wt78.us-east-1.elasticbeanstalk.com/products?id="
    
    func getItemFromUPC(code: String, completionHandler: @escaping (Product?, Error?) -> ())  {
        let finalURL = baseURL + code.characters.dropFirst()
        
        Alamofire.request(finalURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case .success(_):
                print(response.result.value.debugDescription)
                let product = Product(JSON: response.result.value as! [String:Any])!
                completionHandler(product, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}
