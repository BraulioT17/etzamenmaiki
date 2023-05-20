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
        Image(systemName: "square.and.pencil").font(.system(size: 20.0)).fontWeight(.bold).foregroundColor(Color.black)
    }
  }
   
  var body: some View {
    Form {
      Section(header: AppLabel(title: "IDClient")) {
        Text(sale.idCliente)
        //Text("\(sale.edad) year(s)")
      }
       
      Section(header: AppLabel(title: "IDProduct")) {
        Text(sale.idProducto)
      }
        Section(header: AppLabel(title: "IDSalesman")) {
          Text(sale.idVendedor)
        }
        Section(header: AppLabel(title: "Pieces")) {
          Text(sale.piezas)
        }
        Section(header: AppLabel(title: "Subtotal")) {
          Text(sale.subTotal)
        }
        Section(header: AppLabel(title: "Total")) {
          Text(sale.total)
        }
      //Section(header: Text("Photo")) {
          //AnimatedImage(url: URL(string: book.image)!).resizable().frame(width: 300, height: 300)
      //}
    }.scrollContentBackground(.hidden)
          .background(Color(red:10,green:0.88,blue:0.88,opacity: 1))
          .foregroundColor(Color.black)
          .navigationBarBackButtonHidden(true)
          .toolbar(content: {
              ToolbarItem(placement: .navigationBarLeading){
                  Button(action: {presentationMode.wrappedValue.dismiss()}, label: {Image(systemName: "arrow.uturn.backward.circle").foregroundColor(Color.red).font(.system(size: 22))})
              }
          })
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
      let sale = Sale(idCliente: "1", idProducto: "1", idVendedor: "1", piezas: "1", subTotal: "1", total: "1")
    return
      NavigationView {
        SaleDetailsView(sale: sale)
      }
  }
}
