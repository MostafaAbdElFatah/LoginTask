//
//  LoginViewModel.swift
//  Task
//
//  Created by Mostafa Abd ElFatah on 6/26/19.
//  Copyright © 2019 Mostafa Abd ElFatah. All rights reserved.
//

import Foundation
import RxSwift


protocol LoginView {
    func loginSuccess(name:String)
    func showAlert(error:String)
}

class LoginViewModel:FetchUserDataDelegate {
   
    
    private var email:String!
    private var pass:String!
    private var view:LoginVC!
    private let disposeBag = DisposeBag()

    
    init(view:LoginVC) {
        self.view = view
        //self.loginView = view
        self.view.emailObservable.subscribe { (email) in
            self.email = email.element
        }
        self.view.passObservable.subscribe { (pass) in
            self.pass = pass.element
        }
    }
    
    func Login() {
        var params:[String:String] = [:]
        params["email"] = self.email
        params["password"] = self.pass
        APIManager.sharedInstance.loginUser(params: params, responseDelegate: self)
    }
    
    
    func complete(response: Auth) {
        if response.success{
            self.view.loginSuccess(name: response.data.firstName)
        }else{
            self.view.showAlert(error: response.message)
        }
    }
    
    func failed(error: String) {
        self.view.showAlert(error: error)
    }
    
}
