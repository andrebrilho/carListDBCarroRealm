//
//  Carro.swift
//  ArchitectureApiCars
//
//  Created by André Brilho on 20/02/2019.
//  Copyright © 2019 André Brilho. All rights reserved.
//

import Foundation
import RealmSwift

class Carro:Object, Decodable{
    
   @objc dynamic var nome:String = ""
   @objc dynamic var desc:String = ""
   @objc dynamic var url_info:String = ""
   @objc dynamic var url_foto:String = ""
   @objc dynamic var url_video:String = ""
   @objc dynamic var latitude:String = ""
   @objc dynamic var longitude:String = ""
        
    @objc override public class func primaryKey() -> String {
        return "nome"
    }
}

class CarrosResponse: Decodable {
    var carros:Carros?
}
class Carros:Decodable{
    var carro:[Carro]?
}

