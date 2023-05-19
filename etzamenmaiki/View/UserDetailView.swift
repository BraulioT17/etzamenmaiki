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
        Text("Edit").foregroundColor(Color.black)
    }.foregroundColor(Color.black)
  }
   
  var body: some View {
      
    Form {
      Section(header: AppLabel(title: "User")) {
        Text(user.correo)
        Text("\(user.edad) year(s)")
      }
       
      Section(header: AppLabel(title: "Name")) {
        Text(user.nombre)
      }
        Section(header: AppLabel(title: "Lastname")) {
          Text(user.apellido)
        }
        Section(header: AppLabel(title: "Gender")) {
          Text(user.genero)
        }
      //Section(header: Text("Photo")) {
          //AnimatedImage(url: URL(string: book.image)!).resizable().frame(width: 300, height: 300)
      //}
    }.scrollContentBackground(.hidden)
          .background(Color(red:10,green:0.88,blue:0.88,opacity: 1))
      // Establecer el color rojo como fondo del formulario
          .foregroundColor(Color.black)
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
      let user = UserModel(apellido: "Uribe", correo: "alessia@hols.com", edad: "23", genero: "femenino", nombre: "Alessia")
    return
      NavigationView {
        UserDetailsView(user: user)
      }
  }
}
