//
//  AppTeisfil.swift
//  etzamenmaiki
//
//  Created by ISSC_612_2023 on 23/04/23.
//

import SwiftUI

struct AppTeisfil: View {
    let hint:String
    @State var inputText: String = ""
    var body: some View {
        TextField(hint, text: $inputText)
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

struct AppTeisfil_Previews: PreviewProvider {
    @State var inputText2: String = ""
    static var previews: some View {
        
        VStack{
            AppTeisfil(hint: "Hoa")}.background(Color(.red))
    }
}
