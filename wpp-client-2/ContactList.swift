//
//  ContactList.swift
//  wpp-client
//
//  Created by Hanah Santana on 05/09/24.
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
                Text(allDisabled ? "Ficar ON" : "Ficar OFF")
                    .foregroundStyle(allDisabled ? .gray : .red)
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
                                HStack{
                                    Text("🙎")
                                    Text(contact.name)
                                }
                                .foregroundStyle(.white)
                                .padding(10)
                                .frame(maxWidth: .infinity)
                                .background(.gray.opacity(0.65))
                                .contextMenu {
                                    Button {
                                        self.contactList.removeAll {
                                            $0.id == contact.id
                                        }
                                    } label: {
                                        Text("Remover")
                                    }

                                }
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
            .buttonStyle(.borderedProminent)

        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color(.orange).opacity(0.85))
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
