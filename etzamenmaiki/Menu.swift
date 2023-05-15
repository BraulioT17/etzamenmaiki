//
//  Menu.swift
//  etzamenmaiki
//
//  Created by ISSC_612_2023 on 28/04/23.
//

import SwiftUI

struct Menu: View {
    var body: some View {
        ZStack{
            
            VStack{
                
                VStack{}.frame(height: CGFloat(25))
    
                AppTaruls(title: "Menu")


            }.frame(maxHeight: .infinity,alignment: .topTrailing)
            VStack (spacing:50){
                AppButton(title: "Register", onClick: {})
                AppButton(title: "Sales",onClick: {})
                AppButton(title: "Purchase",onClick: {})
                
            }.frame(maxHeight: .infinity)}.frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top).background(Color(red:1,green:0.88,blue:0.88,opacity: 1))
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
