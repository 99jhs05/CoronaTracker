//
//  SafetyTipsView.swift
//  CoronaTracker
//
//  Created by Jae Ho Shin on 2020-03-25.
//  Copyright © 2020 Jae Ho Shin. All rights reserved.
//

import SwiftUI

struct SafetyTipsView: View {
    
    @State private var currentCard = 0
    //@State private var offset: CGFloat = 0
    
    var body: some View {
        VStack{
                ZStack{
                    Color(red: 0, green: 153/255, blue: 204/255)
                    HStack{
                        Image("blue-1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        
                        Image("blue-2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        
                        Image("blue-3")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        
                        Image("blue-4")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        
                        Image("be-ready-social-2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        
                    }.frame(width:UIScreen.main.bounds.width * 5)
                        .offset(x: UIScreen.main.bounds.width * CGFloat((2-self.currentCard)))

                    VStack{
//                        Text("Safety Tips")
//                            .fontWeight(.heavy)
//                        .font(.custom("DIN Alternate", size: 30))
//                        .padding(14)
                        Spacer()
                        HStack(){
                            
                            //Spacer(minLength: 20)
                            
                            Button(action: {
                                withAnimation {
                                    if(self.currentCard>0){
                                        self.currentCard -= 1
                                    }
                                }
                            }) {
                                HStack{
                                    Image(systemName: "arrow.left").font(.title).foregroundColor(.white).padding(14)
                                    Text("PREV").fontWeight(.heavy).font(.custom("DIN Alternate", size: 24)).foregroundColor(.white).padding()
                                }
                            }.background(Color(red: 1, green: 189/255, blue: 89/255))
                            .cornerRadius(20)
                            
                            Spacer()
                                .frame(width:50)
                            
                            Button(action: {
                                withAnimation {
                                    if(self.currentCard<4){
                                        self.currentCard += 1
                                    }
                                }
                            }) {
                                HStack{
                                    Text("NEXT").fontWeight(.heavy).font(.custom("DIN Alternate", size: 24)).foregroundColor(.white).padding()
                                    Image(systemName: "arrow.right").font(.title).foregroundColor(.white).padding(14)
                                }
                            }.background(Color(red: 1, green: 189/255, blue: 89/255))
                            .cornerRadius(20)
                            
                            //Spacer(minLength: 20)
                        }.padding(20)
                    }
                }
            AdBannerView().frame(width: UIScreen.main.bounds.width, height: 60)
        }
    }
}
