/*
 The MIT License (MIT)
 
 Copyright (c) 2013 SuXinDe (Email: suxinde2009@126.com)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>

#import <sys/socket.h>
#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>

#import <UIKit/UIKit.h>

/////////////////////////////////////////////////
//#import "Reachability.h"
/////////////////////////////////////////////////

typedef NS_ENUM(NSInteger, NetworkStatus) {
    // Apple NetworkStatus Compatible Names.
    NotReachable = 0,
    ReachableViaWiFi = 2,
    ReachableViaWWAN = 1
};

typedef NS_ENUM(NSInteger, NOTIFY_POSITION)
{
    TOP_LEFT = 0, TOP_RIGHT = 1, TOP_CENTER = 2,
    CENTER_LEFT = 3, CENTER_RIGHT = 4, CENTER_CENTER = 5,
    BOTTOM_LEFT = 6, BOTTOM_RIGHT = 7, BOTTOM_CENTER = 8
};


typedef void(^XDNetWorkStateNotifyCallback)(NetworkStatus networkStatus);

@interface XDNetWorkStateMonitor: NSObject
{
    XDNetWorkStateNotifyCallback callBack;
}

+ (XDNetWorkStateMonitor*)sharedInstance;
- (void) initWithParent:(UIView*)parentView;
- (void) addNetworkStateNotifyToView:(UIView*)view type:(NetworkStatus)type;
- (NetworkStatus)getCurrentReachabilityStatus;
- (void) handleNetworkChange:(NSNotification *)notice;
- (void) setPosition:(NOTIFY_POSITION) pos;
- (void) show;
- (void) setType:(NetworkStatus)type;

- (void) setCallback:(XDNetWorkStateNotifyCallback)callback;
- (void) removeCallback;

@end

/////////////////////////////////////////////////////////////////
//              DRAW VIEW CLASS
////////////////////////////////////////////////////////////////

typedef void(^DrawView_DrawBlock)(UIView* v,CGContextRef context);

@interface DrawView : UIView

@property (nonatomic,copy) DrawView_DrawBlock drawBlock;

@end




//////////////////////////////////////////////////////////////
//          REACHABILITY CLASS
//////////////////////////////////////////////////////////////

#if OS_OBJECT_USE_OBJC
#define NEEDS_DISPATCH_RETAIN_RELEASE 0
#else
#define NEEDS_DISPATCH_RETAIN_RELEASE 1
#endif

#ifndef NS_ENUM
#define NS_ENUM(_type, _name) enum _name : _type _name; enum _name : _type
#endif

extern NSString *const kReachabilityChangedNotification;

//
//
//typedef NS_ENUM(NSInteger, NetworkStatus) {
//    // Apple NetworkStatus Compatible Names.
//    NotReachable = 0,
//    ReachableViaWiFi = 2,
//    ReachableViaWWAN = 1
//};
//
//

@class Reachability;

typedef void (^NetworkReachable)(Reachability * reachability);
typedef void (^NetworkUnreachable)(Reachability * reachability);

@interface Reachability : NSObject

@property (nonatomic, copy) NetworkReachable    reachableBlock;
@property (nonatomic, copy) NetworkUnreachable  unreachableBlock;


@property (nonatomic, assign) BOOL reachableOnWWAN;

+(Reachability*)reachabilityWithHostname:(NSString*)hostname;
+(Reachability*)reachabilityForInternetConnection;
+(Reachability*)reachabilityWithAddress:(const struct sockaddr_in*)hostAddress;
+(Reachability*)reachabilityForLocalWiFi;

-(Reachability *)initWithReachabilityRef:(SCNetworkReachabilityRef)ref;

-(BOOL)startNotifier;
-(void)stopNotifier;

-(BOOL)isReachable;
-(BOOL)isReachableViaWWAN;
-(BOOL)isReachableViaWiFi;

// WWAN may be available, but not active until a connection has been established.
// WiFi may require a connection for VPN on Demand.
-(BOOL)isConnectionRequired; // Identical DDG variant.
-(BOOL)connectionRequired; // Apple's routine.
// Dynamic, on demand connection?
-(BOOL)isConnectionOnDemand;
// Is user intervention required?
-(BOOL)isInterventionRequired;

-(NetworkStatus)currentReachabilityStatus;
-(SCNetworkReachabilityFlags)reachabilityFlags;
-(NSString*)currentReachabilityString;
-(NSString*)currentReachabilityFlags;

@end
 
