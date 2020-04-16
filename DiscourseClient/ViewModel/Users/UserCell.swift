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
    
    /*
     Aunque hacer la descarga en el didSet está bien, ten en cuenta que este didSet se llama cada vez
     que UIKit llama a cellForRowAtIndexPath. Por tanto, la descarga la estamos haciendo cada vez.
     Propondría como mejora, hacer la descarga en el init de UserCellViewModel (que sólo se llama una vez),
     de forma que sólo la hacemos una vez al construirlo, y luego desde la celda le podemos pedir o bien el Data para
     construir la imagen, o bien la imagen directamente (aunque esto último hace que el VM dependa de UIKit y esto
     no es 100% correcto -> aunque yo muchas veces lo haga 😅)
     */
    var viewModel: UserCellViewModel? {
        didSet {
            imageUserOutlet.layer.cornerRadius = 28
            guard let viewModel = viewModel else { return }
            nameUserOutlet?.text = viewModel.user.user.name
            usernameUserOutlet?.text = viewModel.user.user.username
            DispatchQueue.global(qos: .userInteractive).async {
                let url = URL(string: viewModel.getURLAvatar());
                do {
                    /*
                     Cuidado con los force unwrap (!) que nos llevan a posibles casques
                     */
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
