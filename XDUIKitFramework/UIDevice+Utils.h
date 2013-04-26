#import <Foundation/Foundation.h>


@interface UIDevice (Utils)

+ (bool)isPad;
+ (bool)hasCamera;
+ (NSString *)getMacAddress;
+ (NSString*)generateGUID;
+ (BOOL)isJailbroken;
+ (NSString *)getOSVersion;
+ (NSString *)getModel;
+ (NSString *)getIPAddress;
+ (natural_t)getFreeMemory;

@end

@interface UIDevice (NetWorkConnection)

// 检测当前设备是否联网
+ (BOOL)connectToNetwork;

@end

@interface UIDevice (EmailCapacityAvailable)

// 检测当前设别是否能发送Email
+ (BOOL)canSendMail;

@end
