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
        Image(systemName: "square.and.pencil").font(.system(size: 20.0)).fontWeight(.bold).foregroundColor(Color.black)
    }
  }
   
  var body: some View {
    Form {
      Section(header: AppLabel(title: "Product")) {
        Text(product.nombre)
        Text(" $\(product.precio)")
      }
       
      Section(header: AppLabel(title: "Description")) {
        Text(product.descripcion)
      }
        Section(header: AppLabel(title: "Investment")) {
          Text(product.algo)
        }
        Section(header: AppLabel(title: "Utility")) {
          Text(product.utilidad)
        }
        Section(header: AppLabel(title: "Existency")) {
          Text(product.algo2)
        }
      
    }
    .scrollContentBackground(.hidden)
    .background(Color(red:10,green:0.88,blue:0.88,opacity: 1))
    .navigationBarBackButtonHidden(true)
    .toolbar(content: {
        ToolbarItem(placement: .navigationBarLeading){
            Button(action: {presentationMode.wrappedValue.dismiss()}, label: {Image(systemName: "arrow.uturn.backward.circle").foregroundColor(Color.red).font(.system(size: 22))})
        }
    })
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
