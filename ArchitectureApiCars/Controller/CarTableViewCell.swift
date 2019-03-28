//
//  CarTableViewCell.swift
//  ArchitectureApiCars
//
//  Created by André Brilho on 20/02/2019.
//  Copyright © 2019 André Brilho. All rights reserved.
//

import UIKit
import AlamofireImage

class CarTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgCar: UIImageView!
    @IBOutlet weak var lblNameCar: UILabel!
    @IBOutlet weak var actIndicator: UIActivityIndicatorView!
    
    
    var carro:Carro?{
        didSet{
            configureCell()
        }
    }
    
    func configureCell(){
        lblNameCar.text = carro?.nome
        imgCar.image = nil
        imgCar.af_cancelImageRequest()
        actIndicator.startAnimating()
        imgCar.af_setImage(withURL: URL(string:((carro?.url_foto))!)!, filter: AspectScaledToFitSizeFilter(size: CGSize(width: self.imgCar.frame.width, height: self.imgCar.frame.height)), imageTransition: .crossDissolve(0.3), runImageTransitionIfCached: true, completion: { (_) in
            self.actIndicator.stopAnimating()
        })
    }
}
