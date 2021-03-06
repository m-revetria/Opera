//  UserRepository.swift
//  Example-iOS ( https://github.com/xmartlabs/Example-iOS )
//
//  Copyright (c) 2016 Xmartlabs SRL ( http://xmartlabs.com )
//
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation
import Opera
import Argo
import Curry
import SwiftDate

struct UserRepository {
    
    let id: Int
    let owner: String
    let name: String
    let description: String?
    let forks: Int
    let stargazers: Int
    let watchers: Int
    let issues: Int
    let createdAt: NSDate
    
}

extension UserRepository: OperaDecodable, Argo.Decodable {
    
    static func decode(j: JSON) -> Decoded<UserRepository> {
        return curry(UserRepository.init)
            <^> j <| "id"
            <*> j <| ["owner", "login"]
            <*> j <| "name"
            <*> j <|? "description"
            <*> j <| "forks_count"
            <*> j <| "stargazers_count"
            <*> j <| "watchers_count"
            <*> j <| "open_issues_count"
            <*> j <| "created_at"
    }
    
}

extension NSDate: Argo.Decodable {
    public typealias DecodedType = NSDate
    
    public class func decode(j: JSON) -> Decoded<NSDate> {
        switch j {
        case .String(let dateString):
            return  dateString.toDate(DateFormat.ISO8601Format(.Full)).map(pure) ?? .typeMismatch("NSDate", actual: j)
        default: return .typeMismatch("NSDate", actual: j)
        }
    }
}

