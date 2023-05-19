//
//  ProductDetailView.swift
//  etzamenmaiki
//
//  Created by ISSC_612_2023 on 17/05/23.
//

import SwiftUI
//import SDWebImageSwiftUI
 
struct ProductDetailsView: View {
   
  @Environment(\.presentationMode) var presentationMode
  @State var presentEditBookSheet = false
   
   
  var product: Product
   
  private func editButton(action: @escaping () -> Void) -> some View {
    Button(action: { action() }) {
      Text("Edit")
    }
  }
   
  var body: some View {
    Form {
      Section(header: Text("Product")) {
        Text(product.nombre)
        Text(" $\(product.precio)")
      }
       
      Section(header: Text("Description")) {
        Text(product.descripcion)
      }
        Section(header: Text("Inversion")) {
          Text(product.algo)
        }
        Section(header: Text("Utility")) {
          Text(product.utilidad)
        }
        Section(header: Text("Existency")) {
          Text(product.algo2)
        }
      
    }
    .navigationBarTitle(product.nombre)
    .navigationBarItems(trailing: editButton {
      self.presentEditBookSheet.toggle()
    })
    .onAppear() {
      print("BookDetailsView.onAppear() for \(self.product.nombre)")
    }
    .onDisappear() {
      print("BookDetailsView.onDisappear()")
    }
    .sheet(isPresented: self.$presentEditBookSheet) {
      ProductEditView(viewModel: ProductViewModel(product: product), mode: .edit) { result in
        if case .success(let action) = result, action == .delete {
          self.presentationMode.wrappedValue.dismiss()
        }
      }
    }
  }
}

 
struct ProductDetailsView_Previews: PreviewProvider {
  static var previews: some View {
      let product = Product(algo: "", algo2: "", descripcion: "", nombre: "", precio: "45", utilidad: "")
    return
      NavigationView {
        ProductDetailsView(product: product)
      }
  }
}
