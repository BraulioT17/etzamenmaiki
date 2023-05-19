//
//  SaleEditView.swift
//  etzamenmaiki
//
//  Created by ISSC_612_2023 on 17/05/23.
//

import SwiftUI
 
enum ModeSale {
  case new
  case edit
}
 
enum ActionSale {
  case delete
  case done
  case cancel
}
 
struct SaleEditView: View {
   
  @Environment(\.presentationMode) private var presentationMode
  @State var presentActionSheet = false
 
   
  @ObservedObject var viewModel = SaleViewModel()
  var mode: ModeSale = .new
  var completionHandler: ((Result<ActionSale, Error>) -> Void)?
   
   
  var cancelButton: some View {
    Button(action: { self.handleCancelTapped() }) {
      Text("Cancel")
    }
  }
   
  var saveButton: some View {
    Button(action: { self.handleDoneTapped() }) {
      Text(mode == .new ? "Done" : "Save")
    }
    .disabled(!viewModel.modified)
  }
   
  var body: some View {
    NavigationView {
      Form{
        Section(header: Text("Sale")) {
          TextField("idCliente", value: $viewModel.sale.idCliente, formatter: NumberFormatter())
        }
          
          Section(header: Text("idProducto")) {
              TextField("idProducto", value: $viewModel.sale.idProducto, formatter: NumberFormatter())
          }
         
        Section(header: Text("idVendedor")) {
          TextField("idVendedor", value: $viewModel.sale.idVendedor, formatter: NumberFormatter())
        }
          
          Section(header: Text("Piezas")) {
            TextField("Piezas", value: $viewModel.sale.piezas, formatter: NumberFormatter())
          }
          
          Section(header: Text("subTotal")) {
            TextField("subTotal", value: $viewModel.sale.subTotal, formatter: NumberFormatter())
          }
          
          Section(header: Text("Total")) {
            TextField("Total", value: $viewModel.sale.total, formatter: NumberFormatter())
          }
           
        if mode == .edit {
          Section {
            Button("Delete sale") { self.presentActionSheet.toggle() }
              .foregroundColor(.red)
          }
        }
      }
      .navigationTitle(mode == .new ? "New sale" : viewModel.sale.total)
      .navigationBarTitleDisplayMode(mode == .new ? .inline : .large)
      .navigationBarItems(
        leading: cancelButton,
        trailing: saveButton
      )
      .actionSheet(isPresented: $presentActionSheet) {
          ActionSheet(title: Text("Are you sure?"),
                      buttons: [
                        .destructive(Text("Delete sale"),
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
 
struct SaleEditView_Previews: PreviewProvider {
  static var previews: some View {
    let sale = Sale(idCliente: "", idProducto: "", idVendedor: "", piezas: "", subTotal: "", total: "")
    let saleViewModel = SaleViewModel(sale: sale)
    return SaleEditView(viewModel: saleViewModel, mode: .edit)
  }
}

