//
//  ReadCSV.swift
//  CoronaTracker
//
//  Created by Jae Ho Shin on 2020-03-23.
//  Copyright © 2020 Jae Ho Shin. All rights reserved.
//

import SwiftUI

class ReadCSV: ObservableObject{
    
    @Published var parsedData: [country] = []
    @Published var updateDate: String = ""
    
    init(){
        
        //this fetches confirmed case count data from web
        let confirmedURL = URL(string: "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv")
        
        let task1 = URLSession.shared.dataTask(with: confirmedURL!) {
            (data, resp, err) in
            
            guard let data = data else{
                print((err?.localizedDescription)!)
                return
            }
            
            guard let csvString = String(data: data, encoding: String.Encoding.utf8) else{
                print("cannot cast data into string")
                return
            }
            
            DispatchQueue.main.async {
                self.parseCSV(data: csvString, dataType: 0)
            }
            
        }.resume()
        
        //this fetches death case count data from web
        let deathURL = URL(string: "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv")
        
        
        let task2 = URLSession.shared.dataTask(with: deathURL!) {
            (data, resp, err) in
            
            guard let data = data else{
                print((err?.localizedDescription)!)
                return
            }
            
            guard let csvString = String(data: data, encoding: String.Encoding.utf8) else{
                print("cannot cast data into string")
                return
            }
            
            DispatchQueue.main.async {
                self.parseCSV(data: csvString, dataType: 1)
            }
            
        }.resume()
        
        let recoveredURL = URL(string: "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_recovered_global.csv")
        
        let task3 = URLSession.shared.dataTask(with: recoveredURL!) {
            (data, resp, err) in
            
            guard let data = data else{
                print((err?.localizedDescription)!)
                return
            }
            
            guard let csvString = String(data: data, encoding: String.Encoding.utf8) else{
                print("cannot cast data into string")
                return
            }
            
            DispatchQueue.main.async {
                self.parseCSV(data: csvString, dataType: 2)
            }
            
        }.resume()
    }
    
    func parseCSV(data: String, dataType: Int){ // datatype: true if confirmed case data false if death
        
        var rows = data.components(separatedBy: "\n")
        let firstrow = rows[0].components(separatedBy: ",")
        updateDate = "Last update: " + firstrow[firstrow.count - 1]
        rows.removeFirst()
        
        for row in rows {
            if row == "" {break}        //terminate loop if parsed row is empty
            
            let columns = row.components(separatedBy: ",")
            
            var thisConfirmed = 0
            var thisDeath = 0
            var thisRecovered = 0
            
            if dataType == 0{
                
                thisConfirmed = Int(columns[columns.count-1]) ?? 0
                
            } else if dataType == 1{
                
                thisDeath = Int(columns[columns.count-1]) ?? 0
                
            } else {
                
                thisRecovered = Int(columns[columns.count-1]) ?? 0
            }
            
            let thisActive = thisConfirmed - thisDeath - thisRecovered
            let countryName = (columns[1] == "\"Korea") ? "South Korea" : columns[1]
            let regionName = columns[0]
            
            if regionName != ""{
                
                let regiondata = region(name: regionName, confirmed: thisConfirmed, deaths: thisDeath, recovered: thisRecovered, active: thisActive)
                
                if let i = parsedData.firstIndex(where: {$0.name == countryName}){ //this row contains data of a region, and its country already in result array
                    
                    parsedData[i].confirmed += regiondata.confirmed
                    parsedData[i].deaths += regiondata.deaths
                    parsedData[i].recovered += regiondata.recovered
                    parsedData[i].active += regiondata.active
                    
                    if let j = parsedData[i].subRegions.firstIndex(where: {$0.name == regionName}){
                        
                        parsedData[i].subRegions[j].confirmed += regiondata.confirmed
                        parsedData[i].subRegions[j].deaths += regiondata.deaths
                        parsedData[i].subRegions[j].recovered += regiondata.recovered
                        parsedData[i].subRegions[j].active += regiondata.active
                    }
                        
                    else{
                        parsedData[i].subRegions.append(regiondata)
                    }
                    
                } else{ //this row contains data of a region, but its country not in result array yet
                    let countrydata = country(name: countryName, confirmed: thisConfirmed, deaths: thisDeath, recovered: thisRecovered, active: thisActive, subRegions: [regiondata])
                    parsedData.append(countrydata)
                }
                
            } else { //this row contains data of a country
                
                let countrydata = country(name: countryName, confirmed: thisConfirmed, deaths: thisDeath, recovered: thisRecovered, active: thisActive, subRegions: [])
                
                if let i = parsedData.firstIndex(where: {$0.name == countryName}){
                    
                    parsedData[i].confirmed += countrydata.confirmed
                    parsedData[i].deaths += countrydata.deaths
                    parsedData[i].recovered += countrydata.recovered
                    parsedData[i].active += countrydata.active
                    
                }
                else {parsedData.append(countrydata)}
            }
        }
        
        // sorts countries and its subregions by their confirmed case counts
        
        parsedData.sort{ //sort result array by the element's confirmed count
            return $0.confirmed > $1.confirmed
        }
        
        for i in 0..<parsedData.count{
            if parsedData[i].subRegions.count != 0{
                parsedData[i].subRegions.sort{
                    return $0.confirmed > $1.confirmed
                }
            }
        }
        
    }
}
