//
//  NoteService.swift
//  iOSTemplate
//
//  Created by apple on 2023/12/19.
//

import Foundation

@objc(NoteService)
class NoteService: NSObject, NoteProtocol {
    func writeNote() {
        print("NoteService writeNote")
    }
}
