//
//  FFmpegErrors.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//
import Foundation

typealias ResultCode = Int32
typealias BytePointer = UnsafeMutablePointer<UInt8>

///
/// Helper functions and properties for convenience in error handling and logging.
///
extension ResultCode {

    var errorDescription: String {
        
        if self.isZero {
            return "No error"
            
        } else {
            
            let errorString = FFmpegString(size: 100)
            return av_strerror(self, errorString.pointer, errorString.size).isZero ? errorString.string : "Unknown error"
        }
    }
    
    // MARK: Helper functions to assess the result of the operation that produced this result code.
    
    var isNonNegative: Bool {self >= 0}
    var isNonPositive: Bool {self <= 0}
    
    var isPositive: Bool {self > 0}
    var isNegative: Bool {self < 0}
    
    var isZero: Bool {self == 0}
    var isNonZero: Bool {self != 0}
    
    var isEOF: Bool {self == ERROR_EOF}
}

///
/// Represents an error with an associated integer error code.
///
class CodedError: Error {
    
    /// An integer code indicating what went wrong.
    let code: ResultCode
    
    /// Whether or not this error indicates end of file (EOF).
    var isEOF: Bool {code == ERROR_EOF}
    
    /// A readable description of this error.
    var description: String {code.errorDescription}
    
    /// Instantiates a CodedError with a given result code.
    init(_ code: ResultCode) {
        self.code = code
    }
}

///
/// Represents an error encountered by a codec while decoding audio packets.
///
class DecoderError: CodedError {
    static let eof: DecoderError = DecoderError(ERROR_EOF)
}

///
/// Represents an error encountered while reading audio packets from a stream.
///
class PacketReadError: CodedError {
    static let eof: PacketReadError = PacketReadError(ERROR_EOF)
}

///
/// Represents an error encountered while seeking within an audio stream.
///
class SeekError: CodedError {}

///
/// Represents an error encountered while initializing a decoder.
///
class DecoderInitializationError: CodedError {}

class FormatContextInitializationError: Error {
    
    let description: String
    
    init(description: String) {
        self.description = description
    }
}

class CodecInitializationError: Error {
    
    let description: String
    
    init(description: String) {
        self.description = description
    }
}

class ResamplerInitializationError: Error {
    
    let description: String
    
    init(description: String) {
        self.description = description
    }
}
