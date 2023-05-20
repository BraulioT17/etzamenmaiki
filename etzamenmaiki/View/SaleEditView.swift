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
        Text("Cancel").foregroundColor(Color.black)
    }
  }
   
  var saveButton: some View {
    Button(action: { self.handleDoneTapped() }) {
      Text(mode == .new ? "Done" : "Save").foregroundColor(Color.black)
    }
    .disabled(!viewModel.modified)
  }
   
  var body: some View {
    NavigationStack {
      Form{
        Section(header: AppLabel(title: "Sale")) {
          TextField("idCliente", text: $viewModel.sale.idCliente)
        }
          
          Section(header: AppLabel(title: "IDProduct")) {
              TextField("idProducto", text: $viewModel.sale.idProducto)
          }
         
        Section(header: AppLabel(title: "IDSalesMan")) {
          TextField("idVendedor", text: $viewModel.sale.idVendedor)
        }
          
          Section(header: AppLabel(title: "Pieces")) {
            TextField("Piezas", text: $viewModel.sale.piezas)
          }
          
          Section(header: AppLabel(title: "Subtotal")) {
            TextField("subTotal", text: $viewModel.sale.subTotal)
          }
          
          Section(header: AppLabel(title: "Total")) {
            TextField("Total", text: $viewModel.sale.total)
          }
           
        if mode == .edit {
          Section {
            Button("Delete sale") { self.presentActionSheet.toggle() }
              .foregroundColor(.red)
              .fontWeight(.bold)
          }
        }
      }.scrollContentBackground(.hidden)
            .background(Color(red:10,green:0.88,blue:0.88,opacity: 1))
            .navigationBarBackButtonHidden(true)
        
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

