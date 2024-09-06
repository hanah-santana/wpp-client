//
//  ContentView.swift
//  wpp-client-2
//
//  Created by Luiz Sena on 05/09/24.
//

import SwiftUI

struct ContentView: View {
    @State private var number = 0

    var body: some View {
        VStack {
            Text("Digite o seu número:")
            TextField("Seu número", value: $number, format: .number)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .padding()

            NavigationLink(destination: ContactList(id: self.number.description)) {
                Text("Confirmar!")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
