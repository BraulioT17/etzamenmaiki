import Foundation
import Combine
import FirebaseFirestore
 
class PurchaseViewModel: ObservableObject {
   
  @Published var purchase: Purcahse
  @Published var modified = false
   
  private var cancellables = Set<AnyCancellable>()
   
    init(purchase: Purcahse = Purcahse(idProducto: "", nombre: "", piezas: "", ida: "")) {
    self.purchase = purchase
     
    self.$purchase
      .dropFirst()
      .sink { [weak self] purchase in
        self?.modified = true
      }
      .store(in: &self.cancellables)
  }
   
  private var db = Firestore.firestore()
   
  private func addPurchase(_ purchase: Purcahse) {
    do {
      let _ = try db.collection("compras").addDocument(from: purchase) //no se como va aqui, tal vez falle
    }
    catch {
      print(error)
    }
  }
   
  private func updatePurchase(_ purchase: Purcahse) {
    if let documentId = purchase.id {
      do {
        try db.collection("compras").document(documentId).setData(from: purchase)
      }
      catch {
        print(error)
      }
    }
  }
   
  private func updateOrAddPurchase() {
    if let _ = purchase.id {
      self.updatePurchase(self.purchase)
    }
    else {
        addPurchase(purchase)
    }
  }
   
  private func removePurchase() {
    if let documentId = purchase.id {
      db.collection("compras").document(documentId).delete { error in
        if let error = error {
          print(error.localizedDescription)
        }
      }
    }
  }
   
  func handleDoneTapped() {
    self.updateOrAddPurchase()
  }
   
  func handleDeleteTapped() {
    self.removePurchase()
  }
   
}
