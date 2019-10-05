import Foundation
import Alamofire

public class Chimptastic {
    fileprivate static let sharedInstance = Chimptastic()
    var formURL: String!

    public class func initialize(_ formURL: String) {
        self.sharedInstance.formURL = formURL
    }

    public class func subscribe(_ email: String, success: @escaping (_ responseString: String) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        let parameters = ["EMAIL": email]

        Alamofire.request(self.sharedInstance.formURL, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .responseString { (response) -> Void in
            if response.result.isSuccess {
                success(response.result.value!)
            } else {
                failure(response.result.error)
            }
        }
    }
}
