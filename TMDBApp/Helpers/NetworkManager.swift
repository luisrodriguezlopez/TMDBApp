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
    /*
    func checkInternetConnectionDevice() -> String {
        
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            let connectivity = path.status == .satisfied
            self.isConnectedMsg   =  connectivity ?  "Connected to the internet" : "No internet connection"
            self.image =  connectivity  ? "network" : "network.slash"
                
        }
        let queue = DispatchQueue(label: "NetworkMonitorMessage")
        monitor.start(queue: queue)
        return self.isConnectedMsg
    }*/
    
    func checkInternetConnection(completion: @escaping(Bool) -> Void) {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path  in
          completion(path.status == .satisfied ? true : false)
        }
        
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
    
}

