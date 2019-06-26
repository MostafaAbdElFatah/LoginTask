//
//  ViewController.swift
//  Task
//
//  Created by Mostafa Abd ElFatah on 6/26/19.
//  Copyright © 2019 Mostafa Abd ElFatah. All rights reserved.
//

import UIKit
import RxSwift
import JGProgressHUD

class LoginVC: UIViewController {

    
    @IBOutlet weak var emailTextField: TextFieldValidator!
    @IBOutlet weak var passTextField: TextFieldValidator!
    
    private var hud:JGProgressHUD!
    private var viewModel:LoginViewModel!
    private var email = Variable<String>("")
    private var pass =  Variable<String>("")
    var emailObservable:Observable<String>{
        return email.asObservable()
    }
    var passObservable:Observable<String>{
        return pass.asObservable()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel(view: self)
        self.config()

    }

    
    // MARK: - Login Button Action
    @IBAction func loginBtnClicked(_ sender: Any) {
        self.view.endEditing(true)
        let emailValidate = emailTextField.validate()
        let passValidate = passTextField.validate()
        
        if emailValidate && passValidate {
            hud.show(in: self.view)
            self.email.value = self.emailTextField.text ?? ""
            self.pass.value = self.passTextField.text ?? ""
            self.viewModel.Login()
        }
    }
    
    
    
}

extension LoginVC:LoginView {
    
    // MARK: - Login Respons
    func loginSuccess(name: String) {
        self.hud.dismiss()
        self.showMessage(title: "hello \(name)", message: "you login successfully")
    }
    
    func showAlert(error: String) {
        self.hud.dismiss()
        self.showMessage(title: "error", message: error)
    }
    
    
    func showMessage(title:String, message:String)  {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
}


extension LoginVC:UITextFieldDelegate{
    
    // MARK: - keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}


extension LoginVC{
    
    // MARK: - configuration
    func config()  {
        
        // LOADING PROGRESS
        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Logning"
        
        // add delate to textField
        
        self.emailTextField.delegate = self
        self.passTextField.delegate = self
        
        // add image in the left of text field
        self.emailTextField.leftViewMode = UITextField.ViewMode.always
        let emailImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let emailImage = UIImage(named: "email")
        emailImageView.image = emailImage
        emailTextField.leftView = emailImageView
        
        passTextField.leftViewMode = UITextField.ViewMode.always
        let passImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        let passImage = UIImage(named: "pass")
        passImageView.image = passImage
        passTextField.leftView = passImageView
        
        
        // add expersion to text field for valdiation
        self.emailTextField.addRegx("[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}", withMsg: "Enter valid email.")
        self.passTextField.addRegx("^.{6,20}$", withMsg: "Password characters limit should be come between 6-20")
        self.passTextField.addRegx("[A-Za-z0-9]{6,20}", withMsg: "Password must contain alpha numeric characters.")
    }
    
}
