//
//  PurchaseDetailView.swift
//  etzamenmaiki
//
//  Created by ISSC_612_2023 on 17/05/23.
//

import SwiftUI
//import SDWebImageSwiftUI
 
struct PurchaseDetailsView: View {
    
   
  @Environment(\.presentationMode) var presentationMode
  @State var presentEditBookSheet = false
   
   
  var purchase: Purcahse
   
  private func editButton(action: @escaping () -> Void) -> some View {
    Button(action: { action() }) {
        Image(systemName: "square.and.pencil").font(.system(size: 20.0)).fontWeight(.bold)
    }.foregroundColor(Color.black)
  }
   
  var body: some View {
      
    Form {
      Section(header: AppLabel(title: "Purchase")) {
        Text(purchase.nombre)
        Text("\(purchase.idProducto)")
      }
       
      Section(header: AppLabel(title: "Pieces")) {
        Text(purchase.piezas)
      }
        Section(header: AppLabel(title: "IDA")) {
          Text(purchase.ida)
        }      //Section(header: Text("Photo")) {
          //AnimatedImage(url: URL(string: book.image)!).resizable().frame(width: 300, height: 300)
      //}
    }.scrollContentBackground(.hidden)
          .background(Color(red:10,green:0.88,blue:0.88,opacity: 1))
      // Establecer el color rojo como fondo del formulario
      
          .navigationBarBackButtonHidden(true)
          .toolbar(content: {
              ToolbarItem(placement: .navigationBarLeading){
                  Button(action: {presentationMode.wrappedValue.dismiss()}, label: {Image(systemName: "arrow.uturn.backward.circle").foregroundColor(Color.red).font(.system(size: 22))})
              }
          })
          .foregroundColor(Color.black)
    .navigationBarTitle(purchase.nombre)
    .navigationBarItems(trailing: editButton {
      self.presentEditBookSheet.toggle()
    })
    .onAppear() {
      print("BookDetailsView.onAppear() for \(self.purchase.nombre)")
    }
    .onDisappear() {
      print("BookDetailsView.onDisappear()")
    }
    .sheet(isPresented: self.$presentEditBookSheet) {
      PurchaseEditView(viewModel: PurchaseViewModel(purchase: purchase), mode: .edit) { result in
        if case .success(let action) = result, action == .delete {
          self.presentationMode.wrappedValue.dismiss()
        }
      }
    }
  }
}

 
struct PurchaseDetailsView_Previews: PreviewProvider {
  static var previews: some View {
      let purchase = Purcahse(idProducto: "", nombre: "", piezas: "", ida: "")
    return
      NavigationView {
        PurchaseDetailsView(purchase: purchase)
      }
  }
}
