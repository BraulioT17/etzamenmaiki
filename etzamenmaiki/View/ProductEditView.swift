//
//  ProductEditView.swift
//  etzamenmaiki
//
//  Created by ISSC_612_2023 on 17/05/23.
//

import SwiftUI
 
enum ModeProduct {
  case new
  case edit
}
 
enum ActionProduct {
  case delete
  case done
  case cancel
}
 
struct ProductEditView: View {
   
  @Environment(\.presentationMode) private var presentationMode
  @State var presentActionSheet = false
 
   
  @ObservedObject var viewModel = ProductViewModel()
  var mode: ModeProduct = .new
  var completionHandler: ((Result<ActionProduct, Error>) -> Void)?
   
   
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
    NavigationView {
      Form{
        Section(header: AppLabel(title: "Product")) {
          TextField("Name", text: $viewModel.product.nombre)
        }
          
          Section(header: AppLabel(title: "Description")) {
            TextField("Description", text: $viewModel.product.descripcion)
          }
          
          Section(header: AppLabel(title: "Price")) {
              TextField("Price", value: $viewModel.product.precio, formatter: NumberFormatter())
          }
          
          Section(header: AppLabel(title: "Investment")) {
              TextField("Inversion", value: $viewModel.product.algo, formatter: NumberFormatter())
          }
          
          Section(header: AppLabel(title: "Utility")) {
              TextField("Utility", value: $viewModel.product.utilidad, formatter: NumberFormatter())
          }
          
          Section(header: AppLabel(title: "Existency")) {
              TextField("Existency", value: $viewModel.product.algo2, formatter: NumberFormatter())
          }
           
        if mode == .edit {
          Section {
            Button("Delete product") { self.presentActionSheet.toggle() }
              .foregroundColor(.red)
              .fontWeight(.bold)
          }
        }
      }
      .scrollContentBackground(.hidden)
      .background(Color(red:10,green:0.88,blue:0.88,opacity: 1))
      .navigationTitle(mode == .new ? "New product" : viewModel.product.nombre)
      .navigationBarTitleDisplayMode(mode == .new ? .inline : .large)
      .navigationBarItems(
        leading: cancelButton,
        trailing: saveButton
      )
      .actionSheet(isPresented: $presentActionSheet) {
          ActionSheet(title: Text("Are you sure?"),
                      buttons: [
                        .destructive(Text("Delete product"),
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
 
struct ProductEditView_Previews: PreviewProvider {
  static var previews: some View {
    let product = Product(algo: "", algo2: "", descripcion: "", nombre: "", precio: "", utilidad: "")
    let productViewModel = ProductViewModel(product: product)
    return ProductEditView(viewModel: productViewModel, mode: .edit)
  }
}

