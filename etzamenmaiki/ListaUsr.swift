import SwiftUI
import Combine

struct ListaUsr: View {
    @StateObject var viewModel = UserListViewModel()
    
    var body: some View {
        ZStack {
            Color.white // Fondo blanco
            
            VStack(alignment: .leading, spacing: 8) {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .foregroundColor(.purple) // Color púrpura
                } else {
                    List(viewModel.users) { user in
                        UserListItemView(user: user)
                    }
                }
            }
            .padding()
        }
        .navigationBarTitle(Text("Users"), displayMode: .inline)
        .navigationBarItems(trailing:
            Button(action: {
                // Aquí se puede agregar la lógica para abrir el formulario para agregar un usuario
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.purple) // Color púrpura
            }
        )
        .onAppear {
            viewModel.fetchUsers()
        }
    }
}

struct UserListItemView: View {
    let user: User
    
    var body: some View {
        HStack(spacing: 8) {
            Circle()
                .frame(width: 50, height: 50)
                .foregroundColor(.blue) // Color azul
                .background(
                    AsyncImage(url: user.imageURL) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                    } placeholder: {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .foregroundColor(.purple) // Color púrpura
                    }
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(user.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.black) // Color negro
                
                Text("\(user.lastName) \(user.email) \(user.age)")
                    .foregroundColor(.black) // Color negro
                    .font(.subheadline)
            }
            
            Spacer()
            
            Button(action: {
                // Aquí se puede agregar la lógica para editar/eliminar un usuario
            }) {
                Image(systemName: "pencil")
                    .foregroundColor(.black) // Color negro
            }
        }
        .padding(.vertical, 8)
        .background(Color.white.opacity(0.7))
        .cornerRadius(10)
    }
}

struct User: Identifiable {
    let id = UUID()
    let name: String
    let lastName: String
    let email: String
    let age: String
    let imageURL: URL
}

class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    
    func fetchUsers() {
        isLoading = true
        
        // Simulación de carga de usuarios desde Firebase
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.users = [
                User(name: "John", lastName: "Doe", email: "john.doe@example.com", age: "30", imageURL: URL(string: "https://example.com/images/john.jpg")!),
                User(name: "Jane", lastName: "Smith", email: "jane.smith@example.com", age: "25", imageURL: URL(string: "https://example.com/images/jane.jpg")!)
            ]
            
            self.isLoading = false
        }
    }
}


struct ListaUsr_Previews: PreviewProvider {
    static var previews: some View {
        ListaUsr()
    }
}
