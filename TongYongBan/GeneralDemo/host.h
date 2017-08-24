//
//  host.h
//  CheckDemo
//
//  Created by fhit on 16/7/6.
//  Copyright © 2016年 FH. All rights reserved.
//
#import <Foundation/Foundation.h>
#ifndef host_h
#define host_h

#define DEVICE_TYPE 1  //1 市场版，  2  企业内部下载版

#define IOS7_OR_LATER       ([[[UIDevice currentDevice] systemVersion] compare:@"7" options:NSNumericSearch] != NSOrderedAscending)
#define IOS10_OR_LATER       ([[[UIDevice currentDevice] systemVersion] compare:@"10" options:NSNumericSearch] != NSOrderedAscending)
#define IOS8AFTER           ([[[UIDevice currentDevice] systemVersion] compare:@"8" options:NSNumericSearch] != NSOrderedAscending)
#define IOS8_OR_AFTER           ([[[UIDevice currentDevice] systemVersion] compare:@"8" options:NSNumericSearch] != NSOrderedAscending)
#define IOS8            ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)


#define HostName  @"push.ucallclub.com"//点醒 域名 根据域名获取ip
#define udpPort @"34567"
#define udpHost @"123.125.203.162"//测试服务器

#define DBfile @"plist.text"
#define Urls @"Urls.text"

#define DownLoad @"DownLoad.text"
#define UpLoad @"UpLoad.text"

#define app_key @"726224879187179ef82bcb7c9e37e4fd"

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


#define YunPanDownloadPath  [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"YunPanDownload"] //云盘下载文件存储根路径
#define YunPanUploadPath  [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"YunPanUpload"] //云盘上传文件存储根路径

#define ChatDataPath  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]//聊天消息

#define AccessKeyId  @"593006bea952c140ef2a";                      //营业厅主KEY
#define AccessKey  @"ab81e9539d05b1cf8c4845ade249ba69a5e4c369";  //营业厅主密钥

//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define kTabBarHeight           50.f
#define kStatusBarHeight        20.f    //状态栏高度
#define kNavigationHeight       44.f    //导航栏高度

#define kEdgeInsetsLeft         10


#define IOS7_OR_LATER       ([[[UIDevice currentDevice] systemVersion] compare:@"7" options:NSNumericSearch] != NSOrderedAscending)

#define RGBACOLOR(R, G, B, A)   [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]


#define kColorItem                  RGBCOLOR(147, 158, 166)//底部导航颜色
#define kColorTitle                 RGBCOLOR(0x66, 0x66, 0x66)
#define kColorType                  RGBCOLOR(65,195,255)

#define kColorNavigationTitle       RGBCOLOR(0x48, 0x48, 0x48)

#define kColorNavigationTitleDisable       RGBACOLOR(0x44, 0x44, 0x44, 0.5)
#define kColorBtn                   RGBCOLOR(0x83,0x83,0x83)
#define kColorBackground            RGBCOLOR(243,243,243)
#define kColorLine                  RGBCOLOR(216,216,216)           //分割线颜色
#define AppMainColor                RGBCOLOR(14.0, 75.0, 192.0)//主色调




#define kFontMiddle                 [UIFont systemFontOfSize:15]
#define kFontSuper_b                [UIFont boldSystemFontOfSize:18]
#define Message_Font_Size   14        // 普通聊天文字大小

#define UISreenWidthScale   SCREEN_WIDTH / 320


#define dispatch_async_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}




//...........................网络请求API..........................//
#define HOST_URL [DateManger shareDataManger].UcallApiUrl  //切记 url要正确无误 多或者少空格会导致错误

#define MessageServer_Url     [DateManger shareDataManger].MessageServerUrl

#define CallTask_Url          [DateManger shareDataManger].CallTaskUrl

#define base_URL @"https://touch.ucallclub.com/api/v4/PlatformInfo"


#define SendText_Url [NSString stringWithFormat:@"%@v7/Message",HOST_URL];//发送文本@"https://anhui.ucallapi.ucallclub.com:9023/Help/Api/POST-api-v7-Message"
#define SendMedia_Url [NSString stringWithFormat:@"%@v7/UploadMedia",HOST_URL];//发送媒体文件@"https://anhui.ucallapi.ucallclub.com:9023/Help/Api/POST-api-v7-UploadMedia"


#define USERLOGIN_API [NSString stringWithFormat:@"%@v6/Login",HOST_URL];   //登录的url
#define GUANXI_API [NSString stringWithFormat:@"%@v4/AddressBook",HOST_URL];   //关系的url
#define USERLOGOUT_API [NSString stringWithFormat:@"%@v6/Logout",HOST_URL];   //退出的url
#define CHANGEUSER_API [NSString stringWithFormat:@"%@v4/Employee",HOST_URL];   //修改密码的url
#define GETICON_API [NSString stringWithFormat:@"%@v4/EmployeeAvatar",HOST_URL];   //获取头像的url
#define GETGROUP_API [NSString stringWithFormat:@"%@v4/Group",HOST_URL];   //获取群组的url

#define POSTAddGROUP_API [NSString stringWithFormat:@"%@v9/GroupExp",HOST_URL];   //添加群组

#define POSTUpdateGROUP_API [NSString stringWithFormat:@"%@v9/GroupUpdate",HOST_URL];   //更新群组

#define POSTMemberToGROUP_API [NSString stringWithFormat:@"%@v9/GroupmemberExp",HOST_URL];   //添加成员到群组

#define GETAllGROUP_API [NSString stringWithFormat:@"%@v9/GroupList",HOST_URL];   //获取个人全部群组的url

#define GETGROUPMembers_API [NSString stringWithFormat:@"%@v9/GroupmemberList",HOST_URL];   //获取群组成员的url


#define GETGroupExt_API [NSString stringWithFormat:@"%@v4/GroupExt",HOST_URL];   //获取参与的群组的url
#define POSTMEMBER_API [NSString stringWithFormat:@"%@v4/GroupMember",HOST_URL];   //添加成员到群组的url

#define PUTDEVICE_API [NSString stringWithFormat:@"%@v4/EmployeeDevice",HOST_URL]; //绑定设备


#define DELEMEETING_API  [NSString stringWithFormat:@"%@v6/Meeting",HOST_URL]; //结束会议

#define PUTMEETING_API  [NSString stringWithFormat:@"%@v6/MeetingMember",HOST_URL]; //转接会议

#define GETIMTOKEN_API  [NSString stringWithFormat:@"%@v8/Getimtoken",HOST_URL]; //获取IM token


#define GETEmployeePrivateContact  [NSString stringWithFormat:@"%@v6/EmployeePrivateContact",HOST_URL]; //员工个人名片夹管理

#define GETEmployeeFavorite  [NSString stringWithFormat:@"%@v4/EmployeeFavorite",HOST_URL]; //员工收藏 v8/CallRecord

#define GETCallRecord_API  [NSString stringWithFormat:@"%@v5/CallRecord",HOST_URL]; //员工个人名片夹管理

#endif /* host_h */
