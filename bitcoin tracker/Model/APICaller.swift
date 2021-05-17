//
//  APICaller.swift
//  bitcoin tracker
//
//  Created by Dalveer singh on 11/05/21.
//

import Foundation
final class APICaller{
    static let shared = APICaller()
    private struct Constants{
        static let working = "https://rest.coinapi.io/v1/assets/?apikey=2235D7DF-0DE1-4249-A5AA-A568039F2060"
        static let extra = "https://rest.coinapi.io/v1/exchangerate/BTC?apikey=2235D7DF-0DE1-4249-A5AA-A568039F2060"
        static let apiKey = "2235D7DF-0DE1-4249-A5AA-A568039F2060"
        static let assestsEndpoint:String = "https://rest-sandbox.coinapi.io/v1/assets/"
    }
    private init(){}
    private var isReadyBlock:((Result<[Crypto],Error>)->Void)?
    public var icons:[Icons] = []
    //MARK:- Public
    public func getAllCryptoData(completion: @escaping (Result<[Crypto],Error>)->Void)
    {
        guard icons.isEmpty == false else {
            isReadyBlock = completion
            return}
        guard let url = URL(string: "https://rest.coinapi.io/v1/assets/?apikey=2235D7DF-0DE1-4249-A5AA-A568039F2060")
        else{
            print("Error in URL")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data,error==nil else
            {
                return
            }
            do{
                // decode the resonsce
                var cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                cryptos.sort { (first, second) -> Bool in
                    return first.price_usd ?? 0 > second.price_usd ?? 0
                }
                completion(.success(cryptos))
            }
            catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    public func getAllICons(){
        let link = "https://rest.coinapi.io/v1/assets/icons/55/?apikey=2235D7DF-0DE1-4249-A5AA-A568039F2060"
        guard let url = URL(string: link) else{ return }
        let task = URLSession.shared.dataTask(with: url) { [weak self](data, _, error) in
            guard let data = data,error==nil else
            {return}
            do{
                self?.icons = try JSONDecoder().decode([Icons].self, from: data)
                if let completion = self?.isReadyBlock {
                    self?.getAllCryptoData(completion: completion)
                 }
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
}
