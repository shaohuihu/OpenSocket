//
//  viewController.m
//  OpenLock
//
//  Created by yons on 14-10-14.
//  Copyright (c) 2014年 yons. All rights reserved.
//

#import "viewController.h"
#import "SockButton.h"
#import "ConnectController.h" 
#import "socketTool.h"
@interface viewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_arry;
    UIView *_cover;
    UITableView *_tableView;
    NSArray *_titleArry;
    int index;
 
    NSMutableArray *_allSocketButton;   //所有的Socketbutton;
   // NSMutableArray *_connectcontainner;  //所有连接成功的Socketbutton;
    socketTool *tool;
}

@end

@implementation viewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title =@"WIFI手机开锁演示软件";
        self.view.backgroundColor =[UIColor yellowColor];
        [self baseSetting];
        [self addSocketButton];
        [self addNotification];
    }
    return self;
}
-(void)baseSetting
{
    //_connectcontainner =[NSMutableArray array];
    _allSocketButton =[NSMutableArray array];
}
-(void)addNotification
{
    //添加连接成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connect:) name:connecting object:nil];
    
    //开锁成功通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(success:) name:openSuccess object:nil];
    
    
    //断开服务器通知，
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lose) name:loseServer object:nil];
  
}


- (void)viewDidLoad
{
    _arry  =@[@"添加设备",@"删除设备",@"关于"];
    _titleArry =@[@"1号电机锁",@"2号电机锁",@"3号电机锁",@"4号电机锁",@"5号电机锁",@"6号电机锁",@"7号电机锁",@"8号电机锁",@"9号电机锁",@"10号电机锁",@"11号电机锁",@"12号电机锁"];
    [super viewDidLoad];
	[self addTopBottom];
   
}

-(void)addTopBottom
{
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setFrame:CGRectMake(0, 568-40, 320, 40)];
    
     button.tag =100;
    
    [button setBackgroundColor:[UIColor blackColor]];
    
    [button setTitle:@"浙江电子设备有限公司" forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(about) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}
-(void)addSocketButton
{
    
    for(int i =0;i <=3;i++){
        for(int j =0;j<=2;j++){
            //默认设置
              SockButton *button =[[SockButton alloc] init];
            
              button.title =_titleArry[index];
            
              button.tag =index+1;

              button.stateLabel =@"离线";
            
              if(i ==1)
                  
              {
               [button setFrame:CGRectMake(j*90+(j+1)*10, i*90+75+(i+1)*20, 0, 0)];
              }
            
              else
              {
                 [button setFrame:CGRectMake(j*90+(j+1)*10, i*90+75+(i+1)*20, 0, 0)];
              }
            
             [_allSocketButton addObject:button];
            
             [self.view addSubview:button];
         
            index++;
            }
        }
     //连接服务器
    for(int i =0 ;i<_allSocketButton.count;i++)
    {
        SockButton  *button =_allSocketButton[i];
        
        [button connectServer:(i+1)];
    }
    
}

-(void)connect:(NSNotification *)notify
{
   
    NSNumber *num =[notify object];
    
    int tag =[num intValue];
    
    SockButton *button =(SockButton*)[self.view viewWithTag:tag];
    
    NSLog(@"button  %d 连接成功",button.tag);
    
   
    [button setStateLabel:@"连接"];
  
    
 //   [_connectcontainner addObject:button];
   
}


-(void)success:(NSNotification *)notify
{
    NSNumber *num =[notify object];
    
    int tag =[num intValue];
    
    SockButton *button =(SockButton*)[self.view viewWithTag:tag];
    
    NSLog(@"button  %d 开锁成功",button.tag);
    
 
        
    [button setStateLabel:@"已开"];
        
    [self performSelector:@selector(Online:) withObject:button afterDelay:6.0];  //延迟6秒之后显示在线
   
}

-(void)Online:(SockButton *)button
{
    if(![button.stateLabel isEqualToString:@"离线"]){
        NSLog(@"button  %d 在线",button.tag);
        [button setStateLabel:@"在线"];
    }
    
}
//由于服务器原因，一次性全部断开
-(void)lose
{
   
        for(int i =0 ;i<_allSocketButton.count;i++)
        {
            SockButton  *button =_allSocketButton[i];
            
            button.stateLabel =@"离线";
        }
   
}

-(void)about
{
    if(!_cover)
    {
        UIView * cover =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
        
        [cover setBackgroundColor:[UIColor grayColor]];
        
        [cover setAlpha:0.4];
        
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
        
        [cover addGestureRecognizer:tap];
        
        [self.view addSubview:cover];
        
        _cover = cover;
        
        [self.navigationController.view addSubview:cover];
        
        
        UITableView *table =[[UITableView alloc] initWithFrame:CGRectMake(0, 568-40-120, 320, 120) style:UITableViewStylePlain];
        
        table.scrollEnabled =NO;
        
        table.delegate =self;
        
        table.dataSource =self;
     
        _tableView =table;
        
        [self.view addSubview:table];
    
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [_arry count];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier =@"CellIdentifier";
    
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text =_arry[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row ==0){
        ConnectController *con =[[ConnectController alloc] init];
        con.title =@"添加设备";
       
        
        UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
        returnButtonItem.title = @"返回";
        self.navigationItem.backBarButtonItem = returnButtonItem;
        [self.navigationController pushViewController:con animated:YES];
        [self removeView];
    }
}
-(void)removeView
{
    [_tableView removeFromSuperview];
    [_cover removeFromSuperview];
    _cover = nil;
}
@end
