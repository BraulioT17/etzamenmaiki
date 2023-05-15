//
//  ContentView.swift
//  etzamenmaiki
//
//  Created by ISSC_612_2023 on 23/04/23.
//

import SwiftUI

struct ContentView: View {
    @State var buttonClick = false
    var body: some View {
        NavigationView{
            ZStack{
                
                VStack{
                    
                    VStack{}.frame(height: CGFloat(25))
                    
                    AppTaruls(title: "Login")
                    
                    
                }.frame(maxHeight: .infinity,alignment: .topTrailing)
                VStack (spacing:20){
                    AppTaruls(title: "User")
                    
                    AppTeisfil(hint: "Usuario")
                    AppTaruls(title: "Password")
                    AppSicreTeisfil(hint: "Password")
                    AppButton(title: "Log in", onClick: {
                        print(buttonClick)
                        buttonClick = true
                        print(buttonClick)
                        //NavigationLink
                    })
                    
                    
                }.frame(maxHeight: .infinity)
                
                NavigationLink(destination: Menu(), isActive: $buttonClick, label: {EmptyView()})
            }.frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top).background(Color(red:1,green:0.88,blue:0.88,opacity: 1))
            
        }
        
        
}
                         
                         
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
