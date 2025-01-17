//
//  PubCompPacket.swift
//  NIOMQTT
//
//  Created by Bofei Zhu on 7/27/19.
//  Copyright © 2019 HealthTap Inc. All rights reserved.
//

/// PUBCOMP Packet – Publish complete (QoS 2 delivery part 3)
///
/// The PUBCOMP packet is the response to a PUBREL packet.
/// It is the fourth and final packet of the QoS 2 protocol exchange.
struct PubCompPacket: ControlPacketProtocol {

    /// Fixed Header
    let fixedHeader: FixedHeader

    /// Variable Header
    let variableHeader: VariableHeader
}
