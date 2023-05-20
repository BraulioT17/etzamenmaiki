//
//  PurchasesView.swift
//  etzamenmaiki
//
//  Created by ISSC_612_2023 on 17/05/23.
//

import SwiftUI
import Firebase
//import SDWebImageSwiftUI
 
struct PurchasesView: View {
    @Environment(\.presentationMode) var presentationMode
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
     
    @StateObject var viewModel = PurchasesViewModel()
    @State var presentAddBookSheet = false
     
    private var addButton: some View {
      Button(action: { self.presentAddBookSheet.toggle() }) {
          Image(systemName: "cart.badge.plus").font(.system(size: 20.0)).fontWeight(.bold)
      }
    }
     
    private func purchaseRowView(purchase: Purcahse) -> some View {
      NavigationLink(destination: PurchaseDetailsView(purchase: purchase)) {
        VStack(alignment: .leading) {
            HStack {
                //AnimatedImage(url: URL(string: book.image)!).resizable().frame(width: 65, height: 65).clipShape(Circle())
                 
                VStack(alignment: .leading) {
                    Text(purchase.nombre)
                        .fontWeight(.bold)
                    Text(purchase.piezas)
                }
            }
        }
      }
    }
     
    var body: some View {
      NavigationStack {
              List {
                  Section{
                      ForEach (viewModel.purchases) { purchase in
                          purchaseRowView(purchase: purchase)
                      }
                      .onDelete() { indexSet in
                          viewModel.removePurchases(atOffsets: indexSet)
                      }.listRowSeparator(.hidden)
                          .listRowBackground(Capsule()
                            .fill(Color(white: 1)).padding(4))
                          .padding(.vertical, 15)
                            .headerProminence(.increased)
                            
                  }header: {
                      HStack{
                          AppTaruls(title: "Buy").bold()
                          Image(systemName: "cart").font(.system(size: 20.0))
                      }
                      VStack{}.frame(height: CGFloat(55))
                  }.listRowInsets(.init(top: 0, leading: 20, bottom: 0, trailing: 20))
                      
                  
              }
          
        .scrollContentBackground(.hidden)
        .background(Color(red:10,green:0.88,blue:0.88,opacity: 1))
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading){
                Button(action: {presentationMode.wrappedValue.dismiss()}, label: {Image(systemName: "arrow.uturn.backward.circle").foregroundColor(Color.red).font(.system(size: 22))})
            }
        })
        .navigationBarItems(trailing: addButton).foregroundColor(Color.black)
        .onAppear() {
          print("BooksListView appears. Subscribing to data updates.")
          self.viewModel.subscribe()
        }
        .sheet(isPresented: self.$presentAddBookSheet) {
          PurchaseEditView()
        }
        .background(Color.clear) // Agregar un fondo rosa a la vista
      }
    }
}


 
struct PurchasesView_Previews: PreviewProvider {
    static var previews: some View {
        PurchasesView()
    }
}
