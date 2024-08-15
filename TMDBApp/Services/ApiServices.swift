//
//  Services.swift
//  TMDBApp
//
//  Created by luis rodriguez on 14/08/24.
//

import Foundation

class ApiConfig {
    
    let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String
    let base_url = Bundle.main.infoDictionary?["BASE_URL"] as? String
    let version = Bundle.main.infoDictionary?["API_VERSION"] as? String
    var apiManager : ApiManager?
    
    
    init() {
        apiManager = ApiManager(url: base_url ?? "", httpMethod: "GET", token: apiKey ?? "", version: version ?? "")
    }
    
}

class ApiManager {
    
    var url : String
    var token: String
    var version: String
    var method: String
    init(url : String =  "", httpMethod: String = "GET", token: String, version: String) {
        self.token = token
        self.url = url
        self.version = version
        self.method = httpMethod
    }
    //MAKR:
        /** Configurar URLRequest  **/
        // remover movie/now y hacer enums de los posibles paths
    func configRequest() -> URLRequest {
        let url: String = "\(url)/\(version)/movie/now_playing?api_key=\(token)"
        let baseURL = URL(string: url)!
        var request = URLRequest(url: baseURL)
        let jsonHeader = "application/json"
        request.setValue(jsonHeader, forHTTPHeaderField: "Accept")
        request.setValue(jsonHeader, forHTTPHeaderField: "Content-Type")
        request.httpMethod = method
        return request
    }
    
    func getMovies(success : @escaping (_ movies : MovieResponse) -> () , onError: @escaping(_ error:NSError) -> ()) {
        var request = configRequest()

        self.getCall(request: request) { data in
            guard  let dataJson = try? JSONDecoder().decode(MovieResponse.self, from: data)  else {
                return
            }
            success(dataJson)
        } onError: { error in
            onError(error)
        }
    }

    func getCall(request : URLRequest, success : @escaping (_ data : Data) -> () , onError: @escaping(_ error:NSError) -> ()){
      
        let task = URLSession.shared.dataTask(with: request) { data, httpResponse, error in
            guard let status = httpResponse as? HTTPURLResponse, (200...299).contains(status.statusCode) else {
                return
            }
            guard error == nil else {
                onError(error! as NSError)
                return
            }
            success(data!)
            
        }
        task.resume()
    }
}

