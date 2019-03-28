//
//  ApiCarros.swift
//  ArchitectureApiCars
//
//  Created by André Brilho on 20/02/2019.
//  Copyright © 2019 André Brilho. All rights reserved.
//

import Foundation
import Alamofire

class ApiCarros{
    static func fetchCars(update:Bool, completion:@escaping(Result<[Carro], Error>)->Void){
        if let url = URL(string: Constants.URL_BASE){
            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30)
            let carrosDbRealm = AppDelegate.realmCarroDB.objects(Carro.self).sorted(byKeyPath: "nome")
            if !update {
                if !carrosDbRealm.isEmpty {
                    var carrosFromDB = [Carro]()
                    for carro in carrosDbRealm {
                        carrosFromDB.append(carro)
                        print(carro.nome)
                    }
                    completion(.Success(carrosFromDB))
                    return
                }
            }
            Alamofire.request(request).responseData { (response) in
                let statusCode = response.response?.statusCode
                switch statusCode{
                case 200:
                    do{
                        let jsonObject = try JSONDecoder().decode(CarrosResponse.self, from: response.data!)
                        let arrayCars = jsonObject.carros?.carro
                        DispatchQueue.main.async {
                            do {
                                var carrosToInsert = [Carro]()
                                for carro in arrayCars ?? [] {
                                    carrosToInsert.append(carro)
                                    print("append carro no banco de dados", carro.nome)
                                    print(carrosToInsert.count)
                                }
                                AppDelegate.realmCarroDB?.beginWrite()
                                AppDelegate.realmCarroDB?.add(carrosToInsert, update: true)
                                try
                                    AppDelegate.realmCarroDB?.commitWrite()
                                print("numero total de carro inseridos", carrosToInsert.count)
                                completion(.Success(jsonObject.carros?.carro))
                            }catch{
                                print("deu ruim")
                            }
                        }
                    }catch{
                        print("erro desconhecido")
                    }
                default:
                    completion(.Error(response.error!))
                }
            }
        }
    }
}
