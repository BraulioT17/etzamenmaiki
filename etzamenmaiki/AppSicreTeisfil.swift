//
//  AppSicreTeisfil.swift
//  etzamenmaiki
//
//  Created by ISSC_612_2023 on 28/04/23.
//

import SwiftUI

struct AppSicreTeisfil: View {
    let hint:String
    @State var inputText: String = ""
    var body: some View {
        SecureField(hint, text: $inputText)
        .padding(.leading, 20)
        .padding(.trailing, 20)
        .background(
            RoundedRectangle(cornerRadius: 2)
                .fill(Color.white.opacity(0.3)
            )
            .padding(.leading, 20)
            .padding(.trailing, 20)
        )
        .padding(.top)
        .padding(.bottom)
    }
}

struct AppSicreTeisfil_Previews: PreviewProvider {
    static var previews: some View {
        AppSicreTeisfil(hint: "Jijijija")
    }
}
