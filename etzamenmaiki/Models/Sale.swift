//
//  Sale.swift
//  etzamenmaiki
//
//  Created by ISSC_612_2023 on 19/05/23.
//

import Foundation
import FirebaseFirestoreSwift
 
struct Sale: Identifiable, Codable {
    @DocumentID var id: String?
    var idCliente: String
    var idProducto: String
    var idVendedor: String
    var piezas: String
    var subTotal: String
    var total: String
   
  enum CodingKeys: String, CodingKey {
      case id
      case idCliente
      case idProducto
      case idVendedor
      case piezas
      case subTotal
      case total
  }
}
