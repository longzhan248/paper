//
//  CommonUtil.m
//  paper
//
//  Created by 詹龙 on 2018/9/16.
//  Copyright © 2018年 longzhan. All rights reserved.
//

#import "CommonUtil.h"
#import <sys/socket.h>
#import <sys/xattr.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <netdb.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#import <CoreLocation/CoreLocation.h>
#import <ImageIO/ImageIO.h>

#define DocumentsDirectory [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES) lastObject]


@implementation CommonUtil

+ (id)shareInstance {
    static CommonUtil *singleton;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[super allocWithZone:NULL] init];
    });
    return singleton;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self shareInstance];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

+ (void)registerNotice:(NSString *)keyString object:(NSObject*)object
{
    [[NSNotificationCenter defaultCenter] postNotificationName:keyString object:object];
}

+ (NSString *)turnToEmojiTextWithString:(NSString *)string {
    NSRegularExpression *  emojiRegularExpress = [[NSRegularExpression alloc] initWithPattern:@"\\\\ue[a-z0-9A-Z]{3}" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSString *description = string;
    NSString *text = description;
    
    NSArray   *array = [emojiRegularExpress matchesInString:text options:0 range:NSMakeRange(0, [text length])];
    
    if ([array count] !=0) {
        
        for (NSTextCheckingResult *b in array) {
            NSString *string = [description substringWithRange:b.range];
            NSString *newString = [self decodeUnicodeBytes:(char *)[string UTF8String]];
            text = [text stringByReplacingOccurrencesOfString:string withString:newString];
        }
        
    }
    
    return text;
}

+ (NSString *)decodeUnicodeBytes:(char *)stringEncoded {
    unsigned int    unicodeValue;
    char            *p, buff[5];
    NSMutableString *theString;
    NSString        *hexString;
    NSScanner       *pScanner;
    
    theString = [[NSMutableString alloc] init];
    p = stringEncoded;
    
    buff[4] = 0x00;
    while (*p != 0x00) {
        
        if (*p == '\\') {
            p++;
            if (*p == 'u') {
                memmove(buff, ++p, 4);
                
                hexString = [NSString stringWithUTF8String:buff];
                pScanner = [NSScanner scannerWithString: hexString];
                [pScanner scanHexInt: &unicodeValue];
                
                [theString appendFormat:@"%C", (unichar)unicodeValue];
                p += 4;
                continue;
            }
        }
        
        [theString appendFormat:@"%c", *p];
        p++;
    }
    
    return [NSString stringWithString:theString];
}

+ (NSString *)timeIntervalTurnDate:(NSString *)string
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[string doubleValue]];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *timeString = [formatter stringFromDate:date];
    return timeString;
}

+ (NSString *)YearMonthIntervalTurnDate:(NSString *)string;
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[string doubleValue]/1000];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *timeString = [formatter stringFromDate:date];
    return timeString;
}

+ (NSString *)YearIntervalTurnDate:(NSString *)string
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[string doubleValue]];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月"];
    NSString *timeString = [formatter stringFromDate:date];
    return timeString;
}

+ (NSString *)MonthIntervalTurnDate:(NSString *)string
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[string doubleValue]];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd HH:mm"];
    NSString *timeString = [formatter stringFromDate:date];
    return timeString;
}

+ (NSString *)getLocalTime
{
    NSDateFormatter*dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYYMMddhhmmss"];
    NSString *datestr = [dateFormatter stringFromDate:[NSDate date]];
    
    return datestr;
}

+ (NSString*)TimeformatFromSeconds:(int)seconds
{
    int totalm = seconds/(60);
    int h = totalm/(60);
    int m = totalm%(60);
    int s = seconds%(60);
    if (h==0) {
        return  [NSString stringWithFormat:@"%02d:%02d", m, s];
    }
    return [NSString stringWithFormat:@"%02d:%02d:%02d", h, m, s];
}
+ (NSString*)TotalTimeformatFromSeconds:(int)seconds
{
    if (seconds == 0) {
        return 0;
    }
    // 以毫秒为单位
    int totalm = seconds/(60)/(1000);
    int h = totalm/(60);
    int m = totalm%(60);
    int s = (seconds/1000)%(60);
    if (h==0) {
        return  [NSString stringWithFormat:@"%02d:%02d", m, s];
    }
    return [NSString stringWithFormat:@"%02d:%02d:%02d", h, m, s];
}

+ (void)NotiTip:(NSString *)tip color:(UIColor *)color
{
    [ZLNotificationManager showMessage:tip withOptions:@{ZL_TEXT_COLOR_KEY:kUIColorFromRGB(WHITE),ZL_BACKGROUND_COLOR_KEY:color}];
}

- (void)stopNotificationView
{
    UIView *aView = (UIView *)[[UIApplication sharedApplication].keyWindow viewWithTag:10050];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2];
    [aView removeFromSuperview];
    [UIView commitAnimations];
}


+ (NSString *)generateUuidString
{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

#pragma mark - dateChangeFormatAt
- (NSMutableAttributedString *)attributeString2:(NSString *)agree
{
    
    attributeString = [[NSMutableAttributedString alloc] initWithString:agree];
    return attributeString;
}


+ (NSString*)dateChangeFormatAt:(NSString *)createdAt{
    
    // 2014-09-17 07:11:08
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //时间格式要一侄
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* createdAtDate = [dateFormatter dateFromString:createdAt];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSTimeInterval interval =[[NSDate date]timeIntervalSinceDate:createdAtDate];
    if (interval > 365 * 24 * 60 * 60 * 60) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }else
        [dateFormatter setDateFormat:@"MM-dd"];
    
    NSString* string = nil;
    
    
    string =[CommonUtil changeTime:createdAtDate toDateString:[dateFormatter stringFromDate:createdAtDate]];
    
    return string;
    
}

+ (NSString*)changeTime:(NSDate*)onedate toDateString:(NSString*)str
{
    NSTimeInterval interval =[[NSDate date]timeIntervalSinceDate:onedate];
    
    
    NSString* string=nil;
    if (interval < 60) {
        string = @"刚刚";
    }else if (interval >= 60 && interval < 60 * 60 ){
        string = [NSString stringWithFormat:@"%d分钟前",(int)ceilf(interval/60)];
        
    }else if (interval >= 60 * 60 && interval < 24 *60 * 60 ){
        
        string = [NSString stringWithFormat:@"%d小时前",(int)ceilf(interval/(60*60))];
    }else if (interval >= 24 * 60 * 60  && interval < 2 * 24 * 60 * 60){
        
        string = @"昨天";
    }else if (interval >= 48 * 60 * 60  && interval < 7 * 24 * 60 * 60){
        
        string = [NSString stringWithFormat:@"%d天前",(int)interval/ (24*60*60)];
        
    }else if (interval >= 7 * 24 * 60 * 60 &&  interval < 2 * 7 * 24 * 60 * 60)
    {
        string = @"一周前";
    }else{
        
        string = str;
    }
    
    return string;
}

+ (NSString *)compareDate:(NSDate *)date {
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [[NSDate alloc] init];
    NSDate *tomorrow, *yesterday;
    
    tomorrow = [today dateByAddingTimeInterval: secondsPerDay];
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    
    // 10 first characters of description is the calendar date:
    NSString * todayString = [[today description] substringToIndex:10];
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    NSString * tomorrowString = [[tomorrow description] substringToIndex:10];
    
    NSString * dateString = [[date description] substringToIndex:10];
    
    if ([dateString isEqualToString:todayString])
    {
        return @"今天";
    } else if ([dateString isEqualToString:yesterdayString])
    {
        return @"昨天";
    }else if ([dateString isEqualToString:tomorrowString])
    {
        return @"明天";
    }
    else
    {
        return dateString;
    }
}

+ (void)date{
    
    NSDate *nowDate = [NSDate date];    //这是当前的时间，其实这里可以是任意时间
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps;
    comps = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit) fromDate:nowDate];
    NSInteger nowYear = [comps year];
    NSInteger nowMonth = [comps month];
    NSInteger nowDay = [comps day];
    NSInteger nowWeek = [comps weekday];
    NSString *weekStr = [[NSString alloc] init];
    switch (nowWeek) {
        case 1:
            weekStr = @"星期天";
            break;
        case 2:
            weekStr = @"星期一";
            break;
        case 3:
            weekStr = @"星期二";
            break;
        case 4:
            weekStr = @"星期三";
            break;
        case 5:
            weekStr = @"星期四";
            break;
        case 6:
            weekStr = @"星期五";
            break;
        case 7:
            weekStr = @"星期六";
            break;
            
        default:
            break;
    }
    NSLog(@"年:%ld;月:%ld;日:%ld;%@",(long)nowYear,(long)nowMonth,(long)nowDay,weekStr);
    
}

#pragma mark - 判断网络状态
+ (BOOL) connectedToNetwork
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

- (BOOL)isChineseCharacterAndLettersAndNumbersAndUnderScore:(NSString *)string
{
    NSInteger len = string.length;
    for(int i=0;i<len;i++)
    {
        unichar a=[string characterAtIndex:i];
        if(!((isalpha(a))
             ||(isalnum(a))
             ||((a=='_'))
             ||((a >= 0x4e00 && a <= 0x9fa6))
             ))
            return NO;
    }
    return YES;
}

- (BOOL)regexPhone:(NSString *)phoneNum
{
    NSString *regex = @"^1[3|5|8][0-9]([0-9]{8})$";
    NSPredicate *emailMatch = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [emailMatch evaluateWithObject:phoneNum];
    return isMatch;
}

+(id)StringTurnJSON:(NSString *)jsonStr
{
    NSData* data=[jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
    return dict;
}

+(UIViewController *)popCtrl:(UIViewController *)rootCtrl count:(int)count
{
    rootCtrl = [rootCtrl.navigationController.viewControllers objectAtIndex:rootCtrl.navigationController.viewControllers.count-count];
    
    return rootCtrl;
}

- (AppDelegate *)myDelegate
{
    AppDelegate *mydelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return mydelegate;
}

+ (void)userDefaultModel:(id)model modelKey:(NSString *)key
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
    [USERDEFAULT setObject:data forKey:key];
    [USERDEFAULT synchronize];
}

@end
