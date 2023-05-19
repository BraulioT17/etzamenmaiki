//
//  UsersView.swift
//  etzamenmaiki
//
//  Created by ISSC_612_2023 on 17/05/23.
//

import SwiftUI
import Firebase
//import SDWebImageSwiftUI
 
struct UsersView: View {
    @StateObject var viewModel = UsersViewModel()
    @State var presentAddBookSheet = false
    
    private var addButton: some View {
        Button(action: { self.presentAddBookSheet.toggle() }) {
            Image(systemName: "plus")
        }
    }
    
    private func userRowView(user: UserModel) -> some View {
        NavigationLink(destination: UserDetailsView(user: user)) {
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(user.nombre)
                            .fontWeight(.bold)
                        Text(user.apellido)
                    }
                }
            }
        }
    }
    
    var body: some View {

            ZStack {
                NavigationView {
                    List {
                        ForEach(viewModel.users) { userModel in
                            userRowView(user: userModel)
                        }
                        .onDelete() { indexSet in
                            viewModel.removeUsers(atOffsets: indexSet)
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .navigationTitle("User")
                    .navigationBarItems(trailing: addButton)
                    .onAppear() {
                        print("BooksListView appears. Subscribing to data updates.")
                        self.viewModel.subscribe()
                    }
                    .background(Color.clear)
                    .sheet(isPresented: self.$presentAddBookSheet) {
                        UserEditView()
                    }
                    // Ajustar los márgenes del NavigationView
                }.padding(EdgeInsets(top: 10, leading: 10, bottom: 80, trailing: 10))
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                .background(Color.clear)
            
        }
        .background(Color(red: 10, green: 0.88, blue: 0.88, opacity: 1))
    }
}


 
struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}
