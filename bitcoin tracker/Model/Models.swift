//
//  Models.swift
//  bitcoin tracker
//
//  Created by Dalveer singh on 15/05/21.
//

import Foundation
struct Crypto:Codable{
    let asset_id:String
    let name:String?
    let price_usd:Double?
    let id_icon:String?
}
struct Icons:Codable{
    let asset_id:String
    let url:String
}

//"asset_id": "BTC",
//    "name": "Bitcoin",
//    "type_is_crypto": 1,
//    "data_start": "2010-07-17",
//    "data_end": "2021-05-15",
//    "data_quote_start": "2014-02-24T17:43:05.0000000Z",
//    "data_quote_end": "2021-05-15T17:34:01.9756315Z",
//    "data_orderbook_start": "2014-02-24T17:43:05.0000000Z",
//    "data_orderbook_end": "2020-08-05T14:38:38.3413202Z",
//    "data_trade_start": "2010-07-17T23:09:17.0000000Z",
//    "data_trade_end": "2021-05-15T17:30:03.7100000Z",
//    "data_symbols_count": 53990,
//    "volume_1hrs_usd": 244789514188756.75,
//    "volume_1day_usd": 4675802430100762.32,
//    "volume_1mth_usd": 88656470889365313.12,
//    "price_usd": 48109.386647831694596783699645,
//    "id_icon": "4caf2b16-a017-4e26-a348-2cea69c34cba"
