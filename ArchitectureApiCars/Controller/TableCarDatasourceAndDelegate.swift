//
//  TableCarDatasourceAndDelegate.swift
//  ArchitectureApiCars
//
//  Created by André Brilho on 20/02/2019.
//  Copyright © 2019 André Brilho. All rights reserved.
//

import Foundation
import UIKit

class TableCarDatasourceAndDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var dados:[Carro] = []
    var viewControllerToPress:UIViewController!
    
    init(infoTbl:UITableView, viewControllerToPress:UIViewController) {
        super.init()
        self.viewControllerToPress = viewControllerToPress
        configureTable(tableInfos:infoTbl)
    }

    func configureTable(tableInfos:UITableView){
        tableInfos.delegate = self
        tableInfos.dataSource = self
        tableInfos.register(UINib(nibName: "CarTableViewCell", bundle: nil), forCellReuseIdentifier: "CarTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dados.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CarTableViewCell", for: indexPath) as? CarTableViewCell{
            cell.carro = dados[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        if let detailCarroViewController = storyboard.instantiateViewController(withIdentifier: "DetalhesViewController") as? DetalhesViewController {
            detailCarroViewController.carro = dados[indexPath.row]
            viewControllerToPress.present(detailCarroViewController, animated: true)
            
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        do {
            AppDelegate.realmCarroDB.beginWrite()
            let carro = dados[indexPath.row]
            AppDelegate.realmCarroDB.delete(carro)
            try
            AppDelegate.realmCarroDB.commitWrite()
            dados.remove(at: indexPath.row)
            tableView.reloadData()
        }catch{
            print("erro")
        }
    }
}
