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
    @Environment(\.presentationMode) private var presentationMode
    @StateObject var viewModel = SalesViewModel()
    @State var presentAddBookSheet = false
    
    private var addButton: some View {
        Button(action: { self.presentAddBookSheet.toggle() }) {
            Image(systemName: "bag.badge.plus").font(.system(size: 20.0)).fontWeight(.bold).foregroundColor(Color .black)
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
                NavigationStack {
                    List {
                        Section{
                            ForEach(viewModel.sales) { sale in
                                saleRowView(sale: sale)
                            }
                            .onDelete() { indexSet in
                                viewModel.removeSales(atOffsets: indexSet)
                            }
                            .listRowSeparator(.hidden)
                                .listRowBackground(Capsule()
                                  .fill(Color(white: 1)).padding(4))
                                .padding(.vertical, 15)
                                  .headerProminence(.increased)
                        }header: {
                            HStack{
                                AppTaruls(title: "Sales").bold()
                                Image(systemName: "bag").font(.system(size: 20.0))
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
                }
            
        }
        .background(Color(red: 10, green: 0.88, blue: 0.88, opacity: 1))
    }
}
 
struct SalesView_Previews: PreviewProvider {
    static var previews: some View {
        SalesView()
    }
}
