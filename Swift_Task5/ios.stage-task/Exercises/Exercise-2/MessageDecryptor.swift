import UIKit

class MessageDecryptor: NSObject {
    
    func decryptMessage(_ message: String) -> String {
        var message = message
        while message.contains("[") {
            decode(&message)
        }
        return message
    }

    private func decode(_ message: inout String) {
        guard let lastIndex = message.firstIndex(of: "]"),
              let firstIndex = message[...lastIndex].lastIndex(of: "["),
              firstIndex != message.startIndex
        else {
            message = message
                .replacingOccurrences(of: "[", with: "")
                .replacingOccurrences(of: "]", with: "")
            return
        }

        var firstNumIndex: String.Index?
        var lastNumIndex: String.Index?

        if message[message.index(before: firstIndex)].isNumber {
            firstNumIndex = message.index(before: firstIndex)
            lastNumIndex = message.index(before: firstIndex)
        }

        while let first = firstNumIndex,
              first != message.startIndex,
              message[message.index(before: first)].isNumber {
            firstNumIndex = message.index(before: first)
        }

        let startString = message.index(after: firstIndex)
        let endString = message.index(before: lastIndex)
        let string = String(message[startString...endString])
        guard let first = firstNumIndex,
              let last = lastNumIndex,
              let coef = Int(message[first...last])
        else {
            message.replaceSubrange(firstIndex...lastIndex,
                                    with: String(repeating: string, count: 1))
            return
        }
        message.replaceSubrange(first...lastIndex,
                                with: String(repeating: string, count: coef))
    }
}
 
