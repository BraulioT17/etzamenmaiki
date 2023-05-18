//
//  Purchase.swift
//  etzamenmaiki
//
//  Created by ISSC_612_2023 on 17/05/23.
//

import SwiftUI

struct Purchase: View {
    @State var buttonClick = false
    var body: some View {
        NavigationView{
            
            ZStack{
                ScrollView{
                VStack{
                    
                    VStack{}.frame(height: CGFloat(30))
                    
                    AppTaruls(title: "Purchase")
                    
                    
                }.frame(maxHeight: .infinity,alignment: .topTrailing)
                
                VStack (){
                    VStack{}.frame(height: CGFloat(50))
                VStack{
                    AppLabel(title: "Product ID")
                    Textfield2(hint: "Product ID")}
                VStack{
                    AppLabel(title: "Name")
                    Textfield2(hint: "Name")}
                VStack{
                    AppLabel(title: "Pieces")
                    Textfield2(hint: "Pieces")}
                    
                VStack{
                    AppLabel(title: "Register ID")
                    Textfield2(hint: "Register ID")}
                }
                    VStack{}.frame(height: CGFloat(30))

                    
                    AppButton(title: "Register", onClick: {
                        //NavigationLink(<#T##titleKey: LocalizedStringKey##LocalizedStringKey#>, value: <#T##Hashable?#>)
                    })
                    
                }.frame(maxHeight: .infinity)}.frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top).background(Color(red:1,green:0.88,blue:0.88,opacity: 1))
        }
        }
    }


struct Purchase_Previews: PreviewProvider {
    static var previews: some View {
        Purchase()
    }
}
