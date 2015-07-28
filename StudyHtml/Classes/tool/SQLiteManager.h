

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "News.h"
/*
 1.添加系统类库
 2.打开数据库
 */

@interface SQLiteManager : NSObject

+(sqlite3 *)openDB;
+(void)closeDB;
//添加一个 新闻
+(BOOL)addNews:(News *)news;
//查询
+(NSMutableArray *)findAllNews;
//修改
+(BOOL)updateNewsTitle:(NSString *)title andUrl:(NSString *)url whereIDIsEqul:(int)ID;

//删除
+(BOOL)deleteByID:(int)ID;

//通过title查找一个News
+(News *)findNewsByTitle:( NSString *) title;

@end
