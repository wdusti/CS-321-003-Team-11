//
//  HomeScreen.swift
//  GMUBooking
//
//  Created by Emil Natour on 3/22/22.
//

import UIKit

class HomeScreen: UIViewController {

    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var usernameError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetFields()
    }
    
    func resetFields(){
        loginButton.isEnabled = false
        
        usernameError.isHidden = false
        passwordError.isHidden = false
        
        usernameError.text = "Required"
        passwordError.text = "Required"
        
        usernameTF.text = ""
        passwordTF.text = ""
    }
    
    @IBAction func usernameChanged(_ sender: Any) {
        if let username = usernameTF.text{
            if let errorMessage = invalidUsername(username){
                usernameError.text = errorMessage
                usernameError.isHidden = false
            }
            else{
                usernameError.isHidden = true
            }
        }
        checkForValidForm()
    }
    
    func invalidUsername(_ value: String) -> String?{
        let regularExpression = "[A-Z0-9a-z._%+-]+@[gmu]{3}+\\.[edu]{3}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        if !predicate.evaluate(with: value){
            return "Invalid Username, must be GMU email!"
        }
        return nil
    }
    
    @IBAction func passwordChanged(_ sender: Any) {
        if let password = passwordTF.text{
            if let errorMessage = invalidPassword(password){
                passwordError.text = errorMessage
                passwordError.isHidden = false
            }
            else{
                passwordError.isHidden = true
            }
        }
        checkForValidForm()
    }
    
    func invalidPassword(_ value: String) -> String?{
        if value.count < 7{
            return "Password must be at least 7 characters"
        }
        return nil
    }
    
    func checkForValidForm(){
        if usernameError.isHidden && passwordError.isHidden{
            loginButton.isEnabled = true
        }
        else{
            loginButton.isEnabled = false
        }
    }
    
    @IBAction func loginAction(_ sender: Any) {
        resetFields()
    }
}

