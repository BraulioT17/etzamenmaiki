//
//  Produtz.swift
//  etzamenmaiki
//
//  Created by ISSC_612_2023 on 28/04/23.
//

import SwiftUI

struct Produtz: View {
    var body: some View {
        ZStack{
            
            VStack{
                
                VStack{}.frame(height: CGFloat(25))
                
                AppTaruls(title: "Products")
                
                
            }.frame(maxHeight: .infinity,alignment: .topTrailing)
            VStack (){
                AppTeisfil(hint: "ID")
                AppTeisfil(hint: "Name")
                AppTeisfil(hint: "Age")
                AppTeisfil(hint: "Gender")
                AppTeisfil(hint: "Email")
                AppSicreTeisfil(hint: "Password")
                VStack{}.frame(height: CGFloat(25))

                AppButton(title: "Log in", onClick: {
                    //NavigationLink(<#T##titleKey: LocalizedStringKey##LocalizedStringKey#>, value: <#T##Hashable?#>)
                })
                
            }.frame(maxHeight: .infinity)}.frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top).background(Color(red:1,green:0.88,blue:0.88,opacity: 1))
    }
}

struct Produtz_Previews: PreviewProvider {
    static var previews: some View {
        Produtz()
    }
}