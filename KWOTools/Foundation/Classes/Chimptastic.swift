import Foundation

public class Chimptastic {
    // MARK: - Enums

    public enum Error: Swift.Error {
        case invalidEmail
        case failedRequest
        case failedResponse
    }

    // MARK: - Properties

    private let formUrl: URL
    private let urlSession: URLSession

    // MARK: - Object life cycle

    public init(formUrlString: String, urlSession: URLSession = URLSession.shared) {
        self.formUrl = URL(string: formUrlString)!
        self.urlSession = urlSession
    }

    // MARK: - Public interface

    public func subscribe(_ email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard isValid(email) else {
            completion(.failure(.invalidEmail))
            return
        }

        let parameters = ["EMAIL": email]
        var request = URLRequest(url: formUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            completion(.failure(.failedRequest))
            return
        }
        request.httpBody = httpBody

        urlSession.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(.failedResponse))
            } else {
                completion(.success(()))
            }
        }.resume()
    }

    // MARK: - Private interface

    private func isValid(_ email: String) -> Bool {
        if email.count > 100 {
            return false
        }
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        //let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)

        return emailPredicate.evaluate(with: email)
    }
}
