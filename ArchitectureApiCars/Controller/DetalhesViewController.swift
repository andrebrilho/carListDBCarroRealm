//
//  DetalhesViewController.swift
//  ArchitectureApiCars
//
//  Created by André Brilho on 04/03/19.
//  Copyright © 2019 André Brilho. All rights reserved.
//

import Foundation
import AlamofireImage

class DetalhesViewController:UIViewController {
    
    @IBOutlet weak var imgCarro: UIImageView!
    @IBOutlet weak var lblNomeCarro: UILabel!
    @IBOutlet weak var actIndicator: UIActivityIndicatorView!
    @IBOutlet weak var txtDesc: UITextView!
    var carro:Carro!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblNomeCarro.text = carro.nome
        txtDesc.text = carro.desc
        imgCarro.af_setImage(withURL: URL(string:carro.url_foto)!, filter: AspectScaledToFitSizeFilter(size: imgCarro.frame.size), imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: true, completion: { (_) in
            self.actIndicator.stopAnimating()
        }
        )}
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true)
    }
}
