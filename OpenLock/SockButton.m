//
//  SockButton.m
//  OpenLock
//
//  Created by yons on 14-10-14.
//  Copyright (c) 2014年 yons. All rights reserved.
//

#import "SockButton.h"
#import "socketTool.h"
#import "SocketIndex.h"
@interface SockButton()

{
    UILabel *_state;
    socketTool *tool;
    SockButton *_SelectButton;
}

@end

@implementation SockButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self setBackgroundColor:[UIColor redColor]];
        [self.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self addTarget:self action:@selector(sendOrder:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *state =[[UILabel alloc] init];
        [state setFrame:CGRectMake(30, 20, 50, 50)];       
        [self addSubview:state];
        _state =state;
    }
    return self;
}

-(void)setFrame:(CGRect)frame
{
    frame.size.height =90;
    frame.size.width = 90;
    [super setFrame:frame];
}
-(void)setHighlighted:(BOOL)highlighted{}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    
    return CGRectMake(0, 60, 90, 30);
}

-(void)setTitle:(NSString *)title
{
    _title =title;
    [self setTitle:title forState:UIControlStateNormal];
}
-(void)setStateLabel:(NSString *)stateLabel
{
    _stateLabel =stateLabel;
    _state.text =stateLabel;
    if([stateLabel isEqualToString:@"离线"]){
        
        _state.textColor =[UIColor blackColor];
    }
    else if([stateLabel isEqualToString:@"在线"]){
        
        _state.textColor =[UIColor greenColor];
    }
    else{
        
        _state.textColor =[UIColor blueColor];
    }
}
-(void)connectServer:(NSInteger)tag
{
    tool =[[socketTool alloc] initWithTag:tag];
}
-(void)sendOrder:(SockButton *)button
{
   
      NSLog(@"button  tag  %d",button.tag);
    
    if([button.stateLabel isEqualToString:@"在线"]||
       [button.stateLabel isEqualToString:@"离线"]) {
        return;
    }
   //发出开锁命令
    
    if([SocketIndex sharedSocketIndex].OrderIndex != button.tag){
        [SocketIndex sharedSocketIndex].OrderIndex =button.tag;
        [tool sendHTTPRequest:@"开锁命令--------\r\n"tag:button.tag];
        
    }
   
}


@end
