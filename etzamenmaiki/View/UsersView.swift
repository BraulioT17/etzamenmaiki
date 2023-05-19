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
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
     
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
                  Section{
                      ForEach (viewModel.users) { userModel in
                          userRowView(user: userModel)
                      }
                      .onDelete() { indexSet in
                          viewModel.removeUsers(atOffsets: indexSet)
                      }.listRowSeparator(.hidden)
                          .listRowBackground(Capsule()
                            .fill(Color(white: 1)).padding(1))
                          .padding(.vertical, 15)
                            .headerProminence(.increased)
                            
                  }header: {
                      AppTaruls(title: "Users").bold()
                      VStack{}.frame(height: CGFloat(55))
                  }.listRowInsets(.init(top: 0, leading: 20, bottom: 0, trailing: 20))
                      
                  
              }
          
        .scrollContentBackground(.hidden)
        .background(Color(red:10,green:0.88,blue:0.88,opacity: 1))
        
          
        .navigationBarItems(trailing: addButton).foregroundColor(Color.black)
        .onAppear() {
          print("BooksListView appears. Subscribing to data updates.")
          self.viewModel.subscribe()
        }
        .sheet(isPresented: self.$presentAddBookSheet) {
          UserEditView()
        }
        .background(Color.clear) // Agregar un fondo rosa a la vista
      }
    }
}


 
struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}
