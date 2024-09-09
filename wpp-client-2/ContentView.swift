//
//  ContentView.swift
//  wpp-client
//
//  Created by  Hanah Santana on 05/09/24.
//

import SwiftUI

struct ContentView: View {
    @State private var number = 0

    var body: some View {
        VStack {
            HStack {
                Text("Digite o seu id:")
                    .foregroundStyle(.white)
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 8.0).foregroundStyle(.gray))

                TextField("Seu número", value: $number, format: .number)
//                    .padding(.horizontal, 100)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
            }.padding(.horizontal,50)


            NavigationLink(destination: ContactList(id: self.number.description)) {
                Text("Confirmar!")
                    .frame(width: 350, height: 35)
            }
            .buttonStyle(.borderedProminent)

        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color(.orange).opacity(0.85))
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ContentView()
}
