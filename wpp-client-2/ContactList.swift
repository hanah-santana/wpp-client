//
//  ContactList.swift
//  wpp-client-2
//
//  Created by Luiz Sena on 05/09/24.
//

import SwiftUI

struct ContactList: View {
    let id: String
    @State private var contactList: [Contact] = []
    @State private var isSheetPresented: Bool = false
    @StateObject private var  wsClient: WebSocket = WebSocket()
    @State private var allDisabled: Bool = false
    var body: some View {
        VStack {
            Button {
                allDisabled ? wsClient.connect() : wsClient.disconnect()
                allDisabled.toggle()
            } label: {
                Text(allDisabled ? "Ficar OFF" : "Ficar ON")
            }

            ScrollView{
                VStack(alignment: .center) {
                    if contactList.isEmpty {
                        Text("Sem Contatos...")
                    } else {
                        ForEach(contactList, id: \.self) { contact in
                            NavigationLink {
                                ChatView(id: id, contactId: contact.id, chatMessages: self.$wsClient.messages, onSend: { message in
                                    self.wsClient.sendData(DataWrapper(contentType: .message, content: message.toData()))
                                })
                            } label: {
                                Text(contact.name)
                            }
                        }
                    }
                }
            }
            .disabled(allDisabled)
            Button(action: {
                self.isSheetPresented.toggle()
            }, label: {
                Text("➕ Adicionar Contato")
            })

        }
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $isSheetPresented) {
           SheetView(contactList: $contactList)
        }
        .onAppear {
            self.wsClient.id = self.id
            self.wsClient.connect()
        }

    }

    func addContact() {

    }
}
//
//#Preview {
//    ContactList(wsClient: WebSocket(id: "aa"))
//}
