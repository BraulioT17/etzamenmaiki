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
                //AnimatedImage(url: URL(string: book.image)!).resizable().frame(width: 65, height: 65).clipShape(Circle())
                 
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
      NavigationView {
        List {
          ForEach (viewModel.users) { userModel in
              userRowView(user: userModel)
          }
          .onDelete() { indexSet in
            viewModel.removeUsers(atOffsets: indexSet)
          }
        }
        .navigationBarTitle("Users")
        .navigationBarItems(trailing: addButton)
        .onAppear() {
          print("BooksListView appears. Subscribing to data updates.")
          self.viewModel.subscribe()
        }
        .sheet(isPresented: self.$presentAddBookSheet) {
          UserEditView()
        }
      }
    }
  }
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
