//
//  Yuser.swift
//  etzamenmaiki
//
//  Created by ISSC_612_2023 on 28/04/23.
//

import SwiftUI

struct Yuser: View {
    var body: some View {
        NavigationView{
            
            ZStack{
                ScrollView{
                VStack{
                    
                    VStack{}.frame(height: CGFloat(30))
                    
                    AppTaruls(title: "User")
                    
                    
                }.frame(maxHeight: .infinity,alignment: .topTrailing)
                
                VStack (){
                    VStack{}.frame(height: CGFloat(50))
                    Group{
                        VStack{
                            AppLabel(title: "ID")
                                Textfield2(hint: "ID")}
                        VStack{
                            AppLabel(title: "Name")
                            Textfield2(hint: "Name")}
                        VStack{
                            AppLabel(title: "Lastname")
                            Textfield2(hint: "Lastname")}
                    }
                    VStack{
                        AppLabel(title: "Age")
                        Textfield2(hint: "Age")}
                    VStack{
                        AppLabel(title: "Gender")
                        Textfield2(hint: "Gender")}
                    VStack{
                        AppLabel(title: "Email")
                        Textfield2(hint: "Email")}
                    VStack{
                        AppLabel(title: "Password")
                        PassTextFiel(hint: "Password")}
                        VStack{}.frame(height: CGFloat(40))
                    
                    AppButton(title: "Register", onClick: {
                        //NavigationLink(<#T##titleKey: LocalizedStringKey##LocalizedStringKey#>, value: <#T##Hashable?#>)
                    })
                    
                }.frame(maxHeight: .infinity)}.frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top).background(Color(red:1,green:0.88,blue:0.88,opacity: 1))
        }
        }
    }
}

struct Yuser_Previews: PreviewProvider {
    static var previews: some View {
        Yuser()
    }
    
}
