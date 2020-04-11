//
//  TopicDetailViewController.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// ViewController que representa el detalle de un Topic
class TopicDetailViewController: UIViewController {

    lazy var labelTopicID: UILabel = {
        let label = UILabel()
        label.textColor = colorPurpleText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var labelTopicTitle: UILabel = {
        let label = UILabel()
        label.textColor = colorPurpleText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelTopicPostsCount: UILabel = {
        let label = UILabel()
        label.textColor = colorPurpleText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var buttonDeleteTopic: UIButton = {
        let button = UIButton()
        button.backgroundColor = colorPink
        button.setTitle("Delete", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return button
    }()

    lazy var topicIDStackView: UIStackView = {
        let labelTopicIDTitle = UILabel()
        labelTopicIDTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTopicIDTitle.text = NSLocalizedString("Topic ID: ", comment: "")
        labelTopicIDTitle.font = UIFont.boldSystemFont(ofSize: 17.0)
        labelTopicIDTitle.textColor = colorPrimary

        let topicIDStackView = UIStackView(arrangedSubviews: [labelTopicIDTitle, self.labelTopicID])
        topicIDStackView.translatesAutoresizingMaskIntoConstraints = false
        topicIDStackView.axis = .vertical
        topicIDStackView.spacing = 8
        
        return topicIDStackView
    }()

    lazy var topicNameStackView: UIStackView = {
        let labelTopicTitleTitle = UILabel()
        labelTopicTitleTitle.text = NSLocalizedString("Topic name: ", comment: "")
        labelTopicTitleTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTopicTitleTitle.font = UIFont.boldSystemFont(ofSize: 17.0)
        labelTopicTitleTitle.textColor = colorPrimary

        let topicNameStackView = UIStackView(arrangedSubviews: [labelTopicTitleTitle, self.labelTopicTitle])
        topicNameStackView.translatesAutoresizingMaskIntoConstraints = false
        topicNameStackView.axis = .vertical
        topicNameStackView.spacing = 8

        return topicNameStackView
    }()
    
    lazy var topicPostsCountStackView: UIStackView = {
        let labelTopicPostsCountTitle = UILabel()
        labelTopicPostsCountTitle.text = NSLocalizedString("Posts count: ", comment: "")
        labelTopicPostsCountTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTopicPostsCountTitle.font = UIFont.boldSystemFont(ofSize: 17.0)
        labelTopicPostsCountTitle.textColor = colorPrimary

        let topicPostsCountStackView = UIStackView(arrangedSubviews: [labelTopicPostsCountTitle, self.labelTopicPostsCount])
        topicPostsCountStackView.translatesAutoresizingMaskIntoConstraints = false
        topicPostsCountStackView.axis = .vertical
        topicPostsCountStackView.spacing = 8

        return topicPostsCountStackView
    }()
    
    lazy var deleteTopicStackView: UIStackView = {
        let deleteTopicStackView = UIStackView()
        deleteTopicStackView.addArrangedSubview(buttonDeleteTopic)
        deleteTopicStackView.translatesAutoresizingMaskIntoConstraints = false
        deleteTopicStackView.axis = .vertical
        deleteTopicStackView.spacing = 8

        return deleteTopicStackView
    }()

    let viewModel: TopicDetailViewModel

    init(viewModel: TopicDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        view.addSubview(topicIDStackView)
        NSLayoutConstraint.activate([
            topicIDStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            topicIDStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20),
            topicIDStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])

        view.addSubview(topicNameStackView)
        NSLayoutConstraint.activate([
            topicNameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            topicNameStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20),
            topicNameStackView.topAnchor.constraint(equalTo: topicIDStackView.bottomAnchor, constant: 20)
        ])
        
        view.addSubview(topicPostsCountStackView)
        NSLayoutConstraint.activate([
            topicPostsCountStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            topicPostsCountStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20),
            topicPostsCountStackView.topAnchor.constraint(equalTo: topicNameStackView.bottomAnchor, constant: 20)
        ])
        
        view.addSubview(deleteTopicStackView)
        NSLayoutConstraint.activate([
            deleteTopicStackView.heightAnchor.constraint(equalToConstant: 50),
            deleteTopicStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 80),
            deleteTopicStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -80),
            deleteTopicStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
        
        deleteTopicStackView.isHidden = true

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
    
    @objc func deleteButtonTapped(sender: UIButton!) {
        guard let topicID = self.labelTopicID.text else {return}
        showActionAlert(msg: "Do you want to delete this topic?", title: "Delete Topic", actionTitle: "Delete", actionStyle: .destructive, action: {[weak self] in
            self?.viewModel.deleteButtonTapped(topic: topicID)
        })
    }

    fileprivate func updateUI() {
        labelTopicID.text = viewModel.labelTopicIDText
        labelTopicTitle.text = viewModel.labelTopicNameText
        let postsCount = viewModel.labelTopicPostsCount ?? 0
        labelTopicPostsCount.text = "\(postsCount)"
        guard let topicCanDelete = viewModel.topicCanDelete else {return}
        self.deleteTopicStackView.isHidden = !topicCanDelete
    }
    
    fileprivate func showSuccessAddingTopicAlert() {
        let alertMessage = NSLocalizedString("Topic has been deleted correctly", comment: "")
        showAlert(alertMessage, "SUCCESS", "OK", {[weak self] in
            self?.viewModel.alertDismiss()
        })
    }
    
    fileprivate func showErrorFetchingTopicDetailAlert(error: String) {
        let alertMessage: String = NSLocalizedString("Error fetching topic details:\n'\(error)'\nPlease try again later", comment: "")
        showAlert(alertMessage, "ERROR", "OK", nil)
    }
    
    fileprivate func showErrorDeleteTopicDetailAlert(error: String) {
        let alertMessage: String = NSLocalizedString("Error fetching topic details:\n'\(error)'\nPlease try again later", comment: "")
        showAlert(alertMessage, "ERROR", "OK", nil)
    }
}

extension TopicDetailViewController: TopicDetailViewDelegate {
    func topicDetailFetched() {
        updateUI()
    }

    func errorFetchingTopicDetail(error: String) {
        showErrorFetchingTopicDetailAlert(error: error)
    }
    
    func errorDeletedTopic(error: String) {
        showErrorDeleteTopicDetailAlert(error: error)
    }
    
    func deletedSuccess() {
        showSuccessAddingTopicAlert()
    }
}
