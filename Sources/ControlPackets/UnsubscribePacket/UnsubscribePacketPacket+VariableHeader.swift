//
//  UnsubscribePacket+VariableHeader.swift
//  NIOMQTT
//
//  Created by Bofei Zhu on 8/19/19.
//  Copyright © 2019 HealthTap Inc. All rights reserved.
//

extension UnsubscribePacket: VariableHeaderPacket {

    /// UNSUBSCRIBE Variable Header
    struct VariableHeader: HasProperties, MQTTByteRepresentable {

        /// Packet Identifier
        let packetIdentifier: UInt16

        /// Properties
        let properties: PropertyCollection

        var mqttByteCount: Int {
            return UInt16.byteCount + properties.mqttByteCount
        }
    }
}
