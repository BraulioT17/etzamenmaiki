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
      Text("Cancel")
    }
  }
   
  var saveButton: some View {
    Button(action: { self.handleDoneTapped() }) {
      Text(mode == .new ? "Done" : "Save")
    }
    .disabled(!viewModel.modified)
  }
   
  var body: some View {
    NavigationView {
      Form{
        Section(header: Text("User")) {
          TextField("Email", text: $viewModel.userModel.correo)
          
        }
          
          Section(header: Text("Age")) {
              TextField("Age", value: $viewModel.userModel.numberOfPages, formatter: NumberFormatter())
          }
         
        Section(header: Text("Name")) {
          TextField("Name", text: $viewModel.userModel.nombre)
        }
          
          Section(header: Text("Lastname")) {
            TextField("Lastname", text: $viewModel.userModel.apellido)
          }
          
          Section(header: Text("Gender")) {
            TextField("Gender", text: $viewModel.userModel.genero)
          }
 
        Section(header: Text("Photo")) {
            TextField("Image", text: $viewModel.userModel.image)
        }
           
        if mode == .edit {
          Section {
            Button("Delete user") { self.presentActionSheet.toggle() }
              .foregroundColor(.red)
          }
        }
      }
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
    let user = UserModel(apellido: "Coder", correo: "Cairocoders", edad: 89, genero: "photo1", nombre: "")
    let userViewModel = UserViewModel(userModel: user)
    return UserEditView(viewModel: userViewModel, mode: .edit)
  }
}
