//
//  LoginViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class LoginViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Take email and password input from the user
     *
     * 3) Use the endpoint and paramters provided in LoginClient.m to perform the log in
     *
     * 4) Calculate how long the API call took in milliseconds
     *
     * 5) If the response is an error display the error in a UIAlertController
     *
     * 6) If the response is successful display the success message AND how long the API call took in milliseconds in a UIAlertController
     *
     * 7) When login is successful, tapping 'OK' in the UIAlertController should bring you back to the main menu.
     **/
    
    // MARK: - Properties
    private var client: LoginClient?
    
    ///the view model that calls uses the Backend funcs
    private var loginViewModel = LoginViewModel()
    
    ///api call result
    var mainAPIResult = [String:String]()
    
    
    ///textfields
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    @IBAction func backAction(_ sender: Any) {
        let mainMenuViewController = MenuViewController()
        self.navigationController?.pushViewController(mainMenuViewController, animated: true)
    }
    
    @IBAction func didPressLoginButton(_ sender: Any) {
        
        ///make sure ther is actually text
        if !passwordTextField.text!.isEmpty && !emailTextField.text!.isEmpty {
            let startDate = Date()
            
            self.loginViewModel.login(password: passwordTextField.text!, email: emailTextField.text!, completionHandler: { result in
                
                self.mainAPIResult = result
                self.mainAPIResult["time"] = String(Date().timeIntervalSince(startDate))
               
                
                DispatchQueue.main.async {
                self.processAPICall(apicall: self.mainAPIResult)
                }
                print(self.mainAPIResult)
                
                
            })
            
        }
        
        
    }
    
    
    
    
    func processAPICall(apicall:[String:String])  {
        
        if apicall["sucess"] == "Yes"{
            let alert = UIAlertController(title: "Sucess", message: "Login Successful!\nTime Taken:\( apicall["time"]!)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    let mainMenuViewController = MenuViewController()
                    self.navigationController?.pushViewController(mainMenuViewController, animated: true)
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                @unknown default:
                    print("unkown")
                }
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
        
        
        
        if !(apicall["sucess"] == "Yes"){
            
            
            let alert = UIAlertController(title: "Error", message: "\(apicall["error"]!)\nTime Taken:\(apicall["time"]!)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("do nothing")
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                @unknown default:
                    print("unkown")
                }
            }))
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
}


