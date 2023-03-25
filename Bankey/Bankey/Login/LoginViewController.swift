//
//  ViewController.swift
//  Bankey
//
//  Created by Josh on 3/23/23.
//

import UIKit

// MARK: - LoginViewController
class LoginViewController: UIViewController {
    
    // front end
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    let titleLabel = UILabel()
    let messageLabel = UILabel()
    
    // username and password input vars
    var username: String? {
        return loginView.usernameTextField.text
    }
    var password: String? {
        return loginView.passwordTextField.text
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        style()
        layout()
    }


}
// MARK: - Style and Layout
extension LoginViewController {

    /*
        when working with custom views and auto layout, always make translatesAutoresizingMaskIntoConstraints = false
        what takes any control or element of view in your view controller and makes it ready for auto layout
     */
    
    private func style() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        //define the distance between the image and the text
        signInButton.configuration?.imagePadding = 8
        signInButton.setTitle("Sign In", for: [])
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.isHidden = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.textColor = .systemMint
        titleLabel.font = .systemFont(ofSize: 40)
        titleLabel.numberOfLines = 0
        titleLabel.text = "Bankey"
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textAlignment = .center
        messageLabel.textColor = .systemMint
        messageLabel.numberOfLines = 0
        messageLabel.text = "Your premium Bank!"
        
        
    }
    
    private func layout() {
        view.addSubview(titleLabel)
        view.addSubview(messageLabel)
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        
        // sets isActive to true for all contsraints contained within
        // LoginView
        NSLayoutConstraint.activate([
            /*
                going to appear middle of page by anchoring with centerYAnchor
                how to pin left and right or leading and trailing sides
                1x = 8pts
                going to flip the order of the words, since its the trailingAnchor
                the views trailing will come after the loginviews trailingAnchor
            */
//            messageLabel.bottomAnchor.constraint(equalToSystemSpacingBelow: loginView.topAnchor, multiplier: 2),
//            messageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
//            messageLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
//
            
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
            
        ])
        
        NSLayoutConstraint.activate([
            // button
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            
            //error
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalTo: signInButton.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: signInButton.trailingAnchor)
            
            
        ])
        
    }
    
}
// MARK: - Login()
extension LoginViewController {
    @objc func signInTapped(sender: UIButton) {
        errorMessageLabel.isHidden = true
        login()
        
    }
    
    private func login() {
        
        // using guard let to unwrap the optional strings into strings
        guard let username = username, let password = password else {
            /*
                shows that the internel check has failed
                dev assertions that only appears in debug builds gets compiled out in prod builds
             */
            assertionFailure("Username / password shouldnt be nil")
            return
        }
        
        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Username / password cannot be blank")
            return
        }
        
        
        if username == "Kevin" && password == "Welcome" {
            signInButton.configuration?.showsActivityIndicator = true
        } else {
            configureView(withMessage: "Incorrect username / password")
        }
        
    } // end login()
    
    /*
        using method to display error message with the errormessagelabel
     */
    private func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
    
}