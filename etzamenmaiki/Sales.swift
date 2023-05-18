//
//  Sales.swift
//  etzamenmaiki
//
//  Created by ISSC_612_2023 on 17/05/23.
//

import SwiftUI

struct Sales: View {
    var body: some View {
        NavigationView{
            
            ZStack{
                ScrollView{
                VStack{
                    
                    VStack{}.frame(height: CGFloat(30))
                    
                    AppTaruls(title: "Sales")
                    
                    
                }.frame(maxHeight: .infinity,alignment: .topTrailing)
                
                VStack (){
                    VStack{}.frame(height: CGFloat(50))
                    Group{
                        VStack{
                            AppLabel(title: "IDProduct")
                            Textfield2(hint: "IDProduct")}
                        VStack{
                            AppLabel(title: "Name")
                            Textfield2(hint: "Name")}
                        VStack{
                            AppLabel(title: "Quantity")
                            Textfield2(hint: "Quantity")}
                    }
                    VStack{
                        AppLabel(title: "Sale ID")
                        Textfield2(hint: "Sale ID")}
                    VStack{
                        AppLabel(title: "Purchase ID")
                        Textfield2(hint: "Purchase ID")}
                    VStack{
                        AppLabel(title: "Pieces")
                        Textfield2(hint: "Pieces")}
                    VStack{
                        AppLabel(title: "Subtotal")
                        Textfield2(hint: "Subtotal")}
                    VStack{
                        AppLabel(title: "Total")
                        Textfield2(hint: "Total")}
                        VStack{}.frame(height: CGFloat(40))
                    
                    AppButton(title: "Send Sale", onClick: {
                        //NavigationLink(<#T##titleKey: LocalizedStringKey##LocalizedStringKey#>, value: <#T##Hashable?#>)
                    })
                    
                }.frame(maxHeight: .infinity)}.frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top).background(Color(red:1,green:0.88,blue:0.88,opacity: 1))
        }
        }
    }
}

struct Sales_Previews: PreviewProvider {
    static var previews: some View {
        Sales()
    }
}
