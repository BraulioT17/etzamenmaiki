//
//  PurchaseEditView.swift
//  etzamenmaiki
//
//  Created by ISSC_612_2023 on 17/05/23.
//

import SwiftUI
 
enum ModePurchase {
  case new
  case edit
}
 
enum ActionPurchase {
  case delete
  case done
  case cancel
}
 
struct PurchaseEditView: View {
   
  @Environment(\.presentationMode) private var presentationMode
  @State var presentActionSheet = false
 
   
  @ObservedObject var viewModel = PurchaseViewModel()
  var mode: ModePurchase = .new
  var completionHandler: ((Result<ActionPurchase, Error>) -> Void)?
   
   
  var cancelButton: some View {
    Button(action: { self.handleCancelTapped() }) {
        Text("Cancel").foregroundColor(Color.black)
    }
  }
   
  var saveButton: some View {
    Button(action: { self.handleDoneTapped() }) {
      Text(mode == .new ? "Done" : "Save")
    }.foregroundColor(Color.black)
    .disabled(!viewModel.modified)
  }
   
  var body: some View {
    NavigationView {
        Form{
        Section(header: AppLabel(title: "Purchase")) {
          TextField("Name", text: $viewModel.purchase.nombre)
          
        }
            Section(header: AppLabel(title: "IdProduct")) {
                TextField("IdProduct", value: $viewModel.purchase.idProducto, formatter: NumberFormatter())
            }
          
          Section(header: AppLabel(title: "Pieces")) {
              TextField("Pieces", value: $viewModel.purchase.piezas, formatter: NumberFormatter())
          }
 
            Section(header: AppLabel(title: "IDA")) {
                TextField("IDA", value: $viewModel.purchase.ida, formatter: NumberFormatter())
            }
           
        if mode == .edit {
          Section {
            Button("Delete purchase") { self.presentActionSheet.toggle() }
              .foregroundColor(.red)
              .fontWeight(.bold)
          }
        }
      }.scrollContentBackground(.hidden)
            .background(Color(red:10,green:0.88,blue:0.88,opacity: 1))
      .navigationTitle(mode == .new ? "New purchase" : viewModel.purchase.nombre)
      .navigationBarTitleDisplayMode(mode == .new ? .inline : .large)
      .navigationBarItems(
        leading: cancelButton,
        trailing: saveButton
      )
      .actionSheet(isPresented: $presentActionSheet) {
          ActionSheet(title: Text("Are you sure?"),
                      buttons: [
                        .destructive(Text("Delete purchase"),
                                     action: { self.handleDeleteTapped() }),
                        .cancel()
                      ])
      }
    }
  }
   
  func handleCancelTapped() {
    self.dismiss()
  }
   
  func handleDoneTapped() {
    self.viewModel.handleDoneTapped()
    self.dismiss()
  }
   
  func handleDeleteTapped() {
    viewModel.handleDeleteTapped()
    self.dismiss()
    self.completionHandler?(.success(.delete))
  }
   
  func dismiss() {
    self.presentationMode.wrappedValue.dismiss()
  }
}
 
struct PurchaseEditView_Previews: PreviewProvider {
  static var previews: some View {
    let purchase = Purcahse(idProducto: "", nombre: "", piezas: "", ida: "")
    let purchaseViewModel = PurchaseViewModel(purchase: purchase)
    return PurchaseEditView(viewModel: purchaseViewModel, mode: .edit)
  }
}

