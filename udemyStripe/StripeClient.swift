//
//  StripeClient.swift
//  udemyStripe
//
//  Created by Shannon Le on 6/3/20.
//  Copyright © 2020 Shannon Le. All rights reserved.
//

import Foundation
import Stripe
import Alamofire

class StripeClient {
    static let sharedClient = StripeClient()
    
    var baseURLString: String? = nil
    
    var baseURL: URL {
        if let urlString = self.baseURLString, let url = URL(string: urlString){
            return url
        } else {
            fatalError()
        }
    }
    
    func createAndConfirmPayment(_ token: STPToken, amount: Int, completion: @escaping (_ error: Error?) -> Void) {
        let url = self.baseURL.appendingPathComponent("charge")
        
        let params: [String: Any] = ["stripeToken": token.tokenId,
                                     "amount":amount,
                                     "description":Constants.defaultDescription,
                                     "currency": Constants.defaultCurrency]
        
        AF.request(url, method: .post, parameters: params).validate(statusCode: 200..<300).responseData { (response) in
            
            switch response.result {
            case .success( _):
                print("Payment successful")
                completion(nil)
            case .failure(let error):
                print("error processing the payment", error.localizedDescription)
                completion(error)
            }
        }
    }
}














