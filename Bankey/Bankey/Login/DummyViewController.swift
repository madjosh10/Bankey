//
//  DummyViewController.swift
//  Bankey
//
//  Created by Josh on 3/27/23.
//

import UIKit
import Foundation

class DummyViewController: UIViewController {
    let stackView = UIStackView()
    let label = UILabel()
    
    let logoutbutton = UIButton(type: .system)
    weak var logoutDelegate: LogoutDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        
    }
    
}

extension DummyViewController {
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome"
        label.font = .preferredFont(forTextStyle: .title1)
        
        logoutbutton.translatesAutoresizingMaskIntoConstraints = false
        logoutbutton.configuration = .filled()
        logoutbutton.setTitle("Logout", for: [])
                                            // selectors are names of methods we want to execute at runtime.
        logoutbutton.addTarget(self, action: #selector(logoutButtonTapped), for: .primaryActionTriggered)
        
    }
    
    func layout() {
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(logoutbutton)
        
        view.addSubview(stackView)
        
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    // enables to interact with Objc runtime
    @objc func logoutButtonTapped(sender: UIButton) {
        logoutDelegate?.didLogout()
    }

}
