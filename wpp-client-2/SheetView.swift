//
//  SheetView.swift
//  wpp-client
//
//  Created by  Hanah Santana on 05/09/24.
//

import SwiftUI


struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var contactList: [Contact]
    @State private var name: String = ""
    @State private var id: String = ""
    var body: some View {
        VStack {
            TextField("Digite o apelido do seu contato:", text: $name)
                .textFieldStyle(.roundedBorder)
                .padding()
            TextField("Digite o ID do seu contato:", text: $id)
                .textFieldStyle(.roundedBorder)
                .padding()
            Button(action: {
                contactList.append(Contact(name: name, id: id))
                dismiss()
            }, label: {
                Text("Confirmar")
            }).buttonStyle(.bordered)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.orange).opacity(0.85))
    }
}

#Preview {
    SheetView(contactList: .constant([]))
}
