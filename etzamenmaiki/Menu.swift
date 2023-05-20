//
//  Menu.swift
//  etzamenmaiki
//
//  Created by ISSC_612_2023 on 28/04/23.
//

import SwiftUI

struct Menu: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) private var presentationMode
    @State var buttonClickReg = false
    @State var buttonClickSal = false
    @State var buttonClickPur = false
    var body: some View {
        NavigationStack{
            ZStack{

                
                VStack{
                    
                    
                    VStack{}.frame(height: CGFloat(45))
                    
                    AppTituls(title: "Options")
                    
                    
                }.frame(maxHeight: .infinity,alignment: .topTrailing)
  
                VStack (spacing:50){
                    
                    Image(systemName: "books.vertical").font(.system(size: 100.0))
                    AppButton(title: "Register", onClick: {
                        buttonClickReg = true
                    })
                    AppButton(title: "Sales",onClick: {
                        buttonClickSal = true
                    })
                    AppButton(title: "Purchase",onClick: {
                        buttonClickPur = true
                    })
                    
                }.frame(maxHeight: .infinity)
                
                NavigationLink(destination: RegisterPlus(), isActive: $buttonClickReg, label: {EmptyView()})
                NavigationLink(destination: SalesView(), isActive: $buttonClickSal, label: {EmptyView()})
                NavigationLink(destination: PurchasesView(), isActive: $buttonClickPur, label: {EmptyView()})
                    .navigationBarBackButtonHidden(true)
                    .toolbar(content: {
                        ToolbarItem(placement: .navigationBarLeading){
                            Button(action: {presentationMode.wrappedValue.dismiss()}, label: {Image(systemName: "house").foregroundColor(Color.red).font(.system(size: 22))})
                        }
                    })
                
            }.frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top).background(Color(red:1,green:0.88,blue:0.88,opacity: 1))

        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
