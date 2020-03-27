//
//  Home.swift
//  CoronaTracker
//
//  Created by Jae Ho Shin on 2020-03-09.
//  Copyright © 2020 Jae Ho Shin. All rights reserved.
//

import SwiftUI

struct OverView: View {
    
    @ObservedObject var readCSV = ReadCSV()
    
    var body: some View {
        VStack{
            
            if readCSV.parsedData.count != 0{
                
                ScrollView(.vertical, showsIndicators: false){
                    
                    VStack(spacing: CGFloat(30)){
                        Text("Overview")
                            .fontWeight(.heavy)
                            .font(.custom("DIN Alternate", size: 30))
                            .frame(height: 10)
                        Text(readCSV.updateDate).font(.custom("DIN Alternate", size: 20)).frame(height: 10)
                        Text("*Data source - Johns Hopkins University CSSE")
                        .font(.custom("DIN Alternate", size: 12)).frame(height: 6)
                        
                        ForEach(readCSV.parsedData){i in
                            TrackingCellView(data: i)
                        }
                    }.padding()
                }.edgesIgnoringSafeArea(.all)
            }
            else {Loader()}
            AdBannerView().frame(width: UIScreen.main.bounds.width, height: 60)
        }
    }
}
