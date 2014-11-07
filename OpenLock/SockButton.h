//
//  SockButton.h
//  OpenLock
//
//  Created by yons on 14-10-14.
//  Copyright (c) 2014年 yons. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SockButton : UIButton


@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *stateLabel;


-(void)connectServer:(NSInteger)tag;
//-(void)sendOrder;
@end
