# Hello

Thank you for considering me for this position

### Requirments
Xcode 10
Swift 4.2 onwards.
Cocoapods.

## installation

I am going to zip the project, so no need to run ' pod install'.

### Dependencies 

- Snapkit
- Disk

These dependencies were used because I had limited time, since I will be very busy next 2 weeks finishing up with my current company. (I usually use SnapKit for most of my projects.)

#### Architicture.

I used MVVM with property observers using Boxing. I am aware that this can be done with different approaches sucn as (RFP) but I chose this method for quickness and I didn't want to add more dependencies to the project.

#### Persistence.
I used NSKeyedArchiver for presisting data in the Feed screen. I used the Disk library to implment this because I didn't have time writing my own presistence layer. The FeedLoader checks if there is saved data already if so, it loads the data otherwise it loads from network (Could've been better using other ways such as Reachibility)

#### Wrap up.

I wrote some unit testing using factory implementation instead of setup() and teardown(). I would've loved to write more but given the limited time, I had to move on. I tried to use dependency injections, unify the input and output and make variables private in all my classes to make it easy to test. I might have missed up on some parts of the app and it definitely can be improved. I also could've used coordinator to navigate between the post details and the feed but I didn't have time to do so. 
The networking layer is a bit simple given there is no headers or body in the request but it definitely can be improved  upon


