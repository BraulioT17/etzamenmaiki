import Foundation
import FirebaseFirestoreSwift
 
struct Product: Identifiable, Codable {
    @DocumentID var id: String?
    var algo: String //inversion int
    var algo2: String //existencia int
    var descripcion: String
    var nombre: String
    var precio: String
    var utilidad: String
   
  enum CodingKeys: String, CodingKey {
      case id
      case algo //
      case algo2
      case descripcion //
      case nombre //
      case precio //
      case utilidad //
  }
}
