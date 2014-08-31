#import "NSSqliteManager.h"

#define kDBFileName @"SqliteDB.db"

static NSSqliteManager *__sqliteManager = nil;

@implementation NSSqliteManager

- (id)init
{
    if(self = [super init]){
        [self open];
    }
    return self;
}

+ (id)shareManager
{
    @synchronized(self){
        if(__sqliteManager==nil){
            __sqliteManager = [[NSSqliteManager alloc] init];
        }
    }
    return __sqliteManager;
}

- (NSString *)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:kDBFileName];
}

- (BOOL)open
{
    if (sqlite3_open([[self dataFilePath] UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库打开失败");
        return FALSE;
    }
    
    return TRUE;
}



- (BOOL)execSql:(NSString *)sql
{
//    int sqlite3_prepare_v2(
//                           sqlite3 *db,            /* Database handle */
//                           const char *zSql,       /* SQL statement, UTF-8 encoded */
//                           int nByte,              /* Maximum length of zSql in bytes. */
//                           sqlite3_stmt **ppStmt,  /* OUT: Statement handle */
//                           const char **pzTail     /* OUT: Pointer to unused portion of zSql */
//                           );
    char *err;
    sqlite3_stmt * statement;
    
    if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
        if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
            NSLog(@"数据库操作数据失败: %s", err);
            sqlite3_finalize(statement);
            sqlite3_close(db);
            return FALSE;
        }
    }
    sqlite3_finalize(statement);
    sqlite3_close(db); // no necessary
    return TRUE;
}

- (BOOL)sqlQuery:(NSString *)sql
{
    sqlite3_stmt * statement;
    
    if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *name = (char*)sqlite3_column_text(statement, 1);
            NSString *nsNameStr = [[NSString alloc]initWithUTF8String:name];
            
            int age = sqlite3_column_int(statement, 2);
            
            char *address = (char*)sqlite3_column_text(statement, 3);
            NSString *nsAddressStr = [[NSString alloc]initWithUTF8String:address];
            
            NSLog(@"name:%@  age:%d  address:%@",nsNameStr,age, nsAddressStr);
        }
        sqlite3_finalize(statement);
    }else {
        NSLog(@"查询出错");
        return FALSE;
    }
    sqlite3_close(db);
    return TRUE;
}



@end
