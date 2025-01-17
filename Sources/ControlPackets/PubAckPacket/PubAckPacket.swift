//
//  PubAckPacket.swift
//  NIOMQTT
//
//  Created by Bofei Zhu on 7/22/19.
//  Copyright © 2019 HealthTap Inc. All rights reserved.
//

/// PUBACK Packet – Publish acknowledgement
///
/// A PUBACK packet is the response to a PUBLISH packet with QoS 1.
struct PubAckPacket: ControlPacketProtocol {

    /// Fixed Header
    let fixedHeader: FixedHeader

    /// Variable Header
    let variableHeader: VariableHeader
}
