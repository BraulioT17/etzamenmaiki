//
//  ProductsView.swift
//  etzamenmaiki
//
//  Created by ISSC_612_2023 on 17/05/23.
//

import SwiftUI
import Firebase
//import SDWebImageSwiftUI
 
struct ProductsView: View {
    @StateObject var viewModel = ProductsViewModel()
    @State var presentAddBookSheet = false
    
    private var addButton: some View {
        Button(action: { self.presentAddBookSheet.toggle() }) {
            Image(systemName: "plus")
        }
    }
    
    private func productRowView(product: Product) -> some View {
        NavigationLink(destination: ProductDetailsView(product: product)) {
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(product.nombre)
                            .fontWeight(.bold)
                        Text(product.precio)
                    }
                }
            }
        }
    }
    
    var body: some View {

            ZStack {
                NavigationView {
                    List {
                        ForEach(viewModel.products) { product in
                            productRowView(product: product)
                        }
                        .onDelete() { indexSet in
                            viewModel.removeProducts(atOffsets: indexSet)
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .navigationTitle("Product")
                    .navigationBarItems(trailing: addButton)
                    .onAppear() {
                        print("BooksListView appears. Subscribing to data updates.")
                        self.viewModel.subscribe()
                    }
                    .background(Color.clear)
                    .sheet(isPresented: self.$presentAddBookSheet) {
                        ProductEditView()
                    }
                    // Ajustar los márgenes del NavigationView
                }.padding(EdgeInsets(top: 10, leading: 10, bottom: 80, trailing: 10))
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                .background(Color.clear)
            
        }
        .background(Color(red: 10, green: 0.88, blue: 0.88, opacity: 1))
    }
}


 
struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView()
    }
}
