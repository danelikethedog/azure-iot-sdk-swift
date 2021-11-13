//
//  File.swift
//
//
//  Created by Dane Walton on 11/12/21.
//

import AzureSDKforSwift

let sem = DispatchSemaphore(value: 0)
let queue = DispatchQueue(label: "a", qos: .background)

class App: MQTTClientDelegate {
    let client: AzureIoTHubClient

    var delegateDispatchQueue: DispatchQueue {
        queue
    }

    init() {
        client = AzureIoTHubClient(
            hostName: "dawalton-hub.azure-devices.net",
            deviceId: "String",
        )
    }

    func run() throws {
        client.connect()
    }

    func mqttClient(_ client: MQTTClient, didReceive packet: MQTTPacket) {
        switch packet {
        case let packet as ConnAckPacket:
            print("Connack \(packet)")
            client.subscribe(topic: "a", qos: QOS.0)
            client.publish(topic: "a", retain: false, qos: QOS.0, payload: "abc")
            queue.asyncAfter(deadline: .now() + 40) {
                self.client.disconnect()
            }
        default:
            print(packet)
        }
    }

    func mqttClient(_: MQTTClient, didChange state: ConnectionState) {
        if state == .disconnected {
            sem.signal()
        }
        print(state)
    }

    func mqttClient(_: MQTTClient, didCatchError error: Error) {
        print("Error: \(error)")
    }
}

let app = App()
try app.run()

sem.wait()
