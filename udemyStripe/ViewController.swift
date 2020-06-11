//
//  ViewController.swift
//  udemyStripe
//
//  Created by Shannon Le on 6/3/20.
//  Copyright © 2020 Shannon Le. All rights reserved.
//

import UIKit
import Stripe

let cardParams = STPCardParams()

class ViewController: STPAddCardViewController, STPPaymentCardTextFieldDelegate{

    let paymentCardTextField = STPPaymentCardTextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonPressed))
    }

        func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
            cardParams.number = textField.cardNumber
            cardParams.expMonth = textField.expirationMonth
            cardParams.expYear = textField.expirationYear
            cardParams.cvc = textField.cvc

            if cardParams.number != nil && cardParams.expMonth != nil && cardParams.expYear != nil && cardParams.cvc != nil {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(processCard))
            }
        }

    private func dismissView() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @objc private func cancelButtonPressed(){
       dismissView()
    }
    
    @objc private func processCard() {
        STPAPIClient.shared().createToken(withCard: cardParams) { (token, error) in
            if error == nil {
                self.finishPayment(token: token!)
                print("we have a token", token!)
                
            } else {
                print("Error processing card token", error!.localizedDescription)
            }
        }
    }
    
    private func finishPayment(token: STPToken) {
        let totalPrice = 1999
        
        StripeClient.sharedClient.createAndConfirmPayment(token, amount: totalPrice) { (error) in
            if error == nil {
                print("payment successful")
            } else {
                print("error ", error!.localizedDescription)
            }
        }
        
        
    }
    
}


