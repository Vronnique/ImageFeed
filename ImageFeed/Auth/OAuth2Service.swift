import Foundation

final class OAuth2Service {
    
    // MARK: - Properties
    
    static let shared = OAuth2Service()
    private init() {}
    
    private let tokenStorage = OAuth2TokenStorage()
    
    // MARK: - Models
    
    private struct OAuthTokenResponseBody: Decodable {
        let accessToken: String
        let tokenType: String
        let scope: String
        let createdAt: Int
        
    // MARK: - Coding Keys
    
        enum CodingKeys: String, CodingKey {
            case accessToken = "access_token"
            case tokenType = "token_type"
            case scope
            case createdAt = "created_at"
        }
    }
    
    // MARK: - Private Methods
    
    // создание запроса
    private func makeOAuthTokenRequest(code: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: "https://unsplash.com/oauth/token") else {
            print("Ошибка: не удалось создать URLComponents")
            return nil
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: Constants.accessKey),
            URLQueryItem(name: "client_secret", value: Constants.secretKey),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "grant_type", value: "authorization_code")
    ]
           
        guard let authTokenUrl = urlComponents.url else {
            print(" Ошибка: не удалось создать URL из компонентов")
            return nil
            }
        
        var request = URLRequest(url: authTokenUrl)
        request.httpMethod = "POST"
        return request
    }
    
    // MARK: - Public Methods
    
    // выполнение запроса
    func fetchOAuthToken(code: String, handler: @escaping (Result<String, Error>) -> Void) {
        print("🔄 Начинаем обмен кода на токен: \(code)")
        guard let request = makeOAuthTokenRequest(code: code) else {
            handler(.failure(NetworkError.invalidRequest))
            return
        }
        
        let task = URLSession.shared.data(for: request) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let data):
                
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(OAuthTokenResponseBody.self, from: data)
                    
                    self.tokenStorage.token = response.accessToken
                    print("Токен успешно получен и сохранен")
                    
                    handler(.success(response.accessToken))
                } catch {
                    handler(.failure(NetworkError.decodingError))
                }
                
            case .failure(let error):
                if let networkError = error as? NetworkError {
                    switch networkError {
                    case .invalidRequest:
                        print("Неккоректный запрос")
                    case .httpError(let code):
                        print("HTTP ошибка: статус код \(code)")
                    case .urlSessionError:
                        print("Ошибка URLSession")
                    case .urlRequestError(let requestError):
                        print("Ошибка сетевого запроса: \(requestError.localizedDescription)")
                    case .decodingError:
                        print("Ошибка декодирования")
                    }
                } else {
                    print("Неизвестная ошибка: \(error.localizedDescription)")
                }
                
                handler(.failure(error))
            }
        }
        
        task.resume()
    }
}
