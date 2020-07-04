//
//  ViewController.swift
//  PayTabsAssignment
//  Created by N, Azik Abdullah (Cognizant) on 03/07/20.
//  Copyright © 2020 N, Azik Abdullah (Cognizant). All rights reserved.
//
import UIKit
let kDefaultCurrency = "USD"
class ViewController: UIViewController {

    var initialSetupViewController: PTFWInitialSetupViewController!
    @IBOutlet weak var checkoutScrollView:UIScrollView!
    @IBOutlet weak var customerNameTextField: UITextField!
    @IBOutlet weak var customerEmailTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var orderIDTextField: UITextField!
    @IBOutlet weak var shippingAddressTextField: UITextField!
    @IBOutlet weak var shippingCityTextField: UITextField!
    @IBOutlet weak var shippingStateTextField: UITextField!
    @IBOutlet weak var shippingCountryTextField: UITextField!
    @IBOutlet weak var shippingZipCodeTextField: UITextField!
    @IBOutlet weak var bilingAddressTextField: UITextField!
    @IBOutlet weak var billingCityTextField: UITextField!
    @IBOutlet weak var billingStateTextField: UITextField!
    @IBOutlet weak var billingCountryTextField: UITextField!
    @IBOutlet weak var billingZipCodeTextField: UITextField!
    @IBOutlet weak var customerMobileNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "PayTabs"
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        checkoutScrollView.updateContentView()
    }

    @IBAction func setOnClickPay(_ sender: Any) {
        let validationResult = self.validateAllInputs()
        if validationResult != "valid" {
            showAlert(message: validationResult)
            return
        }
        setUpPayment()
    }
    
    
    func setUpPayment() {

        let bundle = Bundle(url: Bundle.main.url(forResource: "Resources", withExtension: "bundle")!)
        let enteredAmount:String = amountTextField.text ?? ""
        guard let floatAmount = Float(enteredAmount) else {
            return
        }
        self.initialSetupViewController = PTFWInitialSetupViewController.init(
            bundle: bundle,
            andWithViewFrame: self.view.frame,
            andWithAmount: 51.0,
            andWithCustomerTitle: customerNameTextField.text ?? "",
            andWithCurrencyCode: kDefaultCurrency,
            andWithTaxAmount: floatAmount,
            andWithSDKLanguage: "en",
            andWithShippingAddress: shippingAddressTextField.text ?? "",
            andWithShippingCity: shippingCityTextField.text ?? "",
            andWithShippingCountry: shippingCountryTextField.text ?? "",
            andWithShippingState: shippingStateTextField.text ?? "",
            andWithShippingZIPCode: shippingZipCodeTextField.text ?? "",
            andWithBillingAddress: bilingAddressTextField.text ?? "",
            andWithBillingCity: billingCityTextField.text ?? "",
            andWithBillingCountry: billingCountryTextField.text ?? "",
            andWithBillingState: billingStateTextField.text ?? "",
            andWithBillingZIPCode: billingZipCodeTextField.text ?? "",
            andWithOrderID: orderIDTextField.text ?? "",
            andWithPhoneNumber: customerMobileNumberTextField.text ?? "",
            andWithCustomerEmail: customerEmailTextField.text ?? "",
            andIsTokenization:false,
            andIsPreAuth: false,
            andWithMerchantEmail: "abdullah.be@gmail.com",
            andWithMerchantSecretKey: "ifsfzOsmIAmIniZsTaY3VMMugKmkB7RTmk9V8BiRbEzyXy1RJ0UFNH93rwn3DfXZA6VJIdATSasQIuHsuC8hjhkLOIPsYMsySnhA",
            andWithAssigneeCode: "SDK",
            andWithThemeColor:UIColor.red,
            andIsThemeColorLight: false)


        self.initialSetupViewController.didReceiveBackButtonCallback = {

        }

        self.initialSetupViewController.didStartPreparePaymentPage = {
            // Start Prepare Payment Page
            // Show loading indicator
        }
        self.initialSetupViewController.didFinishPreparePaymentPage = {
            // Finish Prepare Payment Page
            // Stop loading indicator
        }

        self.initialSetupViewController.didReceiveFinishTransactionCallback = {(responseCode, result, transactionID, tokenizedCustomerEmail, tokenizedCustomerPassword, token, transactionState) in
            print("Response Code: \(responseCode)")
            print("Response Result: \(result)")
            self.showAlert(message: result)
        }

        self.view.addSubview(initialSetupViewController.view)
        self.addChild(initialSetupViewController)

        initialSetupViewController.didMove(toParent: self)
    }
}

extension UIScrollView {
    func updateContentView() {
        contentSize.height = subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last?.frame.maxY ?? contentSize.height
    }
}
