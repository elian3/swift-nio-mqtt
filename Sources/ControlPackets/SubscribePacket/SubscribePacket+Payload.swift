//
//  SubscribePacket+Payload.swift
//  NIOMQTT
//
//  Created by Bofei Zhu on 7/21/19.
//  Copyright © 2019 HealthTap Inc. All rights reserved.
//

import struct Foundation.Data

extension SubscribePacket: PayloadPacket {

    /// SUBSCRIBE Packet Payload
    struct Payload: MQTTByteRepresentable {

        /// Topic Filter List
        ///
        /// A list of Topic Filters indicating the Topics to which the Client wants to subscribe
        /// - Important: The Payload MUST contain at least one Topic Filter and Subscription Options pair.
        ///     A SUBSCRIBE packet with no Payload is a Protocol Error. 
        let topicFilters: [TopicFilter]

        /// MQTT Byte Count
        ///
        /// - Complexity: O(*n*)
        var mqttByteCount: Int {
            return topicFilters.reduce(0) { $0 + $1.mqttByteCount }
        }
    }

    /// Topic Filter
    ///
    /// Topic Filters indicating the Topics to which the Client wants to subscribe.
    /// The Topic Filters MUST be a UTF-8 Encoded String.
    /// Each Topic Filter is followed by a Subscription Options byte.
    struct TopicFilter: MQTTByteRepresentable {

        /// Topic
        let topic: String

        /// Options
        let options: Options

        var mqttByteCount: Int {
            return topic.mqttByteCount + UInt8.byteCount
        }
    }

    /// Subscription Options
    struct Options: RawRepresentable {
        typealias RawValue = UInt8

        /// Maximum QoS
        let qos: QoS

        /// No Local
        ///
        /// If the value is `true`, Application Messages MUST NOT be forwarded to a connection with a ClientID equal to
        /// the ClientID of the publishing connection.
        /// It is a Protocol Error to set the No Local bit to `true` on a Shared Subscription.
        let noLocal: Bool

        /// Retain As Published
        ///
        /// If `true`, Application Messages forwarded using this subscription keep the RETAIN flag
        /// they were published with. If `false`, Application Messages forwarded using this subscription
        /// have the RETAIN flag set to `false`.
        /// Retained messages sent when the subscription is established have the RETAIN flag set to `true`.
        let retainAsPublished: Bool

        /// Retain Handling
        let retainHandling: RetainHandling

        var rawValue: UInt8 {

            let qosValue = qos.rawValue
            let noLocalValue: UInt8 = noLocal ? 1 : 0
            let retainAsPublishedValue: UInt8 = retainAsPublished ? 1 : 0
            let retainHandlingValue = retainHandling.rawValue

            return qosValue |
                (noLocalValue << 2) |
                (retainAsPublishedValue << 3) |
                (retainHandlingValue << 4)
        }

        init?(rawValue: UInt8) {

            let qosValue = rawValue & 0b11
            guard let qos = QoS(rawValue: qosValue) else {
                return nil
            }
            self.qos = qos

            noLocal = ((rawValue >> 2) & 1) == 1
            retainAsPublished = ((rawValue >> 3) & 1) == 1

            let retainHandlingValue = rawValue >> 4
            guard let retainHandling = RetainHandling(rawValue: retainHandlingValue) else {
                return nil
            }
            self.retainHandling = retainHandling
        }
    }

    /// Retain Handling
    enum RetainHandling: UInt8 {

        /// Send retained messages at the time of the subscribe
        case level0 = 0

        /// Send retained messages at subscribe only if the subscription does not currently exist
        case level1

        /// Do not send retained messages at the time of the subscribe
        case level2
    }
}
