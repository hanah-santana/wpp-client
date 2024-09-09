//
//  ChatView.swift
//  wpp-client
//
//  Created by Hanah Santana on 05/09/24.
//

import SwiftUI

struct ChatView: View {
    let id: String
    let contactId: String
    @Binding var chatMessages: [Message]
    @State var messageToSend: String = ""
    var onSend: (Message) -> ()

    var body: some View {

        VStack {
            ScrollView(.vertical) {
                VStack {
                    ForEach(chatMessages, id: \.content) { message in
                        if ((message.from == self.id || message.from == self.contactId) && (message.to == self.id || message.to == self.contactId)) {
                            Text(message.content)
                                .padding(10)
                                .background(RoundedRectangle(cornerRadius: 8.0).foregroundStyle(message.to == id ? .green : .blue))
                        }
                    }
                }
            }
            
            HStack {
                TextField("Envie sua mensagem:", text: $messageToSend)
                    .padding(10)
                Button {
                    let message = Message(from: id, to: contactId, content: messageToSend)
                    self.chatMessages.append(message)
                    onSend(message)
                } label: {
                    Text("Enviar")
                }.buttonStyle(.bordered)

            }

        }

    }
}
//
//#Preview {
//    ChatView(id: "1", contactId: "2",chatMessages: .constant([]))
//}
