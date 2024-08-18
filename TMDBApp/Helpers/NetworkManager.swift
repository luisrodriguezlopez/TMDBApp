//
//  NetworkMonitor.swift
//  TMDBApp
//
//  Created by luis rodriguez on 14/08/24.
//

import Network
protocol NetworkConnection {
    func checkInternetConnection(completion: @escaping(Bool) -> Void)
}

class NetworkManager : NetworkConnection {
  var connection : Bool = false

    func checkInternetConnection(completion: @escaping(Bool) -> Void) {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path  in
          completion(path.status == .satisfied ? true : false)
        }
        
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
    
}

