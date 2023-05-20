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
    @Environment(\.presentationMode) var presentationMode
    
    private var addButton: some View {
        Button(action: { self.presentAddBookSheet.toggle() }) {
            Image(systemName: "note.text.badge.plus").font(.system(size: 20.0)).fontWeight(.bold).foregroundColor(Color.black)
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
                NavigationStack {
                    List {
                        Section{
                            ForEach(viewModel.products) { product in
                                productRowView(product: product)
                            }
                            .onDelete() { indexSet in
                                viewModel.removeProducts(atOffsets: indexSet)
                            }
                            .listRowSeparator(.hidden)
                                .listRowBackground(Capsule()
                                  .fill(Color(white: 1)).padding(4))
                                .padding(.vertical, 15)
                                  .headerProminence(.increased)
                            
                        }header: {
                            HStack{
                                AppTaruls(title: "Product").bold()
                                Image(systemName: "note.text").font(.system(size: 20.0))
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
                    .navigationBarBackButtonHidden(true)
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
                }
            
        }
        .background(Color(red: 10, green: 0.88, blue: 0.88, opacity: 1))
    }
}


 
struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView()
    }
}
