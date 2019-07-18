//
//  PingRespPacket.swift
//  NIOMQTT
//
//  Created by Bofei Zhu on 6/20/19.
//  Copyright © 2019 HealthTap Inc. All rights reserved.
//

/// A PINGRESP Packet is sent by the Server to the Client in response to a PINGREQ packet.
/// It indicates that the Server is alive.
struct PingRespPacket: ControlPacket {

    /// Reserved fixed header flags for PINGRESP packet
    static let flags: FixedHeaderFlags = 0

    /// The fixed header for PINGRESP packet
    var fixedHeader: FixedHeader
}