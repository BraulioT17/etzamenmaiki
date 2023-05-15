import Foundation
import Combine
import FirebaseFirestore
 
class ProductoViewModel: ObservableObject {
   
  @Published var producto: Producto
  @Published var modified = false
   
  private var cancellables = Set<AnyCancellable>()
   
  init(producto: Producto = Producto(algo: "", algo2: "", descripcion: "", nombre: "", precio: "", utilidad: "")) {
    self.producto = producto
     
    self.$producto
      .dropFirst()
      .sink { [weak self] movie in
        self?.modified = true
      }
      .store(in: &self.cancellables)
  }
   
  // Firestore
   
  private var db = Firestore.firestore()
   
  private func addProducto(_ producto: Producto) {
    do {
      let _ = try db.collection("product").addDocument(from: producto)
    }
    catch {
      print(error)
    }
  }
   
  private func updateProducto(_ producto: Producto) {
    if let documentId = producto.id {
      do {
        try db.collection("product").document(documentId).setData(from: producto)
      }
      catch {
        print(error)
      }
    }
  }
   
  private func updateOrAddProducto() {
    if let _ = producto.id {
      self.updateProducto(self.producto)
    }
    else {
      addProducto(producto)
    }
  }
   
  private func removeProduct() {
    if let documentId = producto.id {
      db.collection("product").document(documentId).delete { error in
        if let error = error {
          print(error.localizedDescription)
        }
      }
    }
  }
   
  // UI handlers
   
  func handleDoneTapped() {
    self.updateOrAddProducto()
  }
   
  func handleDeleteTapped() {
    self.removeProduct()
  }
   
}
