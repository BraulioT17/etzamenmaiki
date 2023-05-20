//
//  AppTituls.swift
//  etzamenmaiki
//
//  Created by ISSC_612_2023 on 19/05/23.
//

import SwiftUI

struct AppTituls: View {
    let title: String
    var body: some View {
        Text(title).font(.system(size: 30)).foregroundColor(.red).tracking(20).fontDesign(.serif).fontWeight(.bold)
    }
}

struct AppTituls_Previews: PreviewProvider {
    static var previews: some View {
        AppTaruls(title: "Usuarios")
    }
}
