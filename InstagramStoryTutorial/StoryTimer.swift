//
//  StoryTimer.swift
//  InstagramStoryTutorial
//
//  Created by Jean-Marc Boullianne on 4/14/20.
//  Copyright © 2020 TrailingClosure. All rights reserved.
//

import Foundation
import Combine

class StoryTimer: ObservableObject {
    
    @Published var progress: Double
    private var interval: TimeInterval
    private var max: Int
    private let publisher: Timer.TimerPublisher
    private var cancellable: Cancellable?
    
    
    init(items: Int, interval: TimeInterval) {
        self.max = items
        self.progress = 0
        self.interval = interval
        self.publisher = Timer.publish(every: 0.1, on: .main, in: .default)
    }
    
    func start() {
        self.cancellable = self.publisher.autoconnect().sink(receiveValue: {  _ in
            var newProgress = self.progress + (0.1 / self.interval)
            if Int(newProgress) >= self.max { newProgress = 0 }
            self.progress = newProgress
        })
    }

    func cancel() {
        self.cancellable?.cancel()
    }
    
    func advance(by number: Int) {
        let newProgress = max((Int(self.progress) + number) % self.max , 0)
        self.progress = Double(newProgress)
    }
    
}
