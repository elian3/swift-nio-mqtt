//
//  PubCompPacket+ReasonCode.swift
//  NIOMQTT
//
//  Created by Bofei Zhu on 7/28/19.
//  Copyright © 2019 HealthTap Inc. All rights reserved.
//

extension PubCompPacket {

    /// PUBCOMP Reason Code
    enum ReasonCode: ReasonCodeValue {

        /// Success
        ///
        /// Packet Identifier released. Publication of QoS 2 message is complete.
        case success = 0

        /// Packet Identifier Not Found
        ///
        /// The Packet Identifier is not known. This is not an error during recovery,
        /// but at other times indicates a mismatch between the Session State on the Client and Server.
        case packetIdentifierNotFound = 146
    }
}
