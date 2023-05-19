import Foundation
import Combine
import FirebaseFirestore
 
class ProductViewModel: ObservableObject {
   
  @Published var product: Product
  @Published var modified = false
   
  private var cancellables = Set<AnyCancellable>()
   
    init(product: Product = Product(algo: "", algo2: "", descripcion: "", nombre: "", precio: "", utilidad: "")) {
    self.product = product
     
    self.$product
      .dropFirst()
      .sink { [weak self] product in
        self?.modified = true
      }
      .store(in: &self.cancellables)
  }
   
  private var db = Firestore.firestore()
   
  private func addProduct(_ product: Product) {
    do {
      let _ = try db.collection("product").addDocument(from: product) //no se como va aqui, tal vez falle
    }
    catch {
      print(error)
    }
  }
   
  private func updateProduct(_ product: Product) {
    if let documentId = product.id {
      do {
        try db.collection("product").document(documentId).setData(from: product)
      }
      catch {
        print(error)
      }
    }
  }
   
  private func updateOrAddProduct() {
    if let _ = product.id {
      self.updateProduct(self.product)
    }
    else {
        addProduct(product)
    }
  }
   
  private func removeProduct() {
    if let documentId = product.id {
      db.collection("product").document(documentId).delete { error in
        if let error = error {
          print(error.localizedDescription)
        }
      }
    }
  }
   
  func handleDoneTapped() {
    self.updateOrAddProduct()
  }
   
  func handleDeleteTapped() {
    self.removeProduct()
  }
   
}
