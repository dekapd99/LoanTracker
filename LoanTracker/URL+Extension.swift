import Foundation

//https://raw.githubusercontent.com/andreascandle/p2p_json_test/main/api/json/loans.json
extension URL {
    
    static var development: URL {
        URL(string: "https://raw.githubusercontent.com")!
    }
    
    static var production: URL {
        URL(string: "https://production.raw.githubusercontent.com")!
    }
    
    static var `default`: URL {
        #if DEBUG
            return development
        #else
            return production
        #endif
    }
    
    static var getAllLoans: URL {
        URL(string: "/andreascandle/p2p_json_test/main/api/json/loans.json", relativeTo: Self.default)!
    }
    
    

}
