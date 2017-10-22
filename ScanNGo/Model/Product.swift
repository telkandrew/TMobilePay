//
//  Product.swift
//  ScanNGo
//
//  Created by Eric Townsend on 10/21/17.
//  Copyright © 2017 TrapFi. All rights reserved.
//

import Foundation
import ObjectMapper

class Product: NSObject, Mappable {
    
    var productId: String?
    var productName: String?
    var productImage: String?
    var productPrice: String?
    var productDescription: String?
    
    private var _productId: String? {
        didSet {
            guard _productId != nil else { return }
            productId = self._productId
        }
    }
    private var _productName: String? {
        didSet {
            guard _productName != nil else { return }
            productName = self._productName
        }
    }
    private var _productImage: String? {
        didSet {
            guard _productImage != nil else { return }
            productImage = self._productImage
        }
    }
    private var _productPrice: String? {
        didSet {
            guard _productPrice != nil else { return }
            productPrice = self._productPrice
        }
    }
    private var _productDescription: String? {
        didSet {
            guard _productDescription != nil else { return }
            productDescription = self._productDescription
        }
    }
    
    required init?(map: Map) {}
    
    override init() {
        super.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        
        productId <- map["ItemLookupResponse.Items.Item.ItemAttributes.UPC"]
        productName <- map["ItemLookupResponse.Items.Item.ItemAttributes.Title"]
        productImage <- map["ItemLookupResponse.Items.Item.LargeImage.URL"]
        productPrice <- map["ItemLookupResponse.Items.Item.ItemAttributes.ListPrice.FormattedPrice"]
        productDescription <- map["ItemLookupResponse.Items.Item.EditorialReviews.EditorialReview.Content"]
        
        _productId <- map["ItemLookupResponse.Items.Item.0.ItemAttributes.UPC"]
        _productName <- map["ItemLookupResponse.Items.Item.0.ItemAttributes.Title"]
        _productImage <- map["ItemLookupResponse.Items.Item.0.LargeImage.URL"]
        _productPrice <- map["ItemLookupResponse.Items.Item.0.ItemAttributes.ListPrice.FormattedPrice"]
        _productDescription <- map["ItemLookupResponse.Items.Item.0.EditorialReviews.EditorialReview.Content"]
    }
}
