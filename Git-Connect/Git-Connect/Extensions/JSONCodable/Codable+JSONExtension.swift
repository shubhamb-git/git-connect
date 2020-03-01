//
//  Codable+JSONExtension.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 27/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import Foundation

public extension Decodable {
    
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    // Create instances of our type from JSON Data.
    init?(jsonData: Data?) {
        guard let data = jsonData,
            let anInstance = try? Self.decoder.decode(Self.self, from: data)
            else { return nil }
        self = anInstance
    }
    
}

extension Encodable where Self: Codable {
    
    static var encoder: JSONEncoder { return JSONEncoder() }
    
    // Return instances as JSON Data.
    func jsonData() -> Data? {
        return try? Self.encoder.encode(self)
    }
    
}
