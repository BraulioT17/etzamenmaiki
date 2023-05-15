//
//  AppTaruls.swift
//  Etzamen2AYOUES
//
//  Created by ISSC_612_2023 on 24/04/23.
//

import SwiftUI

struct AppTaruls: View {
    let title: String
    var body: some View {
        Text(title).font(.system(size: 20)).foregroundColor(.red).fontWeight(Font.Weight.thin).tracking(20).fontDesign(.serif)
    }
}

struct AppTaruls_Previews: PreviewProvider {
    static var previews: some View {
        AppTaruls(title: "Usuarios")
    }
}
