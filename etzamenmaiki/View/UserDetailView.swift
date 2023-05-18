//
//  UserDetailView.swift
//  etzamenmaiki
//
//  Created by ISSC_612_2023 on 17/05/23.
//

import SwiftUI
//import SDWebImageSwiftUI
 
struct UserDetailsView: View {
   
  @Environment(\.presentationMode) var presentationMode
  @State var presentEditBookSheet = false
   
   
  var user: UserModel
   
  private func editButton(action: @escaping () -> Void) -> some View {
    Button(action: { action() }) {
      Text("Edit")
    }
  }
   
  var body: some View {
    Form {
      Section(header: Text("User")) {
        Text(user.nombre)
        Text("\(user.edad) year(s)")
      }
       
      Section(header: Text("Name")) {
        Text(user.nombre)
      }
        Section(header: Text("Lastname")) {
          Text(user.apellido)
        }
        Section(header: Text("Email")) {
          Text(user.correo)
        }
        Section(header: Text("Gender")) {
          Text(user.genero)
        }
      //Section(header: Text("Photo")) {
          //AnimatedImage(url: URL(string: book.image)!).resizable().frame(width: 300, height: 300)
      //}
    }
    .navigationBarTitle(user.nombre)
    .navigationBarItems(trailing: editButton {
      self.presentEditBookSheet.toggle()
    })
    .onAppear() {
      print("BookDetailsView.onAppear() for \(self.user.nombre)")
    }
    .onDisappear() {
      print("BookDetailsView.onDisappear()")
    }
    .sheet(isPresented: self.$presentEditBookSheet) {
      UserEditView(viewModel: UserViewModel(userModel: user), mode: .edit) { result in
        if case .success(let action) = result, action == .delete {
          self.presentationMode.wrappedValue.dismiss()
        }
      }
    }
  }
}

 
struct UserDetailsView_Previews: PreviewProvider {
  static var previews: some View {
      let user = UserModel(apellido: "Coder", correo: "Cairocoders", edad: 23, genero: "photo1", nombre: "")
    return
      NavigationView {
        UserDetailsView(user: user)
      }
  }
}
