//
//  RegisterPlus.swift
//  etzamenmaiki
//
//  Created by ISSC_612_2023 on 17/05/23.
//

import SwiftUI

struct RegisterPlus: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) private var presentationMode
    @State var buttonClickUsr = false
    @State var buttonClickProd = false
    var body: some View {
        NavigationStack{
            ZStack{
                
                VStack{
                    
                    VStack{}.frame(height: CGFloat(45))
                    
                    AppTituls(title: "Register")
                    
                    
                }.frame(maxHeight: .infinity,alignment: .topTrailing)
                
                VStack (spacing:50){
                    Image(systemName: "doc.badge.plus").font(.system(size: 90.0))
                    VStack{}.frame(height: CGFloat(5))
                    AppButton(title: "User", onClick: {
                        buttonClickUsr = true
                    })
                    AppButton(title: "Products",onClick:{
                        buttonClickProd = true
                    })
                    
                }.frame(maxHeight: .infinity)
                
                NavigationLink(destination: UsersView(), isActive: $buttonClickUsr, label: {EmptyView()})
                NavigationLink(destination: ProductsView(), isActive: $buttonClickProd, label: {EmptyView()})                 .navigationBarBackButtonHidden(true)
                    .toolbar(content: {
                        ToolbarItem(placement: .navigationBarLeading){
                            Button(action: {presentationMode.wrappedValue.dismiss()}, label: {Image(systemName: "arrow.uturn.backward.circle").foregroundColor(Color.red).font(.system(size: 22))})
                        }
                    })
                
            }.frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top).background(Color(red:1,green:0.88,blue:0.88,opacity: 1))
        }
    }
}

struct RegisterPlus_Previews: PreviewProvider {
    static var previews: some View {
        RegisterPlus()
    }
}
