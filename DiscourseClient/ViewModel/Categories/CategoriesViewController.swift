//
//  CategoriesViewController.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// ViewController para representar el listado de categorías
class CategoriesViewController: UIViewController {

    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")
        table.estimatedRowHeight = UITableView.automaticDimension
        table.rowHeight = UITableView.automaticDimension
        table.isUserInteractionEnabled = false
        return table
    }()
    
    let viewModel: CategoriesViewModel

    init(viewModel: CategoriesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: colorPurpleText!]
        self.navigationController?.navigationBar.tintColor = colorPurple
        
        let logoImage = UIImage.init(named: "Logo")
        let logoImageView = UIImageView.init(image: logoImage)
        logoImageView.frame = CGRect(x:0.0,y:0.0, width:35, height:35)
        logoImageView.contentMode = .scaleAspectFit
        let imageItem = UIBarButtonItem.init(customView: logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 35),
            logoImageView.heightAnchor.constraint(equalToConstant: 35)
        ])
        self.navigationItem.leftBarButtonItem =  imageItem
        self.navigationItem.leftBarButtonItem?.isEnabled = false
        
        let rightReloadButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.2.circlepath"), style: .plain, target: self, action: #selector(reloadButtonTapped))
        self.navigationItem.rightBarButtonItem = rightReloadButtonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewWasLoaded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        viewModel.viewWasLoaded()
    }
    
    @objc func reloadButtonTapped() {
        viewModel.viewWasLoaded()
    }
    
    fileprivate func showErrorFetchingCategoriesAlert(error : String) {
        let alertMessage: String = NSLocalizedString("Error fetching categories:\n'\(error)'\nPlease try again later", comment: "")
        showAlert(alertMessage, "ERROR", "OK", nil)
    }

}

extension CategoriesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as? CategoryCell,
            let cellViewModel = viewModel.viewModel(at: indexPath) {
            cell.viewModel = cellViewModel
            return cell
        }
        fatalError()
    }
}

extension CategoriesViewController: UITableViewDelegate {
    
}

extension CategoriesViewController: CategoriesViewDelegate {
    func categoriesFetched() {
        tableView.reloadData()
    }

    func errorFetchingCategories(error : String) {
        showErrorFetchingCategoriesAlert(error: error)
    }
}
