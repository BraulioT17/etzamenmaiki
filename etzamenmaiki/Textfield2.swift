//
//  Textfield2.swift
//  etzamenmaiki
//
//  Created by ISSC_612_2023 on 17/05/23.
//

import SwiftUI

struct Textfield2: View {
    @State var inputText: String = ""
    let hint:String
    struct OvalTextFieldStyle: TextFieldStyle {
        func _body(configuration: TextField<Self._Label>) -> some View {
            configuration
                .padding(10)
                .background(LinearGradient(gradient: Gradient(colors: [Color.clear, Color.white]), startPoint: .trailing, endPoint: .leading))
                .cornerRadius(20)
                .shadow(color: .white, radius: 5)
        }
    }
    
    @State var text = ""
    var body: some View {
        VStack(alignment: .leading) {
                        HStack {
                            TextField(hint, text: $inputText)
                        }
                        .textFieldStyle(OvalTextFieldStyle())
                        .foregroundColor(Color.red)
                        
                    }.padding()
    }
}

struct Textfield2_Previews: PreviewProvider {
    static var previews: some View {
        Textfield2(hint: "hola")
        
    }
}
