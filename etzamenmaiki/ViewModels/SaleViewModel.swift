import Foundation
import Combine
import FirebaseFirestore
 
class SaleViewModel: ObservableObject {
   
  @Published var sale: Sale
  @Published var modified = false
   
  private var cancellables = Set<AnyCancellable>()
   
    init(sale: Sale = Sale(idCliente: "", idProducto: "", idVendedor: "", piezas: "", subTotal: "", total: "")) {
    self.sale = sale
     
    self.$sale
      .dropFirst()
      .sink { [weak self] sale in
        self?.modified = true
      }
      .store(in: &self.cancellables)
  }
   
  private var db = Firestore.firestore()
   
  private func addSale(_ sale: Sale) {
    do {
      let _ = try db.collection("ventas").addDocument(from: sale) //no se como va aqui, tal vez falle
    }
    catch {
      print(error)
    }
  }
   
  private func updateSale(_ sale: Sale) {
    if let documentId = sale.id {
      do {
        try db.collection("ventas").document(documentId).setData(from: sale)
      }
      catch {
        print(error)
      }
    }
  }
   
  private func updateOrAddSale() {
    if let _ = sale.id {
      self.updateSale(self.sale)
    }
    else {
        addSale(sale)
    }
  }
   
  private func removeSale() {
    if let documentId = sale.id {
      db.collection("ventas").document(documentId).delete { error in
        if let error = error {
          print(error.localizedDescription)
        }
      }
    }
  }
   
  func handleDoneTapped() {
    self.updateOrAddSale()
  }
   
  func handleDeleteTapped() {
    self.removeSale()
  }
   
}
