//
//  Produtz.swift
//  etzamenmaiki
//
//  Created by ISSC_612_2023 on 28/04/23.
//

import SwiftUI

struct Produtz: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) private var presentationMode
    var body: some View {
        NavigationStack{
            
            ZStack{
                ScrollView{
                VStack{
                    
                    VStack{}.frame(height: CGFloat(30))
                    
                    AppTaruls(title: "Products")
                    
                    
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
                            AppLabel(title: "Description")
                            Textfield2(hint: "Description")}
                    }
                    VStack{
                        AppLabel(title: "Units")
                        Textfield2(hint: "Units")}
                    VStack{
                        AppLabel(title: "Cost")
                        Textfield2(hint: "Cost")}
                    VStack{
                        AppLabel(title: "Price")
                        Textfield2(hint: "Price")}
                    VStack{
                        AppLabel(title: "Utility")
                        Textfield2(hint: "Utility")}
                        VStack{}.frame(height: CGFloat(40))
                    
                    AppButton(title: "Register", onClick: {
                        //NavigationLink(<#T##titleKey: LocalizedStringKey##LocalizedStringKey#>, value: <#T##Hashable?#>)
                    })
                    .navigationBarBackButtonHidden(true)
                        .toolbar(content: {
                            ToolbarItem(placement: .navigationBarLeading){
                                Button(action: {presentationMode.wrappedValue.dismiss()}, label: {Image(systemName: "arrow.uturn.backward.circle").foregroundColor(Color.red).font(.system(size: 22))})
                            }
                        })
                }.frame(maxHeight: .infinity)}.frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top).background(Color(red:1,green:0.88,blue:0.88,opacity: 1))
        }
        }
    }
}

struct Produtz_Previews: PreviewProvider {
    static var previews: some View {
        Produtz()
    }
}
