//
//  UsersViewModel.swift
//  etzamenmaiki
//
//  Created by ISSC_612_2023 on 17/05/23.
//

import Foundation
import Combine
import FirebaseFirestore
 
class UsersViewModel: ObservableObject {
  @Published var users = [UserModel]()
   
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
      listenerRegistration = db.collection("users").addSnapshotListener { (querySnapshot, error) in
        guard let documents = querySnapshot?.documents else {
          print("No documents")
          return
        }
         
        self.users = documents.compactMap { queryDocumentSnapshot in
          try? queryDocumentSnapshot.data(as: UserModel.self)
        }
      }
    }
  }
   
  func removeUsers(atOffsets indexSet: IndexSet) {
    let users = indexSet.lazy.map { self.users[$0] }
    users.forEach { UserModel in
      if let documentId = UserModel.id {
        db.collection("users").document(documentId).delete { error in
          if let error = error {
            print("Unable to remove document: \(error.localizedDescription)")
          }
        }
      }
    }
  }
 
   
}
