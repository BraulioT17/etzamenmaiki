//
//  Purchase.swift
//  etzamenmaiki
//
//  Created by ISSC_612_2023 on 19/05/23.
//

import Foundation
import FirebaseFirestoreSwift
 
struct Purcahse: Identifiable, Codable {
    @DocumentID var id: String?
    var idProducto: String
    var nombre: String
    var piezas: String
    var ida: String
   
  enum CodingKeys: String, CodingKey {
      case id
      case idProducto
      case nombre
      case piezas
      case ida
  }
}
