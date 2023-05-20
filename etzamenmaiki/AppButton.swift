//
//  AppButton.swift
//  etzamenmaiki
//
//  Created by ISSC_612_2023 on 23/04/23.
//

import SwiftUI

struct AppButton: View {
    let title: String
    var onClick: () -> Void
    var body: some View {
        VStack{
            
            Button{
                onClick()
            }label: {
                Text(title).buttonStyle(.borderedProminent).frame(minWidth:.Magnitude(200),maxWidth: .Magnitude(200)).padding().background(Color(.white)).clipShape(Capsule()).foregroundColor(Color(.black)).shadow(radius: .Magnitude(5),y: 5)
            }
        }
    }
}

//hola amigos

struct AppButton_Previews: PreviewProvider {
    
    static var previews: some View {
        
        AppButton(title: "Hola",onClick: {
            print("hola")
        })
    }
}
