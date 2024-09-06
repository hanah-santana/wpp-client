//
//  SheetView.swift
//  wpp-client-2
//
//  Created by Luiz Sena on 05/09/24.
//

import SwiftUI


struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var contactList: [Contact]
    @State private var name: String = ""
    @State private var id: String = ""
    var body: some View {
        TextField("Digite o apelido do seu contato:", text: $name)
        TextField("Digite o ID do seu contato:", text: $id)
        Button(action: {
            contactList.append(Contact(name: name, id: id))
            dismiss()
        }, label: {
            Text("Confirmar")
        }).buttonStyle(.bordered)


    }
}

#Preview {
    SheetView(contactList: .constant([]))
}
