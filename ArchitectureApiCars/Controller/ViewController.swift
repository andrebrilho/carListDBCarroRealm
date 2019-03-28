//
//  ViewController.swift
//  ArchitectureApiCars
//
//  Created by André Brilho on 20/02/2019.
//  Copyright © 2019 André Brilho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tbl: UITableView!
    var tableViewCarDatasourceAndDelegate:TableCarDatasourceAndDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCarros(update: false)
        tableViewCarDatasourceAndDelegate = TableCarDatasourceAndDelegate(infoTbl: tbl, viewControllerToPress: self)
    }

    func getCarros(update:Bool){
        ApiCarros.fetchCars(update: update) { (result) in
            switch result {
            case let .Success(resultWithSuccess):
                DispatchQueue.main.async {
                    self.tableViewCarDatasourceAndDelegate?.dados = (resultWithSuccess)!
                    self.tbl.reloadData()
                }
            case let .Error(error):
                Alert.showAlertError(mensagemErro: error.localizedDescription, titleMsgErro: "Ops", view: self)
            }
        }
    }
    
    @IBAction func updateCarsFromApi(_ sender: Any) {
        getCarros(update: true)
    }
}

