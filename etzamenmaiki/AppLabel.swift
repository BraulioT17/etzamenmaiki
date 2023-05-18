//
//  AppTaruls.swift
//  Etzamen2AYOUES
//
//  Created by ISSC_612_2023 on 24/04/23.
//

import SwiftUI

struct AppLabel: View {
    let title: String
    var body: some View {
        Text(title).font(.system(size:15)).foregroundColor(.red).fontWeight(Font.Weight.thin).tracking(10).fontDesign(.serif)
    }
}

struct AppLabel_Previews: PreviewProvider {
    static var previews: some View {
        AppTaruls(title: "hola")
    }
}
