//
//  UserEditView.swift
//  etzamenmaiki
//
//  Created by ISSC_612_2023 on 17/05/23.
//

import SwiftUI
 
enum Mode {
  case new
  case edit
}
 
enum Action {
  case delete
  case done
  case cancel
}
 
struct UserEditView: View {
   
  @Environment(\.presentationMode) private var presentationMode
  @State var presentActionSheet = false
 
   
  @ObservedObject var viewModel = UserViewModel()
  var mode: Mode = .new
  var completionHandler: ((Result<Action, Error>) -> Void)?
   
   
  var cancelButton: some View {
    Button(action: { self.handleCancelTapped() }) {
        Text("Cancel").foregroundColor(Color.black)
    }
  }
   
  var saveButton: some View {
    Button(action: { self.handleDoneTapped() }) {
      Text(mode == .new ? "Done" : "Save")
    }.foregroundColor(Color.black)
    .disabled(!viewModel.modified)
  }
   
  var body: some View {
    NavigationView {
        Form{
        Section(header: AppLabel(title: "User")) {
          TextField("Email", text: $viewModel.userModel.correo)
          
        }
          
          Section(header: AppLabel(title: "Age")) {
              TextField("Age", value: $viewModel.userModel.edad, formatter: NumberFormatter())
          }
         
          Section(header: AppLabel(title: "Name")) {
          TextField("Name", text: $viewModel.userModel.nombre)
        }
          
          Section(header: AppLabel(title: "Lastname")) {
            TextField("Lastname", text: $viewModel.userModel.apellido)
          }
          
          Section(header: AppLabel(title: "Gender")) {
            TextField("Gender", text: $viewModel.userModel.genero)
          }
 
        //Section(header: Text("Photo")) {
            //TextField("Image", text: $viewModel.userModel.image)
        //}
           
        if mode == .edit {
          Section {
            Button("Delete user") { self.presentActionSheet.toggle() }
              .foregroundColor(.red)
              .fontWeight(.bold)
          }
        }
      }.scrollContentBackground(.hidden)
            .background(Color(red:10,green:0.88,blue:0.88,opacity: 1))
      .navigationTitle(mode == .new ? "New user" : viewModel.userModel.nombre)
      .navigationBarTitleDisplayMode(mode == .new ? .inline : .large)
      .navigationBarItems(
        leading: cancelButton,
        trailing: saveButton
      )
      .actionSheet(isPresented: $presentActionSheet) {
          ActionSheet(title: Text("Are you sure?"),
                      buttons: [
                        .destructive(Text("Delete user"),
                                     action: { self.handleDeleteTapped() }),
                        .cancel()
                      ])
      }
    }
  }
   
  func handleCancelTapped() {
    self.dismiss()
  }
   
  func handleDoneTapped() {
    self.viewModel.handleDoneTapped()
    self.dismiss()
  }
   
  func handleDeleteTapped() {
    viewModel.handleDeleteTapped()
    self.dismiss()
    self.completionHandler?(.success(.delete))
  }
   
  func dismiss() {
    self.presentationMode.wrappedValue.dismiss()
  }
}
 
struct UserEditView_Previews: PreviewProvider {
  static var previews: some View {
    let user = UserModel(apellido: "Coder", correo: "Cairocoders", edad: "89", genero: "photo1", nombre: "")
    let userViewModel = UserViewModel(userModel: user)
    return UserEditView(viewModel: userViewModel, mode: .edit)
  }
}

