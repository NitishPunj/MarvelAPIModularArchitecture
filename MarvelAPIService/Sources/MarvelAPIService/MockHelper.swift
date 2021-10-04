//
//  MockHelper.swift
//  
//
//  Created by Sharma, Nitish X on 04/10/2021.
//
import Foundation

public final class MockHelper {
    public static func loadLocalJSON(_ fileName: String, bundle: Bundle? = nil) -> Data {
        if let filePath =  (bundle ?? .module).path(forResource: fileName, ofType: "json") {
            do {
                let fileURL = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileURL, options: .mappedIfSafe)
                return data
            } catch {
                print(error)
                fatalError("Mock data was not present in bundle")
            }
        }
        fatalError("Mock data was not present in bundle")
    }
}
