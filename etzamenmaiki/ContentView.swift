//
//  ContentView.swift
//  etzamenmaiki
//
//  Created by ISSC_612_2023 on 23/04/23.
//

import SwiftUI

struct ContentView: View {
    @State var buttonClickLog = false
    var body: some View {
        NavigationStack{
            
            ZStack{
                
                
                VStack{
                    
                    VStack{}.frame(height: CGFloat(10))
                    
                    AppTituls(title: "Login")
                    VStack{}.frame(height: CGFloat(5))
                    
                    Image(systemName: "person.crop.circle").font(.system(size: 100.0)).foregroundColor(Color.black)
                    
                    VStack{}.frame(height: CGFloat(90))
                    
                }.frame(maxHeight: .infinity,alignment: .topTrailing)
                VStack{}.frame(height: CGFloat(90))
                VStack (spacing:8){
                    AppTaruls(title: "User")
                    
                    Textfield2(hint: "Usuario")
                    AppTaruls(title: "Password")
                    PassTextFiel(hint: "Password")
                    VStack{}.frame(height: CGFloat(20))
                    AppButton(title: "Log in", onClick: {
                        buttonClickLog = true
                    })
                    
                    
                    
                }.frame(maxHeight: .infinity)
                
                NavigationLink(destination: Menu(), isActive: $buttonClickLog, label: {EmptyView()}).toolbarRole(.editor)
                
            }.frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top).background(Color(red:10,green:0.88,blue:0.88,opacity: 1))
                
            
        }
        
        
        
}
                         
                         
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
