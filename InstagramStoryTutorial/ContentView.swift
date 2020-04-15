//
//  ContentView.swift
//  InstagramStoryTutorial
//
//  Created by Jean-Marc Boullianne on 4/14/20.
//  Copyright © 2020 TrailingClosure. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var imageNames:[String] = ["image01","image02","image03","image04","image05","image06","image07"]
    @ObservedObject var storyTimer: StoryTimer = StoryTimer(items: 7, interval: 1.0)
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Image(self.imageNames[Int(self.storyTimer.progress)])
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: nil, alignment: .center)
                    .animation(.none)
                HStack(alignment: .center, spacing: 4) {
                    ForEach(self.imageNames.indices) { x in
                        LoadingRectangle(progress: min( max( (CGFloat(self.storyTimer.progress) - CGFloat(x)), 0.0) , 1.0) )
                            .frame(width: nil, height: 4, alignment: .leading)
                            .animation(.linear)
                    }
                }.padding()
                HStack(alignment: .center, spacing: 0) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.storyTimer.advance(by: -1)
                    }
                    Rectangle()
                        .foregroundColor(.clear)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.storyTimer.advance(by: 1)
                    }
                }
            }
            .onAppear { self.storyTimer.start() }
            .onDisappear {self.storyTimer.cancel() }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
