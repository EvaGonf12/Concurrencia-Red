//
//  CategoryCell.swift
//  DiscourseClient
//
//  Created by Eva Gonzalez Ferreira on 10/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// Celda que representa un topic en la lista
class CategoryCell: UITableViewCell {
    
    
    @IBOutlet weak var titleNameOutlet: UILabel!
    @IBOutlet weak var textNameOutlet: UILabel!
    @IBOutlet weak var textDescriptionOutlet: UILabel!
    
    var viewModel: CategoryCellViewModel? {
        didSet {
            DispatchQueue.main.async {[weak self] in
                self?.titleNameOutlet.text = NSLocalizedString("Title:", comment: "")
                self?.textNameOutlet.text = self?.viewModel?.category.name
                self?.textDescriptionOutlet.text = self?.viewModel?.category.description
            }
        }
    }
    
}
