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
#define ColorBackground UIColorFromHex(0xf9f9fa)
#define ColorTextKeyboard UIColorFromHex(0x5c5c5c)
#define ColorGradientStart UIColorFromHex(0x71b8fb)
#define ColorGradientEnd UIColorFromHex(0x9576fc)

#define ColorOutlay UIColorFromHex(0xFF6F6F)
#define ColorIncome UIColorFromHex(0x02AE7C)

#define MainTextFont [UIFont systemFontOfSize:17]

#define MainTextColor UIColorFromHex(0x202020)
#define MainTextDisableColor UIColorFromHex(0xb3b0b0)
#define MainTextHintColor UIColorFromHex(0x737373)

#define WS(ws)  __weak __typeof(&*self)(ws) = self


#endif /* WalletMacro_h */
