

#import "SQLiteManager.h"
//为什么要用static？因为要保证数据库对象只有一个
static sqlite3 *db = nil;
@implementation SQLiteManager

+(sqlite3 *)openDB
{
    //一、数据库已经打开的情况
    if (db) {
        return db;
    }
    //二 、数据库没有打开的情况
    //1.先创建一个document路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //2.在docPath路径下面创建一个数据库路径
    //注意：工程数据库文件都要以.sqlite结尾，这样以数据库的图形工具可以直接打开
    NSString *filePath = [docPath stringByAppendingPathComponent:@"newsDB.sqlite"];
    NSLog(@"filePath = %@",filePath);
    //3.在filePath路径下创建一个数据库文件(所有sqlite的操作都是基于c的接口)
    //参数一：数据库文件的路径
    //参数二：数据库对象的地址
    int state = sqlite3_open([filePath UTF8String], &db);
    if (state != SQLITE_OK) {
        NSLog(@"数据库打开失败");
        return nil;
    }
    //数据库打开成功了
     //4.在数据库里面创建数据的表（数据库里的数据以表的形式来存储）
    /*创建表的关键字create table
     classA：表名
     primary key ：主键
     */
    NSString *createTableStr = @"create table if not exists classA(ID integer primary key,title text,url text)";
    //使用sql语句创建表
    char *errmsg ;
    //参数一：要对哪一个数据库进行操作
    //参数二：要对这个数据库进行什么样的操作（SQL语句）
    //参数三，参数四：系统预留参数
    //参数五：错误信息
   int result = sqlite3_exec(db, [createTableStr UTF8String], NULL, NULL, &errmsg);
   if (result) {
       sqlite3_close(db);//关闭数据库
       sqlite3_free(errmsg);//释放指针
    }
    return db;
}




+(void)closeDB
{
    if (db) {
        sqlite3_close(db);
    }
}

#pragma  -mark 添加学生
+(BOOL)addNews:(News *)news
{
    //1.打开数据库
    sqlite3 *db = [SQLiteManager openDB];
    //2.创建一个数据库管理员对象
    sqlite3_stmt *stmt = nil;
    //3.准备一个sql语句
    /*参数一：准备对哪一个参数进行操作
     //参数二：sql语句，？号表示占位符
     //参数三：－1:会自动的计算传入数据的大小
     //参数四:用谁去对数据进行操作（数据管理员）
     //参数五：系统预留参数*/
    int state =  sqlite3_prepare_v2(db, "insert into classA(title,url) values(?,?)", -1, &stmt, nil);
    if (state == SQLITE_OK) {
        //sdl语句准备无误，要对sql语句中？进行赋值
        /*参数一：用仓库管理员对数据进行操作
         //参数二：对哪一个问号进行赋值
         //参数三：要赋的具体的值
         //参数四：－1:自动计算
         //参数五：系统预留参数*/
        sqlite3_bind_text(stmt, 1, [news.title UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 2, [news.url UTF8String], -1, nil);
        
        //执行sql语句(管理员一步一步的去操作)
        int result = sqlite3_step(stmt);
        if (result == SQLITE_DONE) {
            NSLog(@"数据添加成功");
            return YES;
        }
    }
    return NO;
}

#pragma -mark 查询
+(NSMutableArray *)findAllNews
{
    //1.打开数据库
    sqlite3  *db = [SQLiteManager openDB];
    //2.创建一个数据库管理员
    sqlite3_stmt *stmt = nil;
    //3.准备一个sql语句;
    int state = sqlite3_prepare_v2(db, "select * from classA", -1, &stmt, nil);
    //4.创建一个放model类的数组，用来存放查找到的数据
    NSMutableArray *mArray = [[NSMutableArray alloc]init];
    if (state == SQLITE_OK) {
    //5.在循环中一个字段一个字段的去搜索，当一个记录搜索完就保存到model类对象
       
        while (SQLITE_ROW == sqlite3_step(stmt)) {
            int ID = sqlite3_column_int(stmt, 0);//如果想要搜索主键，主键就要从0开始
            const unsigned char *title = sqlite3_column_text(stmt, 1);
            const unsigned char *url = sqlite3_column_text(stmt, 2);
        
            News *news = [[News alloc]init];
            news.ID = ID;
            news.title = [NSString stringWithUTF8String:(char *)title];//将c的字符串转化成oc字符串
            news.url = [NSString stringWithUTF8String:(char *)url];
            [mArray addObject:news];
            NSLog(@"news.title--%@",news.title);
            NSLog(@"news.url--%@",news.url);
        }
    }
    return mArray;
}
#pragma mark 查找一个News
+(News *)findNewsByTitle:(NSString *)title
{
    NSArray *array  =  [self findAllNews];
    for (News *news in array) {
        if ([news.title isEqualToString:title]) {
          
            return news;
        }else{
            return nil;
        }
    }

    return nil;
}





#pragma -mark 更改
+(BOOL)updateNewsTitle:(NSString *)title andUrl:(NSString *)url whereIDIsEqul:(int)ID
{
    sqlite3 *db = [SQLiteManager openDB];
    sqlite3_stmt *stmt = nil;
    int state = sqlite3_prepare_v2(db, "update classA set title = ?,url = ? where ID = ?", -1, &stmt, nil);
    if (state == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [title UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 2, [url UTF8String], -1, nil);
        sqlite3_bind_int(stmt, 3, ID);
        int result =   sqlite3_step(stmt);
        if ( result == SQLITE_DONE) {
            return YES;
        }
    }
    return NO;
}

#pragma -mark 删除
+(BOOL)deleteByID:(int)ID
{
    sqlite3 *db = [SQLiteManager openDB];
    sqlite3_stmt *stmt = nil;
    int state = sqlite3_prepare_v2(db, "delete from classA where ID = ?", -1, &stmt, nil);
    if (state == SQLITE_OK) {
        sqlite3_bind_int(stmt, 1, ID);
        int result = sqlite3_step(stmt);
        if (result == SQLITE_DONE) {
            return YES;
        }
    }
    return NO;
}










































@end
