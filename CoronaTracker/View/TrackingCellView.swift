//
//  TrackingCellView.swift
//  CoronaTracker
//
//  Created by Jae Ho Shin on 2020-03-23.
//  Copyright © 2020 Jae Ho Shin. All rights reserved.
//

import SwiftUI
import FlagKit

struct TrackingCellView: View {
    
    var data: country
    @State var show = false
    
    var body: some View {
        
        VStack{
            HStack{
                Image(uiImage: Flag(countryCode: self.flagName(name: data.name))!.image(style: .none))
                Text(data.name).font(.custom("DIN Alternate", size: 10))
                Spacer()
                VStack{
                    Text("Confirmed").font(.custom("DIN Alternate", size: 12))
                    Text(String(data.confirmed)).font(.custom("DIN Alternate", size: 12))
                }
                VStack{
                    Text("Deaths").font(.custom("DIN Alternate", size: 12)).foregroundColor(.red)
                    Text(String(data.deaths)).font(.custom("DIN Alternate", size: 12))
                }
                VStack{
                    Text("Recovered").font(.custom("DIN Alternate", size: 12)).foregroundColor(.green)
                    Text(String(data.recovered)).font(.custom("DIN Alternate", size: 12))
                }
                VStack{
                    Text("Active").font(.custom("DIN Alternate", size: 12))
                    Text(String(data.active)).font(.custom("DIN Alternate", size: 12))
                }
                
                if data.subRegions.count != 0{
                    Button(action: {
                        withAnimation {
                        self.show.toggle()
                        }
                    }) {Image(systemName: "chevron.down").foregroundColor(Color("DarkMode")).font(.body).padding(6)}
                }
                else {
                    Spacer().frame(width:32)
                }

            }.padding()
            if show && (data.subRegions.count != 0){
                Divider()
                ForEach(data.subRegions){i in
                    HStack{
                        Text(i.name).font(.custom("DIN Alternate", size: 14))
                        Spacer()
                        Text(String(i.confirmed)).font(.custom("DIN Alternate", size: 18)).frame(width:46)
                        Text(String(i.deaths)).font(.custom("DIN Alternate", size: 18)).frame(width:46)
                        Text(String(i.recovered)).font(.custom("DIN Alternate", size: 18)).frame(width:46)
                        Text(String(i.active)).font(.custom("DIN Alternate", size: 18)).frame(width:46)
                        Spacer().frame(width:25)
                    }
                .padding()
                }
            }
        }
        .onTapGesture{
            if (self.data.subRegions.count != 0){
                withAnimation {
                self.show.toggle()
                }
            }
        }
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 1))
    }
}
