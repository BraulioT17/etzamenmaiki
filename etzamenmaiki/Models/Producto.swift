import Foundation
import FirebaseFirestoreSwift
 
struct Producto: Identifiable, Codable {
    @DocumentID var id: String?
    var algo: String
    var algo2: String
    var descripcion: String
    var nombre: String
    var precio: String
    var utilidad: String
   
  enum CodingKeys: String, CodingKey {
      case id
      case algo
      case algo2
      case descripcion
      case nombre
      case precio
      case utilidad
  }
}
