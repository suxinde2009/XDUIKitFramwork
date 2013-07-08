// sqlite
// http://www.sqlite.org/c3ref/funclist.html
// http://marshal.easymorse.com/archives/3349
// http://blog.csdn.net/totogo2010/article/details/7702207
// http://blog.csdn.net/weasleyqi/article/details/8132646

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface NSSqliteManager : NSObject
{
    sqlite3 *db;
}

+ (id)shareManager;
- (NSString *)dataFilePath;
- (BOOL)execSql:(NSString *)sql;
- (BOOL)sqlQuery:(NSString *)sql;

@end
