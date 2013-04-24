// http://bj007.blog.51cto.com/1701577/505279

#import "NSObject+PropertyList.h"
#import <objc/runtime.h>

@implementation NSObject (PropertyList)

- (NSDictionary *)propertiesOfObject
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount = 0, i = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding] autorelease];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setValue:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}

+ (NSMutableArray *)getPropertiesByClassName:(NSString *)cls
{
    const char *clsName = [cls cStringUsingEncoding:NSUTF8StringEncoding];
    id obj = objc_getClass(clsName);
    
    NSMutableArray *propertyList = [[NSMutableArray alloc] init];
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    unsigned int outCount = 0, i = 0;
    objc_property_t *properties = class_copyPropertyList(obj, &outCount);
    
    for( i = 0; i < outCount; i++){
        
        objc_property_t property = properties[i];
        
        //printf("%s\n", property_getName(property));
        
        NSString *propertyString =  [NSString stringWithCString:property_getName(property)
                                                       encoding:NSUTF8StringEncoding];
        //NSLog(@"property: %@", propertyString);
        
        // 字符串非空，则加入属性列表
        if(!(propertyString == nil
             || propertyString.length == 0
             || [propertyString isEqualToString:@""]))
        {
            [propertyList addObject:propertyString];
        }
    }
    
    [pool drain];
    
    return [propertyList autorelease];
}


+ (NSMutableArray *)getPropertyAttrsByClassName:(NSString *)cls
{
    const char *clsName = [cls cStringUsingEncoding:NSUTF8StringEncoding];
    id obj = objc_getClass(clsName);
    
    NSMutableArray *propertyAttrsList = [[NSMutableArray alloc] init];
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    unsigned int outCount = 0, i = 0;
    objc_property_t *properties = class_copyPropertyList(obj, &outCount);
    
    for( i = 0; i < outCount; i++){
        
        objc_property_t property = properties[i];
        
        //printf("%s\n" ,property_getAttributes(property));
        
        NSString *propertyAttrString =  [NSString stringWithCString:property_getAttributes(property)
                                                           encoding:NSUTF8StringEncoding];
        //NSLog(@"propertyAttr: %@", propertyAttrString);
        
        // 字符串非空，则加入属性列表
        if(!(propertyAttrString == nil
             || propertyAttrString.length == 0
             || [propertyAttrString isEqualToString:@""]))
        {
            [propertyAttrsList addObject:propertyAttrString];
        }
    }
    
    [pool drain];
    
    return [propertyAttrsList autorelease];
}

@end
