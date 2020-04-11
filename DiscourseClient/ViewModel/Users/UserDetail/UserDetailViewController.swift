//
//  UserDetailViewController.swift
//  DiscourseClient
//
//  Created by Eva Gonzalez Ferreira on 11/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// ViewController que representa el detalle de un Topic
class UserDetailViewController: UIViewController {

    lazy var labelUserID: UILabel = {
        let label = UILabel()
        label.textColor = colorPurpleText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelUserUsername: UILabel = {
        let label = UILabel()
        label.textColor = colorPurpleText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var textFieldUserName: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .line
        textField.layer.cornerRadius = 16
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.textColor = colorPurpleText
        return textField
    }()
    
    
    lazy var buttonChangeName: UIButton = {
        let button = UIButton()
        button.backgroundColor = colorPrimary
        button.setTitle("Change", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(changeNameButtonTapped), for: .touchUpInside)
        return button
    }()

    lazy var userIDStackView: UIStackView = {
        let labelUserIDTitle = UILabel()
        labelUserIDTitle.translatesAutoresizingMaskIntoConstraints = false
        labelUserIDTitle.text = NSLocalizedString("User ID: ", comment: "")
        labelUserIDTitle.textColor = colorPrimary

        let userIDStackView = UIStackView(arrangedSubviews: [labelUserIDTitle, self.labelUserID])
        userIDStackView.translatesAutoresizingMaskIntoConstraints = false
        userIDStackView.axis = .vertical
        userIDStackView.spacing = 8

        return userIDStackView
    }()
    
    lazy var userUsernameStackView: UIStackView = {
        let labelUserUsernameTitle = UILabel()
        labelUserUsernameTitle.text = NSLocalizedString("Username: ", comment: "")
        labelUserUsernameTitle.translatesAutoresizingMaskIntoConstraints = false
        labelUserUsernameTitle.textColor = colorPrimary

        let userUsernameStackView = UIStackView(arrangedSubviews: [labelUserUsernameTitle, self.labelUserUsername])
        userUsernameStackView.translatesAutoresizingMaskIntoConstraints = false
        userUsernameStackView.axis = .vertical
        userUsernameStackView.spacing = 8
        
        return userUsernameStackView
    }()
    
    lazy var userNameStackView: UIStackView = {
        let labelUserNameTitle = UILabel()
        labelUserNameTitle.translatesAutoresizingMaskIntoConstraints = false
        labelUserNameTitle.text = NSLocalizedString("Name: ", comment: "")
        labelUserNameTitle.textColor = colorPrimary

        let userNameStackView = UIStackView(arrangedSubviews: [labelUserNameTitle, self.textFieldUserName])
        userNameStackView.translatesAutoresizingMaskIntoConstraints = false
        userNameStackView.axis = .vertical
        userNameStackView.spacing = 8

        return userNameStackView
    }()
    
    
    
    lazy var changeNameStackView: UIStackView = {
        let changeNameStackView = UIStackView()
        changeNameStackView.addArrangedSubview(buttonChangeName)
        changeNameStackView.translatesAutoresizingMaskIntoConstraints = false
        changeNameStackView.axis = .horizontal

        return changeNameStackView
    }()

    let viewModel: UserDetailViewModel

    init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)

        view.addSubview(userIDStackView)
        NSLayoutConstraint.activate([
            userIDStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            userIDStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            userIDStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])

        view.addSubview(userUsernameStackView)
        NSLayoutConstraint.activate([
            userUsernameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            userUsernameStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            userUsernameStackView.topAnchor.constraint(equalTo: userIDStackView.bottomAnchor, constant: 20)
        ])
        
        view.addSubview(userNameStackView)
        NSLayoutConstraint.activate([
            userNameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            userNameStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            userNameStackView.topAnchor.constraint(equalTo: userUsernameStackView.bottomAnchor, constant: 20)
        ])
        
        view.addSubview(changeNameStackView)
        NSLayoutConstraint.activate([
            changeNameStackView.heightAnchor.constraint(equalToConstant: 50),
            changeNameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 80),
            changeNameStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -80),
            changeNameStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
        
        self.textFieldUserName.delegate = self
        
        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }

    @objc func backButtonTapped() {
        viewModel.backButtonTapped()
    }
    
    @objc func changeNameButtonTapped(sender: UIButton!) {
        guard let newName = self.textFieldUserName.text else {return}
        guard let username = self.viewModel.labelUserUsername else {return}
        showActionAlert(msg: "Do you want to change user name?", title: "Change User Name", actionTitle: "Change", actionStyle: .default, action: {[weak self] in
            self?.viewModel.submitButtonTapped(username: username, name: newName)
        })
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        self.textFieldUserName.resignFirstResponder()
    }

    fileprivate func updateUI() {
        self.labelUserID.text = viewModel.labelUserIDText
        self.labelUserUsername.text = viewModel.labelUserUsername
        self.textFieldUserName.text = viewModel.labelUserNameText
        guard let nameCanChange = viewModel.userCanEditName else {return}
        self.buttonChangeName.isEnabled = nameCanChange
        self.textFieldUserName.isEnabled = nameCanChange
    }
    
    fileprivate func showSuccessChangeNameAlert() {
        let alertMessage = NSLocalizedString("User name has been changed correctly", comment: "")
        showAlert(alertMessage, "SUCCESS", "OK", {[weak self] in
            self?.viewModel.alertDismiss()
        })
    }
    
    fileprivate func showErrorFetchingUserDetailAlert(error: String) {
        let alertMessage: String = NSLocalizedString("Error fetching user details:\n'\(error)'\nPlease try again later", comment: "")
        showAlert(alertMessage, "ERROR", "OK", nil)
    }
    
    fileprivate func showErrorChangeNameDetailAlert(error: String) {
        let alertMessage: String = NSLocalizedString("Error change user name:\n'\(error)'\nPlease try again later", comment: "")
        showAlert(alertMessage, "ERROR", "OK", nil)
    }
}

extension UserDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ sender: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension UserDetailViewController: UserDetailViewDelegate {
    func userDetailFetched() {
        updateUI()
    }

    func errorFetchingUserDetail(error: String) {
        showErrorFetchingUserDetailAlert(error: error)
    }
    
    func errorChangedUserName(error: String) {
        showErrorChangeNameDetailAlert(error: error)
    }
    
    func changedNameSuccess() {
        showSuccessChangeNameAlert()
    }
}
