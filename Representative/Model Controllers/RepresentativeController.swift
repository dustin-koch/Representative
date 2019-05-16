//
//  RepresentativeController.swift
//  Representative
//
//  Created by Dustin Koch on 5/16/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import Foundation

class RepresentativeController {
    
    //Singleton
    static let shared = RepresentativeController()
    
    //Source of truth
    var representatives: [Representative] = []
    
    //MARK: - Properties
    let baseURL = "https://whoismyrepresentative.com/"

    //MARK: - CRUD functions
    func fetchRepresentativesFor(state: String, completion: @escaping ([Representative]) -> Void) {
        //Construct URL
        guard var url = URL(string: baseURL) else { completion([]); return }
        url.appendPathComponent("getall_reps_bystate.php")
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let stateQuery = URLQueryItem(name: "state", value: state)
        let outputQuery = URLQueryItem(name: "output", value: "json")
        components?.queryItems = [stateQuery, outputQuery]
        guard let finalURL = components?.url else { completion([]); return }
        print(finalURL)
        //Data Task
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("‼️ \(error.localizedDescription)")
                completion([])
                return
            }
            guard let data = data, let responseDataString = String(data: data, encoding: .ascii), let dataAsUTF = responseDataString.data(using: .utf8) else { completion([]); return }
            let jsonDecoder = JSONDecoder()
            
            
            
            do {
                let topLevelJSON = try jsonDecoder.decode(TopLevelJSONDictionary.self, from: dataAsUTF)
                let results = topLevelJSON.results
                completion(results)
            } catch {
                print("💥 \(error.localizedDescription)")
                completion([])
                return
            }
        }.resume()
    }//End of fetch
    
    
}//END OF CLASS
