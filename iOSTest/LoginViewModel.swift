//
//  LoginViewModel.swift
//  iOSTest
//
//  Created by Prithiv Dev on 29/06/21.
//  Copyright © 2021 D&ATechnologies. All rights reserved.
//

import Foundation

class LoginViewModel: NSObject {
    
    private var client = LoginClient()
    
    func login(password:String, email:String, completionHandler: @escaping ([String:String]) -> Void)  {
        
        client.login(withEmail: email, password: password, completion: { result in
            
            completionHandler((result as? [String:String])!)
        })
        
    }
}
