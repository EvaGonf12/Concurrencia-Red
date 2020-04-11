//
//  TopicCell.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// Celda que representa un topic en la lista
class TopicCell: UITableViewCell {
    
    
    @IBOutlet weak var userImageOutlet: UIImageView!
    @IBOutlet weak var titleOutlet: UILabel!
    
    var viewModel: TopicCellViewModel? {
        didSet {
            userImageOutlet.layer.cornerRadius = 28
            guard let viewModel = viewModel else { return }
            titleOutlet?.text = viewModel.topic.title
            DispatchQueue.global(qos: .userInteractive).async {
                let url = URL(string: viewModel.getURLAvatar());
                do {
                    let imageData : Data = try Data.init(contentsOf: url!)
                    let bgImage = UIImage(data: imageData)
                    DispatchQueue.main.async {[weak self] in
                        self?.userImageOutlet.image = bgImage
                    }
                } catch {}
            }
        }
    }
    
}
