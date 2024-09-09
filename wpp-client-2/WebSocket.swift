//
//  WebSocket.swift
//  wpp-client
//
//  Created by Hanah Santana on 05/09/24.
//

import Foundation

class WebSocket: ObservableObject {
    private let serverIp = "localhost:8080"
    private var webSocketTask: URLSessionWebSocketTask?
    private var httpTask: URLSessionDataTask?
    @Published var messages: [Message] = []
    @Published var id: String = ""


    func connect() {
        guard let url = URL(string: "ws://\(self.serverIp)/\(self.id)") else {return}
        let request = URLRequest(url: url)
        webSocketTask = URLSession.shared.webSocketTask(with: request)
        webSocketTask?.resume()
        receiveMessage()
        let verify = VerifyMessage(from: id, content: [])
        self.sendData(DataWrapper(contentType: .verifyMessages, content: verify.toData()))
    }

    func disconnect() {
        self.webSocketTask?.cancel()
    }

    internal func receiveMessage() {
        webSocketTask?.receive { result in
            switch result {
            case .success(let success):
                switch success {
                case .data(let data):
                    let decodedData = try! JSONDecoder().decode(DataWrapper.self, from: data)
                    switch decodedData.contentType {
                    case .message:
                        let decodedContent = try! JSONDecoder().decode(Message.self, from: decodedData.content)
                        DispatchQueue.main.async {
                            self.messages.append(decodedContent)
                        }
                    case .verifyMessages:
                        let decodedContent = try! JSONDecoder().decode(VerifyMessage.self, from: decodedData.content)
                        DispatchQueue.main.async {
                            decodedContent.content.forEach { self.messages.append($0)}
                        }
                    }
                case .string(let text):
                    print(text)
                @unknown default:
                    fatalError()
                }
            case .failure(let failure):
                print(failure.localizedDescription)
                return
            }
            self.receiveMessage()
        }
    }

    func sendData(_ dataWrapper: DataWrapper ) {
        let encoded = try! JSONEncoder().encode(dataWrapper)
        webSocketTask?.send(.data(encoded)) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    func sendText(_ msg: String) {
        webSocketTask?.send(.string(msg), completionHandler: { error in
            if let error = error {
                print(error.localizedDescription)
            }
        })
    }
}
