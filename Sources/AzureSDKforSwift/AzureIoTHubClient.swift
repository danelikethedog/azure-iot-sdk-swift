//
//  File.swift
//  
//
//  Created by Dane Walton on 11/12/21.
//

import Foundation
import MQTT
import NIOSSL

public struct AzureIoTHubClient {
    private let hostname: String?
    private let deviceId: String?
    private let moduleId: String?
    private let modelId: String?
    private let mqttClient: MQTTClient?
    
    public init(
        hostname: String,
        deviceId: String,
        moduleId: String? = nil,
        modelId: String? = nil
    ) {
        self.hostname = hostname
        self.deviceId = deviceId
        self.modelId = moduleId
        self.modelId = modelId
        self.mqttClient = MQTTClient()
    }
    
    public func connect()
    {
        
    }
}
