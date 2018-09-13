//
//  WalletMacro.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/13.
//  Copyright © 2018年 evan. All rights reserved.
//

#ifndef WalletMacro_h
#define WalletMacro_h

#define UIColorFromHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define ColorPrimary UIColorFromHex(0x9576fc)

#define MainTextFont [UIFont systemFontOfSize:17]

#endif /* WalletMacro_h */
