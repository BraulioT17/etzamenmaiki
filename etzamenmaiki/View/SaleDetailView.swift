//
//  SaleDetailView.swift
//  etzamenmaiki
//
//  Created by ISSC_612_2023 on 17/05/23.
//

import SwiftUI
//import SDWebImageSwiftUI
 
struct SaleDetailsView: View {
   
  @Environment(\.presentationMode) var presentationMode
  @State var presentEditBookSheet = false
   
   
  var sale: Sale
   
  private func editButton(action: @escaping () -> Void) -> some View {
    Button(action: { action() }) {
      Text("Edit")
    }
  }
   
  var body: some View {
    Form {
      Section(header: Text("idCliente")) {
        Text(sale.idCliente)
        //Text("\(sale.edad) year(s)")
      }
       
      Section(header: Text("idProducto")) {
        Text(sale.idProducto)
      }
        Section(header: Text("idVendedor")) {
          Text(sale.idVendedor)
        }
        Section(header: Text("Piezas")) {
          Text(sale.piezas)
        }
        Section(header: Text("subTotal")) {
          Text(sale.subTotal)
        }
        Section(header: Text("Total")) {
          Text(sale.total)
        }
      //Section(header: Text("Photo")) {
          //AnimatedImage(url: URL(string: book.image)!).resizable().frame(width: 300, height: 300)
      //}
    }
    .navigationBarTitle(sale.total)
    .navigationBarItems(trailing: editButton {
      self.presentEditBookSheet.toggle()
    })
    .onAppear() {
      print("BookDetailsView.onAppear() for \(self.sale.total)")
    }
    .onDisappear() {
      print("BookDetailsView.onDisappear()")
    }
    .sheet(isPresented: self.$presentEditBookSheet) {
      SaleEditView(viewModel: SaleViewModel(sale: sale), mode: .edit) { result in
        if case .success(let action) = result, action == .delete {
          self.presentationMode.wrappedValue.dismiss()
        }
      }
    }
  }
}

 
struct SaleDetailsView_Previews: PreviewProvider {
  static var previews: some View {
      let sale = Sale(idCliente: "", idProducto: "", idVendedor: "", piezas: "", subTotal: "", total: "")
    return
      NavigationView {
        SaleDetailsView(sale: sale)
      }
  }
}
