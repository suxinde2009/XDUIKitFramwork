// http://bj007.blog.51cto.com/1701577/505279

#import <Foundation/Foundation.h>

@interface NSObject (PropertyList)

- (NSDictionary *)propertiesOfObject;

// 通过类名取出对应的成员属性列表
+ (NSMutableArray *)getPropertiesByClassName:(NSString *)cls;

// 通过类名获取对应的成员属性及属性的类型等信息的列表
+ (NSMutableArray *)getPropertyAttrsByClassName:(NSString *)cls;

@end
