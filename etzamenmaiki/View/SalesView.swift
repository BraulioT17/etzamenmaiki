//
//  SalesView.swift
//  etzamenmaiki
//
//  Created by ISSC_612_2023 on 17/05/23.
//

import SwiftUI
import Firebase
//import SDWebImageSwiftUI
 
struct SalesView: View {
    @StateObject var viewModel = SalesViewModel()
    @State var presentAddBookSheet = false
    
    private var addButton: some View {
        Button(action: { self.presentAddBookSheet.toggle() }) {
            Image(systemName: "plus")
        }
    }
    
    private func saleRowView(sale: Sale) -> some View {
        NavigationLink(destination: SaleDetailsView(sale: sale)) {
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(sale.idVendedor)
                            .fontWeight(.bold)
                        Text(sale.total)
                    }
                }
            }
        }
    }
    
    var body: some View {

            ZStack {
                NavigationView {
                    List {
                        ForEach(viewModel.sales) { sale in
                            saleRowView(sale: sale)
                        }
                        .onDelete() { indexSet in
                            viewModel.removeSales(atOffsets: indexSet)
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .navigationTitle("Sale")
                    .navigationBarItems(trailing: addButton)
                    .onAppear() {
                        print("BooksListView appears. Subscribing to data updates.")
                        self.viewModel.subscribe()
                    }
                    .background(Color.clear)
                    .sheet(isPresented: self.$presentAddBookSheet) {
                        SaleEditView()
                    }
                    // Ajustar los márgenes del NavigationView
                }.padding(EdgeInsets(top: 10, leading: 10, bottom: 80, trailing: 10))
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                .background(Color.clear)
            
        }
        .background(Color(red: 10, green: 0.88, blue: 0.88, opacity: 1))
    }
}
 
struct SalesView_Previews: PreviewProvider {
    static var previews: some View {
        SalesView()
    }
}
