//
//  PropertyCollection.swift
//  NIOMQTT
//
//  Created by Bofei Zhu on 8/16/19.
//  Copyright © 2019 HealthTap Inc. All rights reserved.
//

struct PropertyCollection {
    typealias ArrayType = [Property]

    private var properties: ArrayType = []

    /// Property Length
    ///
    /// Byte count of the properties
    /// - Important:
    ///     The Property Length does not include the bytes used to encode itself,
    ///     but includes the length of the Properties. If there are no properties,
    ///     this MUST be indicated by including a Property Length of zero.
    /// - Complexity: O(*nlog(n)*).
    var propertyLength: VInt {
        return VInt(value: UInt(byteCount))
    }

    /// MQTT Byte Count
    ///
    /// Total number of bytes used to store the property collection in MQTT,
    /// including the byte count of property length.
    /// - Complexity: O(*nlog(n)*).
    var mqttByteCount: Int {
        return propertyLength.bytes.count + byteCount
    }

    // MARK: MQTT Attributes

    var isPayloadUTF8Encoded: Bool = false

    // MARK: Private

    private var byteCount: Int = 0

    init() {}

    /// Adds a property to the end of the collection.
    ///
    /// - Parameter newProperty: The property to append to the collection.
    mutating func append(_ newProperty: Property) {
        properties.append(newProperty)
        byteCount += newProperty.byteCount

        switch newProperty {
        case let .payloadFormatIndicator(isPayloadUTF8Encoded):
            self.isPayloadUTF8Encoded = isPayloadUTF8Encoded

        default:
            break
        }
    }
}

// MARK: - Collection

extension PropertyCollection: Collection {
    typealias Index = ArrayType.Index
    typealias Element = Property

    var startIndex: Index { return properties.startIndex }
    var endIndex: Index { return properties.endIndex }

    subscript(index: Index) -> Element {
        return properties[index]
    }

    func index(after i: Index) -> Index {
        return properties.index(after: i)
    }
}