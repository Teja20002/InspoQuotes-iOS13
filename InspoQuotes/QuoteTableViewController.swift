//
//  QuoteTableViewController.swift
//  InspoQuotes
//
//  Created by Angela Yu on 18/08/2018.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import UIKit
import StoreKit



class QuoteTableViewController: UITableViewController, SKPaymentTransactionObserver {
   
    
    let productID = "com.TejaInspoQuotes.www.TejaPremiumQuotes"
    
    var quotesToShow = [
        "Our greatest glory is not in never falling, but in rising every time we fall. — Confucius",
        "All our dreams can come true, if we have the courage to pursue them. – Walt Disney",
        "It does not matter how slowly you go as long as you do not stop. – Confucius",
        "Everything you’ve ever wanted is on the other side of fear. — George Addair",
        "Success is not final, failure is not fatal: it is the courage to continue that counts. – Winston Churchill",
        "Hardships often prepare ordinary people for an extraordinary destiny. – C.S. Lewis"
    ]
    
    let premiumQuotes = [
        "Believe in yourself. You are braver than you think, more talented than you know, and capable of more than you imagine. ― Roy T. Bennett",
        "I learned that courage was not the absence of fear, but the triumph over it. The brave man is not he who does not feel afraid, but he who conquers that fear. – Nelson Mandela",
        "There is only one thing that makes a dream impossible to achieve: the fear of failure. ― Paulo Coelho",
        "It’s not whether you get knocked down. It’s whether you get up. – Vince Lombardi",
        "Your true success in life begins only when you make the commitment to become excellent at what you do. — Brian Tracy",
        "Believe in yourself, take on your challenges, dig deep within yourself to conquer fears. Never let anyone bring you down. You got to keep going. – Chantal Sutherland"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        SKPaymentQueue.default().add(self)

        
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        

        return quotesToShow.count + 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCell", for: indexPath)

        if indexPath.row < quotesToShow.count{
            cell.textLabel?.text = quotesToShow[indexPath.row]
            cell.textLabel?.numberOfLines = 0
        } else {
            cell.textLabel?.text = "Get More Quotes"
            cell.textLabel?.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            cell.accessoryType = .disclosureIndicator
        }

        return cell
    }
    
    // MARK: - Table view delegate source

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == quotesToShow.count {
            print("Buy Quotes Clicked")
            buyPremiumQuotes()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
   
    
    // MARK: - In-App Purchase Methods
    
    func buyPremiumQuotes() {
        
      if SKPaymentQueue.canMakePayments() {
            // can make payments
          let paymentRequest = SKMutablePayment()
          paymentRequest.productIdentifier = productID
//
//          // Print relevant properties
//          print("Payment request created:")
//          print("Product Identifier: \(paymentRequest.productIdentifier)")
//          print("Quantity: \(paymentRequest.quantity)")
//          print("Requestor: \(paymentRequest.applicationUsername ?? "None")")

          SKPaymentQueue.default().add(paymentRequest)
          
          
          
        } else {
            //cant make payments
            print("user cant make payments")
        }
    }
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        print(SKPaymentQueue())
        
        for transaction in transactions {
            if transaction.transactionState == .purchased {
                //User Payment Successful
                print("Transcation successful!")
            } else if transaction.transactionState == .failed {
                //Payment failed
                print("Transcation failed")
            }
            SKPaymentQueue.default().finishTransaction(transaction)
        }
    }

    
    @IBAction func restorePressed(_ sender: UIBarButtonItem) {
        
    }


}
