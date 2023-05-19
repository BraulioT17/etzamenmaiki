import Foundation
import FirebaseFirestoreSwift
 
struct UserModel: Identifiable, Codable {
    
  @DocumentID var id: String?
  var apellido: String
  var correo: String
  var edad: String
  var genero: String
  var nombre: String
   
  enum CodingKeys: String, CodingKey {
    case id
    case apellido
    case correo
    case edad
    case genero
    case nombre
  }
}
