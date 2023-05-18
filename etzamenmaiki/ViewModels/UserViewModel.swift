import Foundation
import Combine
import FirebaseFirestore
 
class UserViewModel: ObservableObject {
   
  @Published var userModel: UserModel
  @Published var modified = false
   
  private var cancellables = Set<AnyCancellable>()
   
    init(userModel: UserModel = UserModel(apellido: "", correo: "", edad: 0, genero: "", nombre: "")) {
    self.userModel = userModel
     
    self.$userModel
      .dropFirst()
      .sink { [weak self] userModel in
        self?.modified = true
      }
      .store(in: &self.cancellables)
  }
   
  private var db = Firestore.firestore()
   
  private func addUserModel(_ userModel: UserModel) {
    do {
      let _ = try db.collection("users").addDocument(from: userModel) //no se como va aqui, tal vez falle
    }
    catch {
      print(error)
    }
  }
   
  private func updateUserModel(_ userModel: UserModel) {
    if let documentId = userModel.id {
      do {
        try db.collection("users").document(documentId).setData(from: userModel)
      }
      catch {
        print(error)
      }
    }
  }
   
  private func updateOrAddUserModel() {
    if let _ = userModel.id {
      self.updateUserModel(self.userModel)
    }
    else {
        addUserModel(userModel)
    }
  }
   
  private func removeUserModel() {
    if let documentId = userModel.id {
      db.collection("users").document(documentId).delete { error in
        if let error = error {
          print(error.localizedDescription)
        }
      }
    }
  }
   
  func handleDoneTapped() {
    self.updateOrAddUserModel()
  }
   
  func handleDeleteTapped() {
    self.removeUserModel()
  }
   
}
