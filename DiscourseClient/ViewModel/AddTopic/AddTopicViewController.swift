//
//  AddTopicViewController.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// ViewController representando un formulario de entrada para crear un topic
class AddTopicViewController: UIViewController {
    
    lazy var labelTopicTitle: UILabel = {
        let label = UILabel()
        label.textColor = colorPurpleText
        label.text = NSLocalizedString("Title", comment: "")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var topicTitleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .line
        textField.placeholder = NSLocalizedString("Insert topic title", comment: "")
        textField.layer.cornerRadius = 16
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        return textField
    }()
    lazy var topicTitleStackView: UIStackView = {
        let topicTitleStackView = UIStackView(arrangedSubviews: [labelTopicTitle, topicTitleTextField])
        topicTitleStackView.translatesAutoresizingMaskIntoConstraints = false
        topicTitleStackView.axis = .vertical
        topicTitleStackView.spacing = 8
        return topicTitleStackView
    }()
    
    lazy var labelTopicMsg: UILabel = {
        let label = UILabel()
        label.textColor = colorPurpleText
        label.text = NSLocalizedString("Message", comment: "")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var topicMessageTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .line
        textField.placeholder = NSLocalizedString("Insert topic message", comment: "")
        textField.layer.cornerRadius = 16
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        return textField
    }()
    
    lazy var buttonAddTopic: UIButton = {
        let submitButton = UIButton(type: .system)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitle(NSLocalizedString("Submit", comment: ""), for: .normal)
        submitButton.backgroundColor = colorPrimary
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        submitButton.layer.cornerRadius = 25
        return submitButton
    }()
    lazy var topicMsgStackView: UIStackView = {
        let topicTitleStackView = UIStackView(arrangedSubviews: [labelTopicMsg, topicMessageTextField])
        topicTitleStackView.translatesAutoresizingMaskIntoConstraints = false
        topicTitleStackView.axis = .vertical
        topicTitleStackView.spacing = 8
        return topicTitleStackView
    }()
    
    lazy var addTopicStackView: UIStackView = {
        let addTopicStackView = UIStackView()
        addTopicStackView.addArrangedSubview(buttonAddTopic)
        addTopicStackView.translatesAutoresizingMaskIntoConstraints = false
        addTopicStackView.axis = .vertical
        addTopicStackView.spacing = 8
        return addTopicStackView
    }()
    

    let viewModel: AddTopicViewModel

    init(viewModel: AddTopicViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = colorBgLight

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: colorPurpleText!]
        self.navigationController?.navigationBar.tintColor = colorPurple
        
        view.addSubview(topicTitleStackView)
        NSLayoutConstraint.activate([
            topicTitleStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            topicTitleStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            topicTitleStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
        
        view.addSubview(topicMsgStackView)
        NSLayoutConstraint.activate([
            topicMsgStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            topicMsgStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            topicMsgStackView.topAnchor.constraint(equalTo: topicTitleStackView.bottomAnchor, constant: 20)
        ])

        

        view.addSubview(addTopicStackView)
        NSLayoutConstraint.activate([
            addTopicStackView.heightAnchor.constraint(equalToConstant: 50),
            addTopicStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 80),
            addTopicStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -80),
            addTopicStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
        self.topicTitleTextField.delegate = self
        self.topicMessageTextField.delegate = self


        let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    @objc fileprivate func cancelButtonTapped() {
        viewModel.cancelButtonTapped()
    }

    @objc fileprivate func submitButtonTapped() {
        guard let text = topicTitleTextField.text, !text.isEmpty else { return }
        guard let message = topicMessageTextField.text, !text.isEmpty else { return }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = Date()
        let dateString = formatter.string(from: date)
        viewModel.submitButtonTapped(title: text, msg: message, date: dateString)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        self.topicTitleTextField.resignFirstResponder()
        self.topicMessageTextField.resignFirstResponder()
    }

    fileprivate func showErrorAddingTopicAlert(error: String) {
        let alertMessage = NSLocalizedString("Error adding topic:\n'\(error)'\nPlease try again later", comment: "")
        showAlert(alertMessage, "ERROR", "OK", nil)
    }
    
    fileprivate func showSuccessAddingTopicAlert() {
        let alertMessage = NSLocalizedString("Topic has been added correctly", comment: "")
        showAlert(alertMessage, "SUCCESS", "OK", {[weak self] in
            self?.viewModel.alertDismiss()
        })
    }
}

extension AddTopicViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ sender: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension AddTopicViewController: AddTopicViewDelegate {
    func errorAddingTopic(error: String) {
        showErrorAddingTopicAlert(error: error)
    }
    func successAddingTopic() {
        showSuccessAddingTopicAlert()
    }
}
