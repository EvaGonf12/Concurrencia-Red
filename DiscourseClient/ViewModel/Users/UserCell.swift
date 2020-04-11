//
//  UserCell.swift
//  DiscourseClient
//
//  Created by Eva Gonzalez Ferreira on 11/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UserCell : UITableViewCell {
    
    
    @IBOutlet weak var imageUserOutlet: UIImageView!
    
    @IBOutlet weak var nameUserOutlet: UILabel!
    @IBOutlet weak var usernameUserOutlet: UILabel!
    
    
    var viewModel: UserCellViewModel? {
        didSet {
            imageUserOutlet.layer.cornerRadius = 28
            guard let viewModel = viewModel else { return }
            nameUserOutlet?.text = viewModel.user.user.name
            usernameUserOutlet?.text = viewModel.user.user.username
            DispatchQueue.global(qos: .userInteractive).async {
                let url = URL(string: viewModel.getURLAvatar());
                do {
                    let imageData : Data = try Data.init(contentsOf: url!)
                    let bgImage = UIImage(data: imageData)
                    DispatchQueue.main.async {[weak self] in
                        self?.imageUserOutlet.image = bgImage
                    }
                } catch {}
            }
        }
    }
    
}
