//
//  Dao.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/14.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "Dao.h"

@implementation Dao

+ (FMDatabase *)sharedDao {
    static FMDatabase *db;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *docsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *dbPath = [docsPath stringByAppendingPathComponent:@"wallet.db"];
        db = [FMDatabase databaseWithPath:dbPath];
        
        if ([db open]) {
            NSString *foreignSQL = @"PRAGMA foreign_keys = ON";
            [db executeUpdate:foreignSQL];
            
            NSString *recordTypeSQL = @"CREATE TABLE IF NOT EXISTS RecordType ('ID' INTEGER PRIMARY KEY AUTOINCREMENT, 'name' TEXT NOT NULL, 'img_name' TEXT NOT NULL, 'type' INTEGER NOT NULL, 'state' INTEGER NOT NULL, 'ranking' INTEGER NOT NULL)";
            [db executeUpdate:recordTypeSQL];
            NSString *indexRecordTypeSQL = @"CREATE INDEX Index_RecordType ON RecordType('type', 'ranking', 'state')";
            [db executeUpdate:indexRecordTypeSQL];
            
            NSString *recordSQL = @"CREATE TABLE IF NOT EXISTS Record ('ID' INTEGER PRIMARY KEY AUTOINCREMENT, 'money' INTEGER, 'remark' TEXT, 'time' INTEGER, 'create_time' INTEGER, 'record_type_id' INTEGER NOT NULL, 'assets_id' INTEGER, FOREIGN KEY('record_type_id') REFERENCES RecordType('ID') ON UPDATE NO ACTION ON DELETE NO ACTION)";
            [db executeUpdate:recordSQL];
            NSString *indexRecordSQL = @"CREATE INDEX Index_Record on Record('record_type_id', 'time', 'money', 'create_time')";
            [db executeUpdate:indexRecordSQL];
            
            NSString *assetsSQL = @"CREATE TABLE IF NOT EXISTS Assets ('ID' INTEGER PRIMARY KEY AUTOINCREMENT, 'name' TEXT NOT NULL, 'img_name' TEXT NOT NULL, 'type' INTEGER NOT NULL, 'state' INTEGER NOT NULL, 'remark' TEXT NOT NULL, 'create_time' INTEGER NOT NULL, 'money' INTEGER NOT NULL, 'money_init' TEXT NOT NULL)";
            [db executeUpdate:assetsSQL];
            
            NSString *assetsModifyRecordSQL = @"CREATE TABLE IF NOT EXISTS AssetsModifyRecord ('ID' INTEGER PRIMARY KEY AUTOINCREMENT, 'state' INTEGER NOT NULL, 'create_time' INTEGER NOT NULL, 'assets_id' INTEGER NOT NULL, 'money_before' INTEGER NOT NULL, 'money' INTEGER NOT NULL, FOREIGN KEY('assets_id') REFERENCES Assets('ID') ON UPDATE NO ACTION ON DELETE CASCADE)";
            [db executeUpdate:assetsModifyRecordSQL];
            NSString *indexAssetsModifyRecordSQL = @"CREATE INDEX Index_AssetsModifyRecord ON AssetsModifyRecord('assets_id', 'create_time')";
            [db executeUpdate:indexAssetsModifyRecordSQL];
            
            NSString *assetsTransferRecordSQL = @"CREATE TABLE IF NOT EXISTS AssetsTransferRecord ('ID' INTEGER PRIMARY KEY AUTOINCREMENT, 'state' INTEGER NOT NULL, 'create_time' INTEGER NOT NULL, 'time' INTEGER NOT NULL, 'assets_id_from' INTEGER NOT NULL, 'assets_id_to' INTEGER NOT NULL, 'remark' TEXT NOT NULL, 'money' INTEGER NOT NULL, FOREIGN KEY('assets_id_from') REFERENCES Assets('ID') ON UPDATE NO ACTION ON DELETE CASCADE, FOREIGN KEY('assets_id_to') REFERENCES Assets('ID') ON UPDATE NO ACTION ON DELETE CASCADE)";
            [db executeUpdate:assetsTransferRecordSQL];
            NSString *indexAssetsTransferRecordSQL = @"CREATE INDEX Index_AssetsTransferRecord ON AssetsTransferRecord('assets_id_from', 'assets_id_to')";
            [db executeUpdate:indexAssetsTransferRecordSQL];
        }
    });
    return db;
}

@end
