//
//  PurchasesViewModel.swift
//  etzamenmaiki
//
//  Created by ISSC_612_2023 on 17/05/23.
//

import Foundation
import Combine
import FirebaseFirestore
 
class PurchasesViewModel: ObservableObject {
  @Published var purchases = [Purcahse]()
   
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
      listenerRegistration = db.collection("ventas").addSnapshotListener { (querySnapshot, error) in
        guard let documents = querySnapshot?.documents else {
          print("No documents")
          return
        }
         
        self.purchases = documents.compactMap { queryDocumentSnapshot in
          try? queryDocumentSnapshot.data(as: Purcahse.self)
        }
      }
    }
  }
   
  func removePurchases(atOffsets indexSet: IndexSet) {
    let purchases = indexSet.lazy.map { self.purchases[$0] }
    purchases.forEach { Purchase in
      if let documentId = Purchase.id {
        db.collection("ventas").document(documentId).delete { error in
          if let error = error {
            print("Unable to remove document: \(error.localizedDescription)")
          }
        }
      }
    }
  }
 
   
}
