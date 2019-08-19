//
//  PubRelPacket+VariableHeader.swift
//  NIOMQTT
//
//  Created by Bofei Zhu on 7/28/19.
//  Copyright © 2019 HealthTap Inc. All rights reserved.
//

extension PubRelPacket: VariableHeaderPacket {

    /// PUBREL Variable Header
    struct VariableHeader: HasProperties {

        /// Packet Identifier
        let packetIdentifier: UInt16

        /// Reason Code
        let reasonCode: ReasonCode

        /// Properties
        let properties: PropertyCollection
    }
}
