import Foundation
import Combine
import FirebaseFirestore
 
class ProductosViewModel: ObservableObject {
  @Published var productos = [Producto]()
   
  private var db = Firestore.firestore()
  private var listenerRegistration: ListenerRegistration?
   
  deinit {
    unsubscribe()
  }
   
  func unsubscribe() {
    if listenerRegistration != nil {
      listenerRegistration?.remove()
      listenerRegistration = nil
    }
  }
   
  func subscribe() {
    if listenerRegistration == nil {
      listenerRegistration = db.collection("product").addSnapshotListener { (querySnapshot, error) in
        guard let documents = querySnapshot?.documents else {
          print("No documents")
          return
        }
         
        self.productos = documents.compactMap { queryDocumentSnapshot in
          try? queryDocumentSnapshot.data(as: Producto.self)
        }
      }
    }
  }
   
  func removeMovies(atOffsets indexSet: IndexSet) {
    let producto = indexSet.lazy.map { self.productos[$0] }
    producto.forEach { p in
      if let documentId = p.id {
        db.collection("product").document(documentId).delete { error in
          if let error = error {
            print("Unable to remove document: \(error.localizedDescription)")
          }
        }
      }
    }
  }
 
   
}
